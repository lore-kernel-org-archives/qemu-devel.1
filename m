Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB5BC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7F5216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0M/3mAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7F5216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SOb-0006Nk-EQ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFi-0002HI-JJ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFh-00032K-HO
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:22 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SFh-00030y-Bv; Wed, 21 Aug 2019 11:10:21 -0400
Received: by mail-pl1-x643.google.com with SMTP id c2so1476489plz.13;
 Wed, 21 Aug 2019 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vzEiXgWMAIcrtGJtWdLNIaBgt80NgMVHhXxi+ye0uTI=;
 b=A0M/3mAV+FSZzwI0stLMw6XN/IXJJ1xCjzxsqTvd932Jy8GnDmiA95wA2iyEoDo87Y
 u4fDctytid7KaC004lHg4ZyZamgZe3zxszOWO2+AlzT4HO0BRcWpe+poL9iJSY/MYLOK
 q9fMG62TUMaEfzQfE3LiHyvmqmTLHx4wEYZ2tGQ10w0/Xl1z6Xezp0r/fDBMA2GkaekD
 7IPCelcLHn4dheN/1KopATZbOSG0mz4VgFAjV/KTXm39jDLUN9RamNuBPD9cA3BradPY
 xchk+LvwSd6JvTDXX3gjUYBLPp1HBX/Q/vfIzAdjc4O83X93Oc8Z9CfAS9VKEPfXcJ4S
 lCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vzEiXgWMAIcrtGJtWdLNIaBgt80NgMVHhXxi+ye0uTI=;
 b=FIuxllIYZIyvA9ic6flXsaPoxmY1Kyk6q60UQ2o1h1uxJmw3uGMrQdXRXFCWRRzZbP
 Fkiqi3BisCHl8tFV8QSp6+jWRUJJJfefOdd2/NuUVYEDouFPH1eMkXPaKMn07XzOW1WR
 sz5NvSyjTfhFTj8a8MSbnnp/8vZ+Ip0oYFF78H6yLCZdzY7Pp++z5Ftio1dEAixsv7Ln
 78TAoG0a6jZcgobZpsPt2z1uOlpnFQhrCxjniTFgHdWQieW0HSt/8uu3WT8TAvO+NKmj
 I2PpJfa5GlIJwagkJ/bbfVdNtm0GcQ/c1aQvwM+pstZ787jHOLLOwdMamLfqowWz5upF
 5hDw==
X-Gm-Message-State: APjAAAV/DTim3ilzSq8uB30wLDKchgQ8CruVy6OJZLtudLPN6fdrYaeU
 iwWNZLfg8jnWeVLgKLnKNrNAMReihds=
X-Google-Smtp-Source: APXvYqwRWhBfVhCU/AgiCrq61faUtuf56jJYcmKra3T0GK/rTOwV/NIWxuubIDayeZsuWydAAtY6zQ==
X-Received: by 2002:a17:902:bb94:: with SMTP id
 m20mr33697001pls.336.1566400220206; 
 Wed, 21 Aug 2019 08:10:20 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:19 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:06 +1000
Message-Id: <bd8cba693cdda2a30c400142b576930404bb6951.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v8 12/21] hw/s390x: Hard code size with
 MO_{8|16|32|64}
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Collin Walling <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Tony Nguyen <tony.nguyen.git@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Temporarily no-op size_memop was introduced to aid the conversion of
memory_region_dispatch_{read|write} operand "unsigned size" into
"MemOp op".

Now size_memop is implemented, again hard coded size but with
MO_{8|16|32|64}. This is more expressive and avoids size_memop calls.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 0c958fc391..0e92a372ca 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -782,8 +782,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     for (i = 0; i < len / 8; i++) {
         result = memory_region_dispatch_write(mr, offset + i * 8,
                                               ldq_p(buffer + i * 8),
-                                              size_memop(8),
-                                              MEMTXATTRS_UNSPECIFIED);
+                                              MO_64, MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
             s390_program_interrupt(env, PGM_OPERAND, 6, ra);
             return 0;
-- 
2.23.0


