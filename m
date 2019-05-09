Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3472FC04AB2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0FB2173B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0FB2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54294 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOikl-00016S-5e
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:06:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOiin-0007pk-Sr
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOiim-0007lW-Os
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hOiik-0007Jf-NG
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:04:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AD41308219E
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 13:03:49 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-227.ams2.redhat.com
	[10.36.116.227])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0514B60FA6;
	Thu,  9 May 2019 13:03:45 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:03:41 +0200
Message-Id: <20190509130345.227526-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 09 May 2019 13:03:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/4] Clean ups in net/net.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is a follow up of "[PATCH] net: avoid to use variable length
array in net_client_init()" [1], so it contains the v2 of that patch,
plus other new related patches.

I discovered an assertion failure while I was testing the patches, so I
added the patch 1 to solve this issue.

Following the Markus' advice, I modified the parsing of IPv6 prefix
(patch 2) and IPv4 host:port (patch 3). Then I removed the get_str_sep()
function (patch 4) because it is no longer used.

@Markus, I modified a little bit what you suggested, introducing
g_strsplit() in order to de-duplicate the qemu_opt_set() and
qemu_opt_set_number(). I hope it's good for you.

v2:
 - Added patches 1,3 and 4
 - Patch 2:
   - clean up parsing of IPv6 prefix [Markus]
   - fixed subject line [Eric]

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg614561.html

Stefano Garzarella (4):
  net: fix assertion failure when ipv6-prefixlen is not a number
  net: avoid using variable length array in net_client_init()
  net: use g_strsplit() for parsing host address and port
  net: remove unused get_str_sep() function

 net/net.c | 101 +++++++++++++++++++++++++++---------------------------
 1 file changed, 51 insertions(+), 50 deletions(-)

--=20
2.20.1


