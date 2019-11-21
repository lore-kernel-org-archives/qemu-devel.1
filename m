Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A54C43215
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AB3206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmmwRx3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AB3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoXg-0000ZF-8l
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXoVt-0006pt-RJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXoVs-0001Rz-Jm
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:57 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iXoVs-0001Qs-DL
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:56 -0500
Received: by mail-wm1-x336.google.com with SMTP id l1so4224050wme.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 07:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gaI9AVEMXMIlZsv2qUMeoE7EYhjKWKeZwlkxHdQJpWc=;
 b=KmmwRx3Gqlz8BN0QnYTIRV/jV+wxX0C6uSdV/dSQh4kszqsX8c10apaXW/Y3oSUGVO
 LGC+FNoHoJx5aX1/YtCwkAO5zP3UtaCk0o6Nw7yDNp84necmUcU/S7Zb4MgMcdq7+3bw
 d+ufBuUoGC7WbHoeCB5RABQnikFmca/i86lBD7DifjihxVBDYcsSXruX/3Luw0clw91z
 1CQMhQIU64bihli7jBue0ezPb9YzXz7G/iWdeCs3D25Y/I+GAlreG/MgLR/977UEkn6n
 aqNyAm0EE5ScD4gNtOg5NftnIKXd/QaKUtIKo2RwTkh1Gc+VYW7jADsxU0X+APu410zJ
 PkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=gaI9AVEMXMIlZsv2qUMeoE7EYhjKWKeZwlkxHdQJpWc=;
 b=n1g/eMLnjqMNH/Gn1Zgpi6tzYC5XvukHBn7HvX22fpev2ldNIN2xeAh2mRHwSzy5Hj
 T3MWxgPR3kDd5FsgSbG54s6pbJxNUVrt3fn6079bsjjMUzPZq63nks513VhdAyK8KDYL
 263NgZQQLVfEc4aIUJ763OJdQV9CaBkV7mitUw6PWk/lKHR9H0WB3kKZ6iR7nJSw5Liq
 kPBXCd46A+67iPPzSVe64nvRoBTTT58RIlfkLEnlMy0NG1dSCe7o5ZXusghUcjdm997D
 syt9ZFopShAKr4KDvQEiUxWXaEvMV7Ud3QV7LQbZZbvv2miaGMYwhYEyNucPi/r7ouT5
 M21w==
X-Gm-Message-State: APjAAAXhEmJHwEMUqJ+o7wsExs/V6wVxbNlD4nTpAbIHvzqC/sC1ZzWN
 D20yjqTkyY4khYNfNIG+o0zfnHQY
X-Google-Smtp-Source: APXvYqyrznhpGqfwuhGIo1108Z7B+eAKfK8Yu4EHEHbG3tQKkX0oxIQ68bF3Qyj9/evBw1L8A+K3mQ==
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr10914452wml.170.1574350615051; 
 Thu, 21 Nov 2019 07:36:55 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m15sm3970933wrj.52.2019.11.21.07.36.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 07:36:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] i386: Add -noTSX aliases for hle=off, rtm=off CPU models
Date: Thu, 21 Nov 2019 16:36:49 +0100
Message-Id: <1574350609-29518-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574350609-29518-1-git-send-email-pbonzini@redhat.com>
References: <1574350609-29518-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

We have been trying to avoid adding new aliases for CPU model
versions, but in the case of changes in defaults introduced by
the TAA mitigation patches, the aliases might help avoid user
confusion when applying host software updates.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 37c023f..730fb28 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2904,6 +2904,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
+                .alias = "Skylake-Client-noTSX-IBRS",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -3025,6 +3026,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
+                .alias = "Skylake-Server-noTSX-IBRS",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -3145,6 +3147,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
               },
             },
             { .version = 3,
+              .alias = "Cascadelake-Server-noTSX",
               .props = (PropValue[]) {
                   { "hle", "off" },
                   { "rtm", "off" },
@@ -3257,6 +3260,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .alias = "Icelake-Client-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -3373,6 +3377,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
+                .alias = "Icelake-Server-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
-- 
1.8.3.1


