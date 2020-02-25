Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08EDC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC2F2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmcH+XmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC2F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c4j-0002ic-O1
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bvU-0002ki-PF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bvT-00024e-Pz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bvT-00023r-Kd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e+2ubfbEqLiNZyFIpP2Z+jeoSNKaTGCUsXcUvlVb6BQ=;
 b=SmcH+XmX0bD+93Ggke+LY4VNhmKb2kTI3v1dp/dYrwxdmaa/G5NWk5gP/s/hpLnVO1XapG
 qkMRFe0BJtFBDgbZcmr7cnAfy6W1Fp5Imx0tRrz2o+Lhc7BnqZiBtPaDYqJ1Enz7u4uRie
 EiV+KnSrVPNj5SQvDceVzb19o5ZT66Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-qNi1Kg1xP-uYtFn2iMONMg-1; Tue, 25 Feb 2020 10:15:08 -0500
X-MC-Unique: qNi1Kg1xP-uYtFn2iMONMg-1
Received: by mail-qt1-f200.google.com with SMTP id j5so4857813qtp.19
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=c2crKeR2n2YvQ5rYnZd1NJPOMK8zXZOtMWZi9s0fZkM=;
 b=ITwrnfjXSD9CgG8dixm1sE50ipHcP4If2m20QBvbHfu7DZvyAC14/zW+iomRpUI/9l
 rlBO6hgihdcdlZXlzeujWUhw3vpHGjBVWMEtqm4RZg4XTDqYx3FqSMEtB0ztn/1kJx5N
 PHunoGwYsqiicMShZ745MDjpBA0qjS1wvfAofyNdgWUXYKebel3HAV70S59sjWO9HWXg
 DhGK1gl3JASTrs2tL9CvKY/HaM7vTTVKZBlEx6q2gvXW9a2VT8NlUheaq5uZCJice1ZZ
 VPL+zcCu0hvsmUgP2JU/UQJLacEjBrsNKbAt30/UKEz8P2Ib1Zh4Kp0qXCTdx4QxIJIS
 RCRw==
X-Gm-Message-State: APjAAAWPrVJu/KOOxPRhieZf5+mo3yD5nww5GasTF4bOad4mjj3hKqwv
 TAqvZaeBRbZGLSFeSZWd6uHLmFwi0ERGmlreu0jjOsjoXIH/LkiaX/0CEIzWlzQAHotuv1QMk0/
 EmS4ZI16cmEnPn54=
X-Received: by 2002:ac8:1a8c:: with SMTP id x12mr56686242qtj.297.1582643707887; 
 Tue, 25 Feb 2020 07:15:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7LbWoyyK9MoLk8toBltaGld046Gy5z24rpUEqBNjgJR5n4NzAfYJ6FqJ/fdrwFIgWokXShA==
X-Received: by 2002:ac8:1a8c:: with SMTP id x12mr56686183qtj.297.1582643707487; 
 Tue, 25 Feb 2020 07:15:07 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 j127sm7471687qkc.36.2020.02.25.07.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:15:06 -0800 (PST)
Date: Tue, 25 Feb 2020 10:15:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/32] virtiofsd: add it to the tools list
Message-ID: <20200225151210.647797-32-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

it will be built only when tools are enabled (always enabled by default)

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200207095412.794912-2-lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 218b8259a4..ba8ffc9331 100644
--- a/Makefile
+++ b/Makefile
@@ -327,7 +327,7 @@ HELPERS-y +=3D vhost-user-gpu$(EXESUF)
 vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
=20
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
+ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG)$(CONFIG_TOOLS),y=
yyy)
 HELPERS-y +=3D virtiofsd$(EXESUF)
 vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
 endif
@@ -697,7 +697,7 @@ rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADD=
S)
 =09$(call LINK, $^)
=20
 # relies on Linux-specific syscalls
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
+ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG)$(CONFIG_TOOLS),y=
yyy)
 virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
 =09$(call LINK, $^)
 endif
--=20
MST


