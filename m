Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE9BC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA7D2072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="vtsZYVsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA7D2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBDtt-0002gr-6x
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBDsC-0007Wx-1r
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBDsA-0007Iw-3o
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jBDs9-0007H9-ER
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id f7so4204135wml.4
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=lPu7ZqrTM6XiIoVuprg1Iv/S16uxcjwi4lN0jg0rcaM=;
 b=vtsZYVsNYk3MPyOc1o8LXzThpUnIrutrTGLZJTDYQN+BfflYdheImSF5RpQVACzAQx
 7sG875j36ImNU6b033Lz7V8J5QU9ky8XxnYFCmV/uP30LPPEdETnDuqMBZ2U3GRqHOvf
 uoqyVdiVMHg1vfM7R8S2oMIU0Ob0A1Z3J2Qrh1/SHbBQXzopDILPN+u8J0/6i8jThk8o
 IOVxB2LLljbulfdO4z0/olcpYZ44xDkzPQoBDhjYPGKOUuSljjmJfBNowI/na7UP4t2E
 LBw79RruZVaAT7KMQsNV/SIWwN4TCrB9CEuhmPvImqx17QWJCkG9Diay7Nh5mGXVSyS1
 sNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=lPu7ZqrTM6XiIoVuprg1Iv/S16uxcjwi4lN0jg0rcaM=;
 b=U2jre2yoK0LgNRzTUlvj496K1lAg64XNCxa+WfZVDTk1UvTFDaLBcnwFBlVrfK9F/n
 AXBE6ObPdE6kCPaAm92RrdbS1ZH5PQAQhDk3xUAnNe5W+bBGHdqXsG5nCiSiPGmZPZpX
 AgAkVwEXpcpY1719uN1VwRf5o8FQNhaxIbTplCosgev0+OCEzzbrsvOY9tWS0HV8FwkE
 we5K+XrjqtqbQVsFEKN15N3xUFwaUrED3QM9oMcNFdrwxCdpzkLtvqcVSzMZknrV9gLa
 xk0JOcbbyW8+nOL9d80ldnZtIKPCBi90cvmXZAkdp8stTuDVtl/IwdP8Z5Pu+4e4JbzZ
 B5bA==
X-Gm-Message-State: ANhLgQ0dJxtDuIvsCK5PNGVpDYxpwMCRu1D3dMc+DPdTe2zFIlzbIEv1
 +QCt/hPNctdO/uKvaJg92TpR6T7YOmYtmA==
X-Google-Smtp-Source: ADFU+vvq9H44tdXCHS/LxdC6yGIZ7QosO796gLRRK+UCwxowZHWHV22/uCYT45o3QCENqpzpCiM0RQ==
X-Received: by 2002:a1c:bc84:: with SMTP id
 m126mr18951033wmf.171.1583742888025; 
 Mon, 09 Mar 2020 01:34:48 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id h3sm63749726wrb.23.2020.03.09.01.34.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 09 Mar 2020 01:34:47 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 0/4] reference implementation of RSS
Date: Mon,  9 Mar 2020 10:34:34 +0200
Message-Id: <20200309083438.2389-1-yuri.benditovich@daynix.com>
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

Support for VIRTIO_NET_F_RSS feature in QEMU for reference
purpose. Implements Toeplitz hash calculation for incoming
packets according to configuration provided by driver.

Changes from v1:
Changes in standard virtio_net.h moved to virtio-net.c until
standard Linux header is updated and merged to QEMU
Added migration blocker if RSS is negotiated

Yuri Benditovich (4):
  virtio-net: introduce RSS and hash report features
  virtio-net: implement RSS configuration command
  virtio-net: implement RX RSS processing
  virtio-net: block migration if RSS feature negotiated

 hw/net/trace-events            |   3 +
 hw/net/virtio-net.c            | 347 +++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h |  13 ++
 3 files changed, 352 insertions(+), 11 deletions(-)

-- 
2.17.1


