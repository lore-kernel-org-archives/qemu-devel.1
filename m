Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B76C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4352E20838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="n3wK1KI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4352E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9TlO-0004aU-Aw
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lekiravi@yandex-team.ru>) id 1j9TkG-0002kT-1Z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:07:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lekiravi@yandex-team.ru>) id 1j9TkE-00017g-R3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:07:27 -0500
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:43130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lekiravi@yandex-team.ru>)
 id 1j9Tk9-0000mr-Ce; Wed, 04 Mar 2020 08:07:22 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id C66D32E15B5;
 Wed,  4 Mar 2020 16:07:14 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net
 (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Ozy1oH08C4-77ECqaxH; Wed, 04 Mar 2020 16:07:14 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1583327234; bh=Buqm9BU7btNF5ftlu+o2Q8ZAjGnwQ5hYELyGAUYeBH0=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=n3wK1KI85tfhFycwUO1cQ8tecrbNpXxSvCBq+7f6hkbXsr3zupioaSUS6AH4ZhxHG
 jj+cpqRdsukX5aSyyVx5n6DiNRd7Fq9hbL8sOTv8SnGaFPrcX4j6pi2NXBA7sIjQY6
 JAGFEjXC0keTAWvEjMfT1DQqd/blA+R42ljmMxv0=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:b4f7:3f29:4fea:8822])
 by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 ujb0Gsh6CR-76WO2P6J; Wed, 04 Mar 2020 16:07:07 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 0/4] Introducing QMP query-netdevs command
Date: Wed,  4 Mar 2020 16:06:52 +0300
Message-Id: <20200304130656.16859-1-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Sven Schnelle <svens@stackframe.org>, Rob Herring <robh@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 yc-core@yandex-team.ru, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 xen-devel@lists.xenproject.org, Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Alexey Kirillov <lekiravi@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series introduces a new QMP command "query-netdevs" to get
information about currently attached network devices.
Also, since the "info_str" field of "NetClientState" is now deprecated,
it has been completely removed.
The HMP command "info network" now also uses the new QMP command inside.

Usage example:

-> { "execute": "query-netdevs" }
<- { "return": [
         {
             "peer": "netdev0",
             "netdev": "netdev0",
             "perm-mac": "52:54:00:12:34:56"
             "model": "virtio-net-pci",
             "macaddr": "52:54:00:12:34:56",
             "queues-count": 1,
             "type": "nic",
             "id": "net0"
         },
         {
             "peer": "net0",
             "ipv6": true,
             "ipv4": true,
             "host": "10.0.2.2",
             "queues-count": 1,
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

v2->v1:
- Rewrite HMP "info network" to get information from results of QMP command.
- Remove obsolete field "info_str" from "NetClientState".

Alexey Kirillov (4):
  qapi: net: Add query-netdevs command
  tests: Add tests for query-netdevs command
  hmp: Use QMP query-netdevs in hmp_info_network
  net: Remove field info_str of NetClientState

 hw/net/allwinner_emac.c          |   2 +-
 hw/net/dp8393x.c                 |   2 +-
 hw/net/e1000.c                   |   4 +-
 hw/net/e1000e.c                  |   2 +-
 hw/net/e1000e_core.c             |   2 +-
 hw/net/e1000x_common.c           |   2 +-
 hw/net/eepro100.c                |   5 +-
 hw/net/etraxfs_eth.c             |   2 +-
 hw/net/fsl_etsec/etsec.c         |   2 +-
 hw/net/ftgmac100.c               |   2 +-
 hw/net/i82596.c                  |   6 +-
 hw/net/imx_fec.c                 |   2 +-
 hw/net/lan9118.c                 |   4 +-
 hw/net/mcf_fec.c                 |   2 +-
 hw/net/milkymist-minimac2.c      |   2 +-
 hw/net/mipsnet.c                 |   2 +-
 hw/net/ne2000-isa.c              |   2 +-
 hw/net/ne2000-pci.c              |   2 +-
 hw/net/pcnet.c                   |   2 +-
 hw/net/rocker/rocker_fp.c        |   4 +-
 hw/net/rtl8139.c                 |   6 +-
 hw/net/smc91c111.c               |   2 +-
 hw/net/spapr_llan.c              |   6 +-
 hw/net/stellaris_enet.c          |   2 +-
 hw/net/sungem.c                  |   4 +-
 hw/net/sunhme.c                  |   2 +-
 hw/net/tulip.c                   |   2 +-
 hw/net/virtio-net.c              |   8 +-
 hw/net/vmxnet3.c                 |   4 +-
 hw/net/xen_nic.c                 |   4 -
 hw/net/xgmac.c                   |   2 +-
 hw/net/xilinx_axienet.c          |   2 +-
 hw/net/xilinx_ethlite.c          |   2 +-
 hw/usb/dev-network.c             |   2 +-
 include/net/net.h                |   7 +-
 net/clients.h                    |   1 +
 net/hub.c                        |  12 +-
 net/hub.h                        |   2 +-
 net/l2tpv3.c                     |  20 ++-
 net/net.c                        | 272 +++++++++++++++++++++++++++++--
 net/netmap.c                     |  13 ++
 net/slirp.c                      | 128 ++++++++++++++-
 net/socket.c                     |  93 ++++++++---
 net/tap-win32.c                  |   9 +
 net/tap.c                        | 107 ++++++++++--
 net/vde.c                        |  40 ++++-
 net/vhost-user.c                 |  20 ++-
 qapi/net.json                    |  89 ++++++++++
 tests/qtest/Makefile.include     |   2 +
 tests/qtest/test-query-netdevs.c | 120 ++++++++++++++
 50 files changed, 917 insertions(+), 119 deletions(-)
 create mode 100644 tests/qtest/test-query-netdevs.c

-- 
2.17.1


