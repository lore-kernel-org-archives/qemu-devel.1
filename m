Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17B8C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 18:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCA420675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 18:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCA420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51331 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO50U-0002gO-Mr
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 14:40:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO4wt-0007Su-Bx
	for qemu-devel@nongnu.org; Tue, 07 May 2019 14:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO4ws-0002Ko-A6
	for qemu-devel@nongnu.org; Tue, 07 May 2019 14:36:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO4wp-0002EU-Tr; Tue, 07 May 2019 14:36:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 414DEC058CA8;
	Tue,  7 May 2019 18:36:15 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CE25861781;
	Tue,  7 May 2019 18:36:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 20:36:06 +0200
Message-Id: <20190507183610.9848-2-mreitz@redhat.com>
In-Reply-To: <20190507183610.9848-1-mreitz@redhat.com>
References: <20190507183610.9848-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 07 May 2019 18:36:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/5] qemu-nbd: Add --pid-file option
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

--fork is a bit boring if there is no way to get the child's PID.  This
option helps.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-nbd.c    | 29 +++++++++++++++++++++++++++++
 qemu-nbd.texi |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index dca9e72cee..7e48154f44 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -59,6 +59,7 @@
 #define QEMU_NBD_OPT_IMAGE_OPTS    262
 #define QEMU_NBD_OPT_FORK          263
 #define QEMU_NBD_OPT_TLSAUTHZ      264
+#define QEMU_NBD_OPT_PID_FILE      265
=20
 #define MBR_SIZE 512
=20
@@ -111,6 +112,7 @@ static void usage(const char *name)
 "                            specify tracing options\n"
 "  --fork                    fork off the server process and exit the pa=
rent\n"
 "                            once the server is running\n"
+"  --pid-file=3DPATH           store the server's process ID in the give=
n file\n"
 #if HAVE_NBD_DEVICE
 "\n"
 "Kernel NBD client support:\n"
@@ -651,6 +653,7 @@ int main(int argc, char **argv)
         { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
         { "trace", required_argument, NULL, 'T' },
         { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
+        { "pid-file", required_argument, NULL, QEMU_NBD_OPT_PID_FILE },
         { NULL, 0, NULL, 0 }
     };
     int ch;
@@ -677,6 +680,8 @@ int main(int argc, char **argv)
     bool list =3D false;
     int old_stderr =3D -1;
     unsigned socket_activation;
+    const char *pid_path =3D NULL;
+    FILE *pid_file;
=20
     /* The client thread uses SIGTERM to interrupt the server.  A signal
      * handler ensures that "qemu-nbd -v -c" exits with a nice status co=
de.
@@ -876,6 +881,9 @@ int main(int argc, char **argv)
         case 'L':
             list =3D true;
             break;
+        case QEMU_NBD_OPT_PID_FILE:
+            pid_path =3D optarg;
+            break;
         }
     }
=20
@@ -1196,6 +1204,27 @@ int main(int argc, char **argv)
=20
     nbd_update_server_watch();
=20
+    if (pid_path) {
+        pid_file =3D fopen(pid_path, "w");
+        if (!pid_file) {
+            error_report("Failed to store PID in %s: %s",
+                         pid_path, strerror(errno));
+            exit(EXIT_FAILURE);
+        }
+
+        ret =3D fprintf(pid_file, "%ld", (long)getpid());
+        if (ret < 0) {
+            ret =3D -errno;
+        }
+        fclose(pid_file);
+
+        if (ret < 0) {
+            error_report("Failed to store PID in %s: %s",
+                         pid_path, strerror(-ret));
+            exit(EXIT_FAILURE);
+        }
+    }
+
     /* now when the initialization is (almost) complete, chdir("/")
      * to free any busy filesystems */
     if (chdir("/") < 0) {
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index de342c76b8..7f55657722 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -117,6 +117,8 @@ option; or provide the credentials needed for connect=
ing as a client
 in list mode.
 @item --fork
 Fork off the server process and exit the parent once the server is runni=
ng.
+@item --pid-file=3DPATH
+Store the server's process ID in the given file.
 @item --tls-authz=3DID
 Specify the ID of a qauthz object previously created with the
 --object option. This will be used to authorize connecting users
--=20
2.20.1


