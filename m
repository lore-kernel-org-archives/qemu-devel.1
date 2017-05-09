Received: from eggs.gnu.org ([2001:4830:134:3::10]:44156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1d84FG-00080B-UO
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1d84FD-0007He-RX
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:28:02 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:12498)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1d84FD-0007Gf-Es
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:27:59 -0400
Received: from localhost (ppp005054056245.access.hol.gr [5.54.56.245])
	(authenticated bits=0)
	by smtp1.ntua.gr (8.15.2/8.15.2) with ESMTPSA id v49BeDmk004570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 9 May 2017 14:40:13 +0300 (EEST)
	(envelope-from el13635@mail.ntua.gr)
Date: Tue, 9 May 2017 14:40:06 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170509114006.les3miuqfx4oebat@post>
References: <20170509110128.27261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20170509110128.27261-1-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb-redir: fix stack overflow in
 usbredir_log_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Shouldn't we be checking if a monitor has been set instead of printing=20
to stderr anyway?

On Tue, May 09, 2017 at 01:01:28PM +0200, Gerd Hoffmann wrote:
>Don't reinvent a broken wheel, just use the hexdump function we have.
>
>Impact: low, broken code doesn't run unless you have debug logging
>enabled.
>
>Reported-by: =E6=9D=8E=E5=BC=BA <liqiang6-s@360.cn>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> hw/usb/redirect.c | 13 +------------
> 1 file changed, 1 insertion(+), 12 deletions(-)
>
>diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
>index b001a27f05..ad5ef783a6 100644
>--- a/hw/usb/redirect.c
>+++ b/hw/usb/redirect.c
>@@ -229,21 +229,10 @@ static void usbredir_log(void *priv, int level, co=
nst char *msg)
> static void usbredir_log_data(USBRedirDevice *dev, const char *desc,
>     const uint8_t *data, int len)
> {
>-    int i, j, n;
>-
>     if (dev->debug < usbredirparser_debug_data) {
>         return;
>     }
>-
>-    for (i =3D 0; i < len; i +=3D j) {
>-        char buf[128];
>-
>-        n =3D sprintf(buf, "%s", desc);
>-        for (j =3D 0; j < 8 && i + j < len; j++) {
>-            n +=3D sprintf(buf + n, " %02X", data[i + j]);
>-        }
>-        error_report("%s", buf);
>-    }
>+    qemu_hexdump((char *)data, stderr, desc, len);
> }
>
> /*
>--=20
>2.9.3
>
>
>
