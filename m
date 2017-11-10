Received: from eggs.gnu.org ([2001:4830:134:3::10]:57586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eDDlU-0007yQ-5T
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eDDlQ-0007NL-S7
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:10:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eDDlQ-0007Mb-Iy
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:10:48 -0500
Date: Fri, 10 Nov 2017 13:10:46 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <868707299.39099859.1510337446693.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171110173421.17904-2-lprosek@redhat.com>
References: <20171110173421.17904-1-lprosek@redhat.com>
	<20171110173421.17904-2-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] ivshmem: Don't update non-existent MSI
 routes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, geoff@hostfission.com, pbonzini@redhat.com, armbru@redhat.com



----- Original Message -----
> As of commit 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications"=
),
> QEMU crashes with:
>=20
>   kvm_irqchip_commit_routes: Assertion `ret =3D=3D 0' failed.
>=20
> if the ivshmem device is configured with more vectors than what the serve=
r
> supports. This is caused by the ivshmem_vector_unmask() being called on
> vectors that have not been initialized by ivshmem_add_kvm_msi_virq().
>=20
> This commit fixes it by adding a simple check to the mask and unmask
> callbacks.
>=20
> Note that the opposite mismatch, if the server supplies more vectors than
> what the device is configured for, is already handled and leads to output
> like:
>=20
>   Too many eventfd received, device has 1 vectors
>=20
> Fixes: 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications")
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/misc/ivshmem.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index a5a46827fe..6e46669744 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -317,6 +317,10 @@ static int ivshmem_vector_unmask(PCIDevice *dev,
> unsigned vector,
>      int ret;
> =20
>      IVSHMEM_DPRINTF("vector unmask %p %d\n", dev, vector);
> +    if (!v->pdev) {
> +        error_report("ivshmem: vector %d route does not exist", vector);
> +        return -EINVAL;
> +    }
> =20
>      ret =3D kvm_irqchip_update_msi_route(kvm_state, v->virq, msg, dev);
>      if (ret < 0) {
> @@ -331,12 +335,16 @@ static void ivshmem_vector_mask(PCIDevice *dev,
> unsigned vector)
>  {
>      IVShmemState *s =3D IVSHMEM_COMMON(dev);
>      EventNotifier *n =3D &s->peers[s->vm_id].eventfds[vector];
> +    MSIVector *v =3D &s->msi_vectors[vector];
>      int ret;
> =20
>      IVSHMEM_DPRINTF("vector mask %p %d\n", dev, vector);
> +    if (!v->pdev) {
> +        error_report("ivshmem: vector %d route does not exist", vector);
> +        return;
> +    }
> =20
> -    ret =3D kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n,
> -
> s->msi_vectors[vector].virq);
> +    ret =3D kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, v->virq)=
;
>      if (ret !=3D 0) {
>          error_report("remove_irqfd_notifier_gsi failed");
>      }
> --
> 2.13.5
>=20
>=20
