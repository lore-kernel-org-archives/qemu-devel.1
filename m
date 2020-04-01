Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1719CC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 22:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46462078C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 22:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwxhSjQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46462078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJm1L-0005R0-0Q
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 18:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJm0Y-0004xJ-NM
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 18:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJm0X-0003JP-1y
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 18:38:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43679
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJm0W-0003FH-PP
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 18:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585780727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivXSQ2v603SCtpJYufokL2AaDhtumDHyG4RmHK1dWbY=;
 b=WwxhSjQGMKZo3PQFds02J2cotAjHW6QOPXNisWkjilxo+EjgkumefLwvXnm7Z4vIfgzNjq
 8qKpVJo93Wo3kbMwCVnTvhLmqf/5YZnxlDHqup6t77HI54g45aZozVA5qyDL59V4gfSH7a
 aEIedhwLM1Gp1gZEbMR2j9INRh1CBZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-jx6gRMwdNJagV3Hivrcesw-1; Wed, 01 Apr 2020 18:38:45 -0400
X-MC-Unique: jx6gRMwdNJagV3Hivrcesw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 456AA800D4E;
 Wed,  1 Apr 2020 22:38:44 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97DF089F0A;
 Wed,  1 Apr 2020 22:38:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0?] nbd: Attempt reconnect after server error of
 ESHUTDOWN
Date: Wed,  1 Apr 2020 17:38:41 -0500
Message-Id: <20200401223841.312793-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, rjones@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I was trying to test qemu's reconnect-delay parameter by using nbdkit
as a server that I could easily make disappear and resume.  A bit of
experimenting shows that when nbdkit is abruptly killed (SIGKILL),
qemu detects EOF on the socket and manages to reconnect just fine; but
when nbdkit is gracefully killed (SIGTERM), it merely fails all
further guest requests with NBD_ESHUTDOWN until the client disconnects
first, and qemu was blindly failing the I/O request with ESHUTDOWN
from the server instead of attempting to reconnect.

While most NBD server failures are unlikely to change by merely
retrying the same transaction, our decision to not start a retry loop
in the common case is correct.  But NBD_ESHUTDOWN is rare enough, and
really is indicative of a transient situation, that it is worth
special-casing.

Here's the test setup I used: in one terminal, kick off a sequence of
nbdkit commands that has a temporary window where the server is
offline; in another terminal (and within the first 5 seconds) kick off
a qemu-img convert with reconnect enabled.  If the qemu-img process
completes successfully, the reconnect worked.

$ #term1
$ MYSIG=3D    # or MYSIG=3D'-s KILL'
$ timeout $MYSIG 5s ~/nbdkit/nbdkit -fv --filter=3Ddelay --filter=3Dnoexten=
ts \
  null 200M delay-read=3D1s; sleep 5; ~/nbdkit/nbdkit -fv --filter=3Dexitla=
st \
  --filter=3Ddelay --filter=3Dnoextents null 200M delay-read=3D1s

$ #term2
$ MYCONN=3Dserver.type=3Dinet,server.host=3Dlocalhost,server.port=3D10809
$ qemu-img convert -p -O raw --image-opts \
  driver=3Dnbd,$MYCONN,,reconnect-delay=3D60 out.img

See also: https://bugzilla.redhat.com/show_bug.cgi?id=3D1819240#c8

Signed-off-by: Eric Blake <eblake@redhat.com>
---

This is not a regression, per se, as reconnect-delay has been unchanged
since 4.2; but I'd like to consider this as an interoperability bugfix
worth including in the next rc.

 block/nbd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 2906484390f9..576b95fb8753 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -863,6 +863,15 @@ static coroutine_fn int nbd_co_receive_one_chunk(
     if (ret < 0) {
         memset(reply, 0, sizeof(*reply));
         nbd_channel_error(s, ret);
+    } else if (s->reconnect_delay && *request_ret =3D=3D -ESHUTDOWN) {
+        /*
+         * Special case: if we support reconnect and server is warning
+         * us that it wants to shut down, then treat this like an
+         * abrupt connection loss.
+         */
+        memset(reply, 0, sizeof(*reply));
+        *request_ret =3D 0;
+        nbd_channel_error(s, -EIO);
     } else {
         /* For assert at loop start in nbd_connection_entry */
         *reply =3D s->reply;
--=20
2.26.0.rc2


