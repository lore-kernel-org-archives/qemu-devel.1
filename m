Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF757C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8671E206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=dacohen@zohomail.com header.b="Vh1FS+Qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8671E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=zohomail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5lQ-00084u-IC
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dacohen@zohomail.com>)
 id 1kD5fp-0005JD-UD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:46:05 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dacohen@zohomail.com>)
 id 1kD5fl-0001WY-Io
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:46:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1598964358; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NWZSamrfca0Ug0Oo4am6hLnIpVnTbVZfLsXxXw3MwCOmHqHYLEbOO5FY5eTpG66zfIS1u7mhqPFgNhy6WDWkIZR/xjwFso9pu9u5ZC4Z7JEui+sMDNQt50CAJCb5ykloTo/JQGQ/IMwPDCozYRevh8j1NIgbDo4xq2KuL147u9k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1598964358;
 h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To;
 bh=5TW+zewYKljC/CEpnCMVFx1AV6rAgZQDJjJfMry849o=; 
 b=klpKJuP++CEWCKnsFF0AhMKOaqfkNUgK1gAXhRqWUQ3uKteID15szizrDMFmpxXKK9/HVfSfQ+1dy+QQp7gA0kcGFC7uUJZ1nDiGA8Legg7Mp+9TyZnV3JWgYLjh6mK36vFXCADJmBU8+DVN5/tU7ve+phgW1556ExecgbVGJtQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=dacohen@zohomail.com;
 dmarc=pass header.from=<dacohen@zohomail.com>
 header.from=<dacohen@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1598964358; 
 s=zm2020; d=zohomail.com; i=dacohen@zohomail.com;
 h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=5TW+zewYKljC/CEpnCMVFx1AV6rAgZQDJjJfMry849o=;
 b=Vh1FS+QdfjoU6ULErYbn6Hak+l3pZmETD/krtDIWhoJ48tyNRlqR0XZTYdxjFwfh
 q8S3a2l7kYp286yYuWf1h1cORyq9ApL07/MoYJal6Lhuddrheg+84AmsnOaVMUdp9sL
 gYWZRgexPV79OQdwjHTA67Xrmub7ncjYkYyxNBis=
Received: from Davids-iMac.local (cpe-24-27-46-206.austin.res.rr.com
 [24.27.46.206]) by mx.zohomail.com
 with SMTPS id 1598964356865630.2277097234039;
 Tue, 1 Sep 2020 05:45:56 -0700 (PDT)
To: qemu-devel@nongnu.org
From: David Cohen <dacohen@zohomail.com>
Subject: qemu panic on OSX 10.15.6
Message-ID: <a1f5ea65-073c-6130-1151-722d66d1564e@zohomail.com>
Date: Tue, 1 Sep 2020 07:45:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.95; envelope-from=dacohen@zohomail.com;
 helo=sender4-pp-o95.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 08:45:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm trying to use qemu on OSX Catalina using HVF hypervisor, but it's 
currently panic'ing upon booting Linux guest.

These are the args I'm using:
build % ./qemu-system-x86_64 -cdrom 
~/Downloads/archlinux-2020.08.01-x86_64.iso -smp 4 -m 4G -vga virtio 
-accel hvf -cpu host

I could trace the failure to test_pt_entry(), in this exact position:

build % git diff
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 65d4603dbf..8f04a94cc6 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -113,6 +113,7 @@ static bool test_pt_entry(struct CPUState *cpu, 
struct gpt_translation *pt,
      }

      if (!pte_present(pte)) {
+        printf("Code is failing here");
          return false;
      }


Is anyone aware of this issue?

Br, David Cohen

