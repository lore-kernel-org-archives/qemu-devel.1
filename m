Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B40AC4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8028820757
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="aN4zOKoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8028820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKROL-0003Te-Hq
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kKRLZ-0000pR-2j
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:19:33 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:42724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kKRLU-0004Fv-GM
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:19:31 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 341692E0EBF;
 Mon, 21 Sep 2020 22:19:21 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 dhi4BUjH3O-JKvekXts; Mon, 21 Sep 2020 22:19:21 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1600715961; bh=XiE3esPpBcN1RWiC5vxaFhExcNrgBPR2W5fHbjEu4ho=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=aN4zOKoojfI2WgyG8ZIaZbk3UE+vdDtujCIahvzw7A4DrQFzSjyt9d5JvfaSLdsA+
 DvJ2lxef+orrWcI+1ndQ9HPx0JMS1XKRqityd47VfEVDnrN0H0hFVd8CbKB5tl/PYU
 9Hd1MBPMtiUYgX5NTyJ2UwQptm/DhAhl03ud0fVQ=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:6416::1:4])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 3Nc4XKVFl3-JKl45YtE; Mon, 21 Sep 2020 22:19:20 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 0/4] Introducing QMP query-netdev command
Date: Mon, 21 Sep 2020 22:19:08 +0300
Message-Id: <20200921191912.105305-1-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 15:19:21
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series introduces a new QMP command "query-netdev" to get
information about currently attached backend network devices (netdevs).
Also, since the "info_str" field of "NetClientState" is now deprecated,
we no longer use it for netdevs, only for NIC/hubports.
The HMP command "info network" now also uses the new QMP command inside.

Usage example:

-> { "execute": "query-netdev" }
<- { "return": [
         {
             "listen": "127.0.0.1:90",
             "type": "socket",
             "peer-id": "hub0port1",
             "id": "__org.qemu.net1"
         },
         {
             "script": "/etc/qemu-ifup",
             "downscript": "/etc/qemu-ifdown",
             "ifname": "tap0",
             "type": "tap",
             "peer-id": "net5",
             "vnet_hdr": true,
             "id": "tap0"
         },
         {
             "ipv6": true,
             "ipv4": true,
             "host": "10.0.2.2",
             "ipv6-dns": "fec0::3",
             "ipv6-prefix": "fec0::",
             "net": "10.0.2.0/255.255.255.0",
             "ipv6-host": "fec0::2",
             "type": "user",
             "peer-id": "net0",
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

v3->v4:
- Rename "query-netdevs" to "query-netdev".
- Copy netdev drivers to new QAPI enum "NetBackend".

v2->v3:
- Remove NIC and hubports from query-netdevs.
- Remove several fields from NetdevInfo since they are unnecessary.
- Rename field @peer to @peer-id.
- Add support of vhost-vdpa.
- Keep "info_str" for NIC/hubports, but remove it for netdevs.

v1->v2:
- Rewrite HMP "info network" to get information from results of QMP command.
- Remove obsolete field "info_str" from "NetClientState".

Alexey Kirillov (4):
  qapi: net: Add query-netdev command
  tests: Add tests for query-netdev command
  hmp: Use QMP query-netdev in hmp_info_network
  net: Do not use legacy info_str for backends

 include/net/net.h               |   4 +-
 net/clients.h                   |   1 +
 net/hub.c                       |   4 +-
 net/hub.h                       |   2 +-
 net/l2tpv3.c                    |  21 +++-
 net/net.c                       | 213 +++++++++++++++++++++++++++++++-
 net/netmap.c                    |  13 ++
 net/slirp.c                     | 128 ++++++++++++++++++-
 net/socket.c                    |  91 ++++++++++----
 net/tap-win32.c                 |  10 +-
 net/tap.c                       | 107 ++++++++++++++--
 net/vde.c                       |  39 +++++-
 net/vhost-user.c                |  20 ++-
 net/vhost-vdpa.c                |  15 ++-
 qapi/net.json                   |  80 ++++++++++++
 tests/qtest/meson.build         |   3 +
 tests/qtest/test-query-netdev.c | 115 +++++++++++++++++
 17 files changed, 807 insertions(+), 59 deletions(-)
 create mode 100644 tests/qtest/test-query-netdev.c

-- 
2.25.1


