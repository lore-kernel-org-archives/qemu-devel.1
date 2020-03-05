Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAA3C3F2CE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0472084E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrPgRn7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0472084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ey1-0006sE-2n
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 20:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ewn-0004Lq-B4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ewm-0005Vf-DX
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:05:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ewm-0005VM-9y
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583370308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Pobed26pNltZm/I9CiNxzmUNaY+9kG51Kk6vz3G8IU=;
 b=WrPgRn7uIZnoaVorPNiZXX4Am3uOwT5nUdzrseNAQszgP7qt/BueZbL47iRtyTE4bfSecl
 iaSQZ2GQJzqg8V9Lp5WnYaaKEhxwTo3t0Kq7/L9kShmwXwdEOV4YFgCCV5G+w9lj1C71az
 AeaKMi0oga7wb/SSDEMVryipz5JBDuQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-lut5XvbfNH2cZBwFwl13dg-1; Wed, 04 Mar 2020 20:05:06 -0500
X-MC-Unique: lut5XvbfNH2cZBwFwl13dg-1
Received: by mail-wr1-f72.google.com with SMTP id l15so1106800wrr.21
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 17:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jMnU2Ro3TeTUnU2ZUl/yMOyKuppxic5kPK7lhjxznVI=;
 b=Q5200ylrolOhfnxAR7Ys/9dmuHgVa2GrG+3CnxPuIFG8SKxqt2m5S7QRPwKTrpWhEY
 sSYvAWujY5a+61RVhYIbJaGpMujQKgEYED1HZZyEZeSb9a+hfZmJWqnQUGOiDIJgpgUM
 EVj/QRRf+nMnXfbv7kqNLw4j+vU/sG0oMXX+M1FngBAdmk+nxovVj9xG4CkWO5pLuwiA
 M8NN/l48CPS1FYIKAadH60NfInbyPIoKPkc6n0vSvgL10zNCHLrc80zbTQmXQo14RW73
 3b5jnJsC3Ydebu/DFoi/dTRNRJluKli7BXScts9dwqMgabmsOjUfgjtrjEfojFZ3Dxbe
 /eSw==
X-Gm-Message-State: ANhLgQ3eQF43c4dZLvXl1zNUqLnZwIW71tqq4q0YRaWEUBLGUJIUvaL3
 URzHzQKLM7l0lR4UaWSmvDO/uX1JHpjXMCaDXfd7Z31/ushC1ec0KQ9obeuqhxB+fGE8CWPH8Yw
 WrTCJjQwEMtOEBT8=
X-Received: by 2002:a1c:488b:: with SMTP id v133mr5910586wma.159.1583370304860; 
 Wed, 04 Mar 2020 17:05:04 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsACmAuVe5lYfeAoDO8kBmBnjPUB2CXcZOhSjuKqXRx0ACmPOcBDdZJM9Oi+/8DUXp8ycY47Q==
X-Received: by 2002:a1c:488b:: with SMTP id v133mr5910560wma.159.1583370304662; 
 Wed, 04 Mar 2020 17:05:04 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id g7sm39625648wrm.72.2020.03.04.17.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 17:05:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] virtfs-proxy-helper: Make the helper_opts[] array const
Date: Thu,  5 Mar 2020 02:04:46 +0100
Message-Id: <20200305010446.17029-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305010446.17029-1-philmd@redhat.com>
References: <20200305010446.17029-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reduce a bit the memory footprint by making the helper_opts[]
array const.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 fsdev/virtfs-proxy-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index aa1ab2590d..de061a8a0e 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -43,7 +43,7 @@
 #define BTRFS_SUPER_MAGIC 0x9123683E
 #endif
=20
-static struct option helper_opts[] =3D {
+static const struct option helper_opts[] =3D {
     {"fd", required_argument, NULL, 'f'},
     {"path", required_argument, NULL, 'p'},
     {"nodaemon", no_argument, NULL, 'n'},
--=20
2.21.1


