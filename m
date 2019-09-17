Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8FBC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2972214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2972214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACff-0002UX-TG
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1iACYz-0006u1-B7
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1iACYw-0006i3-TJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:32 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:59354
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1iACYw-0006gt-Mp
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:30 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1iACYv-0003t8-Km; Tue, 17 Sep 2019 14:26:29 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 14:26:24 +0200
Message-Id: <20190917122625.15614-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: [Qemu-devel] [PATCH 1/2] docs: vhost-user: add in-band kick/call
 messages
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
Cc: Johannes Berg <johannes.berg@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

For good reason, vhost-user is currently built asynchronously, that
way better performance can be obtained. However, for certain use
cases such as simulation, this is problematic.

Consider an event-based simulation in which both the device and CPU
have scheduled according to a simulation "calendar". Now, consider
the CPU sending I/O to the device, over a vring in the vhost-user
protocol. In this case, the CPU must wait for the vring interrupt
to have been processed by the device, so that the device is able to
put an entry onto the simulation calendar to obtain time to handle
the interrupt. Note that this doesn't mean the I/O is actually done
at this time, it just means that the handling of it is scheduled
before the CPU can continue running.

This cannot be done with the asynchronous eventfd based vring kick
and call design.

Extend the protocol slightly, so that a message can be used for kick
and call instead, if VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS is
negotiated. This in itself doesn't guarantee synchronisation, but both
sides can also negotiate VHOST_USER_PROTOCOL_F_REPLY_ACK and thus get
a reply to this message by setting the need_reply flag, and ensure
synchronisation this way.

To really use it in both directions, VHOST_USER_PROTOCOL_F_SLAVE_REQ
is also needed.

Since it is used for simulation purposes and too many messages on
the socket can lock up the virtual machine, document that this should
only be used together with the mentioned features.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 docs/interop/vhost-user.rst | 120 +++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 17 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 7827b710aa0a..5f455262d55a 100644
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
@@ -279,6 +280,9 @@ If *master* is unable to send the full message or receives a wrong
 reply it will close the connection. An optional reconnection mechanism
 can be implemented.
 
+If *slave* detects some error such as incompatible features, it may also
+close the connection. This should only happen in exceptional circumstances.
+
 Any protocol extensions are gated by protocol feature bits, which
 allows full backwards compatibility on both master and slave.  As
 older slaves don't support negotiating protocol features, a feature
@@ -315,7 +319,8 @@ it until ring is started, or after it has been stopped.
 
 Client must start ring upon receiving a kick (that is, detecting that
 file descriptor is readable) on the descriptor specified by
-``VHOST_USER_SET_VRING_KICK``, and stop ring upon receiving
+``VHOST_USER_SET_VRING_KICK`` or receiving the in-band message
+``VHOST_USER_VRING_KICK`` if negotiated, and stop ring upon receiving
 ``VHOST_USER_GET_VRING_BASE``.
 
 While processing the rings (whether they are enabled or not), client
@@ -767,24 +772,48 @@ When reconnecting:
 #. Resubmit inflight ``DescStatePacked`` entries in order of their
    counter value
 
+In-band notifications
+---------------------
+
+In some limited situations (e.g. for simulation) it is desirable to
+have the kick, call and error (if used) signals done via in-band
+messages instead of asynchronous eventfd notifications. This can be
+done by negotiating the ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS``
+protocol feature.
+
+Note that due to the fact that too many messages on the sockets can
+cause the sending application(s) to block, it is not advised to use
+this feature unless absolutely necessary. It is also considered an
+error to negotiate this feature without also negotiating
+``VHOST_USER_PROTOCOL_F_SLAVE_REQ`` and ``VHOST_USER_PROTOCOL_F_REPLY_ACK``,
+the former is necessary for getting a message channel from the slave
+to the master, while the latter needs to be used with the in-band
+notification messages to block until they are processed, both to avoid
+blocking later and for proper processing (at least in the simulation
+use case.) As it has no other way of signalling this error, the slave
+should close the connection as a response to a
+``VHOST_USER_SET_PROTOCOL_FEATURES`` message that sets the in-band
+notifications feature flag without the other two.
+
 Protocol features
 -----------------
 
 .. code:: c
 
-  #define VHOST_USER_PROTOCOL_F_MQ             0
-  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD      1
-  #define VHOST_USER_PROTOCOL_F_RARP           2
-  #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
-  #define VHOST_USER_PROTOCOL_F_MTU            4
-  #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
-  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
-  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
-  #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
-  #define VHOST_USER_PROTOCOL_F_CONFIG         9
-  #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
-  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
-  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
+  #define VHOST_USER_PROTOCOL_F_MQ                    0
+  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD             1
+  #define VHOST_USER_PROTOCOL_F_RARP                  2
+  #define VHOST_USER_PROTOCOL_F_REPLY_ACK             3
+  #define VHOST_USER_PROTOCOL_F_MTU                   4
+  #define VHOST_USER_PROTOCOL_F_SLAVE_REQ             5
+  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN          6
+  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION        7
+  #define VHOST_USER_PROTOCOL_F_PAGEFAULT             8
+  #define VHOST_USER_PROTOCOL_F_CONFIG                9
+  #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD        10
+  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER        11
+  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
+  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 13
 
 Master message types
 --------------------
@@ -946,7 +975,12 @@ Master message types
   Bits (0-7) of the payload contain the vring index. Bit 8 is the
   invalid FD flag. This flag is set when there is no file descriptor
   in the ancillary data. This signals that polling should be used
-  instead of waiting for a kick.
+  instead of waiting for the kick. Note that if the protocol feature
+  ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` has been negotiated
+  this message isn't necessary as the ring is also started on the
+  ``VHOST_USER_VRING_KICK`` message, it may however still be used to
+  set an event file descriptor (which will be preferred over the
+  message) or to enable polling.
 
 ``VHOST_USER_SET_VRING_CALL``
   :id: 13
@@ -959,7 +993,12 @@ Master message types
   Bits (0-7) of the payload contain the vring index. Bit 8 is the
   invalid FD flag. This flag is set when there is no file descriptor
   in the ancillary data. This signals that polling will be used
-  instead of waiting for the call.
+  instead of waiting for the call. Note that if the protocol features
+  ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` and
+  ``VHOST_USER_PROTOCOL_F_SLAVE_REQ`` have been negotiated this message
+  isn't necessary as the ``VHOST_USER_SLAVE_VRING_CALL`` message can be
+  used, it may however still be used to set an event file descriptor
+  or to enable polling.
 
 ``VHOST_USER_SET_VRING_ERR``
   :id: 14
@@ -971,7 +1010,12 @@ Master message types
 
   Bits (0-7) of the payload contain the vring index. Bit 8 is the
   invalid FD flag. This flag is set when there is no file descriptor
-  in the ancillary data.
+  in the ancillary data. Note that if the protocol features
+  ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` and
+  ``VHOST_USER_PROTOCOL_F_SLAVE_REQ`` have been negotiated this message
+  isn't necessary as the ``VHOST_USER_SLAVE_VRING_ERR`` message can be
+  used, it may however still be used to set an event file descriptor
+  (which will be preferred over the message).
 
 ``VHOST_USER_GET_QUEUE_NUM``
   :id: 17
@@ -1190,6 +1234,20 @@ Master message types
   ancillary data. The GPU protocol is used to inform the master of
   rendering state and updates. See vhost-user-gpu.rst for details.
 
+``VHOST_USER_VRING_KICK``
+  :id: 34
+  :equivalent ioctl: N/A
+  :slave payload: vring state description
+  :master payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` protocol
+  feature has been successfully negotiated, this message may be
+  submitted by the master to indicate that a buffer was added to
+  the vring instead of signalling it using the vring's kick file
+  descriptor or having the slave rely on polling.
+
+  The state.num field is currently reserved and must be set to 0.
+
 Slave message types
 -------------------
 
@@ -1246,6 +1304,34 @@ Slave message types
   ``VHOST_USER_PROTOCOL_F_HOST_NOTIFIER`` protocol feature has been
   successfully negotiated.
 
+``VHOST_USER_SLAVE_VRING_CALL``
+  :id: 4
+  :equivalent ioctl: N/A
+  :slave payload: vring state description
+  :master payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` protocol
+  feature has been successfully negotiated, this message may be
+  submitted by the slave to indicate that a buffer was used from
+  the vring instead of signalling this using the vring's call file
+  descriptor or having the master relying on polling.
+
+  The state.num field is currently reserved and must be set to 0.
+
+``VHOST_USER_SLAVE_VRING_ERR``
+  :id: 5
+  :equivalent ioctl: N/A
+  :slave payload: vring state description
+  :master payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` protocol
+  feature has been successfully negotiated, this message may be
+  submitted by the slave to indicate that an error occurred on the
+  specific vring, instead of signalling the error file descriptor
+  set by the master via ``VHOST_USER_SET_VRING_ERR``.
+
+  The state.num field is currently reserved and must be set to 0.
+
 .. _reply_ack:
 
 VHOST_USER_PROTOCOL_F_REPLY_ACK
-- 
2.20.1


