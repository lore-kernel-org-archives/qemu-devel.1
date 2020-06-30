Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02931C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09EA20780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4WrfqLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09EA20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDfI-0008WH-W1
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqDeL-0006pE-Du
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:38:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55052
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqDeK-0002IO-0g
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593513479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07ct4LP1waPEbEUp/nBsoiz2BrOfaHiWs7K68B/S55o=;
 b=A4WrfqLEo0zxy/BVcb4BAAeduO/KQpYMT6CGRg31iae7j/qprk12D4ZJ0EBhg0MjP/K2Z1
 02CLWxl3SnxKimzKoq8njeIN2JdFfAxMSSY4CR/6ZAkElDuDFuFhtg6Oc+EnFm50SNmaSE
 8yYvfXNydJ0kkZT254rGs4fUexD17n4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-LOvzEYUZNN-xBlMHzlVbCA-1; Tue, 30 Jun 2020 06:37:57 -0400
X-MC-Unique: LOvzEYUZNN-xBlMHzlVbCA-1
Received: by mail-ed1-f71.google.com with SMTP id d3so2875477edq.14
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=07ct4LP1waPEbEUp/nBsoiz2BrOfaHiWs7K68B/S55o=;
 b=uOrQkbW8bzhviB0I4VMfO2PG/fHDYyppKCZKN/Y+hFD6Cgbom8K5VYs2rBbsD5p79R
 z+cugJ9virrQ4s/8VHThGnY6Vb/aIfqBeKiTuxks+DHak0LLzHxu7PzKxLRkPc+5H7g6
 RKqNKcLDGPR+VEQXzTMZPYoOdWBdfN+wHugCmXHVC7eErb06kyuTu59ypPakbcqhbMUx
 Jc4ryk6TfYmnFHxD2HR7ozyPLs+Es42oDskA3SqPqYgYGCzVH0YS/W/DBrDVwYwx9gUR
 nefrzmeU+Us4DSQcdzt2WwXg4b1n+SN+6shz/5VawGVek41TMmBsd8HDo+SKVkcLmu4l
 aO5Q==
X-Gm-Message-State: AOAM530NXpWJayPNVeIiD3aY3SQ8vUfl6ir+8LCyMBD32YCfrIf7JXHB
 M0YkzLvxGcVouUbgxGFTNgajavxk5BOSrC5dExp4LhvjbzikYOukuwdP3O0As8X1MEiysmI5zqH
 +Kuc3oNTi5XjwUcI=
X-Received: by 2002:a50:f08c:: with SMTP id v12mr21817174edl.119.1593513476389; 
 Tue, 30 Jun 2020 03:37:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRkx0DAQKnDdDHqoeNpSfMkF+Ch6VdicM4WS42wesTeAvNpntDA9EgVIswaL5NEQPKHS4CvQ==
X-Received: by 2002:a50:f08c:: with SMTP id v12mr21817165edl.119.1593513476262; 
 Tue, 30 Jun 2020 03:37:56 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id lj18sm1676744ejb.43.2020.06.30.03.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:37:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] hw/block/nvme: Fix pmrmsc register size
Date: Tue, 30 Jun 2020 12:37:38 +0200
Message-Id: <20200630103739.9715-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630103739.9715-1-philmd@redhat.com>
References: <20200630103739.9715-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Persistent Memory Region Controller Memory Space Control
register is 64-bit wide. See 'Figure 68: Register Definition'
of the 'NVM Express Base Specification Revision 1.4'.

Fixes: 6cf9413229 ("introduce PMR support from NVMe 1.4 spec")
Reported-by: Klaus Jensen <its@irrelevant.dk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Cc: Keith Busch <kbusch@kernel.org>
---
 include/block/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 71c5681912..82c384614a 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -21,7 +21,7 @@ typedef struct QEMU_PACKED NvmeBar {
     uint32_t    pmrsts;
     uint32_t    pmrebs;
     uint32_t    pmrswtp;
-    uint32_t    pmrmsc;
+    uint64_t    pmrmsc;
 } NvmeBar;
 
 enum NvmeCapShift {
-- 
2.21.3


