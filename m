Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6231FC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0F421670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHyCKijx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0F421670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUwV-0008Ro-G8
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34235)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkQ-0004TY-Ku
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkJ-0002zu-UD
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUkC-0002li-VS
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id a10so9932830wrp.9
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JvV1iVqyAdHF++s4qbNgPhXah3+qiDNHrezSixoPhkU=;
 b=mHyCKijx57N9McKdZR2Ut8MF57TxOE2rTTDhHAREOehCXinalcBZgvaV6JWt1C8OC0
 9ECGlWdHZvAM/YESYZRPSekk+JuAobLSYo1ZnjjFVf4CtETWyuepys+gyVTokMDy5lUm
 GQD3iJrxfoFPYM/l70pCIxKrBSpNGI9rJw7xMISx8e62PiGtI71y0F/ARjCH5Ocfpwb7
 sFmTPaWB9udUbUlKSDuU91+xlbo/mZ2UAUIIcUO+aYiACYJOrmICSc1PQxc68wGc9Zbp
 PK1Fx9L2mgIJWlBMKJIFwDcPCPBUbqqnN7CarD2MXN+ajgmhR9NNKC/Q4OyrCpeXAfF3
 moUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=JvV1iVqyAdHF++s4qbNgPhXah3+qiDNHrezSixoPhkU=;
 b=CzmScz6R1Bsk4s51lLMOY+FUpZI1AR8DA5SOj+PT1xyXL/ay9I7XeNrKhTSk7vXfj/
 734/8L3NDMxuddxd/Uj7Q2+n5P/m/ZIANGkCDb1VKsMso9pKMTYQNql0fGh1g9mePMfE
 S1lY1hcM51FtEUOhAp8T40aXSuVuMxVp9OZ5fy705znj5Dy4EiYuq7wjOIr662FQX/fw
 SjOKEOedklzZ2IXTbmUsb2yDC1Mx1CmVoXb2wYBMTUhq9KWRDGmpiklPHvQLsWQ6ulbG
 BmB4AzfLzyDx17MpvepB6MFNqk7tEZ+nfBTH78qX/3BKfNbaDwPw3cYXfXml9Rd4bzGQ
 /Aew==
X-Gm-Message-State: APjAAAUzKCOD9DvcPtNIB1LuW/RTceMuivZHxgctfagdJT97f/ZSakdj
 nMlj0XUjz+JC3eqBeVxs9JvZthRBnuc=
X-Google-Smtp-Source: APXvYqy3vrPXBKUIrjJ0vdtHgDMhQBdVUbEpDeJAhfYQtKbPCKIt5LeIogIFbCjWwdzDN0MAnCOtmw==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr2447440wrp.191.1562358211934; 
 Fri, 05 Jul 2019 13:23:31 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:19 +0200
Message-Id: <1562358202-28008-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 09/12] target/i386: kvm: Fix when nested state
 is needed for migration
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

When vCPU is in VMX operation and enters SMM mode,
it temporarily exits VMX operation but KVM maintained nested-state
still stores the VMXON region physical address, i.e. even when the
vCPU is in SMM mode then (nested_state->hdr.vmx.vmxon_pa != -1ull).

Therefore, there is no need to explicitly check for
KVM_STATE_NESTED_SMM_VMXON to determine if it is necessary
to save nested-state as part of migration stream.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20190624230514.53326-1-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/machine.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 851b249..704ba6d 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -997,9 +997,8 @@ static bool vmx_nested_state_needed(void *opaque)
 {
     struct kvm_nested_state *nested_state = opaque;
 
-    return ((nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
-            ((nested_state->hdr.vmx.vmxon_pa != -1ull) ||
-             (nested_state->hdr.vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON)));
+    return (nested_state->format == KVM_STATE_NESTED_FORMAT_VMX &&
+            nested_state->hdr.vmx.vmxon_pa != -1ull);
 }
 
 static const VMStateDescription vmstate_vmx_nested_state = {
-- 
1.8.3.1



