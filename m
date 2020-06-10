Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8B6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B8B2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F04PfqU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B8B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jispk-0004vp-95
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisNd-00040S-HH
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:30:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisNc-00005k-4V
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8oMz8cU0uw+UrewEP7VqnSORJBEZFEU72TWJXbPFmA=;
 b=F04PfqU9goRTkKjLEYs+aVkvyPrAAF5TcMS7IVkMBZYBqE4lbQkISF2FiA1Ges8iRRRyI/
 o1rZy8yiAMHRz401BesKI9cGQ3t/29aRXgnjJFsqx6jpS3yG0eyGq7bDqaePP99tbp9UCA
 31gTsqbpwPD9OGOYKqTpI4/oW5HRHQ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-4yD4eFIcPyycPi26c5kGQQ-1; Wed, 10 Jun 2020 00:27:42 -0400
X-MC-Unique: 4yD4eFIcPyycPi26c5kGQQ-1
Received: by mail-wr1-f70.google.com with SMTP id w4so506404wrl.13
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=S8oMz8cU0uw+UrewEP7VqnSORJBEZFEU72TWJXbPFmA=;
 b=G+DZRlAO3j+TzpkZSd3FqPuk9TIJihG+oPNkZkgkQnJSnCvGBHzszxkiQlnycF6V2n
 aeyiyWQEiJCUmAqyLlGyJI824nOf08J3+chC12bXLrvWHFn/aRIk0pYYj8qNHecxKYtJ
 qD529nYjccVgyQbg13xwGJ49xlqAdax+63ApReNvpZ90u5KUzB5QBSYnC3/1N32Y8vqM
 tD2nBbDNU4NcFuYVfZkUZcG8jYYLpKPocwMjdroLC+l1bJCXeXfoJHKh5gIja3r9AQ0d
 CUsf+wvZsiyEEmGzp0fywyHq6qrTAFdNA5J/YAZp+YSCe1huvmSBOD5kVLc4g+AhsR7h
 uZ6Q==
X-Gm-Message-State: AOAM53029r6WSX4LbOAZOWeUAk5oDtiyoTqeNvyFQakZkehNpPvXnA7K
 K1FFyo5cY0y3eukgRYdxJzv20WZK9Q4oeyPgbk5ERV9Z/7ZaFMB4Tw7mp8NyyYqk/Bg1JpRFlug
 jVMChvLj/jgYT6x8=
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr1204263wmh.175.1591763261610; 
 Tue, 09 Jun 2020 21:27:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGdyzCZdQd+PQD52Zml4SpSa2Q+/10LL4vMMT9e+C2hEBEqlMDn96B0RP19L/GdYoxvH6XCg==
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr1204247wmh.175.1591763261392; 
 Tue, 09 Jun 2020 21:27:41 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id b18sm5885041wrn.88.2020.06.09.21.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:40 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/56] hw/pci-host/prep: Correct RAVEN bus bridge memory
 region size
Message-ID: <20200610042613.1459309-31-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

memory_region_set_size() handle the 16 Exabytes limit by
special-casing the UINT64_MAX value. This is not a problem
for the 32-bit maximum, 4 GiB.
By using the UINT32_MAX value, the bm-raven MemoryRegion
ends up missing 1 byte:

  $ qemu-system-ppc -M prep -S -monitor stdio -usb
  memory-region: bm-raven
    0000000000000000-00000000fffffffe (prio 0, i/o): bm-raven
      0000000000000000-000000003effffff (prio 0, i/o): alias bm-pci-memory @pci-memory 0000000000000000-000000003effffff
      0000000080000000-00000000ffffffff (prio 0, i/o): alias bm-system @system 0000000000000000-000000007fffffff

Fix by using the correct value. We now have:

  memory-region: bm-raven
    0000000000000000-00000000ffffffff (prio 0, i/o): bm-raven
      0000000000000000-000000003effffff (prio 0, i/o): alias bm-pci-memory @pci-memory 0000000000000000-000000003effffff
      0000000080000000-00000000ffffffff (prio 0, i/o): alias bm-system @system 0000000000000000-000000007fffffff

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200601142930.29408-3-f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci-host/prep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 1a02e9a670..88e2fc66a9 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -294,7 +294,7 @@ static void raven_pcihost_initfn(Object *obj)
                              &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
 
     /* Bus master address space */
-    memory_region_init(&s->bm, obj, "bm-raven", UINT32_MAX);
+    memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
     memory_region_init_alias(&s->bm_pci_memory_alias, obj, "bm-pci-memory",
                              &s->pci_memory, 0,
                              memory_region_size(&s->pci_memory));
-- 
MST


