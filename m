Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EDDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7412065F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4OlVJTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7412065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqE58-0000Fs-RJ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqE49-00078j-Ua
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:04:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48359
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqE48-0006Pg-Bc
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593515079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2SOqjYn/sQWeHMGBwgSo4MEkKWnWmTRHpTDF+JXJD8=;
 b=O4OlVJTYkYqOlUuxchOjf+wo5PAmattOYkDAxLotkRBaPIzGQlHdvtHrL5cQZblDpkwi4f
 5/tvVAUnzovXrO8xcGy9+MWT3rfuQT778/Xyrh2Xc3h5Z0gZ9YccYXoh/gh1FAeeo7TpeH
 bqETeM2v30K/zKFPdRUy8enHuiuWA3k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-EWoOWi4PP8GoHGch5v9Vag-1; Tue, 30 Jun 2020 07:04:37 -0400
X-MC-Unique: EWoOWi4PP8GoHGch5v9Vag-1
Received: by mail-ej1-f69.google.com with SMTP id cf15so12788600ejb.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 04:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c2SOqjYn/sQWeHMGBwgSo4MEkKWnWmTRHpTDF+JXJD8=;
 b=qj8U20Y33Sq2drkmJeTaGIP56vk2Jqwp7n9+Iqi5gpdHCh4oVNNmX5iOI1asP+3Taf
 /CLF/BxgNlWO1fFHJVviPuEItWSmqeTjbOyMURCGnuv3tqpt5Bql9+Fg0Ko6wDFrGFFI
 jtJNk7LMqnT1tmBQH4/jrBfd47XvlseJFoktuYiIj1SQtEZvT3bX3Wmhh8YmHAB1BhY8
 qrUuPk4/n/iQhh3uCtU0Tm5B8JPBDxXuwk0KWaJaaublLgCtATIYzhthajp9kOYIxjkV
 jbLeS+DQB/n7EIWyXZJrLbYrPHDuvfNyssQP7t48uambYCQQoJAelTY335rsiE9O67j4
 Iufw==
X-Gm-Message-State: AOAM531pFi7baKPczkhaXfHYuhg5Kn/lLP8Y7rcbavRCTlRvzRX9Tqaa
 XP4jff6UJ+ICADSgrJh6Z20FaS9qSD3kuvHCf1GxcbylPfgkC1ESayu8yaiBcBCzil23kQUetqq
 crlMJgeNUVyjn1y8=
X-Received: by 2002:a17:906:6a4f:: with SMTP id
 n15mr17416382ejs.378.1593515076501; 
 Tue, 30 Jun 2020 04:04:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOPV0HJIU201xbqXAcgAe4vdWSqAobzYIFIB5IUFt/NfIyy1z6RrvCESxlUbTtrEyzSY1OCA==
X-Received: by 2002:a17:906:6a4f:: with SMTP id
 n15mr17416372ejs.378.1593515076349; 
 Tue, 30 Jun 2020 04:04:36 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id ce19sm1729984ejb.24.2020.06.30.04.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 04:04:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] hw/block/nvme: Update specification URL
Date: Tue, 30 Jun 2020 13:04:26 +0200
Message-Id: <20200630110429.19972-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630110429.19972-1-philmd@redhat.com>
References: <20200630110429.19972-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At some point the URL changed, update it to avoid other
developers to search for it.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1aee042d4c..6628d0a4ba 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -11,7 +11,7 @@
 /**
  * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
  *
- *  http://www.nvmexpress.org/resources/
+ *  https://nvmexpress.org/developers/nvme-specification/
  */
 
 /**
-- 
2.21.3


