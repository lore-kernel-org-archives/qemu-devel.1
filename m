Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B210C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 18:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3392220675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 18:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3392220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO53G-00053O-CB
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 14:42:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO4xA-0008Sy-TX
	for qemu-devel@nongnu.org; Tue, 07 May 2019 14:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO4x9-0002ff-1N
	for qemu-devel@nongnu.org; Tue, 07 May 2019 14:36:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO4ww-0002Nx-Cf; Tue, 07 May 2019 14:36:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1594130992A3;
	Tue,  7 May 2019 18:36:20 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D67517178;
	Tue,  7 May 2019 18:36:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 20:36:08 +0200
Message-Id: <20190507183610.9848-4-mreitz@redhat.com>
In-Reply-To: <20190507183610.9848-1-mreitz@redhat.com>
References: <20190507183610.9848-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 07 May 2019 18:36:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/5] qemu-nbd: Do not close stderr
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
---
As I hinted at in the cover letter, I am not sure whether this is truly
a bug or whether the current behavior is intentional.  So if you
disagree with me on this patch, you are welcome to suggest an
alternative.

I personally can see two:
(1) Add a --log option for a file to store the server's messages in.
    Seems a bit cumbersome to me.

(2) Add a --keep-stderr option, which specifically enables this behavior
    here.  Without this option we keep the old behavior.
---
 qemu-nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 7e48154f44..3805324153 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1015,10 +1015,11 @@ int main(int argc, char **argv)
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
2.20.1


