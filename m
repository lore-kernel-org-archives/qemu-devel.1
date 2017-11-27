Received: from eggs.gnu.org ([2001:4830:134:3::10]:52092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eJKVb-0008FL-2p
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eJKVX-0001ny-5h
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:35:43 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:40081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eJKVW-0001nJ-Uu
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:35:39 -0500
Received: from player791.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 6742482F50
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 15:35:34 +0100 (CET)
Date: Mon, 27 Nov 2017 15:35:17 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171127153517.07406fa1@bahia.lan>
In-Reply-To: <20171127043003.15034-3-david@gibson.dropbear.id.au>
References: <20171127043003.15034-1-david@gibson.dropbear.id.au>
	<20171127043003.15034-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/2] target/ppc: Fix setting of
 cpu->compat_pvr on incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, agraf@suse.de, surajjs@au1.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-stable@nongnu.org

On Mon, 27 Nov 2017 15:30:03 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> 
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
> Fixes: 5dfaa532 ("ppc: fix ppc_set_compat() with KVM PR")
> 

Cc'ing stable since 5dfaa532 was shipped with QEMU 2.10

> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
