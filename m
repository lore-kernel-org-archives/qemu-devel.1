Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1888C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 21:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833C2216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 21:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833C2216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43917 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOTzZ-00066m-Ll
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 17:20:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOTxb-0004mV-CQ
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOTxT-0005p9-DP
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:18:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOTxO-0005nQ-M4; Wed, 08 May 2019 17:18:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04C5B308620F;
	Wed,  8 May 2019 21:18:30 +0000 (UTC)
Received: from localhost (ovpn-204-96.brq.redhat.com [10.40.204.96])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 93CD7107A432;
	Wed,  8 May 2019 21:18:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  8 May 2019 23:18:18 +0200
Message-Id: <20190508211820.17851-4-mreitz@redhat.com>
In-Reply-To: <20190508211820.17851-1-mreitz@redhat.com>
References: <20190508211820.17851-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 08 May 2019 21:18:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/5] qemu-nbd: Do not close stderr
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We kept old_stderr specifically so we could keep emitting error message
on stderr.  However, qemu_daemon() closes stderr.  Therefore, we need to
dup() stderr to old_stderr before invoking qemu_daemon().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index edb5195208..e4446d479c 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1014,10 +1014,11 @@ int main(int argc, char **argv)
             exit(EXIT_FAILURE);
         } else if (pid =3D=3D 0) {
             close(stderr_fd[0]);
+
+            old_stderr =3D dup(STDERR_FILENO);
             ret =3D qemu_daemon(1, 0);
=20
             /* Temporarily redirect stderr to the parent's pipe...  */
-            old_stderr =3D dup(STDERR_FILENO);
             dup2(stderr_fd[1], STDERR_FILENO);
             if (ret < 0) {
                 error_report("Failed to daemonize: %s", strerror(errno))=
;
--=20
2.21.0


