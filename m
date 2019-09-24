Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D27C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCD72168B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCD72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCl2c-0000ah-61
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCk6X-00065c-DJ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCk6V-0001vs-Ul
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:39:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iCk6T-0001sJ-3I; Tue, 24 Sep 2019 08:39:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6DB9F10DCC9F;
 Tue, 24 Sep 2019 12:39:36 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D99EF60C5D;
 Tue, 24 Sep 2019 12:39:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] nbd/client: Add hint when TLS is missing
Date: Tue, 24 Sep 2019 07:39:30 -0500
Message-Id: <20190924123933.10607-2-eblake@redhat.com>
In-Reply-To: <20190924123933.10607-1-eblake@redhat.com>
References: <20190924123933.10607-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 24 Sep 2019 12:39:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Tingting Mao <timao@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I received an off-list report of failure to connect to an NBD server
expecting an x509 certificate, when the client was attempting something
similar to this command line:

$ ./x86_64-softmmu/qemu-system-x86_64 -name 'blah' -machine q35 -nodefaul=
ts \
  -object tls-creds-x509,id=3Dtls0,endpoint=3Dclient,dir=3D$path_to_certs=
 \
  -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0,bus=3Dpcie.0,addr=3D0x6 \
  -drive id=3Ddrive_image1,if=3Dnone,snapshot=3Doff,aio=3Dthreads,cache=3D=
none,format=3Draw,file=3Dnbd:localhost:9000,werror=3Dstop,rerror=3Dstop,t=
ls-creds=3Dtls0 \
  -device scsi-hd,id=3Dimage1,drive=3Ddrive_image1,bootindex=3D0
qemu-system-x86_64: -drive id=3Ddrive_image1,if=3Dnone,snapshot=3Doff,aio=
=3Dthreads,cache=3Dnone,format=3Draw,file=3Dnbd:localhost:9000,werror=3Ds=
top,rerror=3Dstop,tls-creds=3Dtls0: TLS negotiation required before optio=
n 7 (go)
server reported: Option 0x7 not permitted before TLS

The problem?  As specified, -drive is trying to pass tls-creds to the
raw format driver instead of the nbd protocol driver, but before we
get to the point where we can detect that raw doesn't know what to do
with tls-creds, the nbd driver has already failed because the server
complained.  The fix to the broken command line?  Pass
'...,file.tls-creds=3Dtls0' to ensure the tls-creds option is handed to
nbd, not raw.  But since the error message was rather cryptic, I'm
trying to improve the error message.

With this patch, the error message adds a line:

qemu-system-x86_64: -drive id=3Ddrive_image1,if=3Dnone,snapshot=3Doff,aio=
=3Dthreads,cache=3Dnone,format=3Draw,file=3Dnbd:localhost:9000,werror=3Ds=
top,rerror=3Dstop,tls-creds=3Dtls0: TLS negotiation required before optio=
n 7 (go)
Did you forget a valid tls-creds?
server reported: Option 0x7 not permitted before TLS

And with luck, someone grepping for that error message will find this
commit message and figure out their command line mistake.  Sadly, the
only mention of file.tls-creds in our docs relates to an --image-opts
use of PSK encryption with qemu-img as the client, rather than x509
certificate encryption with qemu-kvm as the client.

CC: Tingting Mao <timao@redhat.com>
CC: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190907172055.26870-1-eblake@redhat.com>
[eblake: squash in iotest 233 fix]
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 nbd/client.c               | 1 +
 tests/qemu-iotests/233.out | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/nbd/client.c b/nbd/client.c
index b9dc829175f9..f6733962b49b 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -204,6 +204,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDO=
ptionReply *reply,
     case NBD_REP_ERR_TLS_REQD:
         error_setg(errp, "TLS negotiation required before option %" PRIu=
32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option)=
);
+        error_append_hint(errp, "Did you forget a valid tls-creds?\n");
         break;

     case NBD_REP_ERR_UNKNOWN:
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 24321efa113b..c3c344811b2b 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -21,8 +21,10 @@ server reported: TLS not configured

 =3D=3D check plain client to TLS server fails =3D=3D
 qemu-img: Could not open 'nbd://localhost:PORT': TLS negotiation require=
d before option 7 (go)
+Did you forget a valid tls-creds?
 server reported: Option 0x7 not permitted before TLS
 qemu-nbd: TLS negotiation required before option 3 (list)
+Did you forget a valid tls-creds?
 server reported: Option 0x3 not permitted before TLS

 =3D=3D check TLS works =3D=3D
--=20
2.21.0


