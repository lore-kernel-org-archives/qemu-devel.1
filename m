Received: from eggs.gnu.org ([2001:4830:134:3::10]:54769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIHTk-0002kF-5G
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIHTg-0000qg-Sv
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:09:28 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:58458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eIHTg-0000X0-MA
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:09:24 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id A92C0879D0
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 18:09:21 +0100 (CET)
Date: Fri, 24 Nov 2017 18:09:15 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171124180915.053ebb0b@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20171124042325.28012-3-sjitindarsingh@gmail.com>
References: <20171124042325.28012-1-sjitindarsingh@gmail.com>
	<20171124042325.28012-3-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 2/2] target/ppc: Fix setting of
 cpu->compat_pvr on incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Fri, 24 Nov 2017 15:23:25 +1100
Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:

> cpu->compat_pvr is used to store the current compat mode of the cpu.
> 
> On the receiving side during incoming migration we check compatibility
> with the compat mode by calling ppc_set_compat(). However we fail to set
> the compat mode with the hypervisor since the "new" compat mode doesn't
> differ from the current (due to a "cpu->compat_pvr != compat_pvr" check).
> This means that kvm runs the vcpus without a compat mode, which is the
> incorrect behaviour. The implication being that a compatibility mode
> will never be in effect after migration.
> 
> To fix this so that the compat mode is correctly set with the
> hypervisor, store the desired compat mode and reset cpu->compat_pvr to
> zero before calling ppc_set_compat().
> 

So we'd twist the code in cpu_post_load() because of some check done in
ppc_set_compat(), which is actually a workaround because PR KVM doesn't
support KVM_REG_PPC_ARCH_COMPAT... ouch :-\

David,

This was discussed last summer in

	http://patchwork.ozlabs.org/patch/782039/

and you wrote:

> Well, qemu expects to be able to set ARCH_COMPAT for a pseries guest,
> if that guest is going into a compatibility mode (which it usually
> does these days).  We don't want userspace to have to be constantly
> checking which KVM implementation its working against, so it makes
> sense for PR to implement the call, even if it's a no-op because it
> can't really implement the PCR fully.

I understand your point but implementing ARCH_COMPAT in PR KVM will
probably never happen... and as you say, it might be only a no-op.

So I guess we can "implement" this behaviour in kvmppc_set_compat()
with kvmppc_is_pr() and a fat comment, and drop the compat_pvr check
this patch is trying to negate.

> Fixes: 5dfaa532 ("ppc: fix ppc_set_compat() with KVM PR")
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> 
> ---
> 
> It is worth noting that another option was to add a force flag to the
> ppc_set_compat() function, but the enacted solution seemed cleaner with
> fewer code changes.
> ---
>  target/ppc/machine.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 384caee800..24117e8f31 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -237,9 +237,11 @@ static int cpu_post_load(void *opaque, int version_id)
>  
>  #if defined(TARGET_PPC64)
>      if (cpu->compat_pvr) {
> +        uint32_t compat_pvr = cpu->compat_pvr;
>          Error *local_err = NULL;
>  
> -        ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
> +        cpu->compat_pvr = 0;
> +        ppc_set_compat(cpu, compat_pvr, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>              return -1;
