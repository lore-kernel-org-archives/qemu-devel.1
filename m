Received: from eggs.gnu.org ([2001:4830:134:3::10]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGkqy-0001mR-1e
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGkqu-00053f-4C
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:34:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGkqt-00052j-U0
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:34:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9ED6C04B31E
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 11:34:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-17-marcandre.lureau@redhat.com>
Date: Fri, 02 Jun 2017 13:34:42 +0200
In-Reply-To: <20170531135709.345-17-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:40 +0400")
Message-ID: <87vaoeei7h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 16/45] q35: fix get_mmcfg_size to use
 uint64 visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> e->size is hwaddr, i.e. uint64_t. We silently truncate.
> Fix suggested by Markus Armbruster.

I'd prefer

  Suggested-by: Markus Armbruster <armbru@redhat.com>

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/pci-host/q35.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index cd5c49616e..e8a04d31d1 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -129,9 +129,8 @@ static void q35_host_get_mmcfg_size(Object *obj, Visi=
tor *v, const char *name,
>                                      void *opaque, Error **errp)
>  {
>      PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
> -    uint32_t value =3D e->size;
>=20=20
> -    visit_type_uint32(v, name, &value, errp);
> +    visit_type_uint64(v, name, &e->size, errp);
>  }
>=20=20
>  static Property mch_props[] =3D {

Reviewed-by: Markus Armbruster <armbru@redhat.com>
