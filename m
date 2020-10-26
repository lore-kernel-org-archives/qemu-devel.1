Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8B220770
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+TG2b7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8B220770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzpU-0004IJ-H8
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kWzSV-00087M-2b
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kWzSH-000847-VU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603707020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twoVcfoGV5TNeftkQQNUmkU21mxxut7SYrBi4iqWR4A=;
 b=d+TG2b7WoitaZCjt6ePdh5pO8e4n/QTw3JRIbBBckoX45nfAqBAMaNrtPIMmD3Wu79f4g3
 Ya22UHwkOlsoAc1i8iHNSqVtoCt9rbhe7Hox4UNF7q41SHR4aIinEeFasW71QNH5sIwktQ
 qXY/MePn7lQspFZXhZw654Rk2J0VqLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-RhXHeyLqMFaqzPU4-661DA-1; Mon, 26 Oct 2020 06:10:11 -0400
X-MC-Unique: RhXHeyLqMFaqzPU4-661DA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF0F783DC24;
 Mon, 26 Oct 2020 10:10:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A0DC5C22B;
 Mon, 26 Oct 2020 10:10:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C7AF41132FD3; Mon, 26 Oct 2020 11:10:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] char: Flat alternative to overly nested chardev-add
 arguments
Date: Mon, 26 Oct 2020 11:10:04 +0100
Message-Id: <20201026101005.2940615-4-armbru@redhat.com>
In-Reply-To: <20201026101005.2940615-1-armbru@redhat.com>
References: <20201026101005.2940615-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

chardev-add's arguments use an annoying amount of nesting.  Example:

    {"execute": "chardev-add",
     "arguments": {
         "id":"sock0",
	 "backend": {
	     "type": "socket",
	     "data": {
	         "addr": {
		     "type": "inet",
		     "data": {
		         "host": "0.0.0.0",
			 "port": "2445"}}}}}}

This is because chardev-add predates QAPI features that enable flatter
data structures, both on the wire and in C: base types, flat unions,
commands taking a union or alternate as 'data'.

The nesting would be even more annoying in dotted key syntax:

    id=sock0,\
    backend.type=socket,\
    backend.data.addr.type=inet,\
    backend.data.addr.data.host=0.0.0.0,\
    backend.data.addr.data.port=2445

Relevant, because the next commit will QAPIfy qemu-storage-daemon
--chardev.  We really want this instead:

    --chardev socket,id=sock0,\
    addr.type=inet,\
    addr.host=0.0.0.0,\
    addr.port=2445

To get it, define a new QAPI type ChardevOptions that is the flat
equivalent to chardev-add's arguments.

What we should do now is convert the internal interfaces to take this
new type, and limit the nested old type to the external interface,
similar to what commit bd269ebc82 "sockets: Limit SocketAddressLegacy
to external interfaces" did.  But we're too close to the freeze to
pull that off safely.

What I can do now is convert the new type to the old nested type, and
promise to replace this by what should be done in the next development
cycle.

In more detail:

* Flat union ChardevOptions corresponds to chardev-add's implicit
  arguments type.  It flattens a struct containing a simple union into
  a flat union.

* The flat union's discriminator is named @backend, not @type.  This
  avoids clashing with member @type of ChardevSpiceChannel.  For what
  it's worth, -chardev also uses this name.

* Its branches @socket, @udp use ChardevSocketFlat, ChardevUdpFlat
  instead of ChardevSocket, ChardevUdp.  This flattens simple union
  SocketAddressLegacy members to flat union SocketAddress members.

* New chardev_options_crumple() converts ChardevOptions to
  chardev-add's implict arguments type.

Only one existing QAPI definition is affected: some of ChardevSocket's
members get moved to a new base type ChardevSocketBase, to reduce
duplication.  No change to the generated C type and the wire format.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/char.json         | 106 ++++++++++++++++++++++++++++---
 include/chardev/char.h |   5 ++
 include/qemu/sockets.h |   3 +
 chardev/char-legacy.c  | 140 +++++++++++++++++++++++++++++++++++++++++
 chardev/char-socket.c  |   3 +-
 util/qemu-sockets.c    |  38 +++++++++++
 chardev/meson.build    |   1 +
 7 files changed, 287 insertions(+), 9 deletions(-)
 create mode 100644 chardev/char-legacy.c

diff --git a/qapi/char.json b/qapi/char.json
index 43486d1daa..31b693bbb2 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -244,12 +244,8 @@
   'base': 'ChardevCommon' }
 
 ##
-# @ChardevSocket:
+# @ChardevSocketBase:
 #
-# Configuration info for (stream) socket chardevs.
-#
-# @addr: socket address to listen on (server=true)
-#        or connect to (server=false)
 # @tls-creds: the ID of the TLS credentials object (since 2.6)
 # @tls-authz: the ID of the QAuthZ authorization object against which
 #             the client's x509 distinguished name will be validated. This
@@ -274,9 +270,8 @@
 #
 # Since: 1.4
 ##
-{ 'struct': 'ChardevSocket',
-  'data': { 'addr': 'SocketAddressLegacy',
-            '*tls-creds': 'str',
+{ 'struct': 'ChardevSocketBase',
+  'data': { '*tls-creds': 'str',
             '*tls-authz'  : 'str',
             '*server': 'bool',
             '*wait': 'bool',
@@ -287,6 +282,35 @@
             '*reconnect': 'int' },
   'base': 'ChardevCommon' }
 
+##
+# @ChardevSocket:
+#
+# Configuration info for (stream) socket chardevs.
+#
+# @addr: socket address to listen on (server=true)
+#        or connect to (server=false)
+#
+# Since: 1.4
+##
+{ 'struct': 'ChardevSocket',
+  # Do not add to 'data', it breaks chardev_options_crumple()!  Add to
+  # ChardevSocketBase's 'data' instead.
+  'data': { 'addr': 'SocketAddressLegacy' },
+  'base': 'ChardevSocketBase' }
+
+##
+# @ChardevSocketFlat:
+#
+# Note: This type should eventually replace ChardevSocket.  The
+#       difference between the two: ChardevSocketFlat uses
+#       SocketAddressLegacy, ChardevSocket uses SocketAddress.
+##
+{ 'struct': 'ChardevSocketFlat',
+  # Do not add to 'data', it breaks chardev_options_crumple()!  Add to
+  # ChardevSocketBase's 'data' instead.
+  'data': { 'addr': 'SocketAddress' },
+  'base': 'ChardevSocketBase' }
+
 ##
 # @ChardevUdp:
 #
@@ -298,10 +322,26 @@
 # Since: 1.5
 ##
 { 'struct': 'ChardevUdp',
+  # Do not add to 'data', it breaks chardev_options_crumple()!  Create
+  # ChardevUdpBase instead, similar to ChardevSocketBase.
   'data': { 'remote': 'SocketAddressLegacy',
             '*local': 'SocketAddressLegacy' },
   'base': 'ChardevCommon' }
 
+##
+# @ChardevUdpFlat:
+#
+# Note: This type should eventually replace ChardevUdp.  The
+#       difference between the two: ChardevUdpFlat uses
+#       SocketAddressLegacy, ChardevUdp uses SocketAddress.
+##
+{ 'struct': 'ChardevUdpFlat',
+  # Do not add to 'data', it breaks chardev_options_crumple()!  Create
+  # ChardevUdpBase instead, similar to ChardevSocketBase.
+  'data': { 'remote': 'SocketAddress',
+            '*local': 'SocketAddress' },
+  'base': 'ChardevCommon' }
+
 ##
 # @ChardevMux:
 #
@@ -422,6 +462,56 @@
             # next one is just for compatibility
             'memory': 'ChardevRingbuf' } }
 
+##
+# @ChardevBackendType:
+#
+# Since: 5.2
+##
+{ 'enum': 'ChardevBackendType',
+
+  'data': [ 'file', 'serial', 'parallel', 'pipe', 'socket', 'udp',
+            'pty', 'null', 'mux', 'msmouse', 'wctablet', 'braille',
+            'testdev', 'stdio', 'console', 'spicevmc', 'spiceport',
+            'vc', 'ringbuf' ] }
+
+##
+# @ChardevOptions:
+#
+# Note: This type should eventually replace the implicit arguments
+#       type of chardev-add and chardev-chardev.  The differences
+#       between the two: 1. ChardevSocketOptions is a flat union
+#       rather than a struct with a simple union member, and 2. it
+#       uses SocketAddress instead of SocketAddressLegacy.  This
+#       avoids nesting on the wire, i.e. we need fewer {}.
+#
+# Since: 5.2
+##
+{ 'union': 'ChardevOptions',
+  'base': { 'backend': 'ChardevBackendType',
+            'id': 'str' },
+  'discriminator': 'backend',
+  'data': { 'file': 'ChardevFile',
+            'serial': 'ChardevHostdev',
+            'parallel': 'ChardevHostdev',
+            'pipe': 'ChardevHostdev',
+            'socket': 'ChardevSocketFlat',
+            'udp': 'ChardevUdpFlat',
+            'pty': 'ChardevCommon',
+            'null': 'ChardevCommon',
+            'mux': 'ChardevMux',
+            'msmouse': 'ChardevCommon',
+            'wctablet': 'ChardevCommon',
+            'braille': 'ChardevCommon',
+            'testdev': 'ChardevCommon',
+            'stdio': 'ChardevStdio',
+            'console': 'ChardevCommon',
+            'spicevmc': { 'type': 'ChardevSpiceChannel',
+                          'if': 'defined(CONFIG_SPICE)' },
+            'spiceport': { 'type': 'ChardevSpicePort',
+                           'if': 'defined(CONFIG_SPICE)' },
+            'vc': 'ChardevVC',
+            'ringbuf': 'ChardevRingbuf' } }
+
 ##
 # @ChardevReturn:
 #
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 3b91645081..78090a4178 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -284,6 +284,11 @@ extern int term_escape_char;
 GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
                                  GSourceFunc func, void *private);
 
+/* char-legacy.c */
+
+/* TODO replace by conversion in opposite direction */
+q_obj_chardev_add_arg *chardev_options_crumple(ChardevOptions *chr);
+
 /* console.c */
 void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 7d1f813576..75dc58b4c8 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -111,4 +111,7 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
  */
 SocketAddress *socket_address_flatten(SocketAddressLegacy *addr);
 
+/* TODO remove along with chardev_options_crumple() */
+SocketAddressLegacy *socket_address_crumple(SocketAddress *addr);
+
 #endif /* QEMU_SOCKETS_H */
diff --git a/chardev/char-legacy.c b/chardev/char-legacy.c
new file mode 100644
index 0000000000..d4706d7954
--- /dev/null
+++ b/chardev/char-legacy.c
@@ -0,0 +1,140 @@
+/*
+ * Convert between legacy and modern interfaces
+ *
+ * Copyright (C) 2020 Red Hat, Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-char.h"
+#include "qemu/sockets.h"
+#include "chardev/char.h"
+
+/*
+ * TODO Convert internal interfaces to ChardevOptions, replace this
+ * function by one that flattens (const char *str, ChardevBackend
+ * *backend) -> ChardevOptions.
+ */
+q_obj_chardev_add_arg *chardev_options_crumple(ChardevOptions *chr)
+{
+    q_obj_chardev_add_arg *arg;
+    ChardevBackend *be;
+
+    if (!chr) {
+        return NULL;
+    }
+
+    arg = g_malloc(sizeof(*arg));
+    arg->id = g_strdup(chr->id);
+    arg->backend = be = g_malloc(sizeof(*be));
+
+    switch (chr->backend) {
+    case CHARDEV_BACKEND_TYPE_FILE:
+        be->type = CHARDEV_BACKEND_KIND_FILE;
+        be->u.file.data = QAPI_CLONE(ChardevFile, &chr->u.file);
+        break;
+    case CHARDEV_BACKEND_TYPE_SERIAL:
+        be->type = CHARDEV_BACKEND_KIND_SERIAL;
+        be->u.serial.data = QAPI_CLONE(ChardevHostdev, &chr->u.serial);
+        break;
+    case CHARDEV_BACKEND_TYPE_PARALLEL:
+        be->type = CHARDEV_BACKEND_KIND_PARALLEL;
+        be->u.parallel.data = QAPI_CLONE(ChardevHostdev, &chr->u.parallel);
+        break;
+    case CHARDEV_BACKEND_TYPE_PIPE:
+        be->type = CHARDEV_BACKEND_KIND_PIPE;
+        be->u.pipe.data = QAPI_CLONE(ChardevHostdev, &chr->u.pipe);
+        break;
+    case CHARDEV_BACKEND_TYPE_SOCKET:
+        be->type = CHARDEV_BACKEND_KIND_SOCKET;
+        /*
+         * Clone with SocketAddress crumpled to SocketAddressLegacy.
+         * All other members are in the base type.
+         */
+        be->u.socket.data = g_memdup(&chr->u.socket, sizeof(chr->u.socket));
+        QAPI_CLONE_MEMBERS(ChardevSocketBase,
+                           qapi_ChardevSocket_base(be->u.socket.data),
+                           qapi_ChardevSocketFlat_base(&chr->u.socket));
+        be->u.socket.data->addr = socket_address_crumple(chr->u.socket.addr);
+        break;
+    case CHARDEV_BACKEND_TYPE_UDP:
+        be->type = CHARDEV_BACKEND_KIND_UDP;
+        /*
+         * Clone with SocketAddress crumpled to SocketAddressLegacy.
+         * All other members in are the base type.
+         */
+        be->u.udp.data = g_memdup(&chr->u.udp, sizeof(chr->u.udp));
+        QAPI_CLONE_MEMBERS(ChardevCommon,
+                           qapi_ChardevUdp_base(be->u.udp.data),
+                           qapi_ChardevUdpFlat_base(&chr->u.udp));
+        be->u.udp.data->remote = socket_address_crumple(chr->u.udp.remote);
+        be->u.udp.data->local = socket_address_crumple(chr->u.udp.local);
+        break;
+    case CHARDEV_BACKEND_TYPE_PTY:
+        be->type = CHARDEV_BACKEND_KIND_PTY;
+        be->u.pty.data = QAPI_CLONE(ChardevCommon, &chr->u.pty);
+        break;
+    case CHARDEV_BACKEND_TYPE_NULL:
+        be->type = CHARDEV_BACKEND_KIND_NULL;
+        be->u.null.data = QAPI_CLONE(ChardevCommon, &chr->u.null);
+        break;
+    case CHARDEV_BACKEND_TYPE_MUX:
+        be->type = CHARDEV_BACKEND_KIND_MUX;
+         be->u.mux.data = QAPI_CLONE(ChardevMux, &chr->u.mux);
+        break;
+    case CHARDEV_BACKEND_TYPE_MSMOUSE:
+        be->type = CHARDEV_BACKEND_KIND_MSMOUSE;
+        be->u.msmouse.data = QAPI_CLONE(ChardevCommon, &chr->u.msmouse);
+        break;
+    case CHARDEV_BACKEND_TYPE_WCTABLET:
+        be->type = CHARDEV_BACKEND_KIND_WCTABLET;
+        be->u.wctablet.data = QAPI_CLONE(ChardevCommon, &chr->u.wctablet);
+        break;
+    case CHARDEV_BACKEND_TYPE_BRAILLE:
+        be->type = CHARDEV_BACKEND_KIND_BRAILLE;
+        be->u.braille.data = QAPI_CLONE(ChardevCommon, &chr->u.braille);
+        break;
+    case CHARDEV_BACKEND_TYPE_TESTDEV:
+        be->type = CHARDEV_BACKEND_KIND_TESTDEV;
+        be->u.testdev.data = QAPI_CLONE(ChardevCommon, &chr->u.testdev);
+        break;
+    case CHARDEV_BACKEND_TYPE_STDIO:
+        be->type = CHARDEV_BACKEND_KIND_STDIO;
+        be->u.stdio.data = QAPI_CLONE(ChardevStdio, &chr->u.stdio);
+        break;
+    case CHARDEV_BACKEND_TYPE_CONSOLE:
+        be->type = CHARDEV_BACKEND_KIND_CONSOLE;
+        be->u.console.data = QAPI_CLONE(ChardevCommon, &chr->u.console);
+        break;
+#ifdef CONFIG_SPICE
+    case CHARDEV_BACKEND_TYPE_SPICEVMC:
+        be->type = CHARDEV_BACKEND_KIND_SPICEVMC;
+        be->u.spicevmc.data = QAPI_CLONE(ChardevSpiceChannel,
+                                         &chr->u.spicevmc);
+        break;
+    case CHARDEV_BACKEND_TYPE_SPICEPORT:
+        be->type = CHARDEV_BACKEND_KIND_SPICEPORT;
+        be->u.spiceport.data = QAPI_CLONE(ChardevSpicePort,
+                                          &chr->u.spiceport);
+        break;
+#endif
+    case CHARDEV_BACKEND_TYPE_VC:
+        be->type = CHARDEV_BACKEND_KIND_VC;
+        be->u.vc.data = QAPI_CLONE(ChardevVC, &chr->u.vc);
+        break;
+    case CHARDEV_BACKEND_TYPE_RINGBUF:
+        be->type = CHARDEV_BACKEND_KIND_RINGBUF;
+        be->u.ringbuf.data = QAPI_CLONE(ChardevRingbuf, &chr->u.ringbuf);
+        break;
+    default:
+        abort();
+    }
+
+    return arg;
+}
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 95e45812d5..37a725da7f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1404,7 +1404,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
 
     backend->type = CHARDEV_BACKEND_KIND_SOCKET;
     sock = backend->u.socket.data = g_new0(ChardevSocket, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
+    qemu_chr_parse_common(opts,
+            qapi_ChardevSocketBase_base(qapi_ChardevSocket_base(sock)));
 
     sock->has_nodelay = qemu_opt_get(opts, "delay");
     sock->nodelay = !qemu_opt_get_bool(opts, "delay", true);
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 05e5c73f9d..033f112868 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1387,3 +1387,41 @@ SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
 
     return addr;
 }
+
+/* TODO remove along with chardev_options_crumple() */
+SocketAddressLegacy *socket_address_crumple(SocketAddress *addr)
+{
+    SocketAddressLegacy *addr_legacy;
+
+    if (!addr) {
+        return NULL;
+    }
+
+    addr_legacy = g_malloc(sizeof(*addr_legacy));
+
+    switch (addr->type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        addr_legacy->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
+        addr_legacy->u.inet.data = QAPI_CLONE(InetSocketAddress,
+                                              &addr->u.inet);
+        break;
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        addr_legacy->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
+        addr_legacy->u.q_unix.data = QAPI_CLONE(UnixSocketAddress,
+                                                &addr->u.q_unix);
+        break;
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        addr_legacy->type = SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
+        addr_legacy->u.vsock.data = QAPI_CLONE(VsockSocketAddress,
+                                               &addr->u.vsock);
+        break;
+    case SOCKET_ADDRESS_TYPE_FD:
+        addr_legacy->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
+        addr_legacy->u.fd.data = QAPI_CLONE(String, &addr->u.fd);
+        break;
+    default:
+        abort();
+    }
+
+    return addr_legacy;
+}
diff --git a/chardev/meson.build b/chardev/meson.build
index 859d8b04d4..25074097fb 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -2,6 +2,7 @@ chardev_ss.add(files(
   'char-fe.c',
   'char-file.c',
   'char-io.c',
+  'char-legacy.c',
   'char-mux.c',
   'char-null.c',
   'char-pipe.c',
-- 
2.26.2


