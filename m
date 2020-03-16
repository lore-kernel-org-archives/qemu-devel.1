Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD86C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9004820679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTrua9Zj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9004820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtgS-0002uA-MT
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsHx-0004lD-G0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsHw-0000Xx-8A
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34591)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsHw-0000SQ-3E
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzAY54Ug/Dgdb4+XERmlSJiZ/8IMgFtKzZJKBnbDjxY=;
 b=fTrua9ZjmkILkwKsASTfyk3KZK0sdXp8P3WZFpRyFKm7C+o/VU021XBhdxqMhT49YA8B8n
 wCUWaoX5XQeevRKTvRw/fv3vbyBEvdFSB+uAidbW7Mdhz4M1KGS4chUab9emRZTjdqdA1z
 QbUMvxpyn3M/I8xQ6aQfWnveF99piUE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-oLOXEYRmOKKttTi9ZD2d8A-1; Mon, 16 Mar 2020 12:08:19 -0400
X-MC-Unique: oLOXEYRmOKKttTi9ZD2d8A-1
Received: by mail-ed1-f69.google.com with SMTP id g11so15548941edu.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q9pxkDoDUc80lR6q2sbnb9Lu1UrGguk51WkG66GGoIk=;
 b=lzNZvjA5FxUvmmwGBC4Qx/UbGkOR8cYhVUhGeE2w7xk8PI5bIXpz45fQ5laMPYfV28
 DC9IHMVi0AOe4nzQnzloEDZX5trwNgpK8E02SSPAFlB5BN3UjzeDOFLKZI3pNHaQo3W+
 fLGG0t6CBpNR+cf13SCMOR/q8LZJHipr0QS7uezTcfS/XV62wXGe8YxH9LhBmq3E5134
 XIDeCb/JBoWaVy38r6WZkKKMjtiqrXM9TD/LaTHHVNBfqnJpeRmutbmGurCIR2OftIBC
 rr58p7CL8o/23eXiHwaymyq1TkaWiH6X4UWIXOo5RWr8NluBJXGCazpLYZpLdwQHDdVM
 AjMw==
X-Gm-Message-State: ANhLgQ35wA2k1spUGdvmp0iQVXGDofWKS5PhJYRhyrfUYVAs6DhUhMfW
 y0eXcucr7Q9Eya7fcA3SIkW3juuVAQMuRr+R3AYcCT4RgM/fX+dJeh4rDUehR/RJTi+uX4w71CC
 g+lTr9KEcdyO91S0=
X-Received: by 2002:a05:6402:889:: with SMTP id
 e9mr725048edy.204.1584374897409; 
 Mon, 16 Mar 2020 09:08:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtucDPtYCUUmNKo1v786732XgsbrhpkRJ66ECnTqKEicI6pa/tNzUTcvXKFSS8tLcL/QhoQsA==
X-Received: by 2002:adf:b3d6:: with SMTP id x22mr99071wrd.242.1584374896425;
 Mon, 16 Mar 2020 09:08:16 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id x13sm268246wmj.5.2020.03.16.09.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:08:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/19] hw/arm: Do not build to 'virt' machine on Xen
Date: Mon, 16 Mar 2020 17:06:33 +0100
Message-Id: <20200316160634.3386-19-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 kvm@vger.kernel.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xen on ARM does not use QEMU machines [*]. Disable the 'virt'
machine there to avoid odd errors such:

    CC      i386-softmmu/hw/cpu/a15mpcore.o
  hw/cpu/a15mpcore.c:28:10: fatal error: kvm_arm.h: No such file or directo=
ry

[*] https://wiki.xenproject.org/wiki/Xen_ARM_with_Virtualization_Extensions=
#Use_of_qemu-system-i386_on_ARM

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: xen-devel@lists.xenproject.org
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 8e801cd15f..69a8e30125 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -1,5 +1,6 @@
 config ARM_VIRT
     bool
+    depends on !XEN
     default y if KVM
     imply PCI_DEVICES
     imply TEST_DEVICES
--=20
2.21.1


