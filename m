Received: from eggs.gnu.org ([2001:4830:134:3::10]:43625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpiJy-0006na-AA
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpiJu-0000yb-Dp
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:57:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpiJu-0000yO-6f
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:57:14 -0400
Date: Wed, 6 Sep 2017 17:57:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170906215711.GA18214@flamenco>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<150472074219.24907.5510718414753398145.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150472074219.24907.5510718414753398145.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v4 09/20] instrument: Add basic control
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Sep 06, 2017 at 20:59:02 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
(snip)
> +QI_VPUBLIC void qi_set_fini(qi_fini_fn fn, void *data)
> +{
> +    ERROR_IF(!instr_get_state(), "called outside instrumentation");
> +    instr_set_event(fini_fn, fn);
> +    instr_set_event(fini_data, data);
> +}

Why are these QI_VPUBLIC attributes here? Those are useful for DSO's, not
for executables --by using -rdynamic, all non-static symbols in the
executable are already visible.

> diff --git a/instrument/control.h b/instrument/control.h
> new file mode 100644
> index 0000000000..f2b085f69b
> --- /dev/null
> +++ b/instrument/control.h
(snip)
> + * Instrumentation state of current host thread. Used to ensure instrumentation
> + * clients use QEMU's API only in expected points.
> + */
> +typedef enum {
> +    INSTR_STATE_DISABLE,
> +    INSTR_STATE_ENABLE,
> +} InstrState;

I find this unnecessarily ugly for the little gain we get, i.e. asserts against
calling API code from QEMU.. seems unlikely to me (although admittedly I think
the qemu-internal API is unnecessarily complex/verbose, so maybe
you're better off with these checks).

(snip)
> +/**
> + * instr_get_event:
> + *
> + * Get value set by instrumentation library.
> + */
> +#define instr_get_event(name)                   \
> +    atomic_load_acquire(&instr_event__ ## name)
> +
> +/**
> + * instr_get_event:
> + *
> + * Set value from instrumentation library.
> + */
> +#define instr_set_event(name, fn)               \
> +    atomic_store_release(&instr_event__ ## name, fn)

This isn't enough to decide whether to call instrumentation, especially for
TCG. We need TB's to know what to call, and update that mask with async
work, just like we do with tracing. Check out my alternative patchset.

Also, a single function pointer cannot work for more than one plugin. But
I see you have an XXX when there's more than one plugin, so it's OK for now.
I used RCU lists for this, which at least gives you a time in the future
at which things become visible/invisible by other threads -- this is important
when unloading an instrumenter, since you don't want to clear important stuff
(e.g. dlclose) before you're sure no further callbacks to it are possible.
[no, the atomic_acquire/release isn't enough!]

(snip)
> diff --git a/instrument/load.c b/instrument/load.c
> index a57401102a..e180f03429 100644
> --- a/instrument/load.c
> +++ b/instrument/load.c
> @@ -11,6 +11,8 @@
>  #include "qemu-common.h"
>  
>  #include <dlfcn.h>
> +#include "instrument/control.h"
> +#include "instrument/events.h"
>  #include "instrument/load.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> @@ -105,8 +107,11 @@ InstrLoadError instr_load(const char * path, int argc, const char ** argv,
>          res = INSTR_LOAD_DLERROR;
>          goto err;
>      }
> +    instr_set_event(fini_fn, NULL);
>  
> +    instr_set_state(INSTR_STATE_ENABLE);
>      main_res = main_cb(argc, argv);
> +    instr_set_state(INSTR_STATE_DISABLE);
>  
>      if (main_res != 0) {
>          res = INSTR_LOAD_ERROR;
> @@ -136,6 +141,14 @@ InstrUnloadError instr_unload(int64_t handle_id)
>          goto out;
>      }
>  
> +    qi_fini_fn fini_fn = instr_get_event(fini_fn);
> +    if (fini_fn) {
> +        void *fini_data = instr_get_event(fini_data);
> +        fini_fn(fini_data);
> +    }
> +
> +    instr_set_event(fini_fn, NULL);
> +

Is fini really that useful? Doesn't the tool just die with QEMU once QEMU exits?
At the end of the day, the tool could register its own atexit hook.

		E.
