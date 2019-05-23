Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B67C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CC920879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CC920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35709 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnLm-0007nV-43
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:01:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTnGl-0003dk-6V
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTn6K-0003zQ-5F
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:45:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hTn6K-0003yz-0x; Thu, 23 May 2019 08:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F532301E12F;
	Thu, 23 May 2019 12:45:38 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BCA456836A;
	Thu, 23 May 2019 12:44:57 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 14:43:18 +0200
Message-Id: <20190523124320.28726-14-philmd@redhat.com>
In-Reply-To: <20190523124320.28726-1-philmd@redhat.com>
References: <20190523124320.28726-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 23 May 2019 12:45:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/15] hw/nvram/fw_cfg: Store 'reboot-timeout'
 as little endian
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Li Qiang <liq3ea@163.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

The current codebase is not specific about the endianess of the
fw_cfg 'file' entry 'reboot-timeout'.

Per docs/specs/fw_cfg.txt:

  =3D=3D=3D All Other Data Items =3D=3D=3D

  Please consult the QEMU source for the most up-to-date
  and authoritative list of selector keys and their respective
  items' purpose, format and writeability.

Checking the git history, this code was introduced in commit
ac05f3492421, very similar to commit 3d3b8303c6f8 for the
'boot-menu-wait' entry, which explicitely use little-endian.

OVMF consumes 'boot-menu-wait' as little-endian, however it does
not consume 'reboot-timeout'.

Regarding the git history and OVMF use, we choose to explicit
'reboot-timeout' endianess as little-endian.

Signed-off-by: Li Qiang <liq3ea@163.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190424140643.62457-4-liq3ea@163.com>
[PMD: Reword commit description based on review comments]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b2dc0a80cb..9f7b7789bc 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -234,6 +234,7 @@ static void fw_cfg_reboot(FWCfgState *s)
 {
     const char *reboot_timeout =3D NULL;
     int64_t rt_val =3D -1;
+    uint32_t rt_le32;
=20
     /* get user configuration */
     QemuOptsList *plist =3D qemu_find_opts("boot-opts");
@@ -250,7 +251,8 @@ static void fw_cfg_reboot(FWCfgState *s)
         }
     }
=20
-    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_val, 4), 4);
+    rt_le32 =3D cpu_to_le32(rt_val);
+    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_le32, 4), 4);
 }
=20
 static void fw_cfg_write(FWCfgState *s, uint8_t value)
--=20
2.20.1


