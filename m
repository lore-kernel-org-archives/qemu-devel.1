Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DD1C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC002054F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfxRh8HG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC002054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi9g-0001kT-Cs
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrN-0005SI-7J
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrL-0003Qn-Sd
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrL-0003Pk-Jx
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id p7so7968694wmp.4
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=XQJk1DHPtMxR5rn6iJkZ4+R9JTJIU95kBBNqy6kS5R0=;
 b=mfxRh8HG/WR9akh1+9ibjC5P6cgNZVkmRH+D0d6GRBWPN/dCvg24vEzxpiUCmhurvV
 /YQN4UMa6vXquqdcu7eAl3kuES/O1pHiu8RsRIOC5+DkK3zZU7PcNVlg+N03nGmFCy3U
 wuSrYX4S9Tin09MTm8XZrtCIti+EoZBCVFjzrqiXwX0PPFBwqF6a4LULwJ8h5u+lbhor
 3TX1zFvitlflnQzRSCt7Yw5VrsYy4heUNPSgLHL7Rpmkm/jFYNQuHmnUSyXhcmPQ0UwW
 KKTzZQClPMhbNqg93EJCkrfUDv0H7MP4S5Pjnu2tUJ4tLHc8orkjs71a708nYl+JJkwT
 tSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=XQJk1DHPtMxR5rn6iJkZ4+R9JTJIU95kBBNqy6kS5R0=;
 b=YkOz5fP1Yh0MnHNdjvlqPlT+4b37GB5xGa0BSR2TAVkT0BZHT7j5f9dOr7Q6szbfUW
 zC4tIKxySDwBJk8deqEHe1sTWi72beOhBUjVcXKQwa8kTOcQB04hD3BT/IjwM0VIkVAk
 9Mf1+7z1Gqe4OEhMJnz7/EY5WSaR5hHe6hzw+3D6c72cvmnlBkLW+fOBZbxLA4vT6rCB
 ndwfQHMgq35FMUeexwX8qWUH1Q3CLhGHitFu1rSZ+HvqZW+acnkOUyXr0bIwvgPIoxpO
 7cp7QyPM/4Qbq/5Kl20K9QzrBgxp7fVlGO/B/hixSnEGd384niL36CMEwrVGqhEQfBq6
 aJeQ==
X-Gm-Message-State: APjAAAV3FnvsryyvfTXbW4rZK37xKp/VTjEb4HdbQYUg6A/WWFgp6Tge
 NZIpTuEHZg+2/+doodbux4yptBSg
X-Google-Smtp-Source: APXvYqytYYi13XucODbggEKUqldvBriEYTyy6rL8afO2BACKWUADoTPQc5eHofRNVHZMA4atHpE5Tg==
X-Received: by 2002:a1c:a851:: with SMTP id r78mr3574856wme.166.1570035134368; 
 Wed, 02 Oct 2019 09:52:14 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/30] cris: do not leak struct cris_disasm_data
Date: Wed,  2 Oct 2019 18:51:42 +0200
Message-Id: <1570035113-56848-20-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a stack-allocated struct to avoid a memory leak.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 disas/cris.c | 59 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 2f43c9b..0b0a3fb 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -1294,24 +1294,17 @@ static int cris_constraint
 /* Parse disassembler options and store state in info.  FIXME: For the
    time being, we abuse static variables.  */
 
-static bfd_boolean
-cris_parse_disassembler_options (disassemble_info *info,
+static void
+cris_parse_disassembler_options (struct cris_disasm_data *disdata,
+				 char *disassembler_options,
 				 enum cris_disass_family distype)
 {
-  struct cris_disasm_data *disdata;
-
-  info->private_data = calloc (1, sizeof (struct cris_disasm_data));
-  disdata = (struct cris_disasm_data *) info->private_data;
-  if (disdata == NULL)
-    return false;
-
   /* Default true.  */
   disdata->trace_case
-    = (info->disassembler_options == NULL
-       || (strcmp (info->disassembler_options, "nocase") != 0));
+    = (disassembler_options == NULL
+       || (strcmp (disassembler_options, "nocase") != 0));
 
   disdata->distype = distype;
-  return true;
 }
 
 static const struct cris_spec_reg *
@@ -2736,9 +2729,10 @@ static int
 print_insn_cris_with_register_prefix (bfd_vma vma,
 				      disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v0_v10))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v0_v10);
   return print_insn_cris_generic (vma, info, true);
 }
 /* Disassemble, prefixing register names with `$'.  CRIS v32.  */
@@ -2747,9 +2741,10 @@ static int
 print_insn_crisv32_with_register_prefix (bfd_vma vma,
 					 disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v32);
   return print_insn_cris_generic (vma, info, true);
 }
 
@@ -2761,9 +2756,10 @@ static int
 print_insn_crisv10_v32_with_register_prefix (bfd_vma vma,
 					     disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_common_v10_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_common_v10_v32);
   return print_insn_cris_generic (vma, info, true);
 }
 
@@ -2773,9 +2769,10 @@ static int
 print_insn_cris_without_register_prefix (bfd_vma vma,
 					 disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v0_v10))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v0_v10);
   return print_insn_cris_generic (vma, info, false);
 }
 
@@ -2785,9 +2782,10 @@ static int
 print_insn_crisv32_without_register_prefix (bfd_vma vma,
 					    disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v32);
   return print_insn_cris_generic (vma, info, false);
 }
 
@@ -2798,9 +2796,10 @@ static int
 print_insn_crisv10_v32_without_register_prefix (bfd_vma vma,
 						disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_common_v10_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_common_v10_v32);
   return print_insn_cris_generic (vma, info, false);
 }
 #endif
-- 
1.8.3.1



