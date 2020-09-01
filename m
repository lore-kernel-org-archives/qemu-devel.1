Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD322071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="w9ZjfRyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD322071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDB04-0006pO-Ap
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kDAwk-0002WD-UU
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:23:54 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:52812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kDAwf-0006hh-CG
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:23:54 -0400
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net
 (sas1-ec30c78b6c5b.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 666412E14D8;
 Tue,  1 Sep 2020 21:23:42 +0300 (MSK)
Received: from sas1-58a37b48fb94.qloud-c.yandex.net
 (sas1-58a37b48fb94.qloud-c.yandex.net [2a02:6b8:c08:1d1b:0:640:58a3:7b48])
 by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Fk75UOlIp2-NfQeeCHp; Tue, 01 Sep 2020 21:23:42 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1598984622; bh=HAHASWyXqAf46TxOgSWHaIfJaFW144FXgn+EHmmscKk=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=w9ZjfRyMPysz6bjf2QIkZ6WdthE1GVk/GOFhKCeY89PpobewMCafBiGsJ1+yIdPPs
 G9DAH0pazMeLUflSXFCb7HslmZ2v7Ltaxb+0Dm3LCiYmUU4nisPLY5YY59sY1DbS1e
 i+uo6DPK42Zx1LVHYAn5iJexcvztBuEzj3dyJ3GY=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8026::1:2])
 by sas1-58a37b48fb94.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 kKjd0SHRPh-NfluvT65; Tue, 01 Sep 2020 21:23:41 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 0/4] Introducing QMP query-netdevs command
Date: Tue,  1 Sep 2020 21:23:22 +0300
Message-Id: <20200901182326.59633-1-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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

This patch series introduces a new QMP command "query-netdevs" to get
information about currently attached backend network devices (netdevs).
Also, since the "info_str" field of "NetClientState" is now deprecated,
we no longer use it for netdevs, only for NIC/hubports.
The HMP command "info network" now also uses the new QMP command inside.

Usage example:

-> { "execute": "query-netdevs" }
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
  qapi: net: Add query-netdevs command
  tests: Add tests for query-netdevs command
  hmp: Use QMP query-netdevs in hmp_info_network
  net: Do not use legacy info_str for backends

 include/net/net.h                |   4 +-
 net/clients.h                    |   1 +
 net/hub.c                        |   4 +-
 net/hub.h                        |   2 +-
 net/l2tpv3.c                     |  21 ++-
 net/net.c                        | 213 ++++++++++++++++++++++++++++++-
 net/netmap.c                     |  13 ++
 net/slirp.c                      | 128 ++++++++++++++++++-
 net/socket.c                     |  91 ++++++++++---
 net/tap-win32.c                  |  10 +-
 net/tap.c                        | 107 ++++++++++++++--
 net/vde.c                        |  39 +++++-
 net/vhost-user.c                 |  20 ++-
 net/vhost-vdpa.c                 |  15 ++-
 qapi/net.json                    |  68 ++++++++++
 tests/qtest/meson.build          |   3 +
 tests/qtest/test-query-netdevs.c | 117 +++++++++++++++++
 17 files changed, 797 insertions(+), 59 deletions(-)
 create mode 100644 tests/qtest/test-query-netdevs.c

-- 
2.25.1


