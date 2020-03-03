Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A80C3F2D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DD7214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dY3iQfr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DD7214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94iT-0000NM-OQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94WM-0008IC-Hy
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94WL-0006Gs-Ct
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32530
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94WL-0006Gk-9e
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngv8J/eu4jYSej5X2ep9xhbT/ICki9cwCdKASiCwgIU=;
 b=dY3iQfr+a32iKnehnI9GxppKZczu8BpKTqJeHWraUyFDtO7T1imPifFR+gbikN/rMie1Qw
 hhnVb3mporMSTKHX3BX1BZbbgLBxFzrFML5kxjbZCohApvBcZi4Fpn5aZw3I9udyl8iXQE
 ANluucmoWSSApm3DILf3Cbe+f0nC4bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-wzOGimzTN-6GMm-PXWQCZA-1; Tue, 03 Mar 2020 05:11:20 -0500
X-MC-Unique: wzOGimzTN-6GMm-PXWQCZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89922107ACC7;
 Tue,  3 Mar 2020 10:11:19 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-98.pek2.redhat.com
 [10.72.12.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFA6B8B745;
 Tue,  3 Mar 2020 10:11:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 15/23] e1000e: Avoid hw_error if legacy mode used
Date: Tue,  3 Mar 2020 18:10:34 +0800
Message-Id: <1583230242-14597-16-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

https://bugzilla.redhat.com/show_bug.cgi?id=3D1787142
The emulation issues hw_error if PSRCTL register
is written, for example, with zero value.
Such configuration does not present any problem when
DTYP bits of RCTL register define legacy format of
transfer descriptors. Current commit discards check
for BSIZE0 and BSIZE1 when legacy mode used.

Acked-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 9b76f82..d110c5a 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2813,12 +2813,15 @@ e1000e_set_eitr(E1000ECore *core, int index, uint32=
_t val)
 static void
 e1000e_set_psrctl(E1000ECore *core, int index, uint32_t val)
 {
-    if ((val & E1000_PSRCTL_BSIZE0_MASK) =3D=3D 0) {
-        hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
-    }
+    if (core->mac[RCTL] & E1000_RCTL_DTYP_MASK) {
+
+        if ((val & E1000_PSRCTL_BSIZE0_MASK) =3D=3D 0) {
+            hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
+        }
=20
-    if ((val & E1000_PSRCTL_BSIZE1_MASK) =3D=3D 0) {
-        hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
+        if ((val & E1000_PSRCTL_BSIZE1_MASK) =3D=3D 0) {
+            hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
+        }
     }
=20
     core->mac[PSRCTL] =3D val;
--=20
2.5.0


