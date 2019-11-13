Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57AAC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB91206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="OfL48JWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB91206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV0B3-00025o-Hz
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 16:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lekiravi@yandex-team.ru>) id 1iV090-0001Gd-7X
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lekiravi@yandex-team.ru>) id 1iV08w-0004MC-60
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:25:39 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:51084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lekiravi@yandex-team.ru>)
 id 1iV08v-0004FO-I5
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:25:38 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id A892D2E1440;
 Thu, 14 Nov 2019 00:25:33 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net
 (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 JGd3x5KYY3-PWtqsf4s; Thu, 14 Nov 2019 00:25:33 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1573680333; bh=65Dq7/TxYLGgzDS7c+ZxJIZ84GMGnsm2kGCw1hLFslc=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=OfL48JWmMrEikMYX8pDVtZ3EApLOPzE2RHEwfgF8qipbKMu5caYz8o7WQnPRS/eqF
 11Htx5MugbrncRRLjcRsG11cNOO6WHXuTymr0Yj2I8ArkCKNIzMO3GrmMpSJXgksr9
 JfN63ZVKixvob31a7nGznJN0XUaGyB6B5CY1M1tQ=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7204::1:11])
 by vla1-5826f599457c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 dbNdL4rsWi-PWV8dP2k; Thu, 14 Nov 2019 00:25:32 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Jason Wang <jasowang@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 0/2] Introducing QMP query-netdevs command
Date: Thu, 14 Nov 2019 00:25:14 +0300
Message-Id: <20191113212516.13606-1-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 yc-core@yandex-team.ru, Alexey Kirillov <lekiravi@yandex-team.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces a new QMP command "query-netdevs" to get information
about currently attached network devices.
Potentially, this patch makes the "info_str" field of "struct NetClientState"
and HMP command "info network" obsolete as new command gives out more
information in a structured way.

Usage example:

{ "execute": "x-query-netdevs" }
{ "return": [
    {
      "peer": "netdev0",
      "netdev": "netdev0",
      "model": "virtio-net-pci",
      "macaddr": "52:54:00:12:34:56",
      "queues_count": 1,
      "type": "nic",
      "id": "net0"
    },
    {
      "peer": "net0",
      "ipv6": true,
      "ipv4": true,
      "host": "10.0.2.2",
      "queues_count": 1,
      "ipv6-dns": "fec0::3",
      "ipv6-prefix": "fec0::",
      "net": "10.0.2.0/255.255.255.0",
      "ipv6-host": "fec0::2",
      "type": "user",
      "dns": "10.0.2.3",
      "hostfwd": [
        {
          "str": "tcp::20004-:22"
        }
      ],
      "ipv6-prefixlen": 64,
      "id": "netdev0",
      "restrict": false
    }
  ]
}

Alexey Kirillov (2):
  qapi: net: Add query-netdevs command
  tests: Add tests for query-netdevs command

 include/net/net.h          |   1 +
 net/hub.c                  |   8 +++
 net/l2tpv3.c               |  19 ++++++
 net/net.c                  |  80 +++++++++++++++++++++++
 net/netmap.c               |  13 ++++
 net/slirp.c                | 126 +++++++++++++++++++++++++++++++++++++
 net/socket.c               |  71 +++++++++++++++++++++
 net/tap-win32.c            |   9 +++
 net/tap.c                  | 103 ++++++++++++++++++++++++++++--
 net/vde.c                  |  26 ++++++++
 net/vhost-user.c           |  18 +++++-
 qapi/net.json              |  85 +++++++++++++++++++++++++
 tests/Makefile.include     |   2 +
 tests/test-query-netdevs.c | 114 +++++++++++++++++++++++++++++++++
 14 files changed, 667 insertions(+), 8 deletions(-)
 create mode 100644 tests/test-query-netdevs.c

-- 
2.17.1


