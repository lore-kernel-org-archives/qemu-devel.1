Received: from eggs.gnu.org ([2001:4830:134:3::10]:47488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dsIfE-0004NP-64
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 21:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dsIfA-000684-6h
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 21:09:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dsIf9-00066l-Tl
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 21:09:52 -0400
Date: Wed, 13 Sep 2017 22:09:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170914010947.GH7570@localhost.localdomain>
References: <20170913143958.86385-1-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913143958.86385-1-agraf@suse.de>
Subject: Re: [Qemu-devel] [PATCH] target-i386: enable kvm_pv_unhalt by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andrew Jones <drjones@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Wed, Sep 13, 2017 at 04:39:58PM +0200, Alexander Graf wrote:
> Commit f010bc643a (target-i386: add feature kvm_pv_unhalt) introduced the
> kvm_pv_unhalt feature but didn't enable it by default.
> 
> Without kvm_pv_unhalt we see a measurable degradation in scheduling
> performance, so enabling it by default does make sense IMHO. This patch
> just flips it to default to on by default.
> 
>   [With kvm_pv_unhalt disabled]
>   $ perf bench sched messaging -l 10000
>     Total time: 8.573 [sec]
> 
>   [With kvm_pv_unhalt enabled]
>   $ perf bench sched messaging -l 10000
>     Total time: 4.416 [sec]
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> 
> ---
> 
> Let's ask everyone who was involved back then whether this is a feature
> that is good to enable by default. My measurements imply so, but who knows...
> 
> Also, I'd kindly like to ask for guidance on how to make this reasonably
> well backwards compatible. I assume we only want to flip the default in newer
> machine models? If so, how?

There are two things that need to be taken care of:

* Guest ABI compatibility: if running an older machine-type, the
  feature needs to remain disabled.
* machine-type runnability: libvirt doesn't expect an existing VM
  to become not runnable on the same host if changing only the
  machine-type.  This can happen if the new machine-type enables
  a feature that's not supported by the host kernel.

Guest ABI compatibility is relatively easy to handle: see how we
deal with kvm-pv-eoi on pc-1.2.  Moving the machine-type-specific
kvm-defaults to PCMachineClass (instead of introducing new
pc_compat_*() functions) would be interesting, though; I will
take a look and try to implement that.

machine-type runnability is trickier: it's a problem in theory if
people can be running old kernels that didn't support the
feature, but may be not a problem in practice if the feature is
so old that everybody running a recent QEMU is also running a
recent enough kernel.  In either case, the problem still needs to
be addressed somehow; just documenting the minimum kernel version
QEMU needs would probably be enough.

For reference, kvm_pv_unhalt was introduced in Linux v3.12-rc1.

> ---
>  target/i386/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 69676e13e1..c58f4ab24f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1581,6 +1581,7 @@ static PropValue kvm_default_props[] = {
>      { "kvm-asyncpf", "on" },
>      { "kvm-steal-time", "on" },
>      { "kvm-pv-eoi", "on" },
> +    { "kvm-pv-unhalt", "on" },
>      { "kvmclock-stable-bit", "on" },
>      { "x2apic", "on" },
>      { "acpi", "off" },
> -- 
> 2.12.3
> 

-- 
Eduardo
