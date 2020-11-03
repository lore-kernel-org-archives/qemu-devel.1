Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF320C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162AC206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G52ccmpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162AC206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuUi-0004Z2-2k
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuS3-0001ww-Lu
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:26:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuS1-0006Ti-Oh
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604402769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/AHR77zRKAMCmRWgdDl0ch1BMwO1MYz9I/QcKMgp7y4=;
 b=G52ccmpaxXeAZ4FasGvZ8nvWtXZJ1bfQV4l4E1i8cmt3TlmzdzK7D9MICfS9R63je5Oqsz
 lXBxf+gtTZTSkYnOsLDXkTUZZdIH+PjxuEQqVqSqTwvqhujni7+3FEx9Cx40YkcnPzvCfM
 6VqsLMUd6y3dFB6siL55kqF+GehCRn0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-D8yWUGeoOPqCEB6vYv7ENg-1; Tue, 03 Nov 2020 06:26:07 -0500
X-MC-Unique: D8yWUGeoOPqCEB6vYv7ENg-1
Received: by mail-wr1-f72.google.com with SMTP id h8so7736915wrt.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/AHR77zRKAMCmRWgdDl0ch1BMwO1MYz9I/QcKMgp7y4=;
 b=QqWkEKc9U282uuz/d47duCBFphzX0z0DGnkvHdJtFI9jGebyezosTJP32Oqw/OmcZu
 zbU2/UB5SI1fqWYTdgwi5aZ4D56sOuO8ILrL7MnHKbbj+GtwMDUBM8ON3H5akM2L8rRL
 p/BreiqFP5c60WF21luSj7afviCbvEVnHsyuct+PQbxtLGO91AHRCh0o0XcTqQ6DLnSr
 sAG73ZVI05UCcx1N9r9VlTcp4QgIdvY6Ypmps2hb0Z0k6d4cfNbknln9TVJjn+N34DgX
 Zwu3QFEAekZ5FzMyREgnFyDtWgMIe33FFuZNYA7PiaikzrF2IVDyZtP4hJjitPQ/Icyp
 UV4A==
X-Gm-Message-State: AOAM533QFDpjpk266F5pcjbMjsX6RsRHH2HrUS2h2iTmjxc+4ztVW5/N
 CJ73kGWtjfKIJ4x6nujYGd9bSyM9Xsfz68SoJVaJe/iEakkLjm5bMjafSNULbGsswr2sFihVIxH
 NzZVJesZW1mYKB9Q=
X-Received: by 2002:a05:6000:10c:: with SMTP id
 o12mr27240283wrx.81.1604402766020; 
 Tue, 03 Nov 2020 03:26:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNtFqqbhhJg/UDzhJNPIs3iD3sg/7LZUKn8zxMUfFHWwoa8kiWvjsDbedhDS+L53Y4ttNBZw==
X-Received: by 2002:a05:6000:10c:: with SMTP id
 o12mr27240251wrx.81.1604402765817; 
 Tue, 03 Nov 2020 03:26:05 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f17sm2613658wmf.41.2020.11.03.03.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 03:26:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/4] hw/display/cirrus_vga: Remove debugging code
 commented out
Date: Tue,  3 Nov 2020 12:25:55 +0100
Message-Id: <20201103112558.2554390-2-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit ec87f206d70 ("cirrus: replace debug printf with trace points")
forgot to remove this code once replaced. Do it now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/display/cirrus_vga.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 722b9e7004c..e14096deb46 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2532,9 +2532,6 @@ static uint64_t cirrus_vga_ioport_read(void *opaque, hwaddr addr,
 	case 0x3c5:
 	    val = cirrus_vga_read_sr(c);
             break;
-#ifdef DEBUG_VGA_REG
-	    printf("vga: read SR%x = 0x%02x\n", s->sr_index, val);
-#endif
 	    break;
 	case 0x3c6:
 	    val = cirrus_read_hidden_dac(c);
@@ -2560,9 +2557,6 @@ static uint64_t cirrus_vga_ioport_read(void *opaque, hwaddr addr,
 	    break;
 	case 0x3cf:
 	    val = cirrus_vga_read_gr(c, s->gr_index);
-#ifdef DEBUG_VGA_REG
-	    printf("vga: read GR%x = 0x%02x\n", s->gr_index, val);
-#endif
 	    break;
 	case 0x3b4:
 	case 0x3d4:
@@ -2571,9 +2565,6 @@ static uint64_t cirrus_vga_ioport_read(void *opaque, hwaddr addr,
 	case 0x3b5:
 	case 0x3d5:
             val = cirrus_vga_read_cr(c, s->cr_index);
-#ifdef DEBUG_VGA_REG
-	    printf("vga: read CR%x = 0x%02x\n", s->cr_index, val);
-#endif
 	    break;
 	case 0x3ba:
 	case 0x3da:
@@ -2645,9 +2636,6 @@ static void cirrus_vga_ioport_write(void *opaque, hwaddr addr, uint64_t val,
 	s->sr_index = val;
 	break;
     case 0x3c5:
-#ifdef DEBUG_VGA_REG
-	printf("vga: write SR%x = 0x%02" PRIu64 "\n", s->sr_index, val);
-#endif
 	cirrus_vga_write_sr(c, val);
         break;
     case 0x3c6:
@@ -2670,9 +2658,6 @@ static void cirrus_vga_ioport_write(void *opaque, hwaddr addr, uint64_t val,
 	s->gr_index = val;
 	break;
     case 0x3cf:
-#ifdef DEBUG_VGA_REG
-	printf("vga: write GR%x = 0x%02" PRIu64 "\n", s->gr_index, val);
-#endif
 	cirrus_vga_write_gr(c, s->gr_index, val);
 	break;
     case 0x3b4:
@@ -2681,9 +2666,6 @@ static void cirrus_vga_ioport_write(void *opaque, hwaddr addr, uint64_t val,
 	break;
     case 0x3b5:
     case 0x3d5:
-#ifdef DEBUG_VGA_REG
-	printf("vga: write CR%x = 0x%02"PRIu64"\n", s->cr_index, val);
-#endif
 	cirrus_vga_write_cr(c, val);
 	break;
     case 0x3ba:
-- 
2.26.2


