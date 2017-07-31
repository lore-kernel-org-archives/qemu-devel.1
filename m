Received: from eggs.gnu.org ([2001:4830:134:3::10]:48865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcCRr-0001Xn-Li
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcCRq-0004Lw-Nr
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:17:35 -0400
Date: Mon, 31 Jul 2017 11:17:24 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170731151724.GH6240@localhost.localdomain>
References: <20170731125111.28052-1-kwolf@redhat.com>
	<20170731143809.GC22129@localhost.localdomain>
	<5e788182-b778-e027-2250-8e7c643786ae@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5e788182-b778-e027-2250-8e7c643786ae@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10] block/qapi: Remove redundat NULL
 check to silence Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, Jul 31, 2017 at 11:54:57AM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 07/31/2017 11:38 AM, Jeff Cody wrote:
> >On Mon, Jul 31, 2017 at 02:51:11PM +0200, Kevin Wolf wrote:
> >>When skipping implicit nodes in bdrv_block_device_info(), we know tha=
t
> >>bs0 is always non-NULL; initially, because it's taken from a BdrvChil=
d
> >
> >Not to mention, we deference bs0 in the chunk of code right above this=
, so
> >we'd segfault anyway if the initial value was NULL.
>=20
> Yes, please move your assert before:
>=20
> 137:    if (bs0->drv && bs0->backing) {
>=20
> Once there:
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>

I don't think moving the assert() is the correct thing to do, as it is
useful when iterating in the while() via backing_bs().

But maybe adding some asserts would be useful, if we are really concerned=
.
Looking at the code:

135         }
136

Maybe add an assert(bs0) here, as you suggest...

137         if (bs0->drv && bs0->backing) {
138             info->backing_file_depth++;
139             bs0 =3D bs0->backing->bs;

But then maybe we want one here, too?  Or maybe that is overkill :)

140             (*p_image_info)->has_backing_image =3D true;
141             p_image_info =3D &((*p_image_info)->backing_image);
142         } else {
143             break;
144         }
145
146         /* Skip automatically inserted nodes that the user isn't awar=
e of for
147          * query-block (blk !=3D NULL), but not for query-named-block=
-nodes */
148         while (blk && bs0 && bs0->drv && bs0->implicit) {
149             bs0 =3D backing_bs(bs0);
150         }



> >
> >>and a BdrvChild never has a NULL bs, and after the first iteration
> >>because implicit nodes always have a backing file.
> >>
> >>Remove the NULL check and add an assertion that the implicit node doe=
s
> >>indeed have a backing file.
> >>
> >>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >
> >
> >Reviewed-by: Jeff Cody <jcody@redhat.com>
> >
> >
> >
> >>---
> >>  block/qapi.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/block/qapi.c b/block/qapi.c
> >>index d2b18ee9df..5f1a71f5d2 100644
> >>--- a/block/qapi.c
> >>+++ b/block/qapi.c
> >>@@ -145,8 +145,9 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBack=
end *blk,
> >>          /* Skip automatically inserted nodes that the user isn't aw=
are of for
> >>           * query-block (blk !=3D NULL), but not for query-named-blo=
ck-nodes */
> >>-        while (blk && bs0 && bs0->drv && bs0->implicit) {
> >>+        while (blk && bs0->drv && bs0->implicit) {
> >>              bs0 =3D backing_bs(bs0);
> >>+            assert(bs0);
> >>          }
> >>      }
> >>--=20
> >>2.13.3
> >>
> >>
> >
