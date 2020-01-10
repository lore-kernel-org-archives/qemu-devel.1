Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD4FC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1AA2072A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="xMKTwMvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1AA2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprCm-0006vX-9w
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pizhenwei@bytedance.com>) id 1iprBn-0005jo-0l
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1iprBk-0003ND-EB
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:06:45 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1iprBj-0003Dn-UU
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:06:44 -0500
Received: by mail-pg1-x544.google.com with SMTP id z124so757208pgb.13
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 02:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=oDNrvMBkRQQTH00uWpsTcBSbalZCfUJLPRKuqSeoeSo=;
 b=xMKTwMvmqJqgfiqQQ1f0ZqIME9T87jrJuUXG64OuIf3O0F2zsAyp5tYi8hc2IQVYXN
 Pmd7EvnfptMa+fu7bfL/Q00xwX5C0PAQcpMa3RJBnfuaxF7+08Oa62UbVzd0VXDsgz+a
 NbskKxPRDigGHMum3n/glyS/Yb/QjFtF4SVsfLJpcNGSxT63gmSnIl6tKSlCfZjDcanB
 BiUqvD68BfBI/FhdD7M0Ol8zPFV34qqxR+VxOD86DuhHplKzFa4TC4EGYDvc8TH+kzEP
 +UD5rS0XXdbYCG5xk20Cw+N3Ismuep3KdsWfSHF3D7f3TA761m0Nb2zxOVSYvcTEUjYP
 0aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=oDNrvMBkRQQTH00uWpsTcBSbalZCfUJLPRKuqSeoeSo=;
 b=jEDH9nIcY6Rez9kj9ieoobo7gOvK0SM3dLO5LaQMi4MH8LPZ1eOZOyXaT1XbyNzmwd
 JTT+AKEAVGe3vSCJeWA3gSEH2nQalpQ9txsmDz4fSWgrQXHEU2xTWH+tcVcjs328fbFV
 sOgg8Hwyd7q+Sd/yPUFBjj5wRgrN6ySmaBlT1B2EbzQ/W974H395llS5ChUMv4+HHWxM
 E1wijyNQp0gEgTC5VqjDzeRBx8yOoC/VZ9hBXfVBgU3o602RQudNo9jgH40aduImgW1a
 Gg5jBAFhDZ6JoGb4NAHowN/U5QAVDHukmWVk7u3x7FlYzSTAnKs8zPzKaY8lznF/4UmT
 mvmg==
X-Gm-Message-State: APjAAAXaIvWRVUU7VKJjxffx/fD21BkXXn+yFUf9yMlgW0rZFMDI5SCK
 Rqua9pu/xpH+elxbLmx8PZpWBg==
X-Google-Smtp-Source: APXvYqwOg2iZTvMq8n+lTbhfVWdNMzvGM/Qr1Rzr8smGqT5tcQE2hUGv64lEIz0XWQSSNAl6/fh5gw==
X-Received: by 2002:a63:7045:: with SMTP id a5mr3450324pgn.49.1578650801656;
 Fri, 10 Jan 2020 02:06:41 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id q21sm2179039pff.105.2020.01.10.02.06.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jan 2020 02:06:41 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com
Subject: [PATCH 0/2] implement crashloaded event for pvpanic
Date: Fri, 10 Jan 2020 18:06:32 +0800
Message-Id: <20200110100634.491936-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: yelu@bytedance.com, libvir-list@redhat.com, gregkh@linuxfoundation.org,
 qemu-devel@nongnu.org, zhenwei pi <pizhenwei@bytedance.com>,
 linux-kernel@vger.kernel.org, mprivozn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Guest may handle panic by itself, then just reboot without pvpanic
notification. Then We can't separate the abnormal reboot from
normal operation.

Declear bit 1 for pvpanic as crashloaded event. It should work with
guest kernel side. Link: https://lkml.org/lkml/2019/12/14/265
Before running kexec, guest could wirte this bit to notify host side.
Host side handles crashloaded event, posts event to upper layer.
Then guest side continues to run kexec.

Test with libvirt, libvirt could recieve the new event. The patch of
libvirt will be sent soon.

Zhenwei Pi (2):
  pvpanic: introduce crashloaded for pvpanic
  pvpanic: implement crashloaded event handling

 docs/specs/pvpanic.txt    |  8 ++++++--
 hw/misc/pvpanic.c         | 11 +++++++++--
 include/sysemu/runstate.h |  1 +
 qapi/run-state.json       | 22 +++++++++++++++++++++-
 vl.c                      | 12 ++++++++++++
 5 files changed, 49 insertions(+), 5 deletions(-)

-- 
2.11.0


