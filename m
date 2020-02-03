Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCDAC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C7620721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIuIsK6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C7620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZhu-0001ge-Ee
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfe-0005YI-NF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfc-0000qs-Ii
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:38 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZfc-0000qS-BH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:36 -0500
Received: by mail-wr1-x42e.google.com with SMTP id y17so17491107wrh.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FN6IYNmjTWTwD9RZgEK9RNt2Qj2Z8oostqa0BMBlrpo=;
 b=SIuIsK6zrzjx3vqb6Ui7Lm+IJ3kS/eRuEGWleM5h3Yt0kVeNcwg+JUHpd/1fxOb7rt
 pUD2cw0TJJOkPL50JRxBjSH9rGcaAGMA/QuqzWrsN1RV4A5SfOwWAglMSwdF4LNzfD98
 43KD3/e878182wnia5lLbu2uDQz9c5mGOVqdeCLuyzCTwJ4uC+dWI2CfrVasID+RxcI9
 GvSDEnOc+8PF/cES9kwsnDC6aHDXjGST8vtDS/qVRyjghUe0MJXsTnOr5iTUbikJGzX8
 i10Urd/9IF2n+w6ebOb1DFvIbLUpPBkMse59Q3H1NXqTsZyXK40hEEuG9IAPXWMn3/k6
 rzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FN6IYNmjTWTwD9RZgEK9RNt2Qj2Z8oostqa0BMBlrpo=;
 b=bnYHGcZ4MoV54tgKWFPlHlhlMKoNkqbg3oJ0UOe4BLHmPKfY/LSh+HIeG1L0fhAbTy
 7fiF9kus8awTbEvZqOBAQVJrO2umpczKbSMNITOXRX8PwtREcd9Au2tSeUtgxLyf++IC
 mZ99Hn4QljVRqQc8XywNClCl+WQ78xPy7Cl+ogUKpen4DENvnvPBMHqT78MoNKotlYjw
 e3j7hgvPZUdmmQbRqnH2Z6J2msgp3rMIVUQi6ypKhetZ/o+v5zEDASFXKRhhF8yEo21T
 WcpgFT6t+6OOFbfbIXRNwczD2V9V75w09TYnJlaXualdvvargZipV2qB+cbzfTwRm/OQ
 XE8A==
X-Gm-Message-State: APjAAAWt/nyA8T+NFjRukKGUJ9L6Gbv2xNa7+pvremwSkJrx+6ARLiKR
 k23IBkjCsQZrVVRFuG8NvOWoCcS1JWA8Tw==
X-Google-Smtp-Source: APXvYqxY+J/AvJ0bUTaZG6j1ryF52ruSo2Fk1L7gbHWi7r8D5xjgB28T5UT5LaKujOCEPf8Z3HmX/A==
X-Received: by 2002:adf:b648:: with SMTP id i8mr14801623wre.91.1580728414829; 
 Mon, 03 Feb 2020 03:13:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm24028917wme.35.2020.02.03.03.13.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 03:13:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] virtfs-proxy-helper: Convert documentation to rST
Date: Mon,  3 Feb 2020 11:13:18 +0000
Message-Id: <20200203111318.23378-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203111318.23378-1-peter.maydell@linaro.org>
References: <20200203111318.23378-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Acked-by: Greg Kurz <groug@kaod.org>
Message-id: 20200124162606.8787-9-peter.maydell@linaro.org
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
index 1e0440c3738..a6f5d440828 100644
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
index db3cbc18c92..1f0bc72f218 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1574,6 +1574,7 @@ S: Odd Fixes
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


