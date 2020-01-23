Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E53C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127F322522
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127F322522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXiz-0006DU-3k
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1iuXfy-000210-5e
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1iuXfv-0005lp-UH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:17:18 -0500
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:35506
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1iuXfv-0005jB-Na
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:17:15 -0500
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.93) (envelope-from <johannes@sipsolutions.net>)
 id 1iuXft-00FGF5-Ue; Thu, 23 Jan 2020 09:17:14 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/6] docs: vhost-user: add in-band kick/call messages
Date: Thu, 23 Jan 2020 09:17:07 +0100
Message-Id: <20200123081708.7817-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123081708.7817-1-johannes@sipsolutions.net>
References: <20200123081708.7817-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
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
Cc: Johannes Berg <johannes.berg@intel.com>, mst@redhat.com
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
 docs/interop/vhost-user.rst | 122 ++++++++++++++++++++++++++++++------
 1 file changed, 104 insertions(+), 18 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5f8b3a456b5e..401652397cac 100644
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
@@ -767,25 +772,49 @@ When reconnecting:
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
-  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE   13
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
+  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
+  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
 
 Master message types
 --------------------
@@ -947,7 +976,12 @@ Master message types
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
@@ -960,7 +994,12 @@ Master message types
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
@@ -972,7 +1011,12 @@ Master message types
 
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
@@ -1205,6 +1249,20 @@ Master message types
   Only valid if the ``VHOST_USER_PROTOCOL_F_RESET_DEVICE`` protocol
   feature is set by the backend.
 
+``VHOST_USER_VRING_KICK``
+  :id: 35
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
 
@@ -1261,6 +1319,34 @@ Slave message types
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
2.24.1


