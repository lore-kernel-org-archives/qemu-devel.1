Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F967C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1306720776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7HQlrk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1306720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUWy-0003fz-5C
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdUSH-00039J-AS
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:56:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48104
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdUSG-0002sT-C1
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceuKaaK8VxDsRKmPx9fOojyazY5GYeQnwzsqN7EyL+U=;
 b=F7HQlrk4og1+PurcrHTkcCypXdexFwf+kTIyVDm/WdhtpE9f/oSHVmzt8f7H6si2SYy6mW
 C1kkPzSVzJIe0TUE9gdk4vA53TEmcdn0K4rAji/T+eL9Ez2DVljxV4szP9MvZ9Y5eqDko+
 IRm6z8RlFliUgjHbI2GKLLrG1XRaNEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-F5y16VB3ONqapqe9eu4Icg-1; Tue, 26 May 2020 03:56:47 -0400
X-MC-Unique: F5y16VB3ONqapqe9eu4Icg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95AC4107ACCD;
 Tue, 26 May 2020 07:56:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 540F76ED99;
 Tue, 26 May 2020 07:56:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 12AFD9DB0; Tue, 26 May 2020 09:56:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] audio/mixeng: fix clang 10+ warning
Date: Tue, 26 May 2020 09:56:35 +0200
Message-Id: <20200526075639.27949-5-kraxel@redhat.com>
In-Reply-To: <20200526075639.27949-1-kraxel@redhat.com>
References: <20200526075639.27949-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker Rümelin <vr_qemu@t-online.de>

The code in CONV_NATURAL_FLOAT() and CLIP_NATURAL_FLOAT()
seems to use the constant 2^31-0.5 to convert float to integer
and back. But the float type lacks the required precision and
the constant used for the conversion is 2^31. This is equiva-
lent to a [-1.f, 1.f] <-> [INT32_MIN, INT32_MAX + 1] mapping.

This patch explicitly writes down the used constant. The
compiler generated code doesn't change.

The constant 2^31 has an exact float representation and the
clang 10 compiler stops complaining about an implicit int to
float conversion with a changed value.

A few notes:
- The conversion of 1.f to INT32_MAX + 1 doesn't overflow. The
  type of the destination variable is int64_t.
- At a later stage one of the clip_* functions in
  audio/mixeng_template.h limits INT32_MAX + 1 to the integer
  range.
- The clip_natural_float_* functions in audio/mixeng.c convert
  INT32_MAX and INT32_MAX + 1 to 1.f.

Buglink: https://bugs.launchpad.net/bugs/1878627
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200523201712.23908-1-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/mixeng.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/audio/mixeng.c b/audio/mixeng.c
index 739a500449ce..924dcb858af5 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -271,11 +271,12 @@ f_sample *mixeng_clip[2][2][2][3] = {
 #define CONV_NATURAL_FLOAT(x) (x)
 #define CLIP_NATURAL_FLOAT(x) (x)
 #else
-static const float float_scale = UINT_MAX / 2.f;
+/* macros to map [-1.f, 1.f] <-> [INT32_MIN, INT32_MAX + 1] */
+static const float float_scale = (int64_t)INT32_MAX + 1;
 #define CONV_NATURAL_FLOAT(x) ((x) * float_scale)
 
 #ifdef RECIPROCAL
-static const float float_scale_reciprocal = 2.f / UINT_MAX;
+static const float float_scale_reciprocal = 1.f / ((int64_t)INT32_MAX + 1);
 #define CLIP_NATURAL_FLOAT(x) ((x) * float_scale_reciprocal)
 #else
 #define CLIP_NATURAL_FLOAT(x) ((x) / float_scale)
-- 
2.18.4


