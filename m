Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2635C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A9B20848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7/QAqPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A9B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9cMQ-0001dR-Ha
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 17:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9cLN-0008ON-AI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9cLM-0006Xy-FD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27054
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9cLM-0006Wr-Bw
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583360299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rtGLaqsaZvVKv8neLsnCoHMeb27hmi8Np6ey/SFBDes=;
 b=M7/QAqPFeUknx4e+nyVyLcGitNkPQOQFZmPU0ScQvWdrulklSlfLsq0tziTFLaZ6NhC9uw
 1oPiYqw4FTY7Vhk1PiwiPB2MLnSWSf3OFlHzZ/bIrDMs96gvABwvoVcLDuIloKJW+l/TIR
 ML+PF/oQL+4YZYZ9xYuXPVHFP862+tY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-2XMKtcL5MC63Oders68UQQ-1; Wed, 04 Mar 2020 17:18:16 -0500
X-MC-Unique: 2XMKtcL5MC63Oders68UQQ-1
Received: by mail-wr1-f69.google.com with SMTP id n12so1429477wrp.19
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 14:18:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wqft5lo3Zm47BUbzrIIQxJ61cvphsmqIQUJGbmyNiH4=;
 b=PHD7WYiFR4NR3ey4xYEH/Zeh1K4nxpHu+a4YiiiVRBNfL1Tqe4zYYJkDc2dgJGLMJy
 z9+WlHiBdSf6ACMtTemSEsA9bZiAYLtXRg9DjotKPs3TAuDhmVATvoFDukMtlfVjymZ+
 igg5EPBSeEoPbGd1oyo+EfcEUKwXCR+aQsDw/SjQvGT6eeKOBcBQLcdOEtu2SpgtmUcR
 Q548GWC/Qfz5/cOqxqhF6ulF5yCv60JOW1YO9GziCDh+qN4QqLKPLww6fbPQACWlQZhV
 cNBEPTCK0jXbz8/OgOIOtUJmwb/PyEZCFE0xn0TQ7AZ9EtO8y6E+vdweLWJVpiAp0Kxv
 Whcg==
X-Gm-Message-State: ANhLgQ3uD4mmkhoT79db4WH8Y6keQb2J+fzVAvfqVel6CcrK8/veJCrY
 E6JTK0bKnN8WgUQ75CHQoA9s+UkQACmcKQMp79msbPxHOYb2SMmVwnZnR/TFAjyuPGXSlaN/Vaj
 8XmiR8qcMRh4ISA0=
X-Received: by 2002:a05:6000:1246:: with SMTP id
 j6mr4283579wrx.253.1583360294786; 
 Wed, 04 Mar 2020 14:18:14 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsRtmVe+UpthqG+srK5guxiwnqy+NJfe/5y7pjqxGmb4mD83SZz0mvaBII5LFhzV7eC0Fhkxw==
X-Received: by 2002:a05:6000:1246:: with SMTP id
 j6mr4283558wrx.253.1583360294504; 
 Wed, 04 Mar 2020 14:18:14 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id j5sm6058032wmi.33.2020.03.04.14.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 14:18:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] hw/audio/fmopl: Fix a typo twice
Date: Wed,  4 Mar 2020 23:18:02 +0100
Message-Id: <20200304221807.25212-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304221807.25212-1-philmd@redhat.com>
References: <20200304221807.25212-1-philmd@redhat.com>
MIME-Version: 1.0
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/audio/fmopl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 9f50a89b4a..173a7521f2 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -1066,7 +1066,7 @@ static void OPLResetChip(FM_OPL *OPL)
 =09}
 }
=20
-/* ----------  Create one of vietual YM3812 ----------       */
+/* ----------  Create one of virtual YM3812 ----------       */
 /* 'rate'  is sampling rate and 'bufsiz' is the size of the  */
 FM_OPL *OPLCreate(int clock, int rate)
 {
@@ -1115,7 +1115,7 @@ FM_OPL *OPLCreate(int clock, int rate)
 =09return OPL;
 }
=20
-/* ----------  Destroy one of vietual YM3812 ----------       */
+/* ----------  Destroy one of virtual YM3812 ----------       */
 void OPLDestroy(FM_OPL *OPL)
 {
 #ifdef OPL_OUTPUT_LOG
--=20
2.21.1


