Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542ADC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A7220678
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A7220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqcq-0005hZ-2z
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 03:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iAqZI-0001JW-Eh
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iAqZB-00050J-Ct
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:09:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iAqZA-0004z1-J5
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:09:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B397E3083391;
 Thu, 19 Sep 2019 07:09:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 502216012E;
 Thu, 19 Sep 2019 07:09:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8F304A1E0; Thu, 19 Sep 2019 09:09:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 09:09:17 +0200
Message-Id: <20190919070918.16059-4-kraxel@redhat.com>
In-Reply-To: <20190919070918.16059-1-kraxel@redhat.com>
References: <20190919070918.16059-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 19 Sep 2019 07:09:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/4] ui: add an embedded Barrier client
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>

This allows to receive mouse and keyboard events from
a Barrier server.

This is enabled by adding the following parameter on the
command line

    ... -object input-barrier,id=$id,name=$name ...

Where $name is the name declared in the screens section of barrier.conf

The barrier server (barriers) must be configured and must run on the
local host.

For instance:

  section: screens
      localhost:
          ...
      VM-1:
          ...
      end

  section: links
      localhost:
          right = VM-1
      VM-1:
          left = localhost
  end

Then on the QEMU command line:

    ... -object input-barrier,id=barrie0,name=VM-1 ...

When the mouse will move out of the screen of the local host on
the right, the mouse and the keyboard will be grabbed and all
related events will be send to the guest OS.

This is usefull when qemu is configured without emulated graphic card
but with a VFIO attached graphic card.

More information about Barrier can be found at:

  https://github.com/debauchee/barrier

This avoids to install the Barrier server in the guest OS,
for instance when it is not supported or during the installation.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 20190906083812.29487-1-laurent@vivier.eu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/barrier.txt   | 370 ++++++++++++++++++++++
 ui/input-barrier.h | 112 +++++++
 ui/input-barrier.c | 750 +++++++++++++++++++++++++++++++++++++++++++++
 ui/Makefile.objs   |   1 +
 4 files changed, 1233 insertions(+)
 create mode 100644 docs/barrier.txt
 create mode 100644 ui/input-barrier.h
 create mode 100644 ui/input-barrier.c

diff --git a/docs/barrier.txt b/docs/barrier.txt
new file mode 100644
index 000000000000..b21d15015d96
--- /dev/null
+++ b/docs/barrier.txt
@@ -0,0 +1,370 @@
+                                QEMU Barrier Client
+
+
+* About
+
+    Barrier is a KVM (Keyboard-Video-Mouse) software forked from Symless's
+    synergy 1.9 codebase.
+
+    See https://github.com/debauchee/barrier
+
+* QEMU usage
+
+    Generally, mouse and keyboard are grabbed through the QEMU video
+    interface emulation.
+
+    But when we want to use a video graphic adapter via a PCI passthrough
+    there is no way to provide the keyboard and mouse inputs to the VM
+    except by plugging a second set of mouse and keyboard to the host
+    or by installing a KVM software in the guest OS.
+
+    The QEMU Barrier client avoids this by implementing directly the Barrier
+    protocol into QEMU.
+
+    This protocol is enabled by adding an input-barrier object to QEMU.
+
+    Syntax: input-barrier,id=<object-id>,name=<guest display name>
+            [,server=<barrier server address>][,port=<barrier server port>]
+            [,x-origin=<x-origin>][,y-origin=<y-origin>]
+            [,width=<width>][,height=<height>]
+
+    The object can be added on the QEMU command line, for instance with:
+
+        ... -object input-barrier,id=barrier0,name=VM-1 ...
+
+    where VM-1 is the name the display configured int the Barrier server
+    on the host providing the mouse and the keyboard events.
+
+    by default <barrier server address> is "localhost", port is 24800,
+    <x-origin> and <y-origin> are set to 0, <width> and <height> to
+    1920 and 1080.
+
+    If Barrier server is stopped QEMU needs to be reconnected manually,
+    by removing and re-adding the input-barrier object, for instance
+    with the help of the HMP monitor:
+
+        (qemu) object_del barrier0
+        (qemu) object_add input-barrier,id=barrier0,name=VM-1
+
+* Message format
+
+    Message format between the server and client is in two parts:
+
+        1- the payload length is a 32bit integer in network endianness,
+        2- the payload
+
+    The payload starts with a 4byte string (without NUL) which is the
+    command. The first command between the server and the client
+    is the only command not encoded on 4 bytes ("Barrier").
+    The remaining part of the payload is decoded according to the command.
+
+* Protocol Description (from barrier/src/lib/barrier/protocol_types.h)
+
+    - barrierCmdHello          "Barrier"
+
+      Direction:  server -> client
+      Parameters: { int16_t minor, int16_t major }
+      Description:
+
+          Say hello to client
+          minor = protocol major version number supported by server
+          major = protocol minor version number supported by server
+
+    - barrierCmdHelloBack      "Barrier"
+
+      Direction:  client ->server
+      Parameters: { int16_t minor, int16_t major, char *name}
+      Description:
+
+          Respond to hello from server
+          minor = protocol major version number supported by client
+          major = protocol minor version number supported by client
+          name  = client name
+
+    - barrierCmdDInfo          "DINF"
+
+      Direction:  client ->server
+      Parameters: { int16_t x_origin, int16_t y_origin, int16_t width, int16_t height, int16_t x, int16_t y}
+      Description:
+
+          The client screen must send this message in response to the
+          barrierCmdQInfo message.  It must also send this message when the
+          screen's resolution changes.  In this case, the client screen should
+          ignore any barrierCmdDMouseMove messages until it receives a
+          barrierCmdCInfoAck in order to prevent attempts to move the mouse off
+          the new screen area.
+
+    - barrierCmdCNoop          "CNOP"
+
+      Direction:  client -> server
+      Parameters: None
+      Description:
+
+          No operation
+
+    - barrierCmdCClose         "CBYE"
+
+      Direction:  server -> client
+      Parameters: None
+      Description:
+
+          Close connection
+
+    - barrierCmdCEnter         "CINN"
+
+      Direction:  server -> client
+      Parameters: { int16_t x, int16_t y, int32_t seq, int16_t modifier }
+      Description:
+
+          Enter screen.
+          x,y      = entering screen absolute coordinates
+          seq      = sequence number, which is used to order messages between
+                     screens.  the secondary screen must return this number
+                     with some messages
+          modifier = modifier key mask.  this will have bits set for each
+                     toggle modifier key that is activated on entry to the
+                     screen.  the secondary screen should adjust its toggle
+                     modifiers to reflect that state.
+
+    - barrierCmdCLeave         "COUT"
+
+      Direction:  server -> client
+      Parameters: None
+      Description:
+
+          Leaving screen.  the secondary screen should send clipboard data in
+          response to this message for those clipboards that it has grabbed
+          (i.e. has sent a barrierCmdCClipboard for and has not received a
+          barrierCmdCClipboard for with a greater sequence number) and that
+          were grabbed or have changed since the last leave.
+
+    - barrierCmdCClipboard     "CCLP"
+
+      Direction:  server -> client
+      Parameters: { int8_t id, int32_t seq }
+      Description:
+
+          Grab clipboard. Sent by screen when some other app on that screen
+          grabs a clipboard.
+          id  = the clipboard identifier
+          seq = sequence number. Client must use the sequence number passed in
+                the most recent barrierCmdCEnter.  the server always sends 0.
+
+    - barrierCmdCScreenSaver   "CSEC"
+
+      Direction:  server -> client
+      Parameters: { int8_t started }
+      Description:
+
+          Screensaver change.
+          started = Screensaver on primary has started (1) or closed (0)
+
+    - barrierCmdCResetOptions  "CROP"
+
+      Direction:  server -> client
+      Parameters: None
+      Description:
+
+          Reset options. Client should reset all of its options to their
+          defaults.
+
+    - barrierCmdCInfoAck       "CIAK"
+
+      Direction:  server -> client
+      Parameters: None
+      Description:
+
+          Resolution change acknowledgment. Sent by server in response to a
+          client screen's barrierCmdDInfo. This is sent for every
+          barrierCmdDInfo, whether or not the server had sent a barrierCmdQInfo.
+
+    - barrierCmdCKeepAlive     "CALV"
+
+      Direction:  server -> client
+      Parameters: None
+      Description:
+
+          Keep connection alive. Sent by the server periodically to verify
+          that connections are still up and running.  clients must reply in
+          kind on receipt.  if the server gets an error sending the message or
+          does not receive a reply within a reasonable time then the server
+          disconnects the client.  if the client doesn't receive these (or any
+          message) periodically then it should disconnect from the server.  the
+          appropriate interval is defined by an option.
+
+    - barrierCmdDKeyDown       "DKDN"
+
+      Direction:  server -> client
+      Parameters: { int16_t keyid, int16_t modifier [,int16_t button] }
+      Description:
+
+          Key pressed.
+          keyid    = X11 key id
+          modified = modified mask
+          button   = X11 Xkb keycode (optional)
+
+    - barrierCmdDKeyRepeat     "DKRP"
+
+      Direction:  server -> client
+      Parameters: { int16_t keyid, int16_t modifier, int16_t repeat [,int16_t button] }
+      Description:
+
+          Key auto-repeat.
+          keyid    = X11 key id
+          modified = modified mask
+          repeat   = number of repeats
+          button   = X11 Xkb keycode (optional)
+
+    - barrierCmdDKeyUp         "DKUP"
+
+      Direction:  server -> client
+      Parameters: { int16_t keyid, int16_t modifier [,int16_t button] }
+      Description:
+
+          Key released.
+          keyid    = X11 key id
+          modified = modified mask
+          button   = X11 Xkb keycode (optional)
+
+    - barrierCmdDMouseDown     "DMDN"
+
+      Direction:  server -> client
+      Parameters: { int8_t button }
+      Description:
+
+          Mouse button pressed.
+          button = button id
+
+    - barrierCmdDMouseUp       "DMUP"
+
+      Direction:  server -> client
+      Parameters: { int8_t button }
+      Description:
+
+          Mouse button release.
+          button = button id
+
+    - barrierCmdDMouseMove     "DMMV"
+
+      Direction:  server -> client
+      Parameters: { int16_t x, int16_t y }
+      Description:
+
+          Absolute mouse moved.
+          x,y = absolute screen coordinates
+
+    - barrierCmdDMouseRelMove  "DMRM"
+
+      Direction:  server -> client
+      Parameters: { int16_t x, int16_t y }
+      Description:
+
+          Relative mouse moved.
+          x,y = r relative screen coordinates
+
+    - barrierCmdDMouseWheel    "DMWM"
+
+      Direction:  server -> client
+      Parameters: { int16_t x , int16_t y } or { int16_t y }
+      Description:
+
+          Mouse scroll. The delta should be +120 for one tick forward (away
+          from the user) or right and -120 for one tick backward (toward the
+          user) or left.
+          x = x delta
+          y = y delta
+
+    - barrierCmdDClipboard     "DCLP"
+
+      Direction:  server -> client
+      Parameters: { int8_t id, int32_t seq, int8_t mark, char *data }
+      Description:
+
+          Clipboard data.
+          id  = clipboard id
+          seq = sequence number. The sequence number is 0 when sent by the
+                server.  Client screens should use the/ sequence number from
+                the most recent barrierCmdCEnter.
+
+    - barrierCmdDSetOptions    "DSOP"
+
+      Direction:  server -> client
+      Parameters: { int32 t nb, { int32_t id, int32_t val }[] }
+      Description:
+
+          Set options. Client should set the given option/value pairs.
+          nb  = numbers of { id, val } entries
+          id  = option id
+          val = option new value
+
+    - barrierCmdDFileTransfer  "DFTR"
+
+      Direction:  server -> client
+      Parameters: { int8_t mark, char *content }
+      Description:
+
+          Transfer file data.
+          mark = 0 means the content followed is the file size
+                 1 means the content followed is the chunk data
+                 2 means the file transfer is finished
+
+    - barrierCmdDDragInfo      "DDRG" int16_t char *
+
+      Direction:  server -> client
+      Parameters: { int16_t nb, char *content }
+      Description:
+
+          Drag information.
+          nb      = number of dragging objects
+          content = object's directory
+
+    - barrierCmdQInfo          "QINF"
+
+      Direction:  server -> client
+      Parameters: None
+      Description:
+
+          Query screen info
+          Client should reply with a barrierCmdDInfo
+
+    - barrierCmdEIncompatible  "EICV"
+
+      Direction:  server -> client
+      Parameters: { int16_t nb, major *minor }
+      Description:
+
+          Incompatible version.
+          major = major version
+          minor = minor version
+
+    - barrierCmdEBusy          "EBSY"
+
+      Direction:  server -> client
+      Parameters: None
+      Description:
+
+          Name provided when connecting is already in use.
+
+    - barrierCmdEUnknown       "EUNK"
+
+      Direction:  server -> client
+      Parameters: None
+      Description:
+
+          Unknown client. Name provided when connecting is not in primary's
+           screen configuration map.
+
+    - barrierCmdEBad           "EBAD"
+
+      Direction:  server -> client
+      Parameters: None
+      Description:
+
+          Protocol violation. Server should disconnect after sending this
+          message.
+
+* TO DO
+
+    - Enable SSL
+    - Manage SetOptions/ResetOptions commands
+
diff --git a/ui/input-barrier.h b/ui/input-barrier.h
new file mode 100644
index 000000000000..e5b090590ad5
--- /dev/null
+++ b/ui/input-barrier.h
@@ -0,0 +1,112 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef UI_INPUT_BARRIER_H
+#define UI_INPUT_BARRIER_H
+
+/* Barrier protocol */
+#define BARRIER_VERSION_MAJOR 1
+#define BARRIER_VERSION_MINOR 6
+
+enum barrierCmd {
+    barrierCmdCNoop,
+    barrierCmdCClose,
+    barrierCmdCEnter,
+    barrierCmdCLeave,
+    barrierCmdCClipboard,
+    barrierCmdCScreenSaver,
+    barrierCmdCResetOptions,
+    barrierCmdCInfoAck,
+    barrierCmdCKeepAlive,
+    barrierCmdDKeyDown,
+    barrierCmdDKeyRepeat,
+    barrierCmdDKeyUp,
+    barrierCmdDMouseDown,
+    barrierCmdDMouseUp,
+    barrierCmdDMouseMove,
+    barrierCmdDMouseRelMove,
+    barrierCmdDMouseWheel,
+    barrierCmdDClipboard,
+    barrierCmdDInfo,
+    barrierCmdDSetOptions,
+    barrierCmdDFileTransfer,
+    barrierCmdDDragInfo,
+    barrierCmdQInfo,
+    barrierCmdEIncompatible,
+    barrierCmdEBusy,
+    barrierCmdEUnknown,
+    barrierCmdEBad,
+    /* connection sequence */
+    barrierCmdHello,
+    barrierCmdHelloBack,
+};
+
+enum {
+   barrierButtonNone,
+   barrierButtonLeft,
+   barrierButtonMiddle,
+   barrierButtonRight,
+   barrierButtonExtra0
+};
+
+struct barrierVersion {
+    int16_t major;
+    int16_t minor;
+};
+
+struct barrierMouseButton {
+    int8_t buttonid;
+};
+
+struct barrierEnter {
+    int16_t x;
+    int16_t y;
+    int32_t seqn;
+    int16_t modifier;
+};
+
+struct barrierMousePos {
+    int16_t x;
+    int16_t y;
+};
+
+struct barrierKey {
+    int16_t keyid;
+    int16_t modifier;
+    int16_t button;
+};
+
+struct barrierRepeat {
+    int16_t keyid;
+    int16_t modifier;
+    int16_t repeat;
+    int16_t button;
+};
+
+#define BARRIER_MAX_OPTIONS 32
+struct barrierSet {
+    int nb;
+    struct {
+        int id;
+        char nul;
+        int value;
+    } option[BARRIER_MAX_OPTIONS];
+};
+
+struct barrierMsg {
+    enum barrierCmd cmd;
+    union {
+        struct barrierVersion version;
+        struct barrierMouseButton mousebutton;
+        struct barrierMousePos mousepos;
+        struct barrierEnter enter;
+        struct barrierKey key;
+        struct barrierRepeat repeat;
+        struct barrierSet set;
+    };
+};
+#endif
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
new file mode 100644
index 000000000000..a2c961f285a4
--- /dev/null
+++ b/ui/input-barrier.c
@@ -0,0 +1,750 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "io/channel-socket.h"
+#include "ui/input.h"
+#include "ui/vnc_keysym.h" /* use name2keysym from VNC as we use X11 values */
+#include "qemu/cutils.h"
+#include "qapi/qmp/qerror.h"
+#include "input-barrier.h"
+
+#define TYPE_INPUT_BARRIER "input-barrier"
+#define INPUT_BARRIER(obj) \
+    OBJECT_CHECK(InputBarrier, (obj), TYPE_INPUT_BARRIER)
+#define INPUT_BARRIER_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(InputBarrierClass, (obj), TYPE_INPUT_BARRIER)
+#define INPUT_BARRIER_CLASS(klass) \
+    OBJECT_CLASS_CHECK(InputBarrierClass, (klass), TYPE_INPUT_BARRIER)
+
+typedef struct InputBarrier InputBarrier;
+typedef struct InputBarrierClass InputBarrierClass;
+
+#define MAX_HELLO_LENGTH 1024
+
+struct InputBarrier {
+    Object parent;
+
+    QIOChannelSocket *sioc;
+    guint ioc_tag;
+
+    /* display properties */
+    gchar *name;
+    int16_t x_origin, y_origin;
+    int16_t width, height;
+
+    /* keyboard/mouse server */
+
+    SocketAddress saddr;
+
+    char buffer[MAX_HELLO_LENGTH];
+};
+
+struct InputBarrierClass {
+    ObjectClass parent_class;
+};
+
+static const char *cmd_names[] = {
+    [barrierCmdCNoop]          = "CNOP",
+    [barrierCmdCClose]         = "CBYE",
+    [barrierCmdCEnter]         = "CINN",
+    [barrierCmdCLeave]         = "COUT",
+    [barrierCmdCClipboard]     = "CCLP",
+    [barrierCmdCScreenSaver]   = "CSEC",
+    [barrierCmdCResetOptions]  = "CROP",
+    [barrierCmdCInfoAck]       = "CIAK",
+    [barrierCmdCKeepAlive]     = "CALV",
+    [barrierCmdDKeyDown]       = "DKDN",
+    [barrierCmdDKeyRepeat]     = "DKRP",
+    [barrierCmdDKeyUp]         = "DKUP",
+    [barrierCmdDMouseDown]     = "DMDN",
+    [barrierCmdDMouseUp]       = "DMUP",
+    [barrierCmdDMouseMove]     = "DMMV",
+    [barrierCmdDMouseRelMove]  = "DMRM",
+    [barrierCmdDMouseWheel]    = "DMWM",
+    [barrierCmdDClipboard]     = "DCLP",
+    [barrierCmdDInfo]          = "DINF",
+    [barrierCmdDSetOptions]    = "DSOP",
+    [barrierCmdDFileTransfer]  = "DFTR",
+    [barrierCmdDDragInfo]      = "DDRG",
+    [barrierCmdQInfo]          = "QINF",
+    [barrierCmdEIncompatible]  = "EICV",
+    [barrierCmdEBusy]          = "EBSY",
+    [barrierCmdEUnknown]       = "EUNK",
+    [barrierCmdEBad]           = "EBAD",
+    [barrierCmdHello]          = "Barrier",
+    [barrierCmdHelloBack]      = "Barrier",
+};
+
+static kbd_layout_t *kbd_layout;
+
+static int input_barrier_to_qcode(uint16_t keyid, uint16_t keycode)
+{
+    /* keycode is optional, if it is not provided use keyid */
+    if (keycode && keycode <= qemu_input_map_xorgkbd_to_qcode_len) {
+        return qemu_input_map_xorgkbd_to_qcode[keycode];
+    }
+
+    if (keyid >= 0xE000 && keyid <= 0xEFFF) {
+        keyid += 0x1000;
+    }
+
+    /* keyid is the X11 key id */
+    if (kbd_layout) {
+        keycode = keysym2scancode(kbd_layout, keyid, NULL, false);
+
+        return qemu_input_key_number_to_qcode(keycode);
+    }
+
+    return qemu_input_map_x11_to_qcode[keyid];
+}
+
+static int input_barrier_to_mouse(uint8_t buttonid)
+{
+    switch (buttonid) {
+    case barrierButtonLeft:
+        return INPUT_BUTTON_LEFT;
+    case barrierButtonMiddle:
+        return INPUT_BUTTON_MIDDLE;
+    case barrierButtonRight:
+        return INPUT_BUTTON_RIGHT;
+    case barrierButtonExtra0:
+        return INPUT_BUTTON_SIDE;
+    }
+    return buttonid;
+}
+
+#define read_char(x, p, l)           \
+do {                                 \
+    int size = sizeof(char);         \
+    if (l < size) {                  \
+        return G_SOURCE_REMOVE;      \
+    }                                \
+    x = *(char *)p;                  \
+    p += size;                       \
+    l -= size;                       \
+} while (0)
+
+#define read_short(x, p, l)          \
+do {                                 \
+    int size = sizeof(short);        \
+    if (l < size) {                  \
+        return G_SOURCE_REMOVE;      \
+    }                                \
+    x = ntohs(*(short *)p);          \
+    p += size;                       \
+    l -= size;                       \
+} while (0)
+
+#define write_short(p, x, l)         \
+do {                                 \
+    int size = sizeof(short);        \
+    if (l < size) {                  \
+        return G_SOURCE_REMOVE;      \
+    }                                \
+    *(short *)p = htons(x);          \
+    p += size;                       \
+    l -= size;                       \
+} while (0)
+
+#define read_int(x, p, l)            \
+do {                                 \
+    int size = sizeof(int);          \
+    if (l < size) {                  \
+        return G_SOURCE_REMOVE;      \
+    }                                \
+    x = ntohl(*(int *)p);            \
+    p += size;                       \
+    l -= size;                       \
+} while (0)
+
+#define write_int(p, x, l)           \
+do {                                 \
+    int size = sizeof(int);          \
+    if (l < size) {                  \
+        return G_SOURCE_REMOVE;      \
+    }                                \
+    *(int *)p = htonl(x);            \
+    p += size;                       \
+    l -= size;                       \
+} while (0)
+
+#define write_cmd(p, c, l)           \
+do {                                 \
+    int size = strlen(cmd_names[c]); \
+    if (l < size) {                  \
+        return G_SOURCE_REMOVE;      \
+    }                                \
+    memcpy(p, cmd_names[c], size);   \
+    p += size;                       \
+    l -= size;                       \
+} while (0)
+
+#define write_string(p, s, l)        \
+do {                                 \
+    int size = strlen(s);            \
+    if (l < size + sizeof(int)) {    \
+        return G_SOURCE_REMOVE;      \
+    }                                \
+    *(int *)p = htonl(size);         \
+    p += sizeof(size);               \
+    l -= sizeof(size);               \
+    memcpy(p, s, size);              \
+    p += size;                       \
+    l -= size;                       \
+} while (0)
+
+static gboolean readcmd(InputBarrier *ib, struct barrierMsg *msg)
+{
+    int ret, len, i;
+    enum barrierCmd cmd;
+    char *p;
+
+    ret = qio_channel_read(QIO_CHANNEL(ib->sioc), (char *)&len, sizeof(len),
+                           NULL);
+    if (ret < 0) {
+        return G_SOURCE_REMOVE;
+    }
+
+    len = ntohl(len);
+    if (len > MAX_HELLO_LENGTH) {
+        return G_SOURCE_REMOVE;
+    }
+
+    ret = qio_channel_read(QIO_CHANNEL(ib->sioc), ib->buffer, len, NULL);
+    if (ret < 0) {
+        return G_SOURCE_REMOVE;
+    }
+
+    p = ib->buffer;
+    if (len >= strlen(cmd_names[barrierCmdHello]) &&
+        memcmp(p, cmd_names[barrierCmdHello],
+               strlen(cmd_names[barrierCmdHello])) == 0) {
+        cmd = barrierCmdHello;
+        p += strlen(cmd_names[barrierCmdHello]);
+        len -= strlen(cmd_names[barrierCmdHello]);
+    } else {
+        for (cmd = 0; cmd < barrierCmdHello; cmd++) {
+            if (memcmp(ib->buffer, cmd_names[cmd], 4) == 0) {
+                break;
+            }
+        }
+
+        if (cmd == barrierCmdHello) {
+            return G_SOURCE_REMOVE;
+        }
+        p += 4;
+        len -= 4;
+    }
+
+    msg->cmd = cmd;
+    switch (cmd) {
+    /* connection */
+    case barrierCmdHello:
+        read_short(msg->version.major, p, len);
+        read_short(msg->version.minor, p, len);
+        break;
+    case barrierCmdDSetOptions:
+        read_int(msg->set.nb, p, len);
+        msg->set.nb /= 2;
+        if (msg->set.nb > BARRIER_MAX_OPTIONS) {
+            msg->set.nb = BARRIER_MAX_OPTIONS;
+        }
+        i = 0;
+        while (len && i < msg->set.nb) {
+            read_int(msg->set.option[i].id, p, len);
+            /* it's a string, restore endianness */
+            msg->set.option[i].id = htonl(msg->set.option[i].id);
+            msg->set.option[i].nul = 0;
+            read_int(msg->set.option[i].value, p, len);
+            i++;
+        }
+        break;
+    case barrierCmdQInfo:
+        break;
+
+    /* mouse */
+    case barrierCmdDMouseMove:
+    case barrierCmdDMouseRelMove:
+        read_short(msg->mousepos.x, p, len);
+        read_short(msg->mousepos.y, p, len);
+        break;
+    case barrierCmdDMouseDown:
+    case barrierCmdDMouseUp:
+        read_char(msg->mousebutton.buttonid, p, len);
+        break;
+    case barrierCmdDMouseWheel:
+        read_short(msg->mousepos.y, p, len);
+        msg->mousepos.x = 0;
+        if (len) {
+            msg->mousepos.x = msg->mousepos.y;
+            read_short(msg->mousepos.y, p, len);
+        }
+        break;
+
+    /* keyboard */
+    case barrierCmdDKeyDown:
+    case barrierCmdDKeyUp:
+        read_short(msg->key.keyid, p, len);
+        read_short(msg->key.modifier, p, len);
+        msg->key.button = 0;
+        if (len) {
+            read_short(msg->key.button, p, len);
+        }
+        break;
+    case barrierCmdDKeyRepeat:
+        read_short(msg->repeat.keyid, p, len);
+        read_short(msg->repeat.modifier, p, len);
+        read_short(msg->repeat.repeat, p, len);
+        msg->repeat.button = 0;
+        if (len) {
+            read_short(msg->repeat.button, p, len);
+        }
+        break;
+    case barrierCmdCInfoAck:
+    case barrierCmdCResetOptions:
+    case barrierCmdCEnter:
+    case barrierCmdDClipboard:
+    case barrierCmdCKeepAlive:
+    case barrierCmdCLeave:
+    case barrierCmdCClose:
+        break;
+
+    /* Invalid from the server */
+    case barrierCmdHelloBack:
+    case barrierCmdCNoop:
+    case barrierCmdDInfo:
+        break;
+
+    /* Error codes */
+    case barrierCmdEIncompatible:
+        read_short(msg->version.major, p, len);
+        read_short(msg->version.minor, p, len);
+        break;
+    case barrierCmdEBusy:
+    case barrierCmdEUnknown:
+    case barrierCmdEBad:
+        break;
+    default:
+        return G_SOURCE_REMOVE;
+    }
+
+    return G_SOURCE_CONTINUE;
+}
+
+static gboolean writecmd(InputBarrier *ib, struct barrierMsg *msg)
+{
+    char *p;
+    int ret, i;
+    int avail, len;
+
+    p = ib->buffer;
+    avail = MAX_HELLO_LENGTH;
+
+    /* reserve space to store the length */
+    p += sizeof(int);
+    avail -= sizeof(int);
+
+    switch (msg->cmd) {
+    case barrierCmdHello:
+        if (msg->version.major < BARRIER_VERSION_MAJOR ||
+            (msg->version.major == BARRIER_VERSION_MAJOR &&
+             msg->version.minor < BARRIER_VERSION_MINOR)) {
+            ib->ioc_tag = 0;
+            return G_SOURCE_REMOVE;
+        }
+        write_cmd(p, barrierCmdHelloBack, avail);
+        write_short(p, BARRIER_VERSION_MAJOR, avail);
+        write_short(p, BARRIER_VERSION_MINOR, avail);
+        write_string(p, ib->name, avail);
+        break;
+    case barrierCmdCClose:
+        ib->ioc_tag = 0;
+        return G_SOURCE_REMOVE;
+    case barrierCmdQInfo:
+        write_cmd(p, barrierCmdDInfo, avail);
+        write_short(p, ib->x_origin, avail);
+        write_short(p, ib->y_origin, avail);
+        write_short(p, ib->width, avail);
+        write_short(p, ib->height, avail);
+        write_short(p, 0, avail);    /* warpsize (obsolete) */
+        write_short(p, 0, avail);    /* mouse x */
+        write_short(p, 0, avail);    /* mouse y */
+        break;
+    case barrierCmdCInfoAck:
+        break;
+    case barrierCmdCResetOptions:
+        /* TODO: reset options */
+        break;
+    case barrierCmdDSetOptions:
+        /* TODO: set options */
+        break;
+    case barrierCmdCEnter:
+        break;
+    case barrierCmdDClipboard:
+        break;
+    case barrierCmdCKeepAlive:
+        write_cmd(p, barrierCmdCKeepAlive, avail);
+        break;
+    case barrierCmdCLeave:
+        break;
+
+    /* mouse */
+    case barrierCmdDMouseMove:
+        qemu_input_queue_abs(NULL, INPUT_AXIS_X, msg->mousepos.x,
+                             ib->x_origin, ib->width);
+        qemu_input_queue_abs(NULL, INPUT_AXIS_Y, msg->mousepos.y,
+                             ib->y_origin, ib->height);
+        qemu_input_event_sync();
+        break;
+    case barrierCmdDMouseRelMove:
+        qemu_input_queue_rel(NULL, INPUT_AXIS_X, msg->mousepos.x);
+        qemu_input_queue_rel(NULL, INPUT_AXIS_Y, msg->mousepos.y);
+        qemu_input_event_sync();
+        break;
+    case barrierCmdDMouseDown:
+        qemu_input_queue_btn(NULL,
+                             input_barrier_to_mouse(msg->mousebutton.buttonid),
+                             true);
+        qemu_input_event_sync();
+        break;
+    case barrierCmdDMouseUp:
+        qemu_input_queue_btn(NULL,
+                             input_barrier_to_mouse(msg->mousebutton.buttonid),
+                             false);
+        qemu_input_event_sync();
+        break;
+    case barrierCmdDMouseWheel:
+        qemu_input_queue_btn(NULL, (msg->mousepos.y > 0) ? INPUT_BUTTON_WHEEL_UP
+                             : INPUT_BUTTON_WHEEL_DOWN, true);
+        qemu_input_event_sync();
+        qemu_input_queue_btn(NULL, (msg->mousepos.y > 0) ? INPUT_BUTTON_WHEEL_UP
+                             : INPUT_BUTTON_WHEEL_DOWN, false);
+        qemu_input_event_sync();
+        break;
+
+    /* keyboard */
+    case barrierCmdDKeyDown:
+        qemu_input_event_send_key_qcode(NULL,
+                        input_barrier_to_qcode(msg->key.keyid, msg->key.button),
+                                        true);
+        break;
+    case barrierCmdDKeyRepeat:
+        for (i = 0; i < msg->repeat.repeat; i++) {
+            qemu_input_event_send_key_qcode(NULL,
+                  input_barrier_to_qcode(msg->repeat.keyid, msg->repeat.button),
+                                            false);
+            qemu_input_event_send_key_qcode(NULL,
+                  input_barrier_to_qcode(msg->repeat.keyid, msg->repeat.button),
+                                            true);
+        }
+        break;
+    case barrierCmdDKeyUp:
+        qemu_input_event_send_key_qcode(NULL,
+                        input_barrier_to_qcode(msg->key.keyid, msg->key.button),
+                                        false);
+        break;
+    default:
+        write_cmd(p, barrierCmdEUnknown, avail);
+        break;;
+    }
+
+    len = MAX_HELLO_LENGTH - avail - sizeof(int);
+    if (len) {
+        p = ib->buffer;
+        avail = sizeof(len);
+        write_int(p, len, avail);
+        ret = qio_channel_write(QIO_CHANNEL(ib->sioc), ib->buffer,
+                                len + sizeof(len), NULL);
+        if (ret < 0) {
+            ib->ioc_tag = 0;
+            return G_SOURCE_REMOVE;
+        }
+    }
+
+    return G_SOURCE_CONTINUE;
+}
+
+static gboolean input_barrier_event(QIOChannel *ioc G_GNUC_UNUSED,
+                                    GIOCondition condition, void *opaque)
+{
+    InputBarrier *ib = opaque;
+    int ret;
+    struct barrierMsg msg;
+
+    ret = readcmd(ib, &msg);
+    if (ret == G_SOURCE_REMOVE) {
+        ib->ioc_tag = 0;
+        return G_SOURCE_REMOVE;
+    }
+
+    return writecmd(ib, &msg);
+}
+
+static void input_barrier_complete(UserCreatable *uc, Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(uc);
+    Error *local_err = NULL;
+
+    if (!ib->name) {
+        error_setg(errp, QERR_MISSING_PARAMETER, "name");
+        return;
+    }
+
+    /*
+     * Connect to the primary
+     * Primary is the server where the keyboard and the mouse
+     * are connected and forwarded to the secondary (the client)
+     */
+
+    ib->sioc = qio_channel_socket_new();
+    qio_channel_set_name(QIO_CHANNEL(ib->sioc), "barrier-client");
+
+    qio_channel_socket_connect_sync(ib->sioc, &ib->saddr, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    qio_channel_set_delay(QIO_CHANNEL(ib->sioc), false);
+
+    ib->ioc_tag = qio_channel_add_watch(QIO_CHANNEL(ib->sioc), G_IO_IN,
+                                        input_barrier_event, ib, NULL);
+}
+
+static void input_barrier_instance_finalize(Object *obj)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    if (ib->ioc_tag) {
+        g_source_remove(ib->ioc_tag);
+        ib->ioc_tag = 0;
+    }
+
+    if (ib->sioc) {
+        qio_channel_close(QIO_CHANNEL(ib->sioc), NULL);
+        object_unref(OBJECT(ib->sioc));
+    }
+    g_free(ib->name);
+    g_free(ib->saddr.u.inet.host);
+    g_free(ib->saddr.u.inet.port);
+}
+
+static char *input_barrier_get_name(Object *obj, Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    return g_strdup(ib->name);
+}
+
+static void input_barrier_set_name(Object *obj, const char *value,
+                                  Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    if (ib->name) {
+        error_setg(errp, "name property already set");
+        return;
+    }
+    ib->name = g_strdup(value);
+}
+
+static char *input_barrier_get_server(Object *obj, Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    return g_strdup(ib->saddr.u.inet.host);
+}
+
+static void input_barrier_set_server(Object *obj, const char *value,
+                                     Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    g_free(ib->saddr.u.inet.host);
+    ib->saddr.u.inet.host = g_strdup(value);
+}
+
+static char *input_barrier_get_port(Object *obj, Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    return g_strdup(ib->saddr.u.inet.port);
+}
+
+static void input_barrier_set_port(Object *obj, const char *value,
+                                     Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    g_free(ib->saddr.u.inet.port);
+    ib->saddr.u.inet.port = g_strdup(value);
+}
+
+static void input_barrier_set_x_origin(Object *obj, const char *value,
+                                       Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+    int result, err;
+
+    err = qemu_strtoi(value, NULL, 0, &result);
+    if (err < 0 || result < 0 || result > SHRT_MAX) {
+        error_setg(errp,
+                   "x-origin property must be in the range [0..%d]", SHRT_MAX);
+        return;
+    }
+    ib->x_origin = result;
+}
+
+static char *input_barrier_get_x_origin(Object *obj, Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    return g_strdup_printf("%d", ib->x_origin);
+}
+
+static void input_barrier_set_y_origin(Object *obj, const char *value,
+                                       Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+    int result, err;
+
+    err = qemu_strtoi(value, NULL, 0, &result);
+    if (err < 0 || result < 0 || result > SHRT_MAX) {
+        error_setg(errp,
+                   "y-origin property must be in the range [0..%d]", SHRT_MAX);
+        return;
+    }
+    ib->y_origin = result;
+}
+
+static char *input_barrier_get_y_origin(Object *obj, Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    return g_strdup_printf("%d", ib->y_origin);
+}
+
+static void input_barrier_set_width(Object *obj, const char *value,
+                                       Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+    int result, err;
+
+    err = qemu_strtoi(value, NULL, 0, &result);
+    if (err < 0 || result < 0 || result > SHRT_MAX) {
+        error_setg(errp,
+                   "width property must be in the range [0..%d]", SHRT_MAX);
+        return;
+    }
+    ib->width = result;
+}
+
+static char *input_barrier_get_width(Object *obj, Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    return g_strdup_printf("%d", ib->width);
+}
+
+static void input_barrier_set_height(Object *obj, const char *value,
+                                       Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+    int result, err;
+
+    err = qemu_strtoi(value, NULL, 0, &result);
+    if (err < 0 || result < 0 || result > SHRT_MAX) {
+        error_setg(errp,
+                   "height property must be in the range [0..%d]", SHRT_MAX);
+        return;
+    }
+    ib->height = result;
+}
+
+static char *input_barrier_get_height(Object *obj, Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    return g_strdup_printf("%d", ib->height);
+}
+
+static void input_barrier_instance_init(Object *obj)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    ib->saddr.type = SOCKET_ADDRESS_TYPE_INET;
+    ib->saddr.u.inet.host = g_strdup("localhost");
+    ib->saddr.u.inet.port = g_strdup("24800");
+
+    ib->x_origin = 0;
+    ib->y_origin = 0;
+    ib->width = 1920;
+    ib->height = 1080;
+
+    object_property_add_str(obj, "name",
+                            input_barrier_get_name,
+                            input_barrier_set_name, NULL);
+    object_property_add_str(obj, "server",
+                            input_barrier_get_server,
+                            input_barrier_set_server, NULL);
+    object_property_add_str(obj, "port",
+                            input_barrier_get_port,
+                            input_barrier_set_port, NULL);
+    object_property_add_str(obj, "x-origin",
+                            input_barrier_get_x_origin,
+                            input_barrier_set_x_origin, NULL);
+    object_property_add_str(obj, "y-origin",
+                            input_barrier_get_y_origin,
+                            input_barrier_set_y_origin, NULL);
+    object_property_add_str(obj, "width",
+                            input_barrier_get_width,
+                            input_barrier_set_width, NULL);
+    object_property_add_str(obj, "height",
+                            input_barrier_get_height,
+                            input_barrier_set_height, NULL);
+}
+
+static void input_barrier_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+
+    ucc->complete = input_barrier_complete;
+
+    /* always use generic keymaps */
+    if (keyboard_layout) {
+        /* We use X11 key id, so use VNC name2keysym */
+        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
+                                          &error_fatal);
+    }
+}
+
+static const TypeInfo input_barrier_info = {
+    .name = TYPE_INPUT_BARRIER,
+    .parent = TYPE_OBJECT,
+    .class_size = sizeof(InputBarrierClass),
+    .class_init = input_barrier_class_init,
+    .instance_size = sizeof(InputBarrier),
+    .instance_init = input_barrier_instance_init,
+    .instance_finalize = input_barrier_instance_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void register_types(void)
+{
+    type_register_static(&input_barrier_info);
+}
+
+type_init(register_types);
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index ba39080edb2b..e6da6ff047fd 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -9,6 +9,7 @@ vnc-obj-y += vnc-jobs.o
 
 common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
 common-obj-y += input.o input-keymap.o input-legacy.o kbd-state.o
+common-obj-y += input-barrier.o
 common-obj-$(CONFIG_LINUX) += input-linux.o
 common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
 common-obj-$(CONFIG_COCOA) += cocoa.o
-- 
2.18.1


