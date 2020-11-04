Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807EFC4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE42A20780
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flQxvzM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE42A20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAqJ-0005Gg-T5
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAm3-0006aF-5r
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAm1-0004io-CC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g3L/0LWUS5AALGZ/Ad9jPepioK718BBOf2ilNljz6+w=;
 b=flQxvzM3w4rF0Y9gEaSGx0dD6rYGi47oQQlK9ZoNPV0LpQUdoXV3W5TpBMojJj0SldypGc
 Yy1CNA4HVcsfo/UecYEoTG6YZL2FiXMZSA9aN74qnGYHLvFT61npktZulS1vADY2ZMfKl+
 JzSas7uQDTn7Cu6HncYa1W6MaiZEX0E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-_KzJ-3paOGuIStQF4wjacQ-1; Tue, 03 Nov 2020 23:51:10 -0500
X-MC-Unique: _KzJ-3paOGuIStQF4wjacQ-1
Received: by mail-wr1-f71.google.com with SMTP id w1so8714959wrr.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g3L/0LWUS5AALGZ/Ad9jPepioK718BBOf2ilNljz6+w=;
 b=mblzNz+Vhi23+MtolHvgtojyqJSrzQbvu//HunBYdkblpSu5zEvmuJmlXfPf5adJl2
 dnIqbktFJuA43HLEMTqwHiO8RipuxvC7koaOiPTh1V5A8Wwqxcv98NWZ7oGqZFSpqxoK
 MEGxlkIZqzArI0oZE7HTYOth0hxCnKhwi097VBeEapJhVqW0n3KOiyIkWYVkm2oyehOd
 KOYDQouTeJ8JGFqF6k6X3kbJq7eDzq/zR/8SUbU5wLYNhwy3nY81NkHtLhzfHCIw+DE2
 yQrH2fsJ0xy1IdMJW/8TfZqNvhHP5+cyFPZSjpbYp78OiHMWBWwvMVRn/39bZJspqXAK
 K7gw==
X-Gm-Message-State: AOAM533nTRn3fOeMNsLR3l8oi2ou0OPfyQjdec6SxL2z12tYwKndvbL4
 cIvlCZaMF8y1mNfWcBecRc1JwN+88vaMVCvG3HMpKNh14UnfR7r8nk9Rzd6yWq3j5i9MIJXVmix
 mQiDtHr1iiTdf5iU=
X-Received: by 2002:adf:e7c1:: with SMTP id e1mr31495182wrn.247.1604465469271; 
 Tue, 03 Nov 2020 20:51:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRH3fz1EdqaZqIaBRvcNUlor68i3/UCN/rSCzQqduO81twNUfv8PSUMdTc7o/gD/8zO/BIiw==
X-Received: by 2002:adf:e7c1:: with SMTP id e1mr31495176wrn.247.1604465469165; 
 Tue, 03 Nov 2020 20:51:09 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id f17sm838368wmf.41.2020.11.03.20.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:08 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/38] hw/acpi : add space before the open parenthesis '('
Message-ID: <20201104044937.226370-10-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Igor Mammedov <imammedo@redhat.com>, Kai Deng <dengkai1@huawei.com>,
 Xinhao Zhang <zhangxinhao1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xinhao Zhang <zhangxinhao1@huawei.com>

Fix code style. Space required before the open parenthesis '('.

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
Message-Id: <20201103102634.273021-2-zhangxinhao1@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index ade9158cbf..2c0c83221f 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -558,7 +558,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
     if (val & ACPI_BITMASK_SLEEP_ENABLE) {
         /* change suspend type */
         uint16_t sus_typ = (val >> 10) & 7;
-        switch(sus_typ) {
+        switch (sus_typ) {
         case 0: /* soft power off */
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
             break;
-- 
MST


