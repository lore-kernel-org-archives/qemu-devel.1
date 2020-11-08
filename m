Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B701FC5517A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B591206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2/tvu89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B591206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbreL-0008K1-BW
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrb4-0004QD-09
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrb2-0000VN-76
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2grejy7cDYx/3lhILvA2g1L5VhxTj2T7VuEMQqmhSg=;
 b=P2/tvu89G8gGG2e2iy+qQlYazARg12iMneromVdA0m9OOYRDJ8RhR63zsWfgR64AnD4eiO
 L6+MdgdNZlRElfvlhT+Lwevmos+F7VlRJ21aHEj18yCvkBnFRRTJMakblPYrtR4eli5qBp
 aBQNG63Jwny+mrUwK+Py6h+XcwU0dPc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-jcgmT2QePIS8ANzooQ9fvQ-1; Sun, 08 Nov 2020 15:47:29 -0500
X-MC-Unique: jcgmT2QePIS8ANzooQ9fvQ-1
Received: by mail-wr1-f71.google.com with SMTP id 67so3401852wra.2
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z2grejy7cDYx/3lhILvA2g1L5VhxTj2T7VuEMQqmhSg=;
 b=UlwXrqk7KishN3mPmH5W2B76keR1Gl95EMARThC9pk1R6zGIKo3uPt2e1oFao6tYWA
 LthyAadcA8pI9VYT10zXUt/MnhOR18VpM1+2O2i1EhW1oAOza1wTSiiLIEGCuM70wJeg
 Snjb5Kh4QwyFiR1lHdqHc1MzJ6uPjLU5JYhAlCMvz9XNgxzuBzmM37qLo4t3xrjKDWaK
 mCEXFTThCptsWiz0P98XgmLyHoZsVhH06onq6vTXJOHepnSy2JM8MorN8fDTXa6RCmhD
 zmXTea31c/4C3Y2qufXQx3J0H1JYcayC3XGQ+XGyr+nZMEs1sxSM000i0ihRdG3PtSB4
 fBIw==
X-Gm-Message-State: AOAM530kfktb7dPNl6sWWz60lgUwMCmr83G6Q0ZL+bQJhBS4jPF2njFd
 PsYzg6M+SeSdutINdKo3UCIJMNdZ5W2pZhvRxP1BPFGfvKticrhk+lLeo97GNI0hcoB8Ku2M9MS
 72li9FN5eolqrFHY=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr14205829wrn.362.1604868448412; 
 Sun, 08 Nov 2020 12:47:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6euOhHzjGTMG8udP4rAugOHoI2x9CDy5uQREcFOTMW8mSBLGcWS5mQRTf/2iVWMzWk/w+Pw==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr14205808wrn.362.1604868448301; 
 Sun, 08 Nov 2020 12:47:28 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o11sm11481323wre.39.2020.11.08.12.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 06/17] gitlab-ci: Update 'build-disabled' to cover
 all configurable options
Date: Sun,  8 Nov 2020 21:45:24 +0100
Message-Id: <20201108204535.2319870-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:03:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add these missing options to the 'build-disabled' job:
  --disable-auth-pam             (commit 8953caf3cd38)
  --disable-gcrypt               (commit 91bfcdb01d48)
  --disable-keyring              (commit 54e7aac05624)
  --disable-libudev              (commit 5c53015a480b)
  --disable-opengl               (commit da076ffed6b9)
  --disable-sparse               (commit 03b4fe7de226)

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9f090cca5e3..b98800462ed 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -205,6 +205,7 @@ build-disabled:
     IMAGE: fedora
     CONFIGURE_ARGS:
       --disable-attr
+      --disable-auth-pam
       --disable-avx2
       --disable-bochs
       --disable-brlapi
@@ -217,15 +218,18 @@ build-disabled:
       --disable-curses
       --disable-dmg
       --disable-docs
+      --disable-gcrypt
       --disable-glusterfs
       --disable-gnutls
       --disable-gtk
       --disable-guest-agent
       --disable-iconv
+      --disable-keyring
       --disable-kvm
       --disable-libiscsi
       --disable-libpmem
       --disable-libssh
+      --disable-libudev
       --disable-libusb
       --disable-libxml2
       --disable-linux-aio
@@ -235,6 +239,7 @@ build-disabled:
       --disable-mpath
       --disable-nettle
       --disable-numa
+      --disable-opengl
       --disable-parallels
       --disable-pie
       --disable-qcow1
@@ -249,6 +254,7 @@ build-disabled:
       --disable-slirp
       --disable-smartcard
       --disable-snappy
+      --disable-sparse
       --disable-spice
       --disable-strip
       --disable-tpm
@@ -258,6 +264,7 @@ build-disabled:
       --disable-vhost-net
       --disable-vhost-scsi
       --disable-vhost-user
+      --disable-vhost-user-blk-server
       --disable-vhost-vdpa
       --disable-vhost-vsock
       --disable-virglrenderer
-- 
2.26.2


