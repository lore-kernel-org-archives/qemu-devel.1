Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87042C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C971720867
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABb02oU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C971720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaejE-000371-Hq
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaeck-0003Zt-K6
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaeci-0000rL-EP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604580255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bepWcvGQ0bfdYX/qi1p2dH7ehIvF5dT/hahyqVRGcmk=;
 b=ABb02oU6NvrkVfEorQEE7x0uQsxnzXRmPzmbTN69PXH9109h3piGCsMWApM0zwaPJtwzER
 KQSQo3z6a6pByPaGfTYkqGDwAlAiMSvpDDW1K79813Yht0C/pgYOQQ1Aioyx7kjUpclvLG
 VHXaQxRxh3LTEVnhEsvi4mpBJP+tu7w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-ijN_tnedNcyHQyTj3EtTdg-1; Thu, 05 Nov 2020 07:44:14 -0500
X-MC-Unique: ijN_tnedNcyHQyTj3EtTdg-1
Received: by mail-wr1-f70.google.com with SMTP id t17so657367wrm.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bepWcvGQ0bfdYX/qi1p2dH7ehIvF5dT/hahyqVRGcmk=;
 b=hS+unIv4q5uzGHpm0ZVLxlsIWtfj4tRBwN+9nHEnqWULF3SENv0lthrBcNk6LI7pN6
 jv0n1LMjfSfWFjvVqTMgU3JKxcWwT04xlj4xVyVaBByyn1q2aHMcjxPT4J/C194FYy2V
 646M31bf8Yic8jiDUNVlsE51Domlvn+zmZUss0D6XlIPkKR9AhtTT/lRG09nIN75/Axo
 RZQfpnUnE/ZfQFvQh+UYAc2be4Ib/cyj4n6fGS2dpC86yLmuIfLLzA5snK3t0LMhsT/a
 Ky9/epQaefnyl5BKJizYKHEd7A8WPmXEs1JCakR7cdwbuT09vtBV8Xo06aaMMpFJexUL
 6v+Q==
X-Gm-Message-State: AOAM533Gqj2KRpTsoXtVdAD0flXttB6O5M5VUcT80eBnsI6cnAEuCvO/
 i7inXj3rN7NKcPYN8oBnEYFKw17IhP0wTTrzXiGGQsXaxX14owuspsjmlmdxavBgSIZ95sexQQH
 TSRfJt4mb8/d8cyc=
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr2506104wmi.156.1604580252671; 
 Thu, 05 Nov 2020 04:44:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdmkvAKcvdYqrzbh8740WVd9v1CEuWQdEjPg1sNnohA4LgmpX4vw1ZWRgvfgh9g25KqCR38w==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr2506070wmi.156.1604580252496; 
 Thu, 05 Nov 2020 04:44:12 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u3sm2431544wro.33.2020.11.05.04.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 04:44:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 3/3] gitlab-ci: Test the --disable-virtio-legacy option
Date: Thu,  5 Nov 2020 13:43:53 +0100
Message-Id: <20201105124353.3680057-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105124353.3680057-1-philmd@redhat.com>
References: <20201105124353.3680057-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the recently introduced '--disable-virtio-legacy' configuration
to the 'build-disabled' job.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3b15ae5c302..21fa1a459fd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -218,6 +218,7 @@ build-disabled:
       --disable-strip --disable-tpm --disable-usb-redir --disable-vdi
       --disable-vhost-crypto --disable-vhost-net --disable-vhost-scsi
       --disable-vhost-user --disable-vhost-vdpa --disable-vhost-vsock
+      --disable-virtio-legacy
       --disable-virglrenderer --disable-vnc --disable-vte --disable-vvfat
       --disable-xen --disable-zstd
     TARGETS: arm-softmmu i386-softmmu ppc64-softmmu mips64-softmmu
-- 
2.26.2


