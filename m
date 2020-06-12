Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C43BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DF120691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ektoibFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DF120691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlE6-0002xg-4d
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2V-00078V-9g
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22910
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2S-0001Tt-Mt
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10332xG/Et6G9yDWYNuu/GUK5CzyCJzNTiI8MGCB5RE=;
 b=ektoibFlcy/FaOaMp1GgnDNMvriAEwMO647p/m28Yc4Aps//eXCsNhoEaGqGAJUymX4Elg
 PLjbF0E1KviCFehYUZnF2xlxCsd2R7mmC8x+y0E0xzWKKnq1Z/yghdKK/8NLqUUbdFTznZ
 8USVMkQ7PaaU5SoSvgMwdiDFe+pEK5w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-edYZCoFqO66yY9UrM4nMUg-1; Fri, 12 Jun 2020 10:52:10 -0400
X-MC-Unique: edYZCoFqO66yY9UrM4nMUg-1
Received: by mail-wr1-f70.google.com with SMTP id w16so3976492wru.18
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=10332xG/Et6G9yDWYNuu/GUK5CzyCJzNTiI8MGCB5RE=;
 b=rcM6TmoYuhYlciHOxR+Q6INF3zzu0DsmSCYYk3zptdneorbSwacMJBs0EDCKe1LUWw
 09M2UzgLM7VVXq7KWo5xHhq9M2ZLb/gHM4zum4HSha1iD7xbBWlrowR9SiXRVtW+TMCr
 Is+ZVWwDYpskT8C0gNBqRYQUQ9OQMv/11SGdBEnHpcozVgv6CuCdUENPj0sf9Vvmg7Jj
 Yn/n1c4oSzxfi3Ff8JWry2mnmqluoLgucl16TaxVSpFmXLoBYIBh8NU3WhbK/56JXTSp
 SZ22/cot+PzoWs8RJNbor0ktoLuUTK2iRzCTaQAAzUJU6EdI8gMGt7ZUOn+M9EOODpOX
 gj5g==
X-Gm-Message-State: AOAM530fR2Cm3mc0JSaeioY/dKb8xXDequuIZUtYHi6Ni5BFQx04Dhk3
 f7OtuQqZwC4u1QK1hCvOj1w7ir6o3HhKRTfQyx9cRo5516bFuVcO9py7edjJBnPuOc6gA8OyPAK
 dC5eVGj9JG3uIY0I=
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr14995190wrs.209.1591973529128; 
 Fri, 12 Jun 2020 07:52:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpP8uo1RqI58tiTARxfnua1V7PbmukBMKys7UocvScr6yP2w3gQVW5S4VhSwBSepb8HqkngA==
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr14995175wrs.209.1591973528925; 
 Fri, 12 Jun 2020 07:52:08 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id z25sm9103366wmf.10.2020.06.12.07.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:08 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 29/58] pci: assert configuration access is within bounds
Message-ID: <20200612141917.9446-30-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
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


