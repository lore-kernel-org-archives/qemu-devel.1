Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3130FC5ACD7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CE42076F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="fWeA7ZU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CE42076F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEUpu-0005kJ-2b
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEUng-0003Bw-IB
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEUnf-0004Hq-Fp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jEUne-00045Q-VD
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id s1so7541729wrv.5
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=PrBeOXrlc9s+5ERhc/Dvn2ukFyls171kPB7lx4J1lSA=;
 b=fWeA7ZU6nLvpoDUPkvwA2P+cfjEd4ncLiTQ9n8KXzN5WqTlfzZiY5rZjdqGbp9wnym
 JxNVY8PSOuQv3WWzYkSf2ppTBrdFWNJkGFpmIaCN4xCxX07siZB4tVcT5CsnI5By3HIq
 xagw9J451Mh3g73eAlLvCZSGLu2kU1HdUp/OX2rPtR0uQqZCbl5lKbWRC1yqQpU8M2ZK
 /zlCRlvXKM2Q4msk+ET6ebPdIvsPCzPB7g3cwmDE8U/3I2jPVZHaWz0hCtwNfAi67YX4
 xezMuqTKnnugAkCBKCHqo8hLCQXB1I29S3Xz/RpAP+/CrIe/dDgCtE2ZU76gHwawp3rL
 DEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=PrBeOXrlc9s+5ERhc/Dvn2ukFyls171kPB7lx4J1lSA=;
 b=r0f/QadCRMvVxnyY0aFWr5+E2UGJ3kGibHP96m/v1qF+3rwdcGLp+w7LNIqUiuwAM0
 nfIfA1Iu+UZzpBxUMEbMzLpDaQx5cypt/bpTlVCXPQDINenUAhZsDQ9vB52/kSIrXNBj
 qREQyujRYFZLdXiQE8eIOnnPr0BeYHiOlqfVZXM6YA8lmzuvJaPBCmC/Bho/2lLzeU0A
 Fdm0Z08YEZ/ZLkdd+iVQrEKHOIz+VHaWdi2HBqa6/g9t3AKl21AK5AmDijb287v2RDNm
 giNCEwHGErTExi0MHo8EryXqIYRcRm1lOIhRuDY8Yub92hQy0sxYVP3bfYFLh58/S586
 yaIA==
X-Gm-Message-State: ANhLgQ2xNLM6rtRwtD9OdqMns/0+CAW8RFjLKaNbK8SvhZ8wTX0HO9m5
 CIG3kvum91VT6uzOmKdaVLUfKDmAP5T1Fg==
X-Google-Smtp-Source: ADFU+vvZ2YwTMdokL/CbtybWdBwbb5GkyaC5G9lwIWMVYySNPKxjj0j9Y5WiLNozeWnCkbVdMogKNQ==
X-Received: by 2002:a5d:6908:: with SMTP id t8mr4614982wru.92.1584522940687;
 Wed, 18 Mar 2020 02:15:40 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id z22sm3062342wmi.1.2020.03.18.02.15.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 18 Mar 2020 02:15:39 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v5 0/7] reference implementation of RSS and hash report
Date: Wed, 18 Mar 2020 11:15:18 +0200
Message-Id: <20200318091525.27044-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Changes from v4
Use 16-bit field for indirection table length (patch 2)
Add VMSTATE_VARRAY_UINT16_ALLOC for migration of
indirection table (patch 6)

Yuri Benditovich (7):
  virtio-net: introduce RSS and hash report features
  virtio-net: implement RSS configuration command
  virtio-net: implement RX RSS processing
  tap: allow extended virtio header with hash info
  virtio-net: reference implementation of hash report
  vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
  virtio-net: add migration support for RSS and hash report

 hw/net/trace-events            |   3 +
 hw/net/virtio-net.c            | 437 +++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h |  16 ++
 include/migration/vmstate.h    |  10 +
 net/tap.c                      |  11 +-
 5 files changed, 449 insertions(+), 28 deletions(-)

-- 
2.17.1


