Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AEBC2D0BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0F320717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSsV0QqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0F320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihd2j-0001dE-Cy
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihd0N-0007k9-02
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihd0K-00009e-7E
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:20:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihd0J-00005X-Q0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576689655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgf9utv5iIdUp6bijyWhIucupNguK7s0JQXj95uL2G0=;
 b=DSsV0QqTG9Wlc2DheACHplHRlM4g6WM6kPkqJaWwjKOkctFs9daC6AYtA/0DNKg4gVl0rH
 bhqcaLpfRfynChaskzK/c3gOjkAWi/GT5Sm64kAEKu6WNiG9h/bjf4MaE5oE4jxnAwkT6U
 3zsHHAxMnjQdOdGGxZ+BRVZBtMPoRN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-m5t037RpNl6jBOk9RpqtYA-1; Wed, 18 Dec 2019 12:20:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DEF8107ACC5;
 Wed, 18 Dec 2019 17:20:51 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-235.ams2.redhat.com [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10A9310016DA;
 Wed, 18 Dec 2019 17:20:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 02/14] hw/ipmi: Explicit we ignore some QEMUChrEvent in
 IOEventHandler
Date: Wed, 18 Dec 2019 18:19:57 +0100
Message-Id: <20191218172009.8868-3-philmd@redhat.com>
In-Reply-To: <20191218172009.8868-1-philmd@redhat.com>
References: <20191218172009.8868-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: m5t037RpNl6jBOk9RpqtYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Chardev events are listed in the QEMUChrEvent enum. To be
able to use this enum in the IOEventHandler typedef, we need to
explicit all the events ignored by this frontend, to silent the
following GCC warning:

  hw/ipmi/ipmi_bmc_extern.c: In function =E2=80=98chr_event=E2=80=99:
  hw/ipmi/ipmi_bmc_extern.c:389:5: error: enumeration value =E2=80=98CHR_EV=
ENT_BREAK=E2=80=99 not handled in switch [-Werror=3Dswitch]
    389 |     switch (event) {
        |     ^~~~~~
  hw/ipmi/ipmi_bmc_extern.c:389:5: error: enumeration value =E2=80=98CHR_EV=
ENT_MUX_IN=E2=80=99 not handled in switch [-Werror=3Dswitch]
  hw/ipmi/ipmi_bmc_extern.c:389:5: error: enumeration value =E2=80=98CHR_EV=
ENT_MUX_OUT=E2=80=99 not handled in switch [-Werror=3Dswitch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Add all missing enums

Cc: Corey Minyard <minyard@acm.org>
---
 hw/ipmi/ipmi_bmc_extern.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 450926e5fb..adf2afe728 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -435,6 +435,12 @@ static void chr_event(void *opaque, int event)
             k->handle_rsp(s, ibe->outbuf[0], ibe->inbuf + 1, 3);
         }
         break;
+
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
     }
 }
=20
--=20
2.21.0


