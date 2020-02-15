Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E1C4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0282083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpZ2DX7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0282083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j308i-0004eD-OW
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 11:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j307R-0002vJ-JK
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j307Q-00068h-LB
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j306y-0005dK-0k
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581783367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2W2KV5vhhaOPypV6UoE9INvWUy7cADf9BtseHUCCnZ8=;
 b=HpZ2DX7sf47ZuOBheWWfoNDpWt4rd1f5k+ZpMwvr55p8bAdXYHkmFW3I3ep9Y3k+7RgjMm
 k0F/aDk956uSFggwVtbFSmGqxLfm86Tsx34YawM8wz0mvL9LAUkG7jwxig4TZX4CjQm67P
 PbC05lFSoh8e6B+xfBXMuppwOWwZfEo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-wLuubM3OPdicWWHTFDBTKg-1; Sat, 15 Feb 2020 11:16:04 -0500
Received: by mail-wr1-f69.google.com with SMTP id u18so5888936wrn.11
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 08:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t93RD3b9dRJMk744Iwvg4Pa/O1lItTONfyZhiaohMVU=;
 b=hntyLaPoW0nLc+tbKyjnMpzMYyxptWB3avpkRQUCaCpUSo/tFbvGuIM5Ppv6RF+axh
 MvkgeiUMIhv4/2DbU0zrp5JbSG7jCeH1b+UioxRjTA4UTZBZb5+RpWY0c1tYwMneWIr1
 NsicpuEU98WhQrk4p7Dfr6z1IBU154nmhDSG3qPYTrIZP7EsmsahuZtJzfk79buq55Oa
 iIiiZ/aREqzJeHWoPzySbtiualH02mYChoXrHJLtAP8pj5DZ/BqQi08OqX7AdusYGH+K
 ZQtJqsTFIvcRJ++5VDAyag/ay12OW3lxk/LzMkoPzDu5kxnLNTsWlDr34qGEnisreZRx
 SNGw==
X-Gm-Message-State: APjAAAUYbm8WkSjddjQjba8lK6lUhGB9YDdjHyQCTZqxB5tDYnscJ1Xw
 VOsl/Infms8nj3pSnfwLYVETmhz6RJ1EPGMv4SPPpZNaiNRaumU3TxSNaB8V3RlX7CbuYyMbnUB
 dCVZboy6eLKwL6n4=
X-Received: by 2002:a05:6000:192:: with SMTP id
 p18mr10610940wrx.218.1581783363450; 
 Sat, 15 Feb 2020 08:16:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwj+7l1rgw3xDAlzv9WUiiMsr0WEM7lX9ZCD/FFnzJs4cYtMVSolk6GYqoQJdpfzWpU1SzzAw==
X-Received: by 2002:a05:6000:192:: with SMTP id
 p18mr10610917wrx.218.1581783363170; 
 Sat, 15 Feb 2020 08:16:03 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w26sm11855872wmi.8.2020.02.15.08.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 08:16:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/display/qxl: Remove unneeded variable assignment
Date: Sat, 15 Feb 2020 17:15:56 +0100
Message-Id: <20200215161557.4077-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215161557.4077-1-philmd@redhat.com>
References: <20200215161557.4077-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: wLuubM3OPdicWWHTFDBTKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

  hw/display/qxl.c:1634:14: warning: Value stored to 'orig_io_port' during =
its initialization is never read
      uint32_t orig_io_port =3D io_port;
               ^~~~~~~~~~~~   ~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 64884da708..21a43a1d5e 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1631,7 +1631,7 @@ static void ioport_write(void *opaque, hwaddr addr,
     PCIQXLDevice *d =3D opaque;
     uint32_t io_port =3D addr;
     qxl_async_io async =3D QXL_SYNC;
-    uint32_t orig_io_port =3D io_port;
+    uint32_t orig_io_port;
=20
     if (d->guest_bug && io_port !=3D QXL_IO_RESET) {
         return;
--=20
2.21.1


