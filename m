Received: from eggs.gnu.org ([2001:4830:134:3::10]:60758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=351b3ad51=Paul.Durrant@citrix.com>)
	id 1dSQKs-0008Dn-Un
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 12:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=351b3ad51=Paul.Durrant@citrix.com>)
	id 1dSQKo-0005Fi-QT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 12:05:58 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:20268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=351b3ad51=Paul.Durrant@citrix.com>)
	id 1dSQKo-00054A-EG
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 12:05:54 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 4 Jul 2017 16:05:50 +0000
Message-ID: <4b1c13c385fd4427a112b92bd6ec203e@AMSPEX02CL01.citrite.net>
References: <1499183267-28623-1-git-send-email-igor.druzhinin@citrix.com>
	<1499183267-28623-2-git-send-email-igor.druzhinin@citrix.com>
In-Reply-To: <1499183267-28623-2-git-send-email-igor.druzhinin@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/4] xen: move physmap saving into a
 separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>



> -----Original Message-----
> From: Igor Druzhinin
> Sent: 04 July 2017 16:48
> To: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
> Cc: Igor Druzhinin <igor.druzhinin@citrix.com>; sstabellini@kernel.org;
> Anthony Perard <anthony.perard@citrix.com>; Paul Durrant
> <Paul.Durrant@citrix.com>; pbonzini@redhat.com
> Subject: [PATCH v2 1/4] xen: move physmap saving into a separate function
>=20
> Non-functional change.
>=20
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

> ---
>  hw/i386/xen/xen-hvm.c | 57 ++++++++++++++++++++++++++++------------
> -----------
>  1 file changed, 31 insertions(+), 26 deletions(-)
>=20
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index cffa7e2..d259cf7 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -305,6 +305,36 @@ static hwaddr xen_phys_offset_to_gaddr(hwaddr
> start_addr,
>      return start_addr;
>  }
>=20
> +static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
> +{
> +    char path[80], value[17];
> +
> +    snprintf(path, sizeof(path),
> +            "/local/domain/0/device-
> model/%d/physmap/%"PRIx64"/start_addr",
> +            xen_domid, (uint64_t)physmap->phys_offset);
> +    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)physmap-
> >start_addr);
> +    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
> +        return -1;
> +    }
> +    snprintf(path, sizeof(path),
> +            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
> +            xen_domid, (uint64_t)physmap->phys_offset);
> +    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)physmap->size);
> +    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
> +        return -1;
> +    }
> +    if (physmap->name) {
> +        snprintf(path, sizeof(path),
> +                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name"=
,
> +                xen_domid, (uint64_t)physmap->phys_offset);
> +        if (!xs_write(state->xenstore, 0, path,
> +                      physmap->name, strlen(physmap->name))) {
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
>  static int xen_add_to_physmap(XenIOState *state,
>                                hwaddr start_addr,
>                                ram_addr_t size,
> @@ -316,7 +346,6 @@ static int xen_add_to_physmap(XenIOState *state,
>      XenPhysmap *physmap =3D NULL;
>      hwaddr pfn, start_gpfn;
>      hwaddr phys_offset =3D memory_region_get_ram_addr(mr);
> -    char path[80], value[17];
>      const char *mr_name;
>=20
>      if (get_physmapping(state, start_addr, size)) {
> @@ -368,31 +397,7 @@ go_physmap:
>                                     start_addr >> TARGET_PAGE_BITS,
>                                     (start_addr + size - 1) >> TARGET_PAG=
E_BITS,
>                                     XEN_DOMCTL_MEM_CACHEATTR_WB);
> -
> -    snprintf(path, sizeof(path),
> -            "/local/domain/0/device-
> model/%d/physmap/%"PRIx64"/start_addr",
> -            xen_domid, (uint64_t)phys_offset);
> -    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)start_addr);
> -    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
> -        return -1;
> -    }
> -    snprintf(path, sizeof(path),
> -            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
> -            xen_domid, (uint64_t)phys_offset);
> -    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)size);
> -    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
> -        return -1;
> -    }
> -    if (mr_name) {
> -        snprintf(path, sizeof(path),
> -                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name"=
,
> -                xen_domid, (uint64_t)phys_offset);
> -        if (!xs_write(state->xenstore, 0, path, mr_name, strlen(mr_name)=
)) {
> -            return -1;
> -        }
> -    }
> -
> -    return 0;
> +    return xen_save_physmap(state, physmap);
>  }
>=20
>  static int xen_remove_from_physmap(XenIOState *state,
> --
> 2.7.4
