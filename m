Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7308DC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D7B215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqJIIipW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D7B215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkZQ-0003HI-Bb
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkW3-0005Zu-Cj
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35884
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkW1-0002AH-Ir
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPdxVicu969je/HHuYmc96kgT2/Tmz0/2S+LklATjmE=;
 b=PqJIIipWGWf/7EJ+L/UHrZjVFsu8lxM8x7ZXqSDsiHF0e+Wpda7KjljHaP55yAhS54xYK2
 lmt9jc+hSjKhxxilTULdN9OQV68VaFW0DPppQ7WuhI92VdlCPv8ICj8xQUse+7Xgi4Mgrm
 rtkVepbvgi2+BH2WrR2LbU/0yOgzZ6o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-lrKowiSqOd6NBV7cvaz--w-1; Thu, 07 May 2020 13:40:55 -0400
X-MC-Unique: lrKowiSqOd6NBV7cvaz--w-1
Received: by mail-ej1-f69.google.com with SMTP id jp4so3191733ejb.20
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GU+pb8s4KCPhcsiRUlvVEDRxp1DqtYppL7zwVgzuzEQ=;
 b=f3mPDOdQJ50rQOHGlLSIcF5KkaNhehB7oaueuS3eRWPnnalyWCPAgYDnzXwgnGFoR8
 ydm8Wd1Thr8fAUPLH6HB0cRT5A3Q1GfoL7P9XTASyu1kFsfzlPO84pxIh2C33BVw3WHX
 YXtoOSzVE6PrqSOl56G513jXsC2hKCO4S5xYNdVSluwBCvWQvGCErGWw4XGNPONfNC2+
 94Kd/IY/hiRB/hc0xDvlxTDf3Z7QsyBZaV1v2N2xcCZR2QBGnp7h4+moqZlxqjDlIn/N
 AbufFONaQ8TKkWJnxsVFXErXZ7eR7rddWgxVKJT4xIr5PGf2DsJF+pqCu0j3gjIUOAPA
 Q2Sw==
X-Gm-Message-State: AGi0PuauHb6Mz2fXuZP+541E8cZK+hcYqDofhVCN8hWMKnGWMTbSp8yj
 jua+HeG1rmCUu36YtTTLHGP2hGD707HzN4Lh+TI4CHrcs3fg/M+DgAC4hPpGjyx3+yB9H4U6qRe
 SH0cODgcP2Qvdzuw=
X-Received: by 2002:a17:906:2d4a:: with SMTP id
 e10mr13560855eji.222.1588873253598; 
 Thu, 07 May 2020 10:40:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypJSzp8FrllgoD8AfFcqANwT/r92S58QUd+F/AuoUVq6Oym4Bc4+UQvyW+kuojt0+IflWUrAUw==
X-Received: by 2002:a17:906:2d4a:: with SMTP id
 e10mr13560841eji.222.1588873253422; 
 Thu, 07 May 2020 10:40:53 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id bu4sm606672edb.90.2020.05.07.10.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:40:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 08/10] hw/block: Let the NVMe emulated device be
 target-agnostic
Date: Thu,  7 May 2020 19:39:56 +0200
Message-Id: <20200507173958.25894-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now than qemu_ram_msync() has been ...

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 47960b5f0d..8855c22656 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -13,6 +13,6 @@ common-obj-$(CONFIG_SH4) +=3D tc58128.o
=20
 obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk.o
 obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk.o
-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
+common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
=20
 obj-y +=3D dataplane/
--=20
2.21.3


