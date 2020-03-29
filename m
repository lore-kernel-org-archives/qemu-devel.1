Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C855C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 15:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BC7206F6
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 15:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="fN7nd1QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BC7206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIZb4-000138-C6
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 11:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jIZZf-0007gb-NL
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jIZZe-0006iN-LW
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jIZZe-0006fT-AR
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id d1so18320366wmb.2
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=ETpaNK1dMjFrlh/JeskAdsl5YHHm6MmUrz9HfD8MZl0=;
 b=fN7nd1QPbfJNxaedqGcHWfxmNsT54PUtppPYXgzJGH0xPisIIjv2Jg/3a6qNW27bAm
 ZPiA+wx/68aOFIq/wGWrL0JOZoPOmJnt8t/HXUiIneJMNRxkWlsL3QUDHqOTY1gr1DUT
 gQVhqK1MToKAzap8QDqRrV2xnfj5O3TkNyNxkjm2p7GpPSJ0A1AQjYioPbPcP8UlKnpX
 734Tma0jndpOb7XlSHIPaHz9HzpM0VG7K6H5t1Avx1OeJvwuwlRVW29O5cY4PWVxmwYa
 as16WSfsygWm4PR4H/Rbf4VVUINPgYPg+EtLZDQyPfYRRvCVYAbRR/NpS50uSuQsQx3H
 8P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ETpaNK1dMjFrlh/JeskAdsl5YHHm6MmUrz9HfD8MZl0=;
 b=m7DNorxNhNu9cnYqnbbsvB3+A5TLQbrVHuZRZkC+GnBGk31HAfQJiF9D+4luOTZmLg
 /7luAltKdlcAIKzFX+CH2vyIJkVstb9WTgt2ib2TS/zkCE68V07Yt9ZtSsQ4TPJrjM6H
 vq5ImwIOZ4gspwcVk74wML7leZYw4q5o1RSJHT6qR3klHo9bV5/yRLv8A7sKOmfREX1/
 uPGQaY4esME/MYokbSfFYFw9L28MyIlBntrzC4Usg0YCvO+A9ro1MhuW2DDj03thK/Vq
 EuQYExiYlIEKBCEd1hSbaYsdGSDbqC/Su9e4fxPhTbyDITMPL4Dwri0Mztk7zz9OfYP6
 qAVA==
X-Gm-Message-State: ANhLgQ12Iy3lU2r5FtfUyEPh1u/8tISqYyMeX/nYJXHW7Fv7jUFUK0SF
 BBWChyTQvLQYfbACYprpbRc7BdvDxfjy6A==
X-Google-Smtp-Source: ADFU+vvfDAscy8xuESZx+J3TOXO7fEW5YB72moiP9V2c5CgcYPLU96Yl0FWVtR4XHcsGZJw0j/x0PA==
X-Received: by 2002:a1c:23d6:: with SMTP id j205mr8724149wmj.22.1585494604875; 
 Sun, 29 Mar 2020 08:10:04 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-67-107.red.bezeqint.net.
 [79.183.67.107])
 by smtp.gmail.com with ESMTPSA id s2sm5477874wmh.37.2020.03.29.08.10.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 29 Mar 2020 08:10:04 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v7 0/7] reference implementation of RSS and hash report
Date: Sun, 29 Mar 2020 18:09:46 +0300
Message-Id: <20200329150953.23812-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
features in QEMU for reference purpose.
Implements Toeplitz hash calculation for incoming
packets according to configuration provided by driver.
Uses calculated hash for decision on receive virtqueue
and/or reports the hash in the virtio header

Changes from v6:
Fixed a bug in patch 5 "reference implementation of hash report"
that caused the ASAN test to fail
was: n->rss_data.populate_hash = true;
fixed: n->rss_data.populate_hash = !!hash_report;

Yuri Benditovich (7):
  virtio-net: introduce RSS and hash report features
  virtio-net: implement RSS configuration command
  virtio-net: implement RX RSS processing
  tap: allow extended virtio header with hash info
  virtio-net: reference implementation of hash report
  vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
  virtio-net: add migration support for RSS and hash report

 hw/net/trace-events            |   3 +
 hw/net/virtio-net.c            | 448 +++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h |  16 ++
 include/migration/vmstate.h    |  10 +
 net/tap.c                      |  11 +-
 5 files changed, 460 insertions(+), 28 deletions(-)

-- 
2.17.1


