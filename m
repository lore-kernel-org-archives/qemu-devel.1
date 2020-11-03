Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9642C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36919206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdBFAwnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36919206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuYG-0008BJ-2s
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuSK-0002HO-Lo
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:26:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuSI-0006aB-Uv
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604402786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ms9/MqSjQ1PZDOJSmQXaPdJqLuT/XwivS769IUm5axs=;
 b=PdBFAwnM/UXLtUKVhkjGzRXCTVhK8wGkXusA/QjUBOtzQd8EBia14mmKxz/N4MpDdBsH5P
 N/9YEyKWlCwvTeadu0FjpYecF7FFmShcYaLmPKsr4S+IbvR4zLlMMEJMvzhoSlFjIqLcO2
 lxFwbbkVrPJLZ7gfx5Q+eiPqmflKIhk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-bue1exOsMv6x3t27vDbupA-1; Tue, 03 Nov 2020 06:26:22 -0500
X-MC-Unique: bue1exOsMv6x3t27vDbupA-1
Received: by mail-wr1-f69.google.com with SMTP id v5so7766705wrr.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ms9/MqSjQ1PZDOJSmQXaPdJqLuT/XwivS769IUm5axs=;
 b=XNc0QHBcZSi0N1q3xyqoTqN+9Z153zTEzIYZzrTzof6hDRTUzfz6/0P7Z1vGShmhyy
 j/I3EKr+PqSgEDFaKpWHPFfd20ZlRVmi36C5lpfACudyjI7XrFqCciHlrqLl7ZjQTLob
 BBQfnT18wIYPPPhaXveQMmKVBwsYodzO6RIo9TpSuV92M0gpU31eN50mGoHETM1s3/Qz
 DGfGgkP/q3ah6ausH/+UZalZ1Ce2jRjjBZZQ4QbznzgV3jhXYpYvGLlfp/5VUlia5o90
 ga8QIzOyATsx5EsyKfn1184E8luJURnD3d0ALwPgKbKNCKEqcpYD43oyjp3VWG7U6VDc
 OueA==
X-Gm-Message-State: AOAM531306fgYOoTZLNBOPNfo3MQRZz1qYlEAivCC5BBQy/cEP8GbX8E
 JQNTkS0YRrZFs1Ebz0xsVuRs4AmdbQBTvK9FuOXGRfBBz1GWyu5chyZ4YMKtqv3ve3Tdmf2A3IC
 sJrT5AcMz5mfXjgk=
X-Received: by 2002:adf:e807:: with SMTP id o7mr14149496wrm.303.1604402781199; 
 Tue, 03 Nov 2020 03:26:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlWuAW9vhsOwtH2y6J/QpafR8zIjFMv/LxT9xs1kOwxJmpSiiXn3skvqGO5xgOSpeA0rt8mQ==
X-Received: by 2002:adf:e807:: with SMTP id o7mr14149483wrm.303.1604402781080; 
 Tue, 03 Nov 2020 03:26:21 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y187sm2554418wmg.33.2020.11.03.03.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 03:26:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 4/4] migration/ram: Fix hexadecimal format string
 specifier
Date: Tue,  3 Nov 2020 12:25:58 +0100
Message-Id: <20201103112558.2554390-5-philmd@redhat.com>
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
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2da2b622ab2..23dcfb3ac38 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3729,7 +3729,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
     }
 
     if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
-        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIu64,
+        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIx64,
                      __func__, block->idstr, end_mark);
         ret = -EINVAL;
         goto out;
-- 
2.26.2


