Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC23C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 20:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF589208C0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 20:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF589208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNNSG-0004h5-3X
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 16:09:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNPi-0002ff-Ao
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNPW-0004t8-L5
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNNPO-0004AK-Hf; Sun, 05 May 2019 16:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B61C9308213C;
	Sun,  5 May 2019 20:06:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA48160851;
	Sun,  5 May 2019 20:06:39 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Date: Sun,  5 May 2019 22:06:00 +0200
Message-Id: <20190505200602.12412-4-philmd@redhat.com>
In-Reply-To: <20190505200602.12412-1-philmd@redhat.com>
References: <20190505200602.12412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Sun, 05 May 2019 20:06:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/5] hw/block/pflash_cfi01: Add the
 DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505200600.qxfHnVjl8E_Uz5NLoqmxi9PmamstzeoPCUMWNz2ETcw@z>

The pflash device is a child of TYPE_DEVICE, so it can implement
the DeviceReset handler. Actually it has to implement it, else
on machine reset it might stay in an incoherent state, as it has
been reported in the buglink listed below.

Add the DeviceReset handler and remove its call from the realize()
function.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 073cd14978f..639b05bc4d5 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -762,7 +762,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
         pfl->max_device_width =3D pfl->device_width;
     }
=20
-    pflash_reset(pfl);
     /* Hardcoded CFI table */
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
@@ -850,6 +849,11 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
     pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
 }
=20
+static void pflash_cfi01_reset(DeviceState *dev)
+{
+    pflash_reset(PFLASH_CFI01(dev));
+}
+
 static Property pflash_cfi01_properties[] =3D {
     DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
     /* num-blocks is the number of blocks actually visible to the guest,
@@ -894,6 +898,7 @@ static void pflash_cfi01_class_init(ObjectClass *klas=
s, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
+    dc->reset =3D pflash_cfi01_reset;
     dc->realize =3D pflash_cfi01_realize;
     dc->props =3D pflash_cfi01_properties;
     dc->vmsd =3D &vmstate_pflash;
--=20
2.20.1


