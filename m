Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99F5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026F320759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7EkixLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026F320759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHRQ-0008KP-0H
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaHPq-0006eM-Hz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaHPo-0005Vj-NY
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604491043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFU0pp+sAaUJV7Uz07XCo0kf/Xpwz4nVfgdLF0eVzjo=;
 b=U7EkixLp3oIJKD8K/nsFlav+CQ74QclDBbBoQksVZb5xr9fnVNSZU4AU2RewJQsqiYrh8J
 k0e4HYBfQDAiqMBEpUmiRdbRwJSzHO7WeSQcFTY4ACTZ4yf5kD8t+612kI+4dgAe3vwJwU
 dBq83HMaUAtuEWZqo06J6m4y2ghDM1Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-j_Am8wAaPcSGDLB3RMRM4w-1; Wed, 04 Nov 2020 06:57:21 -0500
X-MC-Unique: j_Am8wAaPcSGDLB3RMRM4w-1
Received: by mail-wm1-f70.google.com with SMTP id t201so1128842wmt.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vFU0pp+sAaUJV7Uz07XCo0kf/Xpwz4nVfgdLF0eVzjo=;
 b=TDXmx+8Miy5ATepUb9/Z+XJ7HUI9ExlzX2uY1tPc0xozmdpEaq05IiJLuvyjiykn8Y
 MH3rui9YDdySosFMdUkciAmt71zRSduYRCrmzNCk2BaNMfXRhJ7et5LP1WrCZWzRdnkz
 /QyarYlNi9/QqzKZr/RrjAOLHvoRwJTEJkfm5HWwhC/7Us0QUoGvmILLGMsmltxH9Hx0
 HnUQidyPGHEURdupNBf2dYT0QtahiLXdNH/Pxhso6K7EOZavCXPfoQFUIciMcvmJPRLZ
 rosWV82quFQnbLsAY9zZTKNlvwwHYMwLDkMcHr7zWFGHdDAU3I8scD/9pJfto4ge7dA7
 rljw==
X-Gm-Message-State: AOAM531aW6IAkbFMaVh20LFMG0yiBsJcoUdC40uSkb6SElWOf6FXufEa
 A/7C2Pg4rvTtR3EQokACndySCxlkRaRJCNnElAOaplPnW9J9b5KOhhNSk8C/+doZgCicvQXmNhy
 nUwfCjNtnWOn7hYs=
X-Received: by 2002:adf:f20e:: with SMTP id p14mr30747723wro.376.1604491039884; 
 Wed, 04 Nov 2020 03:57:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6O/flHIYR/UleClnQnn4DXbprA02Qdr+LmWU88GsHun8X3K1oAsLw14FXKYMM+joIbNDW6A==
X-Received: by 2002:adf:f20e:: with SMTP id p14mr30747702wro.376.1604491039757; 
 Wed, 04 Nov 2020 03:57:19 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id a15sm2226651wrn.75.2020.11.04.03.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 03:57:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 2/4] hw/9pfs: Fix Kconfig dependency problem
 between 9pfs and Xen
Date: Wed,  4 Nov 2020 12:57:04 +0100
Message-Id: <20201104115706.3101190-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104115706.3101190-1-philmd@redhat.com>
References: <20201104115706.3101190-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paul Durrant <paul@xen.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit b2c00bce54c ("meson: convert hw/9pfs, cleanup") introduced
CONFIG_9PFS (probably a wrong conflict resolution). This config is
not used anywhere. Backends depend on CONFIG_FSDEV_9P which itself
depends on CONFIG_VIRTFS.

Remove the invalid CONFIG_9PFS and use CONFIG_FSDEV_9P instead, to
fix the './configure --without-default-devices --enable-xen' build:

  /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function `xen_be_register_common':
  hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_ops'
  /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference to `local_ops'
  /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference to `synth_ops'
  /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference to `proxy_ops'
  collect2: error: ld returned 1 exit status

Fixes: b2c00bce54c ("meson: convert hw/9pfs, cleanup")
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Reworded description (Greg)

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: xen-devel@lists.xenproject.org
Cc: Greg Kurz <groug@kaod.org>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/Kconfig     | 4 ----
 hw/9pfs/meson.build | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
index d3ebd737301..3ae57496613 100644
--- a/hw/9pfs/Kconfig
+++ b/hw/9pfs/Kconfig
@@ -2,12 +2,8 @@ config FSDEV_9P
     bool
     depends on VIRTFS
 
-config 9PFS
-    bool
-
 config VIRTIO_9P
     bool
     default y
     depends on VIRTFS && VIRTIO
     select FSDEV_9P
-    select 9PFS
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index cc094262122..99be5d91196 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -15,6 +15,6 @@
   'coxattr.c',
 ))
 fs_ss.add(when: 'CONFIG_XEN', if_true: files('xen-9p-backend.c'))
-softmmu_ss.add_all(when: 'CONFIG_9PFS', if_true: fs_ss)
+softmmu_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
 
 specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-device.c'))
-- 
2.26.2


