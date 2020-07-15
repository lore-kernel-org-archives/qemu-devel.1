Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A600C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03103205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUp+C5xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03103205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jviSR-0002m6-87
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jviRf-0001uE-Ex
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:31:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jviRd-0004RO-55
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594823496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FHUdpwI/e04VKflNbP5dRc1lRbvhPuEpIoG9FxQ+WWE=;
 b=TUp+C5xFZ/Jc829BzM/VdQ+uvkHvqIfZT25HQEDe1XUf/qF2W4esTBPTnDpX/1Tuj+JV7c
 KSgG6xSERZhn2trA8S46tuKZa5UoR+oxG8pSz7L+ugtWn73EeTnb3wop+yHZfwXA5vNI2c
 vxCHMhoDU1Y+iqSLMEd8vIqAJBOSdQg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-6eaUClykMHO2dzj2Gnxsug-1; Wed, 15 Jul 2020 10:31:34 -0400
X-MC-Unique: 6eaUClykMHO2dzj2Gnxsug-1
Received: by mail-wr1-f71.google.com with SMTP id c6so1453437wru.7
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 07:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FHUdpwI/e04VKflNbP5dRc1lRbvhPuEpIoG9FxQ+WWE=;
 b=RWGLVFRMw7sL0CkjAlZsnS/0kLgEFtgicZjuWpqjv2HUCTTE5UZt1dKdoEEHEV4aRV
 VclR6qhmv9YVDf8QqTJhDxk3XLJ3gu/RneIRFiT/v+XOr0g3LEbyVlCgGupvMKjtkmPS
 pRZBgjZVlPrQtLUo7/Wfdq7TjtQ49SekEoqe2wZRh+rBUafuPsif+iwN8X5Ed9GJYPsP
 IYNTXyefhuhF0qSNvJOdUkBKgQHQBLYgxU7efUy2eWb/lnSlEwB01lOZDkT7ed66npS7
 sXtqHE4zEQuRwwWK64ScnO7Sg5ppVDUkJ+S/n0qkS1YKWPTfksVO35XneC86GJiiH680
 rvLQ==
X-Gm-Message-State: AOAM533lUJC6TyO8Q4NA2tQN1yPSksfvS48y0FxhpfxTPMmzvWSZ77oZ
 BE9ZZkqZ608+pyMbM6yC+nH+Lh0tY6PlsbcQyX2nrykj51MJkzROycpnejUy7tVlzu7U5u3XATI
 kWL1VtRlN/YG4V5Q=
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr9263574wmg.182.1594823493079; 
 Wed, 15 Jul 2020 07:31:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq1ko4VIdvprtDyeBQIAhB67v5Nt1jw4JYKd9krMoIV0/OJamgWYSkfwQ6kFcthMWdfKIFOg==
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr9263560wmg.182.1594823492878; 
 Wed, 15 Jul 2020 07:31:32 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm3653030wrn.76.2020.07.15.07.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 07:31:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] net/colo: Remove unused trace event
Date: Wed, 15 Jul 2020 16:31:30 +0200
Message-Id: <20200715143130.11164-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unused trace event cause build failure when using the dtrace backend:

  "probe colo_compare_miscompare doesn't exist"

Fixes: f4b618360e ("colo-compare: add TCP, UDP, ICMP packet comparison")
Reported-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: zhangchen.fnst@cn.fujitsu.com
---
 net/trace-events | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/trace-events b/net/trace-events
index fa49c71533..c3f623d40c 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -17,7 +17,6 @@ colo_compare_udp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
 colo_old_packet_check_found(int64_t old_time) "%" PRId64
-colo_compare_miscompare(void) ""
 colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int hdlen, int pdlen, int offset, int flags) "%s: seq/ack= %u/%u hdlen= %d pdlen= %d offset= %d flags=%d"
 
 # filter-rewriter.c
-- 
2.21.3


