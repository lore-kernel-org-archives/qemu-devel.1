Received: from eggs.gnu.org ([2001:4830:134:3::10]:36939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7wxp-00080H-Ac
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7wxm-0008PF-8f
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:41:33 -0400
References: <20170509034519.16291-1-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <40670f11-21fa-7a8c-db7a-3053d61f082b@redhat.com>
Date: Tue, 9 May 2017 06:41:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170509034519.16291-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Allow workarounds for POWER9
 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de

On 09.05.2017 05:45, David Gibson wrote:
> POWER9 DD1 silicon has some bugs which mean it a) isn't really complian=
t
> with the ISA v3.00 and b) require a number of special workarounds in th=
e
> kernel.
>=20
> At the moment, qemu isn't aware of DD1.  For TCG we don't really want i=
t to
> be (why bother emulating buggy silicon).  But with KVM, the guest does =
need
> to be aware of DD1 so it can apply the necessary workarounds.
>=20
> Meanwhile, the feature negotiation between qemu and the guest strongly
> favours architected compatibility modes to "raw" CPU modes.  In combina=
tion
> with the above, this means the guest sees architected POWER9 mode, and
> doesn't apply the DD1 workarounds.  Well, unless it has yet another
> workaround to partially ignore what qemu tells it.
>=20
> This patch addresses this by disabling support for compatibility modes =
when
> using KVM on a POWER9 DD1 host.

I first though: Hey, it should be fixed in the guest kernel instead, but
thinking about this twice, I think you're right. If the CPU is not fully
compatible to the ISA, we really should not announce it as "architected
/ compatible POWER9" in QEMU.
So basically ACK to your patch, I've just got a cosmetic request below...

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/kvm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8574c36..591b5b5 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2380,6 +2380,17 @@ static void kvmppc_host_cpu_class_init(ObjectCla=
ss *oc, void *data)
> =20
>  #if defined(TARGET_PPC64)
>      pcc->radix_page_info =3D kvm_get_radix_page_info();
> +
> +    if ((pcc->pvr & 0xffffff00) =3D=3D 0x004e0100) {

Could you please add a proper #define for that magic DD1.0 value to
cpu-models.h, please?

 Thanks,
  Thomas
