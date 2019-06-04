Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE73C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 12:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C9C24891
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 12:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C9C24891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50893 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY87S-0001SJ-7o
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 08:00:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hY84V-0007vE-6w
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 07:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hY7zP-0000Sf-3t
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 07:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hY7zM-0000Pn-Rp
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 07:52:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8310D821D8
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 11:52:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2136C5B683;
	Tue,  4 Jun 2019 11:52:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id A5F7F11386A6; Tue,  4 Jun 2019 13:52:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 13:52:20 +0200
Message-Id: <20190604115221.28364-3-armbru@redhat.com>
In-Reply-To: <20190604115221.28364-1-armbru@redhat.com>
References: <20190604115221.28364-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 04 Jun 2019 11:52:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] net: Deprecate tap backend's parameter
 "helper"
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
Cc: jasowang@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

-netdev tap,helper=3D... is a useless duplicate of -netdev bridge.
Deprecate and de-document.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/net.json        |  3 ++-
 qemu-deprecated.texi |  4 ++++
 qemu-options.hx      | 18 ++----------------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 5f7bff1637..59d79a1ae1 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -221,7 +221,8 @@
 #
 # @br: bridge name (since 2.8)
 #
-# @helper: command to execute to configure bridge
+# @helper: command to execute to configure bridge (deprecated, use
+# type 'bridge' instead)
 #
 # @sndbuf: send buffer limit. Understands [TGMKkb] suffixes.
 #
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 50292d820b..52e7600ebc 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -48,6 +48,10 @@ for these file types is 'host_cdrom' or 'host_device' =
as appropriate.
 The @option{name} parameter of the @option{-net} option is a synonym
 for the @option{id} parameter, which should now be used instead.
=20
+@subsection -netdev tap,helper=3D... (since 4.1)
+
+Use -netdev bridge instead.
+
 @subsection -smp (invalid topologies) (since 3.1)
=20
 CPU topology properties should describe whole machine topology including
diff --git a/qemu-options.hx b/qemu-options.hx
index 39dc170429..3324203b51 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2121,7 +2121,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                configure a host TAP network backend with ID 'str'\=
n"
 #else
     "-netdev tap,id=3Dstr[,fd=3Dh][,fds=3Dx:y:...:z][,ifname=3Dname][,sc=
ript=3Dfile][,downscript=3Ddfile]\n"
-    "         [,br=3Dbridge][,helper=3Dhelper][,sndbuf=3Dnbytes][,vnet_h=
dr=3Don|off][,vhost=3Don|off]\n"
+    "         [,br=3Dbridge][,sndbuf=3Dnbytes][,vnet_hdr=3Don|off][,vhos=
t=3Don|off]\n"
     "         [,vhostfd=3Dh][,vhostfds=3Dx:y:...:z][,vhostforce=3Don|off=
][,queues=3Dn]\n"
     "         [,poll-us=3Dn]\n"
     "                configure a host TAP network backend with ID 'str'\=
n"
@@ -2130,8 +2130,6 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                to configure it and 'dfile' (default=3D" DEFAULT_NE=
TWORK_DOWN_SCRIPT ")\n"
     "                to deconfigure it\n"
     "                use '[down]script=3Dno' to disable script execution=
\n"
-    "                use network helper 'helper' (default=3D" DEFAULT_BR=
IDGE_HELPER ") to\n"
-    "                configure it\n"
     "                use 'fd=3Dh' to connect to an already opened TAP in=
terface\n"
     "                use 'fds=3Dx:y:...:z' to connect to already opened =
multiqueue capable TAP interfaces\n"
     "                use 'sndbuf=3Dnbytes' to limit the size of the send=
 buffer (the\n"
@@ -2435,7 +2433,7 @@ qemu-system-i386 -nic  'user,id=3Dn1,guestfwd=3Dtcp=
:10.0.2.100:1234-cmd:netcat 10.10
=20
 @end table
=20
-@item -netdev tap,id=3D@var{id}[,fd=3D@var{h}][,ifname=3D@var{name}][,sc=
ript=3D@var{file}][,downscript=3D@var{dfile}][,br=3D@var{bridge}][,helper=
=3D@var{helper}]
+@item -netdev tap,id=3D@var{id}[,fd=3D@var{h}][,ifname=3D@var{name}][,sc=
ript=3D@var{file}][,downscript=3D@var{dfile}][,br=3D@var{bridge}]
 Configure a host TAP network backend with ID @var{id}.
=20
 Use the network script @var{file} to configure it and the network script
@@ -2445,11 +2443,6 @@ automatically provides one. The default network co=
nfigure script is
 @file{/etc/qemu-ifdown}. Use @option{script=3Dno} or @option{downscript=3D=
no}
 to disable script execution.
=20
-If running QEMU as an unprivileged user, use the network helper
-@var{helper} to configure the TAP interface and attach it to the bridge.
-The default network helper executable is @file{/path/to/qemu-bridge-help=
er}
-and the default bridge device is @file{br0}.
-
 @option{fd}=3D@var{h} can be used to specify the handle of an already
 opened host TAP interface.
=20
@@ -2468,13 +2461,6 @@ qemu-system-i386 linux.img \
         -netdev tap,id=3Dnd1,ifname=3Dtap1 -device rtl8139,netdev=3Dnd1
 @end example
=20
-@example
-#launch a QEMU instance with the default network helper to
-#connect a TAP device to bridge br0
-qemu-system-i386 linux.img -device virtio-net-pci,netdev=3Dn1 \
-        -netdev tap,id=3Dn1,"helper=3D/path/to/qemu-bridge-helper"
-@end example
-
 @item -netdev bridge,id=3D@var{id}[,br=3D@var{bridge}][,helper=3D@var{he=
lper}]
 Connect a host TAP network interface to a host bridge device.
=20
--=20
2.21.0


