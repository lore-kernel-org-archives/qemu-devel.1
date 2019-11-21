Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE436C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7296206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa41B4+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7296206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoZe-0003eP-Pg
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXoVt-0006os-4a
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXoVr-0001QZ-I4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:57 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iXoVr-0001Pn-Bc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:55 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so4978973wru.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9dUEfigVchHfX6ZaLvQxxNBaTzzF6DYxdQ+mCErjP7w=;
 b=Oa41B4+arAzFalN9Shq59ofAqTNT/h3LCHUZ3hXN2SLugpag2ZZe39tPBt2V6mMBnC
 3T4YfUWc6nYlrzdFV/B3EZU8hJ3V2IgTPDmFMTc1T77NwHbPuOtlpZaZmT54u1AHWaWP
 XxADw/MSyeGSQMechYnLmItQ3JYZM3HLReiM9GkXI5D67cSp/kCgQMa/JslU6JtYZrlO
 ZEU73enTMK7874DI9c2jwVkcAc5h3C1eg+4UX5IySHX1NoklTTHdKb7oo8uWxrri9gwu
 zLem+BdAG90mK72hj6nVUs871GFp23cOcszZBojJ1Aj9Ah6dFDNVtrhPlBlC/OeW5FtX
 M7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=9dUEfigVchHfX6ZaLvQxxNBaTzzF6DYxdQ+mCErjP7w=;
 b=G5Q/sWa45Oe0uwWOnxN2fOYAckL/oZifjgKaAwWz0qZlcWMBl+xWJcYt4K7+rR4Jo8
 6+eo+ys1iruqZEW3x72tnUJL68kLQ9mMPUtreJkOglkv6QgAwIC+7VXb1S0dZd7cCr7f
 NyR8DguIjlmBzwyjCjdv3gF7DY6Y3ruoOV5bdWf5uHIW0qlz0zsvNbTj1jOfTtu4rQmh
 MB/kurjwLy95xCKZXcMmZ55tLbb7+LtdZ1oMAZUaBC777WyEtFdMommqyALdylNbFBrA
 M5fDOB6qGddxysHMg9Jg7ei4H1sCLpabJLZeL5T+R2NofLdHlzWoMO2gq+V8j81jdY1C
 IHSQ==
X-Gm-Message-State: APjAAAVgBGZ1PsknGogZa1AIeN739k5lFlMG3JepfwMjrZTJBjdGTG0V
 9X6MYtBxX7M/b27VtN/Ep5CswdIU
X-Google-Smtp-Source: APXvYqzaAMMwlvIzRy862wlNimEvFgmKZs621yTZafY+eEVekn28uauAgSyoGOTnqN7P89GHWDuzUA==
X-Received: by 2002:a5d:5687:: with SMTP id f7mr7669444wrv.384.1574350613987; 
 Thu, 21 Nov 2019 07:36:53 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m15sm3970933wrj.52.2019.11.21.07.36.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 07:36:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] i386: Add new versions of Skylake/Cascadelake/Icelake
 without TSX
Date: Thu, 21 Nov 2019 16:36:48 +0100
Message-Id: <1574350609-29518-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574350609-29518-1-git-send-email-pbonzini@redhat.com>
References: <1574350609-29518-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

One of the mitigation methods for TAA[1] is to disable TSX
support on the host system.  Linux added a mechanism to disable
TSX globally through the kernel command line, and many Linux
distributions now default to tsx=off.  This makes existing CPU
models that have HLE and RTM enabled not usable anymore.

Add new versions of all CPU models that have the HLE and RTM
features enabled, that can be used when TSX is disabled in the
host system.

References:

[1] TAA, TSX asynchronous Abort:
    https://software.intel.com/security-software-guidance/insights/deep-dive-intel-transactional-synchronization-extensions-intel-tsx-asynchronous-abort
    https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9cd9adf..37c023f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2902,6 +2902,14 @@ static X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -3015,6 +3023,14 @@ static X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -3128,6 +3144,13 @@ static X86CPUDefinition builtin_x86_defs[] = {
                   { /* end of list */ }
               },
             },
+            { .version = 3,
+              .props = (PropValue[]) {
+                  { "hle", "off" },
+                  { "rtm", "off" },
+                  { /* end of list */ }
+              },
+            },
             { /* end of list */ }
         }
     },
@@ -3230,6 +3253,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Icelake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "Icelake-Server",
@@ -3334,6 +3369,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
              VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Icelake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "Denverton",
-- 
1.8.3.1



