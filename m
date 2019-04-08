Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BD2C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A812087F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A812087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZZr-0002xR-2l
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:05:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZXh-0001k9-Vd
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZXe-0007HM-DU
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hDZXT-0007Ba-Mh; Mon, 08 Apr 2019 15:02:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4461D81DFB;
	Mon,  8 Apr 2019 19:02:36 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0A6460C70;
	Mon,  8 Apr 2019 19:02:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 14:02:30 -0500
Message-Id: <20190408190233.10321-2-eblake@redhat.com>
In-Reply-To: <20190408190233.10321-1-eblake@redhat.com>
References: <20190408190233.10321-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 08 Apr 2019 19:02:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/4] nbd/server: Fix blockstatus trace
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408190230.1IcK1Oy3DQ0jwYpMmIrccEzVE5mMWQ8jPfjl_Y4RO8Q@z>

Don't increment remaining_bytes until we know that we will actually be
including the current block status extent in the reply; otherwise, the
value traced will include a bytes value that is oversized by the
length of the next block status extent which did not get sent because
it instead ended the loop.

Fixes: fb7afc79
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190403030526.12258-2-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 218a2aa5e65..1b8c8619896 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1880,17 +1880,12 @@ static int blockstatus_to_extents(BlockDriverStat=
e *bs, uint64_t offset,

         flags =3D (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
                 (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);
-        offset +=3D num;
-        remaining_bytes -=3D num;

         if (first_extent) {
             extent->flags =3D flags;
             extent->length =3D num;
             first_extent =3D false;
-            continue;
-        }
-
-        if (flags =3D=3D extent->flags) {
+        } else if (flags =3D=3D extent->flags) {
             /* extend current extent */
             extent->length +=3D num;
         } else {
@@ -1903,6 +1898,8 @@ static int blockstatus_to_extents(BlockDriverState =
*bs, uint64_t offset,
             extent->flags =3D flags;
             extent->length =3D num;
         }
+        offset +=3D num;
+        remaining_bytes -=3D num;
     }

     extents_end =3D extent + 1;
--=20
2.20.1


