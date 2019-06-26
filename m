Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DCCC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 02:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EECC20645
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 02:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EECC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfy1L-0001or-FV
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 22:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hfy0Y-0001Ab-1m
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hfy0X-00041Z-5S
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:50:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hfy0V-0003yr-4g; Tue, 25 Jun 2019 22:49:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD85E2F8BC1;
 Wed, 26 Jun 2019 02:49:55 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-44.phx2.redhat.com [10.3.116.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51DDF60BE5;
 Wed, 26 Jun 2019 02:49:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 21:49:42 -0500
Message-Id: <20190626024942.29758-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 26 Jun 2019 02:49:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qemu-nbd: Permit TLS with Unix sockets
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
Cc: berrange@redhat.com, rjones@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although you generally won't use encryption with a Unix socket (after
all, everything is local, so why waste the CPU power), there are
situations in testsuites where Unix sockets are much nicer than TCP
sockets.  Since nbdkit allows encryption over both types of sockets,
it makes sense for qemu-nbd to do likewise.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index a8cb39e51043..ddfb6815fb69 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -931,10 +931,6 @@ int main(int argc, char **argv)
     }

     if (tlscredsid) {
-        if (sockpath) {
-            error_report("TLS is only supported with IPv4/IPv6");
-            exit(EXIT_FAILURE);
-        }
         if (device) {
             error_report("TLS is not supported with a host device");
             exit(EXIT_FAILURE);
--=20
2.20.1


