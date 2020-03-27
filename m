Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FFBC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA7B20658
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6VBbEvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA7B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrjZ-0006qi-S6
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHrhz-0005cn-L0
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHrhy-0004fQ-8R
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43949)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHrhx-0004bk-OD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585325980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aY34CquGdNoyZJ52ByWHlFyaeb4NffcZT0uK6VrsRVs=;
 b=D6VBbEvrQ1Z6cdZKzNb6lPb7ZnDCmsI2uu2uwpfyhyqmkwk7HHYVZnh4WndkSWQxASTEST
 5+kmsMcFQrEKU4BbFhuXNSh5xWM8DeF0PmmDMiPSwxpGcKD7y17AnrF5mOEA46g5U9Zaot
 zcGRG5fyvReh+zPvXo/ZEfTLcrPgL5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-5-rZPgsmO2uORSxXwHoYFw-1; Fri, 27 Mar 2020 12:19:38 -0400
X-MC-Unique: 5-rZPgsmO2uORSxXwHoYFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ED0D801E66;
 Fri, 27 Mar 2020 16:19:38 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C6185C1D8;
 Fri, 27 Mar 2020 16:19:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] nbd: Try for cleaner TLS shutdown
Date: Fri, 27 Mar 2020 11:19:33 -0500
Message-Id: <20200327161936.2225989-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: berrange@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm currently trying to debug a hang in 'nbdkit nbd' as a client when
TLS is in use, when dealing with three processes:
nbdkit example1[1] <=3Dtls=3D> nbdkit nbd[2] <=3Dplain=3D> qemu-nbd --list[=
3]

In theory, when process [3] exits, the server side of process [2] is
supposed to disconnect as client from process [1].  But we were
hitting sporadic hangs where process [2] was stuck in a poll() while
in gnutls cleanup code, which appears to be because it did not
recognize a clean shutdown from process [3].

I do not yet have a strong reproducible test case (which might include
adding strategic sleep()s in one-off compilations) to prove that the
problem is an unclean TLS shutdown, but at the same time, the gnutls
documentation is clear that without proper use of gnutls_bye(), a
client cannot distinguish between clean end of communications and a
malicious interruption in service.  Shutting down the write side of a
bi-directional socket as soon as possible makes it easier for a client
to begin its own shutdown actions, and can help in avoiding deadlocks
where both sides of a connection are waiting for the other side to
close() the socket first.  If I can come up with a reliable test case,
this series may be a candidate for 5.0; but for now, I'm only
proposing it for 5.1 (we've had more than one release where qemu was
not exploiting the full power of gnutls_bye(), and even if that
triggers poor interaction with other endpoints such as nbdkit, going
one more release with the same behavior isn't making things worse).

Eric Blake (3):
  crypto: Add qcrypto_tls_shutdown()
  io: Support shutdown of TLS channel
  nbd: Use shutdown(SHUT_WR) after last item sent

 qapi/crypto.json            | 15 +++++++++++++++
 include/crypto/tlssession.h | 24 ++++++++++++++++++++++++
 block/nbd.c                 |  1 +
 crypto/tlssession.c         | 27 +++++++++++++++++++++++++++
 io/channel-tls.c            | 27 ++++++++++++++++++++++++++-
 nbd/client.c                |  3 ++-
 nbd/server.c                |  4 ++++
 7 files changed, 99 insertions(+), 2 deletions(-)

--=20
2.26.0.rc2


