Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6412C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9192A206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmRlYKG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9192A206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9shg-0005Ez-CQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCw-0006U9-IT
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCu-0007Tb-G2
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:35467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sCt-0007Sq-Rc
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id y21so103188wmi.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fWK7xkNMUlgfTrhGnvGuIYUCcAtGnQSBVV6UtaSG9/g=;
 b=jmRlYKG5kXGqlNC6hKtUuZNj0FM9tuKyfuptebwfpg6zPqES+Fg2Ka3u+nLvAr6paY
 mZc4MU2P5RDoYxZa6Fq9woKWGaYrAOC4fWkKz3zRxNd0vYwlDT1pagApJUO6TDrNcuto
 PqQLGc/CxO/SzNAMEwhYdnxwt35a6jpxxgaLat1t2TZ+kV5PGPxa67SmkJYYusMrO0ig
 UXMGQN6/pXAqm+TQaToyCCS80iNS7Xq1BqG0tVlmw8dlbVmywS2WNyaLPlW09pq+T8ob
 apE2y46OPNMAXwVCIZTr8x34xlbdQUYuLaRI7aru5iRS7e9iqGOGrBkBePWrWY2Ggvta
 6vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fWK7xkNMUlgfTrhGnvGuIYUCcAtGnQSBVV6UtaSG9/g=;
 b=STszWHDcsIH9FO8gn8Wrc6Vw8HNHcPgSTULiVFX0U4T5foDeUHwpPQ41DRADMevPIh
 Q5ugD5wtFT4n/NwXqcc1TMGZrOs++UrRFdV0Uz9VkDOOG11Elfjt0kSBhfVRDtIscBlm
 fOAsEija/gHJIOaDeVvi7xK4TBlgeHdQEWjF3j56sPV6udqdkB5Nf6OdO1FmaIxknJ3k
 GIUvXvLl3uXrIn9AStbSHrkRkv8v6M+f9CPu2u90PopYFlzXkx8CjemZOhvW5876I0n9
 NUHZrm8gyv8RI2JI+u6AdMuwjYNrTUYsm4WdKTtMKfAOZjVH1NNkeY5c5uzLWTbUq3qQ
 Uk+g==
X-Gm-Message-State: APjAAAVZ0F4FA+lsqbPbEAn1xpE9pAE23W2oj8hccHXJY40ppXDyPtXJ
 HzNjUV97X55pCZQOf57l1mH3Mlhs
X-Google-Smtp-Source: APXvYqzh5s6MT4f2NjdJLxsUHrH+oqa8OhIjoNL2rBvlQcq6FBwNIV5+D3KsIeGsNn3gYAjKCuTDyA==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr24953wmj.121.1568644941886;
 Mon, 16 Sep 2019 07:42:21 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:50 +0200
Message-Id: <1568644929-9124-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PULL 10/29] elf-ops.h: fix int overflow in load_elf()
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
Cc: Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

This patch fixes a possible integer overflow when we calculate
the total size of ELF segments loaded.

Reported-by: Coverity (CID 1405299)
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190910124828.39794-1-sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/loader.c     | 2 ++
 include/hw/elf_ops.h | 5 +++++
 include/hw/loader.h  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 32f7cc7..75eb56d 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -338,6 +338,8 @@ const char *load_elf_strerror(int error)
         return "The image is from incompatible architecture";
     case ELF_LOAD_WRONG_ENDIAN:
         return "The image has incorrect endianness";
+    case ELF_LOAD_TOO_BIG:
+        return "The image segments are too big to load";
     default:
         return "Unknown error";
     }
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 1496d7e..e07d276 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -485,6 +485,11 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                 }
             }
 
+            if (mem_size > INT_MAX - total_size) {
+                ret = ELF_LOAD_TOO_BIG;
+                goto fail;
+            }
+
             /* address_offset is hack for kernel images that are
                linked at the wrong physical address.  */
             if (translate_fn) {
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 07fd928..48a96cd 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -89,6 +89,7 @@ int load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz);
 #define ELF_LOAD_NOT_ELF      -2
 #define ELF_LOAD_WRONG_ARCH   -3
 #define ELF_LOAD_WRONG_ENDIAN -4
+#define ELF_LOAD_TOO_BIG      -5
 const char *load_elf_strerror(int error);
 
 /** load_elf_ram_sym:
-- 
1.8.3.1



