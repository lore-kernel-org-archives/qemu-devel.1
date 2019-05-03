Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D9EC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6DE20651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6DE20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44781 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbet-0000uZ-Ft
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:07:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMbdt-0000UG-BW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMbds-0000ww-AD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hMbds-0000vt-54
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:06:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E302F3091749;
	Fri,  3 May 2019 17:06:34 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.36.118.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E21F419C4F;
	Fri,  3 May 2019 17:06:32 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 19:06:31 +0200
Message-Id: <20190503170631.228487-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 03 May 2019 17:06:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] net: avoid to use variable length array in
 net_client_init()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503170631.itIk5tUGPrhr2ejRK8z6PUUOkvktoK7IC3k5l68Bqcw@z>

net_client_init() uses a variable length array to store the prefix
of 'ipv6-net' parameter (e.g. if ipv6-net=3Dfec0::0/64, the prefix
is 'fec0::0').
Since the IPv6 prefix can be at most as long as an IPv6 address,
we can use an array with fixed size equals to INET6_ADDRSTRLEN.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index f3a3c5444c..2e5f27e121 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1118,7 +1118,7 @@ static int net_client_init(QemuOpts *opts, bool is_=
netdev, Error **errp)
         const char *ip6_net =3D qemu_opt_get(opts, "ipv6-net");
=20
         if (ip6_net) {
-            char buf[strlen(ip6_net) + 1];
+            char buf[INET6_ADDRSTRLEN];
=20
             if (get_str_sep(buf, sizeof(buf), &ip6_net, '/') < 0) {
                 /* Default 64bit prefix length.  */
--=20
2.20.1


