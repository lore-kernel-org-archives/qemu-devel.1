Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87F8C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 12:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28FB206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 12:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28FB206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4lDp-0007nS-SW
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 08:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i4lCS-0006yE-Dx
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 08:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i4lCR-00025v-3p
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 08:12:48 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:60446
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i4lCQ-00023p-TS
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 08:12:47 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.92.1) (envelope-from <johannes@sipsolutions.net>)
 id 1i4lCM-0003Ne-A7; Mon, 02 Sep 2019 14:12:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: qemu-devel@nongnu.org
Date: Mon,  2 Sep 2019 14:12:32 +0200
Message-Id: <20190902121233.13382-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902121233.13382-1-johannes@sipsolutions.net>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call messages
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Johannes Berg <johannes.berg@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

For good reason, vhost-user is currently built asynchronously, that
way better performance can be obtained. However, for certain use
cases such as simulation, this is problematic.

Consider an event-based simulation in which both the device and CPU
have are scheduled according to a simulation "calendar". Now, for
example, consider the CPU sending a command to the device, over a
vring in the vhost-user protocol. In this case, the CPU must wait
for the vring update to have been processed, so that the device has
time to put an entry onto the simulation calendar to obtain time to
handle the interrupt, before the CPU goes back to scheduling and
thus updates the simulation calendar or even has the simulation
move time forward.

This cannot easily achieved with the eventfd based vring kick/call
design.

Extend the protocol slightly, so that a message can be used for kick
and call instead, if the new VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS is
negotiated. This in itself doesn't guarantee synchronisation, but both
sides can also negotiate VHOST_USER_PROTOCOL_F_REPLY_ACK and thus get
a reply to this message by setting the need_reply flag, and ensure
synchronisation this way.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 docs/interop/vhost-user.rst | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 7827b710aa0a..1270885fecf2 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -2,6 +2,7 @@
 Vhost-user Protocol
 ===================
 :Copyright: 2014 Virtual Open Systems Sarl.
+:Copyright: 2019 Intel Corporation
 :Licence: This work is licensed under the terms of the GNU GPL,
           version 2 or later. See the COPYING file in the top-level
           directory.
@@ -785,6 +786,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
   #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
   #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
+  #define VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS 13
 
 Master message types
 --------------------
@@ -946,7 +948,9 @@ Master message types
   Bits (0-7) of the payload contain the vring index. Bit 8 is the
   invalid FD flag. This flag is set when there is no file descriptor
   in the ancillary data. This signals that polling should be used
-  instead of waiting for a kick.
+  instead of waiting for the call. however, if the protocol feature
+  ``VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS`` has been negotiated it instead
+  means the updates should be done using the messages.
 
 ``VHOST_USER_SET_VRING_CALL``
   :id: 13
@@ -959,7 +963,9 @@ Master message types
   Bits (0-7) of the payload contain the vring index. Bit 8 is the
   invalid FD flag. This flag is set when there is no file descriptor
   in the ancillary data. This signals that polling will be used
-  instead of waiting for the call.
+  instead of waiting for the call; however, if the protocol feature
+  ``VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS`` has been negotiated it instead
+  means the updates should be done using the messages.
 
 ``VHOST_USER_SET_VRING_ERR``
   :id: 14
@@ -1190,6 +1196,19 @@ Master message types
   ancillary data. The GPU protocol is used to inform the master of
   rendering state and updates. See vhost-user-gpu.rst for details.
 
+``VHOST_USER_VQ_CALL``
+  :id: 34
+  :equivalent ioctl: N/A
+  :slave payload: vring state description
+  :master payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS`` protocol feature has
+  been successfully negotiated, this message may be submitted by the master
+  to indicate that a buffer was added to the vring instead of signalling it
+  using the vring's event FD or having the slave rely on polling.
+
+  The state.num field is currently reserved and must be set to 0.
+
 Slave message types
 -------------------
 
@@ -1246,6 +1265,19 @@ Slave message types
   ``VHOST_USER_PROTOCOL_F_HOST_NOTIFIER`` protocol feature has been
   successfully negotiated.
 
+``VHOST_USER_VQ_KICK``
+  :id: 4
+  :equivalent ioctl: N/A
+  :slave payload: vring state description
+  :master payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS`` protocol feature has
+  been successfully negotiated, this message may be submitted by the slave
+  to indicate that a buffer was used from the vring instead of signalling it
+  using the vring's kick FD or having the master relying on polling.
+
+  The state.num field is currently reserved and must be set to 0.
+
 .. _reply_ack:
 
 VHOST_USER_PROTOCOL_F_REPLY_ACK
-- 
2.20.1


