Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C2BC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22F620659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDcLj0P8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22F620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zXw-0005tj-Ti
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQg-00025i-Tt
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQf-00067W-Ri
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37983
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQf-000677-OC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WaAuyfScAf/2MXUb8PYYTyYX7vPM6AQh9bWF3qhXnuk=;
 b=LDcLj0P855N1KW7MTkPnkCkSCsHj+LueLuxyhBDlTl+e23lRkgAiQ/MkCEIqZ0tXQrjbDl
 mhARZmCgx4Ge4lwREUWwp028eHmjXaKhLmaSOaBQAREPC+c8Ilr8DxonysDglEkvQg7FBQ
 QyQZU5Zxd526ut2LFD0oZq7pQDRaDm8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-2nMurdnSPuSdfp8xje5Rpw-1; Tue, 18 Feb 2020 04:44:25 -0500
Received: by mail-wr1-f71.google.com with SMTP id s13so10513480wrb.21
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tvommiOA9aXWAuznO/0p1zmrVr71xLCprwkebrVj7q4=;
 b=elK1TALea8oPccLnmQcZhvn9RmKvbJ2SAdMpdK9D/X3+APlisbzLd2fU7MGbSwUwKL
 2cq9haUv2oGdW0te+W6p0HeIggt+IYjD/caITlbxMhFrvvDOmUfmnaSrcc+zFDd4C3X1
 /+SoyvZyxzEYMsNJae55AeSVyyvrobpKP/nVq+DdKg50yYvFKdoDkyRHEspUW4Ze14Hk
 EYhy1V3GQ6sxUQ0Ci6ouQsQftu++DeT00to+nJVk8xVy9pcfOORKRO7Km0uGl4zT8Fiu
 6yCEYr3AD4fjddjviW/UqCU/aLPi3JrE5vL9Qdk4OqgN/iwQrFGyQL92UoLE4j/SLJKX
 v3fQ==
X-Gm-Message-State: APjAAAU7ftPkXA8B3DZDbuJW0pXQUMs++o65XXVkLaeZpZvUow/M1iBD
 HoeijwYdMRvvR+jgG53+bK95M6UEhpCowRXGP+2Kgl8MJmlhe5QiOQWBhG0MDJzBrvz88nKp8fw
 ADgSTnHYCnU4E6ug=
X-Received: by 2002:a5d:614a:: with SMTP id y10mr29114180wrt.73.1582019063768; 
 Tue, 18 Feb 2020 01:44:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0As7+7ciJRK+XKjLIpE6pVb2XxI1tbeyk9YYhNEXjo0WkLuWIqgxrrVNIN6okm60uRVykQw==
X-Received: by 2002:a5d:614a:: with SMTP id y10mr29114137wrt.73.1582019063586; 
 Tue, 18 Feb 2020 01:44:23 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 09/13] migration/multifd: Remove superfluous semicolon
Date: Tue, 18 Feb 2020 10:43:58 +0100
Message-Id: <20200218094402.26625-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 2nMurdnSPuSdfp8xje5Rpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: d32ca5ad798
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 migration/multifd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b3e8ae9bcc..cfaba1369e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -305,7 +305,7 @@ static int multifd_send_pages(QEMUFile *f)
                 + p->packet_len;
     qemu_file_update_transfer(f, transferred);
     ram_counters.multifd_bytes +=3D transferred;
-    ram_counters.transferred +=3D transferred;;
+    ram_counters.transferred +=3D transferred;
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
=20
--=20
2.21.1


