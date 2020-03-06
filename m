Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B995C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31722073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDA8WhRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31722073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAB0m-0003Sa-Uw
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsV-0004T9-Fu
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsS-00062L-Jm
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:51 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAsS-0005zH-AA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id v11so1843284wrm.9
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HQPjwGD/rtQs3BxT1135VkopftouBJM9lz4I1Yz3SRo=;
 b=NDA8WhRBN8/OyIFO37z2or3Lf8zMCO6hyqHGewWmg2lQgZk/ewjMFvy6KbP/4lv1V6
 GA/zrgaszxFFscLITyk76JrwGAmrxOX8cNmhnXAQMR8NRvs+xCtoqswVBVv9pPOED44D
 chTQixzfns0QMBA5Jwbg4y1ybAaNT5iJcNx/0qPhJYgpKpqjdr8iuuAIhVxbaaQKOkf2
 Mj7yhy8KS/4hxg3plDrOSExHPu7xMebq9b8G4S6roeZcTxw163MFIrkE4ZO1X9tu5SZZ
 TLec4AvuVGw+mAS0hOyVMmMi0nNtMmsmwwdp1G75+tvGbu57TAdTLnb4jLyzch7AA6Pk
 sRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HQPjwGD/rtQs3BxT1135VkopftouBJM9lz4I1Yz3SRo=;
 b=Yb9Pka/YS+G9bRkTzIosrvBnRW8BlzbxXvlvU8Q7h5CT+ClUcg3DEIAYNRZ+ccdF5B
 VlGfUO7XtNJKvfwB0zXjTZ9hPzcUk/RC6BmWI8Mpr6DtlCbi/CyPtyo9YZBXkQKUnL74
 KSKJggxk7kRLPJOtoBnrVIGUB2AJksadWcGw6RMvo8XhGyXlISTRSD7vLBANJYCcuBsZ
 AMuLMRV/r//rmHyh+lPm8133RvGv3JSi1U7+e1CJChiKIFUx3+hH8P3Ak9shW+72OMd6
 trHNu5KNzWnp7jBqB73bwVhJmlt9cWf5sdne+mRt5TwSudXv5HPXEi9NZI8ZcJ9cGWP1
 7NVg==
X-Gm-Message-State: ANhLgQ37dBa2o7RxCAIonk5XShS/f1bViZOb2ZA/7g0aI6rVYJ3ZzcUQ
 PQ5gh74nRPjK/dybV0RWLlLHvE99pWvAQw==
X-Google-Smtp-Source: ADFU+vv41eASYZJHwsM3ITJIXTRrzHrXKCYF6nDNH+kKCXPnQ0e+R/DPGgzl6G+p2VKGtPdZb600WA==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr3422896wrq.424.1583493046260; 
 Fri, 06 Mar 2020 03:10:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/33] docs: Split out sections for the manpage into .rst.inc
 files
Date: Fri,  6 Mar 2020 11:09:54 +0000
Message-Id: <20200306110959.29461-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

Sphinx doesn't have very good facilities for marking chunks
of documentation as "put this in the manpage only". So instead
we move the parts we want to put into both the HTML manuals
and the manpage into their own .rst.inc files, which we can
include from both the main manual rst files and a new toplevel
rst file that will be the skeleton of the qemu.1 manpage.

In this commit, just split out the parts of the documentation
that go in the manpage.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200228153619.9906-29-peter.maydell@linaro.org
---
 ...vocation.rst => device-url-syntax.rst.inc} |  16 --
 docs/system/invocation.rst                    | 228 +-----------------
 docs/system/keys.rst                          |  36 +--
 docs/system/{keys.rst => keys.rst.inc}        |   5 -
 docs/system/mux-chardev.rst                   |  28 +--
 .../{mux-chardev.rst => mux-chardev.rst.inc}  |   5 -
 ...rget-i386.rst => target-i386-desc.rst.inc} |  22 --
 docs/system/target-i386.rst                   |  63 +----
 8 files changed, 4 insertions(+), 399 deletions(-)
 copy docs/system/{invocation.rst => device-url-syntax.rst.inc} (96%)
 copy docs/system/{keys.rst => keys.rst.inc} (90%)
 copy docs/system/{mux-chardev.rst => mux-chardev.rst.inc} (87%)
 copy docs/system/{target-i386.rst => target-i386-desc.rst.inc} (76%)

diff --git a/docs/system/invocation.rst b/docs/system/device-url-syntax.rst.inc
similarity index 96%
copy from docs/system/invocation.rst
copy to docs/system/device-url-syntax.rst.inc
index d77dd13d4f7..88d7a372a74 100644
--- a/docs/system/invocation.rst
+++ b/docs/system/device-url-syntax.rst.inc
@@ -1,19 +1,3 @@
-.. _sec_005finvocation:
-
-Invocation
-----------
-
-.. parsed-literal::
-
-   |qemu_system| [options] [disk_image]
-
-disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
-not need a disk image.
-
-.. hxtool-doc:: qemu-options.hx
-
-Device URL Syntax
-~~~~~~~~~~~~~~~~~
 
 In addition to using normal file images for the emulated storage
 devices, QEMU can also use networked resources such as iSCSI devices.
diff --git a/docs/system/invocation.rst b/docs/system/invocation.rst
index d77dd13d4f7..4ba38fc23d2 100644
--- a/docs/system/invocation.rst
+++ b/docs/system/invocation.rst
@@ -15,230 +15,4 @@ not need a disk image.
 Device URL Syntax
 ~~~~~~~~~~~~~~~~~
 
-In addition to using normal file images for the emulated storage
-devices, QEMU can also use networked resources such as iSCSI devices.
-These are specified using a special URL syntax.
-
-``iSCSI``
-   iSCSI support allows QEMU to access iSCSI resources directly and use
-   as images for the guest storage. Both disk and cdrom images are
-   supported.
-
-   Syntax for specifying iSCSI LUNs is
-   "iscsi://<target-ip>[:<port>]/<target-iqn>/<lun>"
-
-   By default qemu will use the iSCSI initiator-name
-   'iqn.2008-11.org.linux-kvm[:<name>]' but this can also be set from
-   the command line or a configuration file.
-
-   Since version Qemu 2.4 it is possible to specify a iSCSI request
-   timeout to detect stalled requests and force a reestablishment of the
-   session. The timeout is specified in seconds. The default is 0 which
-   means no timeout. Libiscsi 1.15.0 or greater is required for this
-   feature.
-
-   Example (without authentication):
-
-   .. parsed-literal::
-
-      |qemu_system| -iscsi initiator-name=iqn.2001-04.com.example:my-initiator \
-                       -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \
-                       -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
-
-   Example (CHAP username/password via URL):
-
-   .. parsed-literal::
-
-      |qemu_system| -drive file=iscsi://user%password@192.0.2.1/iqn.2001-04.com.example/1
-
-   Example (CHAP username/password via environment variables):
-
-   .. parsed-literal::
-
-      LIBISCSI_CHAP_USERNAME="user" \
-      LIBISCSI_CHAP_PASSWORD="password" \
-      |qemu_system| -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
-
-``NBD``
-   QEMU supports NBD (Network Block Devices) both using TCP protocol as
-   well as Unix Domain Sockets. With TCP, the default port is 10809.
-
-   Syntax for specifying a NBD device using TCP, in preferred URI form:
-   "nbd://<server-ip>[:<port>]/[<export>]"
-
-   Syntax for specifying a NBD device using Unix Domain Sockets;
-   remember that '?' is a shell glob character and may need quoting:
-   "nbd+unix:///[<export>]?socket=<domain-socket>"
-
-   Older syntax that is also recognized:
-   "nbd:<server-ip>:<port>[:exportname=<export>]"
-
-   Syntax for specifying a NBD device using Unix Domain Sockets
-   "nbd:unix:<domain-socket>[:exportname=<export>]"
-
-   Example for TCP
-
-   .. parsed-literal::
-
-      |qemu_system| --drive file=nbd:192.0.2.1:30000
-
-   Example for Unix Domain Sockets
-
-   .. parsed-literal::
-
-      |qemu_system| --drive file=nbd:unix:/tmp/nbd-socket
-
-``SSH``
-   QEMU supports SSH (Secure Shell) access to remote disks.
-
-   Examples:
-
-   .. parsed-literal::
-
-      |qemu_system| -drive file=ssh://user@host/path/to/disk.img
-      |qemu_system| -drive file.driver=ssh,file.user=user,file.host=host,file.port=22,file.path=/path/to/disk.img
-
-   Currently authentication must be done using ssh-agent. Other
-   authentication methods may be supported in future.
-
-``Sheepdog``
-   Sheepdog is a distributed storage system for QEMU. QEMU supports
-   using either local sheepdog devices or remote networked devices.
-
-   Syntax for specifying a sheepdog device
-
-   ::
-
-      sheepdog[+tcp|+unix]://[host:port]/vdiname[?socket=path][#snapid|#tag]
-
-   Example
-
-   .. parsed-literal::
-
-      |qemu_system| --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
-
-   See also https://sheepdog.github.io/sheepdog/.
-
-``GlusterFS``
-   GlusterFS is a user space distributed file system. QEMU supports the
-   use of GlusterFS volumes for hosting VM disk images using TCP, Unix
-   Domain Sockets and RDMA transport protocols.
-
-   Syntax for specifying a VM disk image on GlusterFS volume is
-
-   .. parsed-literal::
-
-      URI:
-      gluster[+type]://[host[:port]]/volume/path[?socket=...][,debug=N][,logfile=...]
-
-      JSON:
-      'json:{"driver":"qcow2","file":{"driver":"gluster","volume":"testvol","path":"a.img","debug":N,"logfile":"...",
-                                       "server":[{"type":"tcp","host":"...","port":"..."},
-                                                 {"type":"unix","socket":"..."}]}}'
-
-   Example
-
-   .. parsed-literal::
-
-      URI:
-      |qemu_system| --drive file=gluster://192.0.2.1/testvol/a.img,
-                                     file.debug=9,file.logfile=/var/log/qemu-gluster.log
-
-      JSON:
-      |qemu_system| 'json:{"driver":"qcow2",
-                                "file":{"driver":"gluster",
-                                         "volume":"testvol","path":"a.img",
-                                         "debug":9,"logfile":"/var/log/qemu-gluster.log",
-                                         "server":[{"type":"tcp","host":"1.2.3.4","port":24007},
-                                                   {"type":"unix","socket":"/var/run/glusterd.socket"}]}}'
-      |qemu_system| -drive driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
-                                            file.debug=9,file.logfile=/var/log/qemu-gluster.log,
-                                            file.server.0.type=tcp,file.server.0.host=1.2.3.4,file.server.0.port=24007,
-                                            file.server.1.type=unix,file.server.1.socket=/var/run/glusterd.socket
-
-   See also http://www.gluster.org.
-
-``HTTP/HTTPS/FTP/FTPS``
-   QEMU supports read-only access to files accessed over http(s) and
-   ftp(s).
-
-   Syntax using a single filename:
-
-   ::
-
-      <protocol>://[<username>[:<password>]@]<host>/<path>
-
-   where:
-
-   ``protocol``
-      'http', 'https', 'ftp', or 'ftps'.
-
-   ``username``
-      Optional username for authentication to the remote server.
-
-   ``password``
-      Optional password for authentication to the remote server.
-
-   ``host``
-      Address of the remote server.
-
-   ``path``
-      Path on the remote server, including any query string.
-
-   The following options are also supported:
-
-   ``url``
-      The full URL when passing options to the driver explicitly.
-
-   ``readahead``
-      The amount of data to read ahead with each range request to the
-      remote server. This value may optionally have the suffix 'T', 'G',
-      'M', 'K', 'k' or 'b'. If it does not have a suffix, it will be
-      assumed to be in bytes. The value must be a multiple of 512 bytes.
-      It defaults to 256k.
-
-   ``sslverify``
-      Whether to verify the remote server's certificate when connecting
-      over SSL. It can have the value 'on' or 'off'. It defaults to
-      'on'.
-
-   ``cookie``
-      Send this cookie (it can also be a list of cookies separated by
-      ';') with each outgoing request. Only supported when using
-      protocols such as HTTP which support cookies, otherwise ignored.
-
-   ``timeout``
-      Set the timeout in seconds of the CURL connection. This timeout is
-      the time that CURL waits for a response from the remote server to
-      get the size of the image to be downloaded. If not set, the
-      default timeout of 5 seconds is used.
-
-   Note that when passing options to qemu explicitly, ``driver`` is the
-   value of <protocol>.
-
-   Example: boot from a remote Fedora 20 live ISO image
-
-   .. parsed-literal::
-
-      |qemu_system_x86| --drive media=cdrom,file=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
-
-      |qemu_system_x86| --drive media=cdrom,file.driver=http,file.url=http://archives.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
-
-   Example: boot from a remote Fedora 20 cloud image using a local
-   overlay for writes, copy-on-read, and a readahead of 64k
-
-   .. parsed-literal::
-
-      qemu-img create -f qcow2 -o backing_file='json:{"file.driver":"http",, "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
-
-      |qemu_system_x86| -drive file=/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=on
-
-   Example: boot from an image stored on a VMware vSphere server with a
-   self-signed certificate using a local overlay for writes, a readahead
-   of 64k and a timeout of 10 seconds.
-
-   .. parsed-literal::
-
-      qemu-img create -f qcow2 -o backing_file='json:{"file.driver":"https",, "file.url":"https://user:password@vsphere.example.com/folder/test/test-flat.vmdk?dcPath=Datacenter&dsName=datastore1",, "file.sslverify":"off",, "file.readahead":"64k",, "file.timeout":10}' /tmp/test.qcow2
-
-      |qemu_system_x86| -drive file=/tmp/test.qcow2
+.. include:: device-url-syntax.rst.inc
diff --git a/docs/system/keys.rst b/docs/system/keys.rst
index bf99ee8d5be..e596ae6c4e7 100644
--- a/docs/system/keys.rst
+++ b/docs/system/keys.rst
@@ -3,38 +3,4 @@
 Keys in the graphical frontends
 -------------------------------
 
-During the graphical emulation, you can use special key combinations to
-change modes. The default key mappings are shown below, but if you use
-``-alt-grab`` then the modifier is Ctrl-Alt-Shift (instead of Ctrl-Alt)
-and if you use ``-ctrl-grab`` then the modifier is the right Ctrl key
-(instead of Ctrl-Alt):
-
-Ctrl-Alt-f
-   Toggle full screen
-
-Ctrl-Alt-+
-   Enlarge the screen
-
-Ctrl-Alt\--
-   Shrink the screen
-
-Ctrl-Alt-u
-   Restore the screen's un-scaled dimensions
-
-Ctrl-Alt-n
-   Switch to virtual console 'n'. Standard console mappings are:
-
-   *1*
-      Target system display
-
-   *2*
-      Monitor
-
-   *3*
-      Serial port
-
-Ctrl-Alt
-   Toggle mouse and keyboard grab.
-
-In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp and
-Ctrl-PageDown to move in the back log.
+.. include:: keys.rst.inc
diff --git a/docs/system/keys.rst b/docs/system/keys.rst.inc
similarity index 90%
copy from docs/system/keys.rst
copy to docs/system/keys.rst.inc
index bf99ee8d5be..bd9b8e5f6f5 100644
--- a/docs/system/keys.rst
+++ b/docs/system/keys.rst.inc
@@ -1,8 +1,3 @@
-.. _pcsys_005fkeys:
-
-Keys in the graphical frontends
--------------------------------
-
 During the graphical emulation, you can use special key combinations to
 change modes. The default key mappings are shown below, but if you use
 ``-alt-grab`` then the modifier is Ctrl-Alt-Shift (instead of Ctrl-Alt)
diff --git a/docs/system/mux-chardev.rst b/docs/system/mux-chardev.rst
index e50172c0815..413a6b34460 100644
--- a/docs/system/mux-chardev.rst
+++ b/docs/system/mux-chardev.rst
@@ -3,30 +3,4 @@
 Keys in the character backend multiplexer
 -----------------------------------------
 
-During emulation, if you are using a character backend multiplexer
-(which is the default if you are using ``-nographic``) then several
-commands are available via an escape sequence. These key sequences all
-start with an escape character, which is Ctrl-a by default, but can be
-changed with ``-echr``. The list below assumes you're using the default.
-
-Ctrl-a h
-   Print this help
-
-Ctrl-a x
-   Exit emulator
-
-Ctrl-a s
-   Save disk data back to file (if -snapshot)
-
-Ctrl-a t
-   Toggle console timestamps
-
-Ctrl-a b
-   Send break (magic sysrq in Linux)
-
-Ctrl-a c
-   Rotate between the frontends connected to the multiplexer (usually
-   this switches between the monitor and the console)
-
-Ctrl-a Ctrl-a
-   Send the escape character to the frontend
+.. include:: mux-chardev.rst.inc
diff --git a/docs/system/mux-chardev.rst b/docs/system/mux-chardev.rst.inc
similarity index 87%
copy from docs/system/mux-chardev.rst
copy to docs/system/mux-chardev.rst.inc
index e50172c0815..84ea12cbf58 100644
--- a/docs/system/mux-chardev.rst
+++ b/docs/system/mux-chardev.rst.inc
@@ -1,8 +1,3 @@
-.. _mux_005fkeys:
-
-Keys in the character backend multiplexer
------------------------------------------
-
 During emulation, if you are using a character backend multiplexer
 (which is the default if you are using ``-nographic``) then several
 commands are available via an escape sequence. These key sequences all
diff --git a/docs/system/target-i386.rst b/docs/system/target-i386-desc.rst.inc
similarity index 76%
copy from docs/system/target-i386.rst
copy to docs/system/target-i386-desc.rst.inc
index 92e2038b11e..47a169e0ae2 100644
--- a/docs/system/target-i386.rst
+++ b/docs/system/target-i386-desc.rst.inc
@@ -1,13 +1,3 @@
-.. _QEMU-PC-System-emulator:
-
-x86 (PC) System emulator
-------------------------
-
-.. _pcsys_005fdevices:
-
-Peripherals
-~~~~~~~~~~~
-
 The QEMU PC System emulator simulates the following peripherals:
 
 -  i440FX host PCI bridge and PIIX3 PCI to ISA bridge
@@ -70,15 +60,3 @@ Alternatively:
 Or some other unclaimed IRQ.
 
 CS4231A is the chip used in Windows Sound System and GUSMAX products
-
-.. include:: cpu-models-x86.rst.inc
-
-.. _pcsys_005freq:
-
-OS requirements
-~~~~~~~~~~~~~~~
-
-On x86_64 hosts, the default set of CPU features enabled by the KVM
-accelerator require the host to be running Linux v4.5 or newer. Red Hat
-Enterprise Linux 7 is also supported, since the required
-functionality was backported.
diff --git a/docs/system/target-i386.rst b/docs/system/target-i386.rst
index 92e2038b11e..51be03d881f 100644
--- a/docs/system/target-i386.rst
+++ b/docs/system/target-i386.rst
@@ -8,68 +8,7 @@ x86 (PC) System emulator
 Peripherals
 ~~~~~~~~~~~
 
-The QEMU PC System emulator simulates the following peripherals:
-
--  i440FX host PCI bridge and PIIX3 PCI to ISA bridge
-
--  Cirrus CLGD 5446 PCI VGA card or dummy VGA card with Bochs VESA
-   extensions (hardware level, including all non standard modes).
-
--  PS/2 mouse and keyboard
-
--  2 PCI IDE interfaces with hard disk and CD-ROM support
-
--  Floppy disk
-
--  PCI and ISA network adapters
-
--  Serial ports
-
--  IPMI BMC, either and internal or external one
-
--  Creative SoundBlaster 16 sound card
-
--  ENSONIQ AudioPCI ES1370 sound card
-
--  Intel 82801AA AC97 Audio compatible sound card
-
--  Intel HD Audio Controller and HDA codec
-
--  Adlib (OPL2) - Yamaha YM3812 compatible chip
-
--  Gravis Ultrasound GF1 sound card
-
--  CS4231A compatible sound card
-
--  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
-   hub.
-
-SMP is supported with up to 255 CPUs.
-
-QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
-VGA BIOS.
-
-QEMU uses YM3812 emulation by Tatsuyuki Satoh.
-
-QEMU uses GUS emulation (GUSEMU32 http://www.deinmeister.de/gusemu/) by
-Tibor \"TS\" Schütz.
-
-Note that, by default, GUS shares IRQ(7) with parallel ports and so QEMU
-must be told to not have parallel ports to have working GUS.
-
-.. parsed-literal::
-
-   |qemu_system_x86| dos.img -soundhw gus -parallel none
-
-Alternatively:
-
-.. parsed-literal::
-
-   |qemu_system_x86| dos.img -device gus,irq=5
-
-Or some other unclaimed IRQ.
-
-CS4231A is the chip used in Windows Sound System and GUSMAX products
+.. include:: target-i386-desc.rst.inc
 
 .. include:: cpu-models-x86.rst.inc
 
-- 
2.20.1


