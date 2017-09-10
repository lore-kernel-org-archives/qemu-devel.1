Received: from eggs.gnu.org ([2001:4830:134:3::10]:48561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drBf0-0001yu-2L
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 19:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drBew-0006bh-Rv
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 19:29:06 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:49647)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drBew-0006aq-DU
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 19:29:02 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<150472074219.24907.5510718414753398145.stgit@frigg.lan>
	<20170906215711.GA18214@flamenco>
Date: Mon, 11 Sep 2017 02:28:48 +0300
In-Reply-To: <20170906215711.GA18214@flamenco> (Emilio G. Cota's message of
	"Wed, 6 Sep 2017 17:57:11 -0400")
Message-ID: <87y3pmuo9b.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Emilio G Cota writes:

> On Wed, Sep 06, 2017 at 20:59:02 +0300, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
> (snip)
>> +QI_VPUBLIC void qi_set_fini(qi_fini_fn fn, void *data)
>> +{
>> +    ERROR_IF(!instr_get_state(), "called outside instrumentation");
>> +    instr_set_event(fini_fn, fn);
>> +    instr_set_event(fini_data, data);
>> +}

> Why are these QI_VPUBLIC attributes here? Those are useful for DSO's, not
> for executables --by using -rdynamic, all non-static symbols in the
> executable are already visible.

That's because I'm using -rdynamic, -fvisibility=3Dhidden and these attribu=
tes all
together to limit what symbols are available to dlopen()'ed libs (new series
version will have the visibility compiler flag I forgot to send).


>> diff --git a/instrument/control.h b/instrument/control.h
>> new file mode 100644
>> index 0000000000..f2b085f69b
>> --- /dev/null
>> +++ b/instrument/control.h
> (snip)
>> + * Instrumentation state of current host thread. Used to ensure instrum=
entation
>> + * clients use QEMU's API only in expected points.
>> + */
>> +typedef enum {
>> +    INSTR_STATE_DISABLE,
>> +    INSTR_STATE_ENABLE,
>> +} InstrState;

> I find this unnecessarily ugly for the little gain we get, i.e. asserts a=
gainst
> calling API code from QEMU.. seems unlikely to me (although admittedly I =
think
> the qemu-internal API is unnecessarily complex/verbose, so maybe
> you're better off with these checks).

It ensures only QEMU's threads now calling a library function are allowed t=
o use
the public API. In a later patch, it also ensures that TCG-generating funct=
ions
(e.g., qi_event_gen_guest_mem_before_exec) can only be called from
translation-time library functions.


> (snip)
>> +/**
>> + * instr_get_event:
>> + *
>> + * Get value set by instrumentation library.
>> + */
>> +#define instr_get_event(name)                   \
>> +    atomic_load_acquire(&instr_event__ ## name)
>> +
>> +/**
>> + * instr_get_event:
>> + *
>> + * Set value from instrumentation library.
>> + */
>> +#define instr_set_event(name, fn)               \
>> +    atomic_store_release(&instr_event__ ## name, fn)

> This isn't enough to decide whether to call instrumentation, especially f=
or
> TCG. We need TB's to know what to call, and update that mask with async
> work, just like we do with tracing. Check out my alternative patchset.

What do you mean by TB's need to know what to call?

> Also, a single function pointer cannot work for more than one plugin. But
> I see you have an XXX when there's more than one plugin, so it's OK for n=
ow.
> I used RCU lists for this, which at least gives you a time in the future
> at which things become visible/invisible by other threads -- this is impo=
rtant
> when unloading an instrumenter, since you don't want to clear important s=
tuff
> (e.g. dlclose) before you're sure no further callbacks to it are possible.
> [no, the atomic_acquire/release isn't enough!]

In principle, this together with the API checks above and kicking all vCPUs=
 to
flush TBs before unloading a library (I'm still looking at last bit) should
ensure libs can be safely unloaded. This should work for guest code events,=
 but
I still need to look at other events like vCPU hotplug (is it asynchronous?=
), or
other events we might want triggered outside the vCPU loops.

Flushing all TBs is also on my todo to support immediate event availability=
 when
loading a library and setting a translation-time callback.

Also, I'm not sure if we should support the complexity and performance pena=
lty
of more than one library at a time. Right now, the QAPI commands expose sup=
port
for more than one just for future-proofing (as suggested by Richard Henders=
on,
if I remember correctly).



> (snip)
>> diff --git a/instrument/load.c b/instrument/load.c
>> index a57401102a..e180f03429 100644
>> --- a/instrument/load.c
>> +++ b/instrument/load.c
>> @@ -11,6 +11,8 @@
>> #include "qemu-common.h"
>>=20
>> #include <dlfcn.h>
>> +#include "instrument/control.h"
>> +#include "instrument/events.h"
>> #include "instrument/load.h"
>> #include "qemu/config-file.h"
>> #include "qemu/error-report.h"
>> @@ -105,8 +107,11 @@ InstrLoadError instr_load(const char * path, int ar=
gc, const char ** argv,
>> res =3D INSTR_LOAD_DLERROR;
>> goto err;
>> }
>> +    instr_set_event(fini_fn, NULL);
>>=20
>> +    instr_set_state(INSTR_STATE_ENABLE);
>> main_res =3D main_cb(argc, argv);
>> +    instr_set_state(INSTR_STATE_DISABLE);
>>=20
>> if (main_res !=3D 0) {
>> res =3D INSTR_LOAD_ERROR;
>> @@ -136,6 +141,14 @@ InstrUnloadError instr_unload(int64_t handle_id)
>> goto out;
>> }
>>=20
>> +    qi_fini_fn fini_fn =3D instr_get_event(fini_fn);
>> +    if (fini_fn) {
>> +        void *fini_data =3D instr_get_event(fini_data);
>> +        fini_fn(fini_data);
>> +    }
>> +
>> +    instr_set_event(fini_fn, NULL);
>> +

> Is fini really that useful? Doesn't the tool just die with QEMU once QEMU=
 exits?

The lib can be unloaded at any time (in softmmu mode).


> At the end of the day, the tool could register its own atexit hook.

I'm aware of that, but:

* Passing a pointer when registering the callback avoids global variables.
* I thought that qi_set_fini() would be more discoverable than
  dlclose()+atexit().


Thanks!
  Lluis
