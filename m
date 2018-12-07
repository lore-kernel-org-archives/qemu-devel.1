Received: from eggs.gnu.org ([2001:4830:134:3::10]:43014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=872b883f0=Paul.Durrant@citrix.com>)
	id 1gVHIC-00082E-Jf
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=872b883f0=Paul.Durrant@citrix.com>)
	id 1gVHI8-00007s-W0
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:39:48 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 7 Dec 2018 14:39:40 +0000
Message-ID: <ce9a0cbaa69c42c084e40b96c4d01c26@AMSPEX02CL03.citrite.net>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-4-git-send-email-paul.durrant@citrix.com>
	<20181207143525.GF18875@perard.uk.xensource.com>
In-Reply-To: <20181207143525.GF18875@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 03/18] xen: introduce 'xen-block',
 'xen-disk' and 'xen-cdrom'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 07 December 2018 14:35
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v2 03/18] xen: introduce 'xen-block', 'xen-disk' and
> 'xen-cdrom'
>=20
> On Thu, Dec 06, 2018 at 03:08:29PM +0000, Paul Durrant wrote:
> > +static char *disk_to_vbd_name(unsigned int disk)
> > +{
> > +    char *name, *prefix =3D (disk >=3D 26) ?
> > +        disk_to_vbd_name((disk / 26) - 1) : g_strdup("");
> > +
> > +    name =3D g_strdup_printf("%s%c", prefix, 'a' + disk);
>=20
> I don't think that works, if disk is 27, we do ('a' + 27) here. It's
> probably missing a `disk % 26`.

Damn, yes I was not allowing the >2 letters.

>=20
> > +    g_free(prefix);
> > +
> > +    return name;
> > +}
>=20
> [...]
>=20
> > +static unsigned int vbd_name_to_disk(const char *name, const char
> **endp)
> > +{
> > +    unsigned int disk =3D 0;
> > +
> > +    while (*name !=3D '\0') {
> > +        if (!g_ascii_isalpha(*name) || !g_ascii_islower(*name)) {
> > +            break;
> > +        }
> > +
> > +        disk *=3D 26;
> > +        disk +=3D *name++ - 'a';
> > +    }
> > +    *endp =3D name;
> > +
> > +    return disk;
> > +}
> > +
> > +static void xen_block_set_vdev(Object *obj, Visitor *v, const char
> *name,
> > +                               void *opaque, Error **errp)
> > +{
>=20
> Setting vdev doesn't work. I've tried to add a disk `xvdaa', and it
> result in `xvda', or `d0p0' (in the trace). (Same result with `xvdaaa',
> and 'xvdba' gives 'xvdaa'/d26p0)
>=20

Ok, that's weird. I'll have to figure that out.

  Paul

> --
> Anthony PERARD
