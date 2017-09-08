Received: from eggs.gnu.org ([2001:4830:134:3::10]:48318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqLNv-0007pN-C1
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqLNu-0003vn-0n
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqLNt-0003vV-Qb
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:39:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1372C047B78
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 15:39:56 +0000 (UTC)
Date: Fri, 8 Sep 2017 18:39:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170908183915-mutt-send-email-mst@kernel.org>
References: <20170807181618.22562-1-marcandre.lureau@redhat.com>
	<20170807181618.22562-4-marcandre.lureau@redhat.com>
	<20170908183337-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170908183337-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/8] fw_cfg: add vmcoreinfo file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, berrange@redhat.com, ehabkost@redhat.com, anderson@redhat.com, lersek@redhat.com

On Fri, Sep 08, 2017 at 06:39:01PM +0300, Michael S. Tsirkin wrote:
> On Mon, Aug 07, 2017 at 08:16:13PM +0200, Marc-Andr=E9 Lureau wrote:
> > diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
> > index 08c00bdf44..37d0f9f40a 100644
> > --- a/docs/specs/fw_cfg.txt
> > +++ b/docs/specs/fw_cfg.txt
> > @@ -136,6 +136,22 @@ struct FWCfgFile {		/* an individual file entry,=
 64 bytes total */
> >      char name[56];		/* fw_cfg item name, NUL-terminated ascii */
> >  };
> > =20
> > +=3D=3D=3D etc/vmcoreinfo =3D=3D=3D
> > +
> > +A guest may use this entry to add information details to qemu
> > +dumps. The entry gives location and size of an ELF note that is
> > +appended in qemu dumps.
> > +
> > +The entry is of 12 bytes with this format:
> > +
> > +struct FWCfgVMCoreInfo {
> > +    uint64_t paddr;             /* physical address of ELF note, LE =
*/
> > +    uint32_t size;              /* size of ELF note region, LE */
> > +};
> > +
> > +The note format/class must be of the target bitness and the size mus=
t
> > +be less than 1Mb.
> > +
>=20
> I would say adding a format bitmap would make sense for future compatib=
ility.
> How about:
>=20
> struct FWCfgVMCoreInfo {
>     uint16_t host_format;       /* Formats host supports. 0x1 LE - ELF =
note. Other bits - ignored. */
>     uint16_t guest_format;      /* Formats guest supplies. Must be 0x1 =
LE */

.. to set the ELF note info, or 0x0 to reset the device.

>     uint32_t size;              /* size of ELF note region, LE */
>     uint64_t paddr;             /* physical address of ELF note, LE */
> };
>=20
>=20
> >  =3D=3D=3D All Other Data Items =3D=3D=3D
> > =20
> >  Please consult the QEMU source for the most up-to-date and authorita=
tive list
> > --=20
> > 2.14.0.1.geff633fa0
