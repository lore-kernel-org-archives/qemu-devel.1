Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81AFC4649E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93ED3216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93ED3216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQZs-00052O-TN
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36653)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjQQq-0003RJ-Bo
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjQQm-0007Hk-UW
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:47:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hjQQf-0006dA-Du; Fri, 05 Jul 2019 11:47:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B563B4E908;
 Fri,  5 Jul 2019 15:47:14 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A26051001B30;
 Fri,  5 Jul 2019 15:47:12 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:46:36 +0200
Message-Id: <20190705154639.16591-7-philmd@redhat.com>
In-Reply-To: <20190705154639.16591-1-philmd@redhat.com>
References: <20190705154639.16591-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 05 Jul 2019 15:47:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 6/9] hw/block/pflash_cfi01: Simplify
 CFI_QUERY processing
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current code does:

if (write_cycle =3D=3D 0)
  if (command =3D=3D CFI_QUERY)
    break
  write_cycle +=3D 1
  last_command =3D command

if (write_cycle =3D=3D 1)
  if (last_command =3D=3D CFI_QUERY)
    if (command =3D=3D READ_ARRAY
      write_cycle =3D 0
      last_command =3D READ_ARRAY

Simplify by not increasing the write_cycle on CFI_QUERY,
the next command are processed as normal wcycle=3D0.

This matches the hardware datasheet (we do not enter the WRITE
state machine, thus no write cycle involved).

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index c32c67d01d..e097d9260d 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -491,7 +491,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
             return;
         case 0x98: /* CFI query */
             DPRINTF("%s: CFI query\n", __func__);
-            break;
+            pfl->cmd =3D cmd;
+            return;
         case 0xe8: /* Write to buffer */
             DPRINTF("%s: Write to buffer\n", __func__);
             /* FIXME should save @offset, @width for case 1+ */
@@ -565,13 +566,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
fset,
                 goto mode_read_array;
             }
             break;
-        case 0x98:
-            if (cmd =3D=3D 0xff) {
-                goto mode_read_array;
-            } else {
-                DPRINTF("%s: leaving query mode\n", __func__);
-            }
-            break;
         default:
             goto error_flash;
         }
--=20
2.20.1


