Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B018C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041F0206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivRY8BgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041F0206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnCW-0001gB-3T
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7S-0000xw-VG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7Q-0005wW-3C
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QoQLqcCGXTEq/TAmIUw2m4awB0M5QrT2MRC6GDSSjNM=;
 b=ivRY8BgZ+ti9tJmlZ67Wli1N7as/5EAOtR0woudnf7uy4Cx8/g1COXeAjehJReyhERMUVC
 Zw2pH4CyfBZ2+OG+p9obuFzRaRq1E0S253swZNeP8WoVbaU9vaNfyfi5OUIJuLc6FK6drL
 bOiIHs44T1DUZyoWh3VUcBY+vJ/CHxI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-eVd1i5OjNdCLA2B_KwkohQ-1; Thu, 03 Sep 2020 07:09:26 -0400
X-MC-Unique: eVd1i5OjNdCLA2B_KwkohQ-1
Received: by mail-wm1-f69.google.com with SMTP id m125so840318wmm.7
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QoQLqcCGXTEq/TAmIUw2m4awB0M5QrT2MRC6GDSSjNM=;
 b=nAVVo+0ruIW8xFMP6/daoE1Z77/cOBreIKYS+w/mY+NgPoNQQWzkxPs04tIQ2l3vz1
 849hR5UUZ55dy920YqqYgrWvfeDL1haeVjJL50Woxv0yYVM8oSSaj7kjNSaX23EtKb5H
 IRJyXZo0UyXTzTkk6vFuId8J50pbWstzJaa9mBw8aQWAoNT+kN6qY+NwSUViZijB3xG5
 v6shD02N/5rO4YyDfrqZ1gH3pUzL1yQW0vtPsMxjQMGMtJ8vzsoBEod+PbGmrE9tFo9t
 D6MrJJ8uDPz2ex0RV1fhDC8i/wwqywx3vvzgz8pfUk3qjIqJlI70rwNWHkFmWZkEp5em
 5Rkg==
X-Gm-Message-State: AOAM531LhKlIEc/CN3ShREA8xT32voFkX1LmLyHZy5QuxIYlG24Xklfi
 X2eAH9prvhScMVlCclrHSP4rtFJM3aUd4bNZDgi0fTR/037Jo7m3NHnfwFAtLQTwDXWv666msRd
 e0ussoT5lybj5tK8=
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr2031717wmd.72.1599131364949; 
 Thu, 03 Sep 2020 04:09:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaSU7iRONFARcRVCRaU47oXkeaP1W8IN/jSQZtdmBcceRd3LDSad+4MzXAb9YBpYg9kk+eLA==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr2031677wmd.72.1599131364785; 
 Thu, 03 Sep 2020 04:09:24 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id h6sm3675054wmb.22.2020.09.03.04.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:09:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/12] docs/devel/loads-stores: Add regexp for DMA functions
Date: Thu,  3 Sep 2020 13:08:27 +0200
Message-Id: <20200903110831.353476-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903110831.353476-1-philmd@redhat.com>
References: <20200903110831.353476-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/devel/loads-stores.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9a944ef1af6..5b20f907e4d 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -477,6 +477,8 @@ make sure our existing code is doing things correctly.
 
 Regexes for git grep
  - ``\<dma_memory_\(read\|write\|rw\)\>``
+ - ``\<ldu\?[bwlq]\(_[bl]e\)\?_dma\>``
+ - ``\<st[bwlq]\(_[bl]e\)\?_dma\>``
 
 ``pci_dma_*`` and ``{ld,st}*_pci_dma``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.26.2


