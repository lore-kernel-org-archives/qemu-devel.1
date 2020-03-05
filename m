Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218FEC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9EE720848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHyeOnsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EE720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pu7-00007o-0E
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9psg-00066m-J7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9psf-0001Km-FB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9psf-0001Ke-Am
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583412336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8JgHjC2tXoZAEY+Z+QWQFzxkwOUopjQLXjv3/2fagw=;
 b=AHyeOnsSnrDsx5B/GH9UcQVwIsdQbrgBK1Rcw9FjHArxO7/dpvigDu2fGAiFjENOGYplRd
 +t9lv4ZoP/e9IOomdxJFNR7BeKDCZ91FSw5DcC22wy1ArsASIy1PkyJooNWuiJntKRwgvD
 EK1wry7DJ0TUfrh3TAiCWBlLL+j9t0g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-Ew-UClyXMz64FZgDfKNDVQ-1; Thu, 05 Mar 2020 07:45:35 -0500
X-MC-Unique: Ew-UClyXMz64FZgDfKNDVQ-1
Received: by mail-wr1-f72.google.com with SMTP id b12so2282043wro.4
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e8/VptnNWOgnx0RgaFPk1+9lrGqKzxjndWbawBpy4oA=;
 b=EDswy+DAyadaUm0gVo0CI+nBuNIEznZeX/YX3CcdOuqFx467Z0bJry4+UUSKgPvoTv
 kOKsQho6Yv9X4BfZv+HYYdRQGQLMPRJktL0zdGrLUblLrhUiM/EkTILUI43LoHVyZ8Dv
 qlMT8yQzw3Ua0ZskiieNBBR50At2/3fFTeLFMjdNdDh+TqLZR7s7nBcOgARdoc/Bk3h7
 00XX86EfTWNFT/LuSh6k1DOnyaJUullCNnkAHyWOBdfKB3vEfhz2g72GW2L1q29dyhII
 4WABqcAPaWX7wL/fxzenjMFq+37MBmBXHHWBTGGPDO1OsXSJ6N7Na2Ewnr9REqY/XoiO
 KJ8A==
X-Gm-Message-State: ANhLgQ300zMXqCmcJ9wxzTpKg2bkedS4MoqqpJf0DdWpweVAOZtt/Nfe
 +b5AOLvyaoning5oqeRn9E/Bl0NbqNwOwXsy4rqaX+N7KkMQ4+sTR3G63t+2B+rTD03mVyholwN
 Y/91swfqyvN14PJA=
X-Received: by 2002:adf:f041:: with SMTP id t1mr9555754wro.98.1583412334057;
 Thu, 05 Mar 2020 04:45:34 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvBJX4eBPj6deoHJ3R1XiuP/1oQusUpv01W1MI5QD8pSRm/PrjA2JhtMn33wjd9Ey+mMm3Npg==
X-Received: by 2002:adf:f041:: with SMTP id t1mr9555734wro.98.1583412333897;
 Thu, 05 Mar 2020 04:45:33 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id w16sm10556707wrp.8.2020.03.05.04.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:45:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] hw/audio/fmopl: Fix a typo twice
Date: Thu,  5 Mar 2020 13:45:17 +0100
Message-Id: <20200305124525.14555-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305124525.14555-1-philmd@redhat.com>
References: <20200305124525.14555-1-philmd@redhat.com>
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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


