Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AABC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E9720734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL4E9pFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E9720734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisg6-0004yd-UP
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisL2-0000D9-4o
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisL1-0008J0-9W
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10332xG/Et6G9yDWYNuu/GUK5CzyCJzNTiI8MGCB5RE=;
 b=iL4E9pFb4tQZi7ZWGFdEzANnRhn7FtsZwL8MyjdaX4QQbTrBTpbwwcr1fqhu9/mezDWzkk
 Yyngpgxd1lmfRFrV/5Lf1K6BfPUyYZJGPmcaQZt370UDZk22lp99ivRGydW0ftkJpY+OQa
 gBvkpGeMLRdRM5r6k1ES+DxSlDsD/SQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-8y6WvEyrMxibuo3ewRfQwA-1; Wed, 10 Jun 2020 00:27:40 -0400
X-MC-Unique: 8y6WvEyrMxibuo3ewRfQwA-1
Received: by mail-wr1-f70.google.com with SMTP id p9so508526wrx.10
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=10332xG/Et6G9yDWYNuu/GUK5CzyCJzNTiI8MGCB5RE=;
 b=Uxzl6OggijUXEfY7P8rCX2mPdU8IURROWkpCBASaxDUcqaahf4Alk7gfqMfwmUL1eS
 newO8oVT+SQj3FobgMggDkQJKttdoT7x+y5S4SCnBI5S0ercqUXZTMyYPivT/5GOGvJm
 E/uz77EL86vTYaNi0tLFPf5hLZ6r+stMjGShytXUaRnoqHwYR5sYd0XGR/WGDV3jjInF
 T4KCUZVcvaZQqW2svxWzZnKdLJ6VB+46ZnNTo91Ut9Dc9KNlMQNzp2SY4qTFP8DCsDb4
 eG/+w+JnmROJhBWbq/nhLv9C7Nzqh4LckGbl8EP9OI++mYvqPMRvnrrucqu09WZsHN50
 hShg==
X-Gm-Message-State: AOAM533Q/KXicAriGaexj85GMNpgxm9LbHg7IK2xro2g0Xygy+Qo2r8s
 s+c677yd6ESfR3akSpiDbMkYqDFkxHk/0SNQsc0jxtejoKu9+S+tg/er0GPjvUAVBZYLWlV+TSO
 AqGAylxEzq92RT4k=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr1340341wrp.419.1591763259329; 
 Tue, 09 Jun 2020 21:27:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGLRyVGCdR8+ttsTV3QAuPfwNDTqlGm4Mk/ODjO6Ikpf97LPn0/6EUHmxrA2q7LYOXQ68Ekw==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr1340327wrp.419.1591763259130; 
 Tue, 09 Jun 2020 21:27:39 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id l17sm5163022wmi.16.2020.06.09.21.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:38 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/56] pci: assert configuration access is within bounds
Message-ID: <20200610042613.1459309-30-mst@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While accessing PCI configuration bytes, assert that
'address + len' is within PCI configuration space.

Generally it is within bounds. This is more of a defensive
assert, in case a buggy device was to send 'address' which
may go out of bounds.

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <20200604113525.58898-1-ppandit@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 70c66965f5..7bf2ae6d92 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1381,6 +1381,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
 {
     uint32_t val = 0;
 
+    assert(address + len <= pci_config_size(d));
+
     if (pci_is_express_downstream_port(d) &&
         ranges_overlap(address, len, d->exp.exp_cap + PCI_EXP_LNKSTA, 2)) {
         pcie_sync_bridge_lnk(d);
@@ -1394,6 +1396,8 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
     int i, was_irq_disabled = pci_irq_disabled(d);
     uint32_t val = val_in;
 
+    assert(addr + l <= pci_config_size(d));
+
     for (i = 0; i < l; val >>= 8, ++i) {
         uint8_t wmask = d->wmask[addr + i];
         uint8_t w1cmask = d->w1cmask[addr + i];
-- 
MST


