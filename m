Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA46C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9585C20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JraAs/eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9585C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv8s-0003PQ-1J
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDupi-0000us-9F
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuph-0007Je-73
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuph-0007Ck-0k
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6SdkZkbHtZbpGj30/TNvSyK6rwDYnvFekTs4gXk1Gs=;
 b=JraAs/eUqpY1HFPGWOQrICWlybKYqtWLt096CLv76JGI6973GCXBKHbPLdVkc5FShG/ODT
 8folApAGfX3AQGM4aQ6Sqcq3IlpEcmBsb8XsJ4fkYtaFpFO6M0hd50rblTnyXkzGGPPQW3
 vYQBXVlDy5wTRKKVRMtZm3bP5DV39xQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-O4miobZiOuWPSuQhPdPd-Q-1; Mon, 16 Mar 2020 14:51:22 -0400
X-MC-Unique: O4miobZiOuWPSuQhPdPd-Q-1
Received: by mail-wm1-f71.google.com with SMTP id f9so3415411wme.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BHfEltHWnJM0z/TMqJwXjvVhbV/f/WiV8vJxO2iwc/M=;
 b=QAZcWjhZiu/0Ut+/l/I27JkmgBaH8dgeGDnX8iV/03o95jw8oMyPoof3vi5C1JG2tv
 gpydtj2GwS355kSLWDhpiTYZ8nW3grjYs64YVmdVk5tcNh/SlGcfBZAjgDgNOjvzkejW
 s42Ibw5m/7KEIMwq9N3C7s8rQsKvuzm6FzUZ9AG+YdmeCsDXlyJOzDcBECnjJeQDXr4c
 G1mlP6sOolMx4AOu35bfmTCzJ/eHiUx13K3ryKEgMgY1ESSgBS9GYj/ggxZ69aK5pGOA
 hZTb83QRowXA3U8dqHhq7PyD1RhDjc5wbqhy3ky54z5w90hAvb8RnN3+nOjOGTNEfk3J
 PQIw==
X-Gm-Message-State: ANhLgQ2MrPckuKkCsm+9QF+IOjfQvfjsrEhqLGv5aATHuR7r+IAtfzEP
 ikY9C+83pkg404SCyHy+tjZAOuyuxCxbdLIVoZO5zV8AZH4fj9VayCGx32ATsEZqN5xne1yIQME
 2mUnAJO6NKprbVVI=
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr773329wre.160.1584384681597; 
 Mon, 16 Mar 2020 11:51:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuN9lbEtfI9IT2eh6/dMbvu5oUyRVDk6NkP/8fNtteSCQYaXMzoG4LyOqsrwuu5pN54GOde8g==
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr773311wre.160.1584384681433; 
 Mon, 16 Mar 2020 11:51:21 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id j39sm1182045wre.11.2020.03.16.11.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:51:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 14/25] scripts/cocci: Patch to detect potential use of
 memory_region_init_rom
Date: Mon, 16 Mar 2020 19:49:55 +0100
Message-Id: <20200316185006.576-15-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a semantic patch to detect potential replacement of
memory_region_init_ram(readonly) by memory_region_init_rom().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .../memory-region-housekeeping.cocci          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/=
coccinelle/memory-region-housekeeping.cocci
index ee3923d369..9cdde71bb1 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -29,6 +29,25 @@ symbol true;
 )
=20
=20
+@possible_memory_region_init_rom@
+expression E1, E2, E3, E4, E5;
+position p;
+@@
+(
+  memory_region_init_ram@p(E1, E2, E3, E4, E5);
+  ...
+  memory_region_set_readonly(E1, true);
+|
+  memory_region_init_ram_nomigrate@p(E1, E2, E3, E4, E5);
+  ...
+  memory_region_set_readonly(E1, true);
+)
+@script:python@
+p << possible_memory_region_init_rom.p;
+@@
+cocci.print_main("potential use of memory_region_init_rom*() in ", p)
+
+
 // Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
--=20
2.21.1


