Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAF5C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139B52080D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="m57wfhAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139B52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irC0a-000200-Tf
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 21:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pizhenwei@bytedance.com>) id 1irBz9-0000FE-8b
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1irBz5-0003RM-Dt
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:31:12 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1irBz4-0003Oy-Gj
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:31:11 -0500
Received: by mail-pl1-x643.google.com with SMTP id y8so4590277pll.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 18:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=oDNrvMBkRQQTH00uWpsTcBSbalZCfUJLPRKuqSeoeSo=;
 b=m57wfhAlYH6hIE57ahyBAmG1u704XJRdyhT/WcMH19BXhsmWCHJpeKF9GfgxF+dHiM
 TmPvCrTPNU6h304ism86fJDBNmdQ33e6XegIyv4acUL9GV5BHjGGRGYBHo4ypMIj41Nr
 9SAUaGYuQz9EefbEX7s+xfqFE/2x7rFl9QgRFzBopWlev0hR27z4SHLwVkAfWp3MlPrs
 byKXsYkm+svl4SXOrhUZ0UGs4XEGaNrnQjoLxDiPafEXau7392uPlGNqNgNpKJlIOCph
 RhTRB/+vkKR9Cqp6bDEPIBnWP5S81wP0+U2b21Gxv+X/sInI+rIrfDljpbeRlSA54uzv
 j6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=oDNrvMBkRQQTH00uWpsTcBSbalZCfUJLPRKuqSeoeSo=;
 b=lo+vA0u2GsRjv89enUdBZEgS2d8eqbQDEmDCoM28FI0gp20OBFk+Bm7J44POvaU812
 WB4eIhzgj2Ah/DzutCtTubxC7vEvbHmHSkco8AwHhpvTP6nTaiESDnrGQnfM5E/sYmmp
 xcQts5cSR4CHbJ4zfG2T0XgVErhxld6xOOHuxVTyFGvEpqKsqVNTtX4EKqUt7f7nF0H9
 UH59lOUwuYuvYMDdneLA9xxxoX+/c6FKcW0Y6jS/KEGmczJzuKFbS+Szo6K5AEJUsR3p
 Aw2NTx/fEXr8HeM9PnsoeUdNzsx8KNU2FGhtvJTNDxudfXC3LlMd47pxSZXtqhGFutED
 ExKA==
X-Gm-Message-State: APjAAAVmmjZq4R4iJiF5twfMvEkEobkBKm5W3OxmMXc1rcKxjaOOIb5e
 ueQcQ9JaArtOizAz9Z+2GNdOFQ==
X-Google-Smtp-Source: APXvYqw2GGKY98QBoPTGSWXcvDPONV8N4+ERhCP4con4+EQ6LX5p7/ETHntC90Q7iT6qefFfxAXz9Q==
X-Received: by 2002:a17:902:848f:: with SMTP id
 c15mr17417150plo.182.1578969068845; 
 Mon, 13 Jan 2020 18:31:08 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id w5sm14693898pgb.78.2020.01.13.18.31.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2020 18:31:08 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com
Subject: [PATCH 0/2] pvpanic: implement crashloaded event for pvpanic
Date: Tue, 14 Jan 2020 10:31:00 +0800
Message-Id: <20200114023102.612548-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: gregkh@linuxfoundation.org, yelu@bytedance.com, qemu-devel@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>, mprivozn@redhat.com
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


