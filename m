Received: from eggs.gnu.org ([2001:4830:134:3::10]:53711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cWKDg-0007aM-7A
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 04:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cWKDb-0004Q5-TM
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 04:50:23 -0500
Message-ID: <1485337815.29826.103.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 25 Jan 2017 10:50:15 +0100
In-Reply-To: <20170125083005.GA12762@olga.wb>
References: <1485328025-3783-1-git-send-email-kraxel@redhat.com>
	<20170125083005.GA12762@olga.wb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix oob access issue
 (CVE-2017-TODO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>, qemu-stable@nongnu.org, P J P <ppandit@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mi, 2017-01-25 at 09:30 +0100, Wolfgang Bumiller wrote:
> On Wed, Jan 25, 2017 at 08:07:05AM +0100, Gerd Hoffmann wrote:
> > From: Li Qiang <liqiang6-s@360.cn>
> >=20
> > When doing bitblt copy in backward mode, we should minus the
> > blt width first just like the adding in the forward mode. This
> > can avoid the oob access of the front of vga's vram.
> >=20
> > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> > Message-id: 5887254f.863a240a.2c122.5500@mx.google.com
> >=20
> > { kraxel: with backward blits (negative pitch) addr is the topmost
> >           address, so check it as-is against vram size ]
> >=20
> > Cc: qemu-stable@nongnu.org
> > Cc: P J P <ppandit@redhat.com>
> > Cc: Laszlo Ersek <lersek@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
> > Fixes: d3532a0db02296e687711b8cdc7791924efccea0 (CVE-2014-8106)
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  hw/display/cirrus_vga.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> > index 379910d..b8c29a6 100644
> > --- a/hw/display/cirrus_vga.c
> > +++ b/hw/display/cirrus_vga.c
> > @@ -277,10 +277,9 @@ static bool blit_region_is_unsafe(struct CirrusVGA=
State *s,
> >      }
> >      if (pitch < 0) {
> >          int64_t min =3D addr
> > -            + ((int64_t)s->cirrus_blt_height-1) * pitch;
> > -        int32_t max =3D addr
> > -            + s->cirrus_blt_width;
> > -        if (min < 0 || max > s->vga.vram_size) {
> > +            + ((int64_t)s->cirrus_blt_height - 1) * pitch
> > +            - s->cirrus_blt_width;
> > +        if (min < 0 || addr > s->vga.vram_size) {
>=20
> Call me paranoid, but shouldn't this be '>=3D'? Missed this yesterday
> apparently, correct me if I'm wrong:
> If VRAM goes from 0..7 it has a size of 8, and this would accept
> address 8 as it's not > size.

I think you are right.  The bkwd ops first execute the op, then
decrement, so addr is inclusive and the check is off by one.

> Note that for the blit functions themselves as well as
> blit_region_is_unsafe() the addresses are masked with cirrus_addr_mask.

[ ... ]

> But it seems this is not always the case?

[ ... ]

Looks like a bug indeed.

> Would it make sense to apply the masks in cirrus_bitblt_start() right
> after extracting them from s->vga.gr? Or to not mask the address inside
> blit_is_unafe()?

Applying the mask right after extracting sounds best to me, but I think
I'll better have a close look at the code first ...

cheers,
  Gerd
