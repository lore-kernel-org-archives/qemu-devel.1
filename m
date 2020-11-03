Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A199C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF69206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhqaQjJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF69206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuWt-00075w-T6
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuSJ-0002Fr-FL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:26:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuSC-0006Y0-Vt
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604402778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/WriUkAF5WQqVMHWgQv1QLJ6c0DsVi572s0W42JyGk=;
 b=YhqaQjJbixZonkQfLcB6WsJSlerp8HqiRmh9Avrv4GF6R/0c0cbWBH+6u1xZzW6bJ3dkVQ
 rqRXY2rZUWjQ1Z3VpBS3FoJBVrWun4xj//NK23lI2+dWLTtr4L15DiB5XPoSzyS9Zma6nl
 CKwKYjEvwB/s1O3EM7AdfAS2TbJROdk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-SWgf8rXwMl6NBxo8iOECQA-1; Tue, 03 Nov 2020 06:26:17 -0500
X-MC-Unique: SWgf8rXwMl6NBxo8iOECQA-1
Received: by mail-wm1-f69.google.com with SMTP id o81so1470284wma.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J/WriUkAF5WQqVMHWgQv1QLJ6c0DsVi572s0W42JyGk=;
 b=dQDemOpBizUhp34XkEVzeCJFbZoFdiWTPEp1v1kT4lauqzFWMV3xRkLaSfo42DbY72
 hwoAImm+HkbVtCXQgxAqXMXLtl+mHEphMRD8wachbejYp/d64WHAJhuBHQPNvfoikyjm
 8Jsd2XgnJLphMkwQ+bPhHtCBGsujUhc5j/y21ytz86U7yaFen3YobRnHm8pJXqDK6XM5
 j97++CYdMm5QwN/2BfUzgQ2sOrUY0/H4OTKLa6TLMs8RX8elg7S1Wye9BDVGroTlbdOY
 RBxhNOhr44ItHe0wJBHbDrZmINDVxgL2yqGzF1jpA2deskc82LTDMhq/Pg+jPr43xLHs
 fZdA==
X-Gm-Message-State: AOAM531VETP6HIqs0p5fFZ94iIdQBvz2A8XOajRygiTjiCiBISb9FKgu
 rCn4dzCM5BgtE5yqVQrfgUh8/Wm4UK3qklNYuJB5MVzRAsQB5Xx3VlVqMAkBKw99BWi0FaO17FK
 4ytappC2yAIPps50=
X-Received: by 2002:adf:dc4c:: with SMTP id m12mr12923485wrj.177.1604402776125; 
 Tue, 03 Nov 2020 03:26:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTl+t5I9FpG8/KLS8m1QoHOaFWtqY+CTqoUmfuR/B2d6DVdY+/+PfSoNgEgI7cecNbPe3uAQ==
X-Received: by 2002:adf:dc4c:: with SMTP id m12mr12923461wrj.177.1604402775992; 
 Tue, 03 Nov 2020 03:26:15 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l3sm2990672wmg.32.2020.11.03.03.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 03:26:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 3/4] hw/ppc/spapr_tpm_proxy: Fix hexadecimal format
 string specifier
Date: Tue,  3 Nov 2020 12:25:57 +0100
Message-Id: <20201103112558.2554390-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103112558.2554390-1-philmd@redhat.com>
References: <20201103112558.2554390-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The '%u' conversion specifier is for decimal notation.
When prefixing a format with '0x', we want the hexadecimal
specifier ('%x').

Inspired-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/ppc/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index dcc06d49b5a..6d8d095aa28 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -19,7 +19,7 @@ spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned magic) "Old
 spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 
 # spapr_tpm_proxy.c
-spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_device_path=%s operation=0x%"PRIu64
+spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_device_path=%s operation=0x%"PRIx64
 spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_out, uint64_t data_out_sz) "data_in=0x%"PRIx64", data_in_sz=%"PRIu64", data_out=0x%"PRIx64", data_out_sz=%"PRIu64
 
 # spapr_iommu.c
-- 
2.26.2


