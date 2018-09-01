Received: from eggs.gnu.org ([2001:4830:134:3::10]:46150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fw6Gv-0001aj-3G
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 09:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fw6F3-0005cX-43
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 09:47:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fw6F2-0005bE-1j
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 09:47:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8921140216E7
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 13:47:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  1 Sep 2018 15:46:52 +0200
Message-Id: <20180901134652.25884-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hmp: fix migrate status timer leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Spotted by ASAN doing some manual testing:

Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f5fcdc75e50 in calloc (/lib64/libasan.so.5+0xeee50)
    #1 0x7f5fcd47241d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5241d)
    #2 0x55f989be92ce in timer_new /home/elmarco/src/qq/include/qemu/time=
r.h:561
    #3 0x55f989be92ff in timer_new_ms /home/elmarco/src/qq/include/qemu/t=
imer.h:630
    #4 0x55f989c0219d in hmp_migrate /home/elmarco/src/qq/hmp.c:2038
    #5 0x55f98955927b in handle_hmp_command /home/elmarco/src/qq/monitor.=
c:3498
    #6 0x55f98955fb8c in monitor_command_cb /home/elmarco/src/qq/monitor.=
c:4371
    #7 0x55f98ad40f11 in readline_handle_byte /home/elmarco/src/qq/util/r=
eadline.c:393
    #8 0x55f98955fa4f in monitor_read /home/elmarco/src/qq/monitor.c:4354
    #9 0x55f98aae30d7 in qemu_chr_be_write_impl /home/elmarco/src/qq/char=
dev/char.c:175
    #10 0x55f98aae317a in qemu_chr_be_write /home/elmarco/src/qq/chardev/=
char.c:187
    #11 0x55f98aae940c in fd_chr_read /home/elmarco/src/qq/chardev/char-f=
d.c:66
    #12 0x55f98ab63018 in qio_channel_fd_source_dispatch /home/elmarco/sr=
c/qq/io/channel-watch.c:84
    #13 0x7f5fcd46c8ac in g_main_dispatch gmain.c:3177

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hmp.c b/hmp.c
index 4975fa56b0..52a4279e51 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2001,6 +2001,7 @@ static void hmp_migrate_status_cb(void *opaque)
         }
         monitor_resume(status->mon);
         timer_del(status->timer);
+        timer_free(status->timer);
         g_free(status);
     }
=20
--=20
2.19.0.rc1
