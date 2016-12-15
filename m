Received: from eggs.gnu.org ([2001:4830:134:3::10]:43748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCZ-0005Qu-3H
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCW-0001p7-1O
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCV-0001oF-PH
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:11 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jnnn130279
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:10 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdku13mk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:10 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:47:09 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:01 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481762701-4587-8-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/67] vnc: fix qemu crash because of SIGSEGV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: Gonglei <arei.gonglei@huawei.com>

The backtrace is:

0x00007f0b75cdf880 in pixman_image_get_stride () from /lib64/libpixman-1.=
so.0
0x00007f0b77bcb3cf in vnc_server_fb_stride (vd=3D0x7f0b7a1a2bb0) at ui/vn=
c.c:680
vnc_dpy_copy (dcl=3D0x7f0b7a1a2c00, src_x=3D224, src_y=3D263, dst_x=3D319=
, dst_y=3D363, w=3D1, h=3D1) at ui/vnc.c:915
0x00007f0b77bbcc35 in dpy_gfx_copy (con=3D0x7f0b7a146210, src_x=3Dsrc_x@e=
ntry=3D224, src_y=3Dsrc_y@entry=3D263, dst_x=3Ddst_x@entry=3D319,
dst_y=3Ddst_y@entry=3D363, w=3D1, h=3D1) at ui/console.c:1575
0x00007f0b77bbda4e in qemu_console_copy (con=3D<optimized out>, src_x=3Ds=
rc_x@entry=3D224, src_y=3Dsrc_y@entry=3D263, dst_x=3Ddst_x@entry=3D319,
dst_y=3Ddst_y@entry=3D363, w=3D<optimized out>, h=3D<optimized out>) at u=
i/console.c:2111
0x00007f0b77ac0980 in cirrus_do_copy (h=3D<optimized out>, w=3D<optimized=
 out>, src=3D<optimized out>, dst=3D<optimized out>, s=3D0x7f0b7b086090) =
at hw/display/cirrus_vga.c:774
cirrus_bitblt_videotovideo_copy (s=3D0x7f0b7b086090) at hw/display/cirrus=
_vga.c:793
cirrus_bitblt_videotovideo (s=3D0x7f0b7b086090) at hw/display/cirrus_vga.=
c:915
cirrus_bitblt_start (s=3D0x7f0b7b086090) at hw/display/cirrus_vga.c:1056
0x00007f0b77965cfb in memory_region_write_accessor (mr=3D0x7f0b7b096e40, =
addr=3D320, value=3D<optimized out>, size=3D1, shift=3D<optimized out>,ma=
sk=3D<optimized out>, attrs=3D...) at /root/rpmbuild/BUILD/master/qemu/me=
mory.c:525
0x00007f0b77963f59 in access_with_adjusted_size (addr=3Daddr@entry=3D320,=
 value=3Dvalue@entry=3D0x7f0b69a268d8, size=3Dsize@entry=3D4,
access_size_min=3D<optimized out>, access_size_max=3D<optimized out>, acc=
ess=3Daccess@entry=3D0x7f0b77965c80 <memory_region_write_accessor>,
mr=3Dmr@entry=3D0x7f0b7b096e40, attrs=3Dattrs@entry=3D...) at /root/rpmbu=
ild/BUILD/master/qemu/memory.c:591
0x00007f0b77968315 in memory_region_dispatch_write (mr=3Dmr@entry=3D0x7f0=
b7b096e40, addr=3Daddr@entry=3D320, data=3D18446744073709551362,
size=3Dsize@entry=3D4, attrs=3Dattrs@entry=3D...) at /root/rpmbuild/BUILD=
/master/qemu/memory.c:1262
0x00007f0b779256a9 in address_space_write_continue (mr=3D0x7f0b7b096e40, =
l=3D4, addr1=3D320, len=3D4, buf=3D0x7f0b77713028 "\002\377\377\377",
attrs=3D..., addr=3D4273930560, as=3D0x7f0b7827d280 <address_space_memory=
>) at /root/rpmbuild/BUILD/master/qemu/exec.c:2544
address_space_write (as=3D<optimized out>, addr=3D<optimized out>, attrs=3D=
..., buf=3D<optimized out>, len=3D<optimized out>) at /root/rpmbuild/BUIL=
D/master/qemu/exec.c:2601
0x00007f0b77925c1d in address_space_rw (as=3D<optimized out>, addr=3D<opt=
imized out>, attrs=3D..., attrs@entry=3D...,
buf=3Dbuf@entry=3D0x7f0b77713028 "\002\377\377\377", len=3D<optimized out=
>, is_write=3D<optimized out>) at /root/rpmbuild/BUILD/master/qemu/exec.c=
:2703
0x00007f0b77962f53 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x7f0b79fcc2d0) at =
/root/rpmbuild/BUILD/master/qemu/kvm-all.c:1965
0x00007f0b77950cc6 in qemu_kvm_cpu_thread_fn (arg=3D0x7f0b79fcc2d0) at /r=
oot/rpmbuild/BUILD/master/qemu/cpus.c:1078
0x00007f0b744b3dc5 in start_thread (arg=3D0x7f0b69a27700) at pthread_crea=
te.c:308
0x00007f0b70d3d66d in clone () from /lib64/libc.so.6

The code path while meeting segfault:
 vnc_dpy_copy
   vnc_update_client
     vnc_disconnect_finish [while vnc_disconnect_start() is invoked becau=
se somethins wrong]
       vnc_update_server_surface
         vd->server =3D NULL;
   vnc_server_fb_stride
     pixman_image_get_stride(vd->server)

Let's add a non-NULL check before calling vnc_server_fb_stride() to avoid=
 segmentation fault.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Reported-by: Yanying Zhuang <ann.zhuangyanying@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1472788698-120964-1-git-send-email-arei.gonglei@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 3e10c3ecfcaf604d8b400d6e463e1a186ce97d9b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 ui/vnc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index d1087c9..76a3273 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -911,6 +911,10 @@ static void vnc_dpy_copy(DisplayChangeListener *dcl,
         }
     }
=20
+    if (!vd->server) {
+        /* no client connected */
+        return;
+    }
     /* do bitblit op on the local surface too */
     pitch =3D vnc_server_fb_stride(vd);
     src_row =3D vnc_server_fb_ptr(vd, src_x, src_y);
--=20
1.9.1
