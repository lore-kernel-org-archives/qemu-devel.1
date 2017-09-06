Received: from eggs.gnu.org ([2001:4830:134:3::10]:39487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpi0A-0001BT-IX
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpi05-0007MH-RF
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:36:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpi05-0007Jm-IU
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:36:45 -0400
Date: Wed, 6 Sep 2017 17:36:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170906213641.GE25558@flamenco>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<150472122675.24907.11597641982841030964.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150472122675.24907.11597641982841030964.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v4 11/20] instrument: Track vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Sep 06, 2017 at 21:07:06 +0300, Lluís Vilanova wrote:
> Keep a translation between instrumentation's QICPU and CPUState objects to avoid
> exposing QEMU's internals to instrumentation clients.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
(snip)
> diff --git a/instrument/control.c b/instrument/control.c
> index 2c2781beeb..83453ea561 100644
> --- a/instrument/control.c
> +++ b/instrument/control.c
> @@ -13,10 +13,32 @@
>  #include "instrument/load.h"
>  #include "instrument/qemu-instr/control.h"
>  #include "instrument/qemu-instr/visibility.h"
> +#include "qom/cpu.h"
> +
>  
>  __thread InstrState instr_cur_state;
>  
>  
> +unsigned int instr_cpus_count;
> +CPUState **instr_cpus;
> +
> +void instr_cpu_add(CPUState *vcpu)
> +{
> +    unsigned int idx = vcpu->cpu_index;
> +    if (idx >= instr_cpus_count) {
> +        instr_cpus_count = idx + 1;
> +        instr_cpus = realloc(instr_cpus, sizeof(*instr_cpus) * instr_cpus_count);
> +    }
> +    instr_cpus[idx] = vcpu;
> +}
> +
> +void instr_cpu_remove(CPUState *vcpu)
> +{
> +    unsigned int idx = vcpu->cpu_index;
> +    instr_cpus[idx] = NULL;
> +}

instr_cpus_count and instr_cpus are both modified with cpu_list_lock.
However, other readers do not acquire this same lock. This gets messy
when you try to implement something like "vcpu_for_each", which is
very useful when you load an instrumentation tool once the program
is running (otherwise the tool cannot know for sure what the vCPUs
are). This vcpu_for_each would also have to take cpu_list_lock, for
otherwise it'd miss new threads being added. As you can imagine this
gets messy pretty quickly, given that you have your own lock here.
I went with having my own hash table (a list would be fine too),
protected with the same "instr_lock" you have (i.e. the recursive mutex).

An unrelated comment: your usage of get/set/put confuses me. I'd expect those
to work on refcounted items; instead you use them for instance to hide a cast
(cpu_set) or to create/destroy (e.g. handle_get/put).

		E.
