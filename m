Received: from eggs.gnu.org ([2001:4830:134:3::10]:43174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d1X37-0007e3-I9
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d1X35-00051T-Ut
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:48:29 -0400
Date: Fri, 21 Apr 2017 13:48:11 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170421114811.hcqgwfuqrapzvzk4@aurel32.net>
References: <cover.1492770667.git.balaton@eik.bme.hu>
	<ebcd276cb56c012e196f7ed0ff0e548963fd6014.1492770667.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ebcd276cb56c012e196f7ed0ff0e548963fd6014.1492770667.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v6 08/13] sm501: Fix hardware cursor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 2017-04-21 12:31, BALATON Zoltan wrote:
> Rework HWC handling to simplify it and fix cursor not updating on
> screen as needed. Previously cursor was not updated because checking
> for changes in a line overrode the update flag set for the cursor but
> fixing this is not enough because the cursor should also be updated if
> its shape or location changes. Introduce hwc_invalidate() function to
> handle that similar to other display controller models.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>=20
> v3: simplify return expression in get_bpp
>=20
>  hw/display/sm501.c          | 169 +++++++++++++++++++++++++-------------=
------
>  hw/display/sm501_template.h |  25 +++----
>  2 files changed, 107 insertions(+), 87 deletions(-)
>=20
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index a628ef1..dc806a3 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1339,14 +1362,16 @@ static void sm501_draw_crt(SM501State *s)
>      /* draw each line according to conditions */
>      memory_region_sync_dirty_bitmap(&s->local_mem_region);
>      for (y =3D 0; y < height; y++) {
> -        int update_hwc =3D draw_hwc_line ? within_hwc_y_range(s, y, 1) :=
 0;
> -        int update =3D full_update || update_hwc;
> +        int update, update_hwc;
>          ram_addr_t page0 =3D offset;
>          ram_addr_t page1 =3D offset + width * src_bpp - 1;
> =20
> +        /* check if hardware cursor is enabled and we're within its rang=
e */
> +        update_hwc =3D draw_hwc_line && c_y <=3D y && y < c_y + SM501_HW=
C_HEIGHT;
> +        update =3D full_update || update_hwc;
>          /* check dirty flags for each line */
> -        update =3D memory_region_get_dirty(&s->local_mem_region, page0,
> -                                         page1 - page0, DIRTY_MEMORY_VGA=
);
> +        update |=3D memory_region_get_dirty(&s->local_mem_region, page0,
> +                                          page1 - page0, DIRTY_MEMORY_VG=
A);
> =20
>          /* draw line and change status */
>          if (update) {
> @@ -1358,7 +1383,7 @@ static void sm501_draw_crt(SM501State *s)
> =20
>              /* draw hardware cursor */
>              if (update_hwc) {
> -                draw_hwc_line(s, 1, hwc_palette, y - get_hwc_y(s, 1), d,=
 width);
> +                draw_hwc_line(d, hwc_src, width, hwc_palette, c_x, y - c=
_y);
>              }
> =20
>              if (y_start < 0) {

The above change causes a warning with at least GCC 6 and GCC 7, which
causes a build failure when using -Werror:

|   CC      sh4-softmmu/hw/display/sm501.o
| /home/aurel32/git/qemu/hw/display/sm501.c: In function =E2=80=98sm501_upd=
ate_display=E2=80=99:
| /home/aurel32/git/qemu/hw/display/sm501.c:1504:17: warning: =E2=80=98hwc_=
src=E2=80=99 may be used uninitialized in this function [-Wmaybe-uninitiali=
zed]
|                  draw_hwc_line(d, hwc_src, width, hwc_palette, c_x, y - c=
_y);
|                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
| /home/aurel32/git/qemu/hw/display/sm501.c:1488:59: warning: =E2=80=98c_y=
=E2=80=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
|          update_hwc =3D draw_hwc_line && c_y <=3D y && y < c_y + SM501_HW=
C_HEIGHT;
|                                                            ^
| /home/aurel32/git/qemu/hw/display/sm501.c:1504:17: warning: =E2=80=98c_x=
=E2=80=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
|                  draw_hwc_line(d, hwc_src, width, hwc_palette, c_x, y - c=
_y);
|                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~

GCC fails to notice that hwc_src, c_x and c_y are always defined if
draw_hwc_line is not NULL. This is obviously not a bug in the code, but
it might be a good idea to put a workaround for example by defining
default values for those variables.

Aurelien
--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
