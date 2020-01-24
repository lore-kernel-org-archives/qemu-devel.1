Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E10C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D842620709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGOEBdJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D842620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1rQ-00030X-1N
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1mt-0002v4-BS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1mr-00030L-6e
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:27 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:36797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iv1mr-0002yW-0Q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:25 -0500
Received: by mail-wm1-x32c.google.com with SMTP id p17so56871wma.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WH7rcf6kZQLCAooNxGLvCLPcLVX0txly3whV92JnSP8=;
 b=LGOEBdJM7Rk14FIofHyr7x63E/QUjR2KRU8xttAafAzQzs1U+OVFLhgerBBVFtwtYQ
 itWJAorKvX9vi58vCbNGAPUdbGTid+7DDpu/DMSd9CyGbO29O5pqA2sZa349U9Y9CiVo
 gJRpLXdgy7WVIFgMSjy258HhhITvxVsQo5jLFfSJigrJ6hwlA+DHMYQlXSIsdv1+T8S2
 80BmdcjyH8cvXNFKMSbVlPaQRrSYYnyDYcNzQBVg3Nucdu76LF+iCjKO0x2aMeNtoeRF
 7rvEvxsuLaVKg/vaG9dD033oZVD4Zudi8JMEJRLm8nUsH7KS16fVk1+Wqkz5+V4cZ5b/
 1DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WH7rcf6kZQLCAooNxGLvCLPcLVX0txly3whV92JnSP8=;
 b=BYHrtGzmPNV/nRGRx9ItcTBdCg/xW4SQdVERiYFBJCtxSIbqh07Wob2A4L9zXnV5FM
 9i58LnsmfRlnKEEwvolU18eHci9HLQqHdZchD2Vmrsvg1CFQtTtCfK37e1P3b91BS0+V
 U3RgLhtwrtHf+eX2t3wC+XbjlU/5JWjdIVcb/u4/pkcFLYl2Be9zjIfNZf0rQ6vRqyuQ
 CFJO3BzOEmATsC2eY0zcI63EJoDQ1LE72ZDpy7F4pfjXwSKIW78vhMRAVrLNBxG3qlbb
 MHl8odUwOtu96/HG7837Hfij46C1SIQkFxDfqurNyMlks/zpWAA+dwGvG9uA0uX0Rz4+
 8WEw==
X-Gm-Message-State: APjAAAV0J9CFFcOD8yRQpEU51RKP2afgGizUtPF/YuepmDhVb1eMRGNk
 o/NY5Tn5OCKd7lB500PvzoxLnKuJ8YmVUA==
X-Google-Smtp-Source: APXvYqyim0M6sA9Fz99ZYjLifRDzYWIonc0AYnkR+Jtzfhy2n1QrQBgKavfqudFEW+8hShNFVSx5kg==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr26112wml.71.1579883182197;
 Fri, 24 Jan 2020 08:26:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q3sm7054998wmj.38.2020.01.24.08.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:26:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 8/8] virtfs-proxy-helper: Convert documentation to rST
Date: Fri, 24 Jan 2020 16:26:06 +0000
Message-Id: <20200124162606.8787-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124162606.8787-1-peter.maydell@linaro.org>
References: <20200124162606.8787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtfs-proxy-helper documentation is currently in
fsdev/qemu-trace-stap.texi in Texinfo format, which we
present to the user as:
 * a virtfs-proxy-helper manpage
 * but not (unusually for QEMU) part of the HTML docs

Convert the documentation to rST format that lives in
the docs/ subdirectory, and present it to the user as:
 * a virtfs-proxy-helper manpage
 * part of the interop/ Sphinx manual

There are minor formatting changes to suit Sphinx, but no
content changes. In particular I've split the -u and -g
options into each having their own description text.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                             |  7 ++-
 MAINTAINERS                          |  1 +
 docs/interop/conf.py                 |  5 +-
 docs/interop/index.rst               |  1 +
 docs/interop/virtfs-proxy-helper.rst | 72 ++++++++++++++++++++++++++++
 fsdev/virtfs-proxy-helper.texi       | 63 ------------------------
 6 files changed, 81 insertions(+), 68 deletions(-)
 create mode 100644 docs/interop/virtfs-proxy-helper.rst
 delete mode 100644 fsdev/virtfs-proxy-helper.texi

diff --git a/Makefile b/Makefile
index 5dded94bf63..e08882fd49f 100644
--- a/Makefile
+++ b/Makefile
@@ -354,7 +354,7 @@ DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qe
 DOCS+=docs/qemu-cpu-models.7
 DOCS+=$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
-DOCS+=fsdev/virtfs-proxy-helper.1
+DOCS+=$(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1
 endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1
@@ -859,7 +859,7 @@ endif
 endif
 ifdef CONFIG_VIRTFS
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
 endif
 
 install-datadir:
@@ -1051,7 +1051,7 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 	$(call build-manual,system,html)
 
 $(call define-manpage-rule,interop,\
-       qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1,\
+       qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1 virtfs-proxy-helper.1,\
        $(SRC_PATH/qemu-img-cmds.hx))
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
@@ -1078,7 +1078,6 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
-fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
 
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
diff --git a/MAINTAINERS b/MAINTAINERS
index 54c4429069d..83fb32b8601 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1573,6 +1573,7 @@ S: Odd Fixes
 F: hw/9pfs/
 X: hw/9pfs/xen-9p*
 F: fsdev/
+F: docs/interop/virtfs-proxy-helper.rst
 F: tests/qtest/virtio-9p-test.c
 T: git https://github.com/gkurz/qemu.git 9p-next
 
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index baea7fb50ee..b0f322207ca 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -24,5 +24,8 @@ man_pages = [
     ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
      ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
     ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool',
-     [], 1)
+     [], 1),
+    ('virtfs-proxy-helper', 'virtfs-proxy-helper',
+     u'QEMU 9p virtfs proxy filesystem helper',
+     ['M. Mohan Kumar'], 1)
 ]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index d756a826b26..3b763b1eebe 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -23,3 +23,4 @@ Contents:
    qemu-trace-stap
    vhost-user
    vhost-user-gpu
+   virtfs-proxy-helper
diff --git a/docs/interop/virtfs-proxy-helper.rst b/docs/interop/virtfs-proxy-helper.rst
new file mode 100644
index 00000000000..6cdeedf8e93
--- /dev/null
+++ b/docs/interop/virtfs-proxy-helper.rst
@@ -0,0 +1,72 @@
+QEMU 9p virtfs proxy filesystem helper
+======================================
+
+Synopsis
+--------
+
+**virtfs-proxy-helper** [*OPTIONS*]
+
+Description
+-----------
+
+Pass-through security model in QEMU 9p server needs root privilege to do
+few file operations (like chown, chmod to any mode/uid:gid).  There are two
+issues in pass-through security model:
+
+- TOCTTOU vulnerability: Following symbolic links in the server could
+  provide access to files beyond 9p export path.
+
+- Running QEMU with root privilege could be a security issue.
+
+To overcome above issues, following approach is used: A new filesystem
+type 'proxy' is introduced. Proxy FS uses chroot + socket combination
+for securing the vulnerability known with following symbolic links.
+Intention of adding a new filesystem type is to allow qemu to run
+in non-root mode, but doing privileged operations using socket IO.
+
+Proxy helper (a stand alone binary part of qemu) is invoked with
+root privileges. Proxy helper chroots into 9p export path and creates
+a socket pair or a named socket based on the command line parameter.
+QEMU and proxy helper communicate using this socket. QEMU proxy fs
+driver sends filesystem request to proxy helper and receives the
+response from it.
+
+The proxy helper is designed so that it can drop root privileges except
+for the capabilities needed for doing filesystem operations.
+
+Options
+-------
+
+The following options are supported:
+
+.. program:: virtfs-proxy-helper
+
+.. option:: -h
+
+  Display help and exit
+
+.. option:: -p, --path PATH
+
+  Path to export for proxy filesystem driver
+
+.. option:: -f, --fd SOCKET_ID
+
+  Use given file descriptor as socket descriptor for communicating with
+  qemu proxy fs drier. Usually a helper like libvirt will create
+  socketpair and pass one of the fds as parameter to this option.
+
+.. option:: -s, --socket SOCKET_FILE
+
+  Creates named socket file for communicating with qemu proxy fs driver
+
+.. option:: -u, --uid UID
+
+  uid to give access to named socket file; used in combination with -g.
+
+.. option:: -g, --gid GID
+
+  gid to give access to named socket file; used in combination with -u.
+
+.. option:: -n, --nodaemon
+
+  Run as a normal program. By default program will run in daemon mode
diff --git a/fsdev/virtfs-proxy-helper.texi b/fsdev/virtfs-proxy-helper.texi
deleted file mode 100644
index f4cbb60623b..00000000000
--- a/fsdev/virtfs-proxy-helper.texi
+++ /dev/null
@@ -1,63 +0,0 @@
-@example
-@c man begin SYNOPSIS
-@command{virtfs-proxy-helper} @var{options}
-@c man end
-@end example
-
-@c man begin DESCRIPTION
-@table @description
-Pass-through security model in QEMU 9p server needs root privilege to do
-few file operations (like chown, chmod to any mode/uid:gid).  There are two
-issues in pass-through security model
-
-1) TOCTTOU vulnerability: Following symbolic links in the server could
-provide access to files beyond 9p export path.
-
-2) Running QEMU with root privilege could be a security issue.
-
-To overcome above issues, following approach is used: A new filesystem
-type 'proxy' is introduced. Proxy FS uses chroot + socket combination
-for securing the vulnerability known with following symbolic links.
-Intention of adding a new filesystem type is to allow qemu to run
-in non-root mode, but doing privileged operations using socket IO.
-
-Proxy helper(a stand alone binary part of qemu) is invoked with
-root privileges. Proxy helper chroots into 9p export path and creates
-a socket pair or a named socket based on the command line parameter.
-QEMU and proxy helper communicate using this socket. QEMU proxy fs
-driver sends filesystem request to proxy helper and receives the
-response from it.
-
-The proxy helper is designed so that it can drop root privileges except
-for the capabilities needed for doing filesystem operations.
-
-@end table
-@c man end
-
-@c man begin OPTIONS
-The following options are supported:
-@table @option
-@item -h
-@findex -h
-Display help and exit
-@item -p|--path path
-Path to export for proxy filesystem driver
-@item -f|--fd socket-id
-Use given file descriptor as socket descriptor for communicating with
-qemu proxy fs drier. Usually a helper like libvirt will create
-socketpair and pass one of the fds as parameter to -f|--fd
-@item -s|--socket socket-file
-Creates named socket file for communicating with qemu proxy fs driver
-@item -u|--uid uid -g|--gid gid
-uid:gid combination to give access to named socket file
-@item -n|--nodaemon
-Run as a normal program. By default program will run in daemon mode
-@end table
-@c man end
-
-@setfilename virtfs-proxy-helper
-@settitle QEMU 9p virtfs proxy filesystem helper
-
-@c man begin AUTHOR
-M. Mohan Kumar
-@c man end
-- 
2.20.1


