Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04D2C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A44520663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8SDcMLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A44520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDoSO-0004Xt-3y
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jDnx1-00023G-7x
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jDnwz-0001i5-Sd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51121)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jDnwz-0001bm-Ni
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584358228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iI7EvAcPsxErgC/GJdfEIFJRdfocYN4FRixDOCOaMns=;
 b=T8SDcMLReJf7TO+dlBVT3GCyCxtsenVm5gsTzbwrUrUOiL00IryYrO4sOq9IkSbgL6QtQU
 rihzOHMmrzx17FNKFh3IZIKkXtHskpxsFeMNb7TE1LDcv6O5MAWUpEtYI0Xb9/n/DCWhXt
 ybTKx0iZ28UdNg/gkTh92in/92Aj6AQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-_QrWc6D2O86WAG2vHHlH-Q-1; Mon, 16 Mar 2020 07:30:26 -0400
X-MC-Unique: _QrWc6D2O86WAG2vHHlH-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 570A4DB21;
 Mon, 16 Mar 2020 11:30:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AC1060BE2;
 Mon, 16 Mar 2020 11:30:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AFB4E9B0C; Mon, 16 Mar 2020 12:30:15 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] audio: fix saturation nonlinearity in clip_* functions
Date: Mon, 16 Mar 2020 12:30:14 +0100
Message-Id: <20200316113015.28013-6-kraxel@redhat.com>
In-Reply-To: <20200316113015.28013-1-kraxel@redhat.com>
References: <20200316113015.28013-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

The current positive limit for the saturation nonlinearity is
only correct if the type of the result has 8 bits or less.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200308193321.20668-5-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/mixeng_template.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/audio/mixeng_template.h b/audio/mixeng_template.h
index fc8e1d4d9ebf..bc8509e423f6 100644
--- a/audio/mixeng_template.h
+++ b/audio/mixeng_template.h
@@ -83,10 +83,9 @@ static inline int64_t glue (conv_, ET) (IN_T v)
=20
 static inline IN_T glue (clip_, ET) (int64_t v)
 {
-    if (v >=3D 0x7f000000) {
+    if (v >=3D 0x7fffffffLL) {
         return IN_MAX;
-    }
-    else if (v < -2147483648LL) {
+    } else if (v < -2147483648LL) {
         return IN_MIN;
     }
=20
--=20
2.18.2


