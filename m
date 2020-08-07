Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_HTML_ATTACH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE60C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D782820866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qVUCGTr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D782820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k45eU-0008Df-6H
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 12:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1k45dh-0007mh-Gs
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:54:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1k45dc-0004rm-HO
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:54:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 077GqEET024859;
 Fri, 7 Aug 2020 16:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2020-01-29;
 bh=KWUQWaDmtD2/vhb8hM6UQgA+F8PhzugKVRwpwPzcaWQ=;
 b=qVUCGTr41Qv0FwjLFbbwbn1XHp7y7FplWYheMISCe35mYnqfk/xa+QhkW8UjmBAJObq9
 bgm5I1XTf3v9ObaGyuXGzzzkWSeGnfwU9oldqVUyUNrxXLENFoZo7zzd5psYoL/KQix6
 31ycwAsDVfjGT7k2RKxHgYBpd/0ZLhMjOOvGiX5aQpn1kVtqzkyi4mw/lNsqf7uWgfsb
 grEj/peMXGLQXVBH6VBo0nqd3cnaxVC75bh5uEXv9F7van9dsyJZkScnguOK04vijtrg
 ELzjMRoKsgQFnLVsQ6xAn6hAqkTS1mUHMHaJlYHKVQS1AzEjhR5XEixq+HcUU3I8QIXi yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 32r6ep9mpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 07 Aug 2020 16:54:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 077Gh33j155983;
 Fri, 7 Aug 2020 16:52:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 32pdp15517-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Aug 2020 16:52:26 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 077GqOTw026051;
 Fri, 7 Aug 2020 16:52:24 GMT
Received: from [192.168.10.3] (/24.5.35.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Aug 2020 09:52:24 -0700
From: John G Johnson <john.g.johnson@oracle.com>
Message-Id: <BAEE677E-991A-452E-8345-BD63EFE7501D@oracle.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_0078527D-57B0-458F-941A-A3B6210ACFA0"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH] introduce VFIO-over-socket protocol specificaion
Date: Fri, 7 Aug 2020 09:52:21 -0700
In-Reply-To: <20200729124803.GF37763@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <1594913503-52271-1-git-send-email-thanos.makatos@nutanix.com>
 <20200717121753.GK128195@stefanha-x1.localdomain>
 <MW2PR02MB372306D4995774D4E6D036AD8B790@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200729124803.GF37763@stefanha-x1.localdomain>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9706
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008070117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9706
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070118
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=john.g.johnson@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 12:40:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_HTML_ATTACH=0.01 autolearn=ham autolearn_force=no
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_0078527D-57B0-458F-941A-A3B6210ACFA0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


	Updated doc to address comments.  Many changes are typos, but
some are more more substantive.

								JJ


Version title is a hyperlink the versioning section
Rewrote concurrency section to be less concurrent
Removed disconnection recovery section - disconnect now causes client =
device reset
Message type is now enumerated in flags to distinguish it from message =
attributes
argsz fields use VFIO definitions instead of being reserved
sys/vfio.h -> linux/vfio.h



--Apple-Mail=_0078527D-57B0-458F-941A-A3B6210ACFA0
Content-Disposition: attachment;
	filename=vfio-user.diff
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="vfio-user.diff"
Content-Transfer-Encoding: 7bit

diff --git a/docs/devel/vfio-user.rst b/docs/devel/vfio-user.rst
index 05a788b..ea99db6 100644
--- a/docs/devel/vfio-user.rst
+++ b/docs/devel/vfio-user.rst
@@ -2,9 +2,9 @@
 vfio-user Protocol Specification
 ********************************
 
------------
-Version 0.1
------------
+------------
+Version_ 0.1
+------------
 
 .. contents:: Table of Contents
 
@@ -207,21 +207,19 @@ protocol.
 
 Command Concurrency
 -------------------
-There can be multiple outstanding commands per virtual device, e.g. a frame
-buffer where the guest does multiple stores to the virtual device.  Commands
-must be executed in the order they are received.  The server can execute and
-reorder non-conflicting commands in parallel, depending on the device
-semantics.
-
-.. Note::
-   For instance, a client can issue the following operations back to back
-   without waiting for the first two to complete:
-
-   1. map a DMA region 
-   2. trigger some device-specific operation that results in data being read
-      into that DMA region, and
-   3. unmap the DMA region
-
+A client may pipeline multiple commands without waiting for previous command
+replies.  The server will process commands in the order they are received.
+A consequence of this is if a client issues a command with the *No_reply* bit,
+then subseqently issues a command without *No_reply*, the older command will
+have been processed before the reply to the younger command is sent by the
+server.  The client must be aware of the device's capability to process concurrent
+commands if pipelining is used.  For example, pipelining allows multiple client
+threads to concurently access device memory; the client must ensure these acceses
+obey device semantics.
+
+An example is a frame buffer device, where the device may allow concurrent access
+to different areas of video memory, but may have indeterminate behavior if concurrent
+acceses are performed to command or status registers.
 
 Socket Disconnection Behavior
 -----------------------------
@@ -234,29 +232,14 @@ Server Disconnection
 A server disconnecting from the client may indicate that:
 
 1) A virtual device has been restarted, either intentionally (e.g. because of a
-   device update) or unintentionally (e.g. because of a crash). In any case,
-   the virtual device will come back so the client should not do anything (e.g.
-   simply reconnect and retry failed operations).
+   device update) or unintentionally (e.g. because of a crash).
 2) A virtual device has been shut down with no intention to be restarted.
 
 It is impossible for the client to know whether or not a failure is
 intermittent or innocuous and should be retried, therefore the client should
-attempt to reconnect to the socket. Since an intentional server restart (e.g.
-due to an upgrade) might take some time, a reasonable timeout should be used.
-In cases where the disconnection is expected (e.g. the client exits), no new
-commands will be sent anyway so this situation does not pose a problem. The
-control stack will clean up accordingly.
-
-Parameterizing this behaviour by having the server advertise a reasonable
-reconnect is deferred to a future version of the protocol.
-
-Recovering state is implementation-specific. The protocol provides all the
-building blocks and does not enforce a particular mechanism:
-
-* Recovering state must be initiated by the client since it is the master in
-  the vfio-user model. Interrupts/DMA may have to be reconfigured,
-  unacknowledged requests may have to be re-submitted, etc.
-* The server may have to persistently store device state.
+reset the VFIO device when it detects the socket has been disconnected.
+Error recovery will be driven by the guest's device error handling
+behavior.
 
 Client Disconnection
 ^^^^^^^^^^^^^^^^^^^^
@@ -274,6 +257,12 @@ take no action when the client disconnects. If anything happens to the client
 the control stack will know about it and can clean up resources
 accordingly.
 
+Live Migration
+^^^^^^^^^^^^^^
+A future version of the protocol will support client live migration.  This action
+will require the socket to be quiesced before it is disconnected,  This mechanism
+will be defined when live migration support is added.
+
 Request Retry and Response Timeout
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 A failed command is a command that has been successfully sent and has been
@@ -335,48 +324,53 @@ All messages, both command messages and reply messages, are preceded by a
 header that contains basic information about the message. The header is
 followed by message-specific data described in the sections below.
 
-+----------------+--------+-------------+
-| Name           | Offset | Size        |
-+================+========+=============+
-| Message ID     | 0      | 2           |
-+----------------+--------+-------------+
-| Command        | 2      | 2           |
-+----------------+--------+-------------+
-| Message size   | 4      | 4           |
-+----------------+--------+-------------+
-| Flags          | 8      | 4           |
-+----------------+--------+-------------+
-|                | +-----+------------+ |
-|                | | Bit | Definition | |
-|                | +=====+============+ |
-|                | | 0   | Reply      | |
-|                | +-----+------------+ |
-|                | | 1   | No_reply   | |
-|                | +-----+------------+ |
-|                | | 2   | Error      | |
-|                | +-----+------------+ |
-+----------------+--------+-------------+
-| Error          | 12     | 4           |
-+----------------+--------+-------------+
-| <message data> | 16     | variable    |
-+----------------+--------+-------------+
-
-* *Message ID* identifies the message, and is used echoed in the reply message.
++----------------+---------+-------------+
+| Name           | Offset  | Size        |
++================+=========+=============+
+| Message ID     | 0       | 2           |
++----------------+---------+-------------+
+| Command        | 2       | 2           |
++----------------+---------+-------------+
+| Message size   | 4       | 4           |
++----------------+---------+-------------+
+| Flags          | 8       | 4           |
++----------------+---------+-------------+
+|                | +------+------------+ |
+|                | | Bit  | Definition | |
+|                | +======+============+ |
+|                | | 0-3  | Type       | |
+|                | +------+------------+ |
+|                | | 4    | No_reply   | |
+|                | +------+------------+ |
+|                | | 5    | Error      | |
+|                | +------+------------+ |
++----------------+---------+-------------+
+| Errno          | 12      | 4           |
++----------------+---------+-------------+
+| <message data> | 16      | variable    |
++----------------+---------+-------------+
+
+* *Message ID* identifies the message, and is echoed in the command's reply message.
 * *Command* specifies the command to be executed, listed in Commands_.
 * *Message size* contains the size of the entire message, including the header.
 * *Flags* contains attributes of the message:
 
-  * The reply bit differentiates command messages from reply messages. A reply
-    message acknowledges a previous command with the same message ID.
-  * No_reply indicates that no reply is needed for this command. This is
-    commonly used when multiple commands are sent, and only the last needs
+  * The *Type* bits indicate the message type.
+
+    *  *Command* (value 0x0) indicates a command message.
+    *  *Reply* (value 0x1) indicates a reply message acknowledging a previous
+       command with the same message ID.
+  * *No_reply* in a command message indicates that no reply is needed for this command.
+    This is commonly used when multiple commands are sent, and only the last needs
     acknowledgement.
+  * *Error* in a reply message indicates the command being acknowledged had
+    an error. In this case, the *Errno* field will be valid.
 
-* *Error* is a UNIX errno value set only in the reply message. It is reserved in
-  the command message.
+* *Errno* in a reply message is a UNIX errno value. It is reserved in a command message.
 
-Each command message in Commands_ must be replied to with a reply message,
-which consists of the header with the reply bit set, plus any additional data.
+Each command message in Commands_ must be replied to with a reply message, unless the
+message sets the *No_Reply* bit.  The reply consists of the header with the *Reply*
+bit set, plus any additional data.
 
 VFIO_USER_VERSION
 -----------------
@@ -395,7 +389,7 @@ Message format
 +--------------+------------------------+
 | Flags        | Reply bit set in reply |
 +--------------+------------------------+
-| Error        | 0/errno                |
+| Errno        | 0/errno                |
 +--------------+------------------------+
 | Version      | JSON byte array        |
 +--------------+------------------------+
@@ -415,6 +409,8 @@ included:
 |              |        | be empty.                                         |
 +--------------+--------+---------------------------------------------------+
 
+.. _Version:
+
 Versioning and Feature Support
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Upon accepting a connection, the server must send a VFIO_USER_VERSION message
@@ -457,7 +453,7 @@ Message Format
 +--------------+------------------------+
 | Flags        | Reply bit set in reply |
 +--------------+------------------------+
-| Error        | 0/errno                |
+| Errno        | 0/errno                |
 +--------------+------------------------+
 | Table        | array of table entries |
 +--------------+------------------------+
@@ -543,14 +539,14 @@ Message format
 +--------------+----------------------------+
 | Flags        | Reply bit set in reply     |
 +--------------+----------------------------+
-| Error        | 0/errno                    |
+| Errno        | 0/errno                    |
 +--------------+----------------------------+
 | Device info  | VFIO device info           |
 +--------------+----------------------------+
 
 This command message is sent by the client to the server to query for basic
 information about the device. Only the message header is needed in the command
-message.  The VFIO device info structure is defined in ``<sys/vfio.h>``
+message.  The VFIO device info structure is defined in ``<linux/vfio.h>``
 (``struct vfio_device_info``).
 
 VFIO device info format
@@ -576,8 +572,7 @@ VFIO device info format
 | num_irqs    | 28     | 4                        |
 +-------------+--------+--------------------------+
 
-* *argz* is reserved in vfio-user, it is only used in the ioctl() VFIO
-  implementation.
+* *argsz* is the size of the VFIO device info structure.
 * *flags* contains the following device attributes.
 
   * VFIO_DEVICE_FLAGS_RESET indicates that the device supports the
@@ -607,14 +602,14 @@ Message format
 +--------------+------------------------+
 | Flags        | Reply bit set in reply |
 +--------------+------------------------+
-| Error        | 0/errno                |
+| Errno        | 0/errno                |
 +--------------+------------------------+
 | Region info  | VFIO region info       |
 +--------------+------------------------+
 
 This command message is sent by the client to the server to query for
 information about device memory regions. The VFIO region info structure is
-defined in ``<sys/vfio.h>`` (``struct vfio_region_info``). Since the client
+defined in ``<linux/vfio.h>`` (``struct vfio_region_info``). Since the client
 does not know the size of the capabilities, the size of the reply it should
 expect is 48 plus any capabilities whose size is indicated in the size field of
 the reply header.
@@ -650,8 +645,8 @@ VFIO region info format
 | offset     | 40     | 8                            |
 +------------+--------+------------------------------+
 
-* *argz* is reserved in vfio-user, it is only used in the ioctl() VFIO
-  implementation.
+* *argsz* is the size of the VFIO region info structure plus the
+  size of any region capabilities returned.
 * *flags* are attributes of the region:
 
   * *VFIO_REGION_INFO_FLAG_READ* allows client read access to the region.
@@ -668,7 +663,7 @@ VFIO region info format
 * *cap_offset* describes where additional region capabilities can be found.
   cap_offset is relative to the beginning of the VFIO region info structure.
   The data structure it points is a VFIO cap header defined in
-  ``<sys/vfio.h>``.
+  ``<linux/vfio.h>``.
 * *size* is the size of the region.
 * *offset* is the offset given to the mmap() system call for regions with the
   MMAP attribute. It is also used as the base offset when mapping a VFIO
@@ -679,7 +674,7 @@ VFIO Region capabilities
 The VFIO region information can also include a capabilities list. This list is
 similar to a PCI capability list - each entry has a common header that
 identifies a capability and where the next capability in the list can be found.
-The VFIO capability header format is defined in ``<sys/vfio.h>`` (``struct
+The VFIO capability header format is defined in ``<linux/vfio.h>`` (``struct
 vfio_info_cap_header``).
 
 VFIO cap header format
@@ -718,7 +713,7 @@ VFIO sparse mmap
 The only capability supported in this version of the protocol is for sparse
 mmap. This capability is defined when only a subrange of the region supports
 direct access by the client via mmap(). The VFIO sparse mmap area is defined in
-``<sys/vfio.h>`` (``struct vfio_region_sparse_mmap_area``).
+``<linux/vfio.h>`` (``struct vfio_region_sparse_mmap_area``).
 
 VFIO region info cap sparse mmap
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -742,7 +737,7 @@ VFIO region info cap sparse mmap
   the base offset given in the VFIO_USER_DEVICE_GET_REGION_INFO to form the
   offset argument of the subsequent mmap() call.
 
-The VFIO sparse mmap area is defined in ``<sys/vfio.h>`` (``struct
+The VFIO sparse mmap area is defined in ``<linux/vfio.h>`` (``struct
 vfio_region_info_cap_sparse_mmap``).
 
 VFIO_USER_DEVICE_GET_IRQ_INFO
@@ -762,14 +757,14 @@ Message format
 +--------------+------------------------+
 | Flags        | Reply bit set in reply |
 +--------------+------------------------+
-| Error        | 0/errno                |
+| Errno        | 0/errno                |
 +--------------+------------------------+
 | IRQ info     | VFIO IRQ info          |
 +--------------+------------------------+
 
 This command message is sent by the client to the server to query for
 information about device interrupt types. The VFIO IRQ info structure is
-defined in ``<sys/vfio.h>`` (``struct vfio_irq_info``).
+defined in ``<linux/vfio.h>`` (``struct vfio_irq_info``).
 
 VFIO IRQ info format
 ^^^^^^^^^^^^^^^^^^^^
@@ -798,8 +793,7 @@ VFIO IRQ info format
 | count | 28     | 4                         |
 +-------+--------+---------------------------+
 
-* *argz* is reserved in vfio-user, it is only used in the ioctl() VFIO
-  implementation.
+* *argsz* is the size of the VFIO IRQ info structure.
 * *flags* defines IRQ attributes:
 
   * *VFIO_IRQ_INFO_EVENTFD* indicates the IRQ type can support server eventfd
@@ -834,17 +828,17 @@ Message format
 +--------------+------------------------+
 | Flags        | Reply bit set in reply |
 +--------------+------------------------+
-| Error        | 0/errno                |
+| Errno        | 0/errno                |
 +--------------+------------------------+
 | IRQ set      | VFIO IRQ set           |
 +--------------+------------------------+
 
 This command message is sent by the client to the server to set actions for
 device interrupt types. The VFIO IRQ set structure is defined in
-``<sys/vfio.h>`` (``struct vfio_irq_set``).
+``<linux/vfio.h>`` (``struct vfio_irq_set``).
 
-VFIO IRQ info format
-^^^^^^^^^^^^^^^^^^^^
+VFIO IRQ set format
+^^^^^^^^^^^^^^^^^^^
 
 +-------+--------+------------------------------+
 | Name  | Offset | Size                         |
@@ -878,8 +872,7 @@ VFIO IRQ info format
 | data  | 36     | variable                     |
 +-------+--------+------------------------------+
 
-* *argz* is reserved in vfio-user, it is only used in the ioctl() VFIO
-  implementation.
+* *argsz* is the size of the VFIO IRQ set structure, including any *data* field.
 * *flags* defines the action performed on the interrupt range. The DATA flags
   describe the data field sent in the message; the ACTION flags describe the
   action to be performed. The flags are mutually exclusive for both sets.
@@ -909,7 +902,8 @@ VFIO IRQ info format
 * *start* is the start of the sub-index being set.
 * *count* describes the number of sub-indexes being set. As a special case, a
   count of 0 with data flags of VFIO_IRQ_SET_DATA_NONE disables all interrupts
-  of the index data is an optional field included when the
+  of the index.
+* *data* is an optional field included when the
   VFIO_IRQ_SET_DATA_BOOL flag is present. It contains an array of booleans
   that specify whether the action is to be performed on the corresponding
   index. It's used when the action is only performed on a subset of the range
@@ -975,8 +969,6 @@ DMA Read/Write Data
 * *Count* is the size of the data to be transferred.
 * *Data* is the data to be read or written.
 
-Address and count can also be accessed as ``struct iovec`` from ``<sys/uio.h>``.
-
 VFIO_USER_REGION_READ
 ---------------------
 
@@ -994,7 +986,7 @@ Message format
 +--------------+------------------------+
 | Flags        | Reply bit set in reply |
 +--------------+------------------------+
-| Error        | 0/errno                |
+| Errno        | 0/errno                |
 +--------------+------------------------+
 | Read info    | REGION read/write data |
 +--------------+------------------------+
@@ -1021,7 +1013,7 @@ Message format
 +--------------+------------------------+
 | Flags        | Reply bit set in reply |
 +--------------+------------------------+
-| Error        | 0/errno                |
+| Errno        | 0/errno                |
 +--------------+------------------------+
 | Write info   | REGION read/write data |
 +--------------+------------------------+
@@ -1048,7 +1040,7 @@ Message format
 +--------------+------------------------+
 | Flags        | Reply bit set in reply |
 +--------------+------------------------+
-| Error        | 0/errno                |
+| Errno        | 0/errno                |
 +--------------+------------------------+
 | DMA info     | DMA read/write data    |
 +--------------+------------------------+
@@ -1075,7 +1067,7 @@ Message format
 +--------------+------------------------+
 | Flags        | Reply bit set in reply |
 +--------------+------------------------+
-| Error        | 0/errno                |
+| Errno        | 0/errno                |
 +--------------+------------------------+
 | DMA info     | DMA read/write data    |
 +--------------+------------------------+
@@ -1102,7 +1094,7 @@ Message format
 +----------------+------------------------+
 | Flags          | Reply bit set in reply |
 +----------------+------------------------+
-| Error          | 0/errno                |
+| Errno          | 0/errno                |
 +----------------+------------------------+
 | Interrupt info | <interrupt>            |
 +----------------+------------------------+
@@ -1143,7 +1135,7 @@ Message format
 +--------------+------------------------+
 | Flags        | Reply bit set in reply |
 +--------------+------------------------+
-| Error        | 0/errno                |
+| Errno        | 0/errno                |
 +--------------+------------------------+
 
 This command message is sent from the client to the server to reset the device.

--Apple-Mail=_0078527D-57B0-458F-941A-A3B6210ACFA0
Content-Disposition: attachment;
	filename=vfio-user.rst
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="vfio-user.rst"
Content-Transfer-Encoding: 7bit

********************************
vfio-user Protocol Specification
********************************

------------
Version_ 0.1
------------

.. contents:: Table of Contents

Introduction
============
vfio-user is a protocol that allows a device to be emulated in a separate
process outside of a Virtual Machine Monitor (VMM). vfio-user devices consist
of a generic VFIO device type, living inside the VMM, which we call the client,
and the core device implementation, living outside the VMM, which we call the
server.

The `Linux VFIO ioctl interface <https://www.kernel.org/doc/html/latest/driver-api/vfio.html>`_
been chosen as the base for this protocol for the following reasons:

1) It is a mature and stable API, backed by an extensively used framework.
2) The existing VFIO client implementation in QEMU (qemu/hw/vfio/) can be
   largely reused.

.. Note::
   In a proof of concept implementation it has been demonstrated that using VFIO
   over a UNIX domain socket is a viable option. vfio-user is designed with
   QEMU in mind, however it could be used by other client applications. The
   vfio-user protocol does not require that QEMU's VFIO client  implementation
   is used in QEMU.

None of the VFIO kernel modules are required for supporting the protocol,
neither in the client nor the server, only the source header files are used.

The main idea is to allow a virtual device to function in a separate process in
the same host over a UNIX domain socket. A UNIX domain socket (AF_UNIX) is
chosen because file descriptors can be trivially sent over it, which in turn
allows:

* Sharing of client memory for DMA with the server.
* Sharing of server memory with the client for fast MMIO.
* Efficient sharing of eventfd's for triggering interrupts.

Other socket types could be used which allow the server to run in a separate
guest in the same host (AF_VSOCK) or remotely (AF_INET). Theoretically the
underlying transport does not necessarily have to be a socket, however we do
not examine such alternatives. In this protocol version we focus on using a
UNIX domain socket and introduce basic support for the other two types of
sockets without considering performance implications.

While passing of file descriptors is desirable for performance reasons, it is
not necessary neither for the client nor for the server to support it in order
to implement the protocol. There is always an in-band, message-passing fall
back mechanism.

VFIO
====
VFIO is a framework that allows a physical device to be securely passed through
to a user space process; the device-specific kernel driver does not drive the
device at all.  Typically, the user space process is a VMM and the device is
passed through to it in order to achieve high performance. VFIO provides an API
and the required functionality in the kernel. QEMU has adopted VFIO to allow a
guest to directly access physical devices, instead of emulating them in
software.

vfio-user reuses the core VFIO concepts defined in its API, but implements them
as messages to be sent over a socket. It does not change the kernel-based VFIO
in any way, in fact none of the VFIO kernel modules need to be loaded to use
vfio-user. It is also possible for the client to concurrently use the current
kernel-based VFIO for one device, and vfio-user for another device.

VFIO Device Model
-----------------
A device under VFIO presents a standard interface to the user process. Many of
the VFIO operations in the existing interface use the ioctl() system call, and
references to the existing interface are called the ioctl() implementation in
this document.

The following sections describe the set of messages that implement the VFIO
interface over a socket. In many cases, the messages are direct translations of
data structures used in the ioctl() implementation. Messages derived from
ioctl()s will have a name derived from the ioctl() command name.  E.g., the
VFIO_GET_INFO ioctl() command becomes a VFIO_USER_GET_INFO message.  The
purpose of this reuse is to share as much code as feasible with the ioctl()
implementation.

Connection Initiation
^^^^^^^^^^^^^^^^^^^^^
After the client connects to the server, the initial server message is
VFIO_USER_VERSION to propose a protocol version and set of capabilities to
apply to the session. The client replies with a compatible version and set of
capabilities it supports, or closes the connection if it cannot support the
advertised version.

DMA Memory Configuration
^^^^^^^^^^^^^^^^^^^^^^^^
The client uses VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP messages to inform
the server of the valid DMA ranges that the server can access on behalf
of a device. DMA memory may be accessed by the server via VFIO_USER_DMA_READ
and VFIO_USER_DMA_WRITE messages over the socket.

An optimization for server access to client memory is for the client to provide
file descriptors the server can mmap() to directly access client memory. Note
that mmap() privileges cannot be revoked by the client, therefore file
descriptors should only be exported in environments where the client trusts the
server not to corrupt guest memory.

Device Information
^^^^^^^^^^^^^^^^^^
The client uses a VFIO_USER_DEVICE_GET_INFO message to query the server for
information about the device. This information includes:

* The device type and capabilities,
* the number of device regions, and
* the device presents to the client the number of interrupt types the device
  supports.

Region Information
^^^^^^^^^^^^^^^^^^
The client uses VFIO_USER_DEVICE_GET_REGION_INFO messages to query the server
for information about the device's memory regions. This information describes:

* Read and write permissions, whether it can be memory mapped, and whether it
  supports additional capabilities.
* Region index, size, and offset.

When a region can be mapped by the client, the server provides a file
descriptor which the client can mmap(). The server is responsible for polling
for client updates to memory mapped regions.

Region Capabilities
"""""""""""""""""""
Some regions have additional capabilities that cannot be described adequately
by the region info data structure. These capabilities are returned in the
region info reply in a list similar to PCI capabilities in a PCI device's
configuration space.

Sparse Regions
""""""""""""""
A region can be memory-mappable in whole or in part. When only a subset of a
region can be mapped by the client, a VFIO_REGION_INFO_CAP_SPARSE_MMAP
capability is included in the region info reply. This capability describes
which portions can be mapped by the client.

.. Note::
   For example, in a virtual NVMe controller, sparse regions can be used so
   that accesses to the NVMe registers (found in the beginning of BAR0) are
   trapped (an infrequent event), while allowing direct access to the doorbells
   (an extremely frequent event as every I/O submission requires a write to
   BAR0), found right after the NVMe registers in BAR0.

Interrupts
^^^^^^^^^^
The client uses VFIO_USER_DEVICE_GET_IRQ_INFO messages to query the server for
the device's interrupt types. The interrupt types are specific to the bus the
device is attached to, and the client is expected to know the capabilities of
each interrupt type. The server can signal an interrupt either with
VFIO_USER_VM_INTERRUPT messages over the socket, or can directly inject
interrupts into the guest via an event file descriptor. The client configures
how the server signals an interrupt with VFIO_USER_SET_IRQS messages.

Device Read and Write
^^^^^^^^^^^^^^^^^^^^^
When the guest executes load or store operations to device memory, the client
forwards these operations to the server with VFIO_USER_REGION_READ or
VFIO_USER_REGION_WRITE messages. The server will reply with data from the
device on read operations or an acknowledgement on write operations.

DMA
^^^
When a device performs DMA accesses to guest memory, the server will forward
them to the client with VFIO_USER_DMA_READ and VFIO_USER_DMA_WRITE messages.
These messages can only be used to access guest memory the client has
configured into the server.

Protocol Specification
======================
To distinguish from the base VFIO symbols, all vfio-user symbols are prefixed
with vfio_user or VFIO_USER. In revision 0.1, all data is in the little-endian
format, although this may be relaxed in future revision in cases where the
client and server are both big-endian. The messages are formatted for seamless
reuse of the native VFIO structs.

Socket
------

A server can serve:

1) one or more clients, and/or
2) one or more virtual devices, belonging to one or more clients.

The current protocol specification requires a dedicated socket per
client/server connection. It is a server-side implementation detail whether a
single server handles multiple virtual devices from the same or multiple
clients. The location of the socket is implementation-specific. Multiplexing
clients, devices, and servers over the same socket is not supported in this
version of the protocol.

Authentication
--------------
For AF_UNIX, we rely on OS mandatory access controls on the socket files,
therefore it is up to the management layer to set up the socket as required.
Socket types than span guests or hosts will require a proper authentication
mechanism. Defining that mechanism is deferred to a future version of the
protocol.

Command Concurrency
-------------------
A client may pipeline multiple commands without waiting for previous command
replies.  The server will process commands in the order they are received.
A consequence of this is if a client issues a command with the *No_reply* bit,
then subseqently issues a command without *No_reply*, the older command will
have been processed before the reply to the younger command is sent by the
server.  The client must be aware of the device's capability to process concurrent
commands if pipelining is used.  For example, pipelining allows multiple client
threads to concurently access device memory; the client must ensure these acceses
obey device semantics.

An example is a frame buffer device, where the device may allow concurrent access
to different areas of video memory, but may have indeterminate behavior if concurrent
acceses are performed to command or status registers.

Socket Disconnection Behavior
-----------------------------
The server and the client can disconnect from each other, either intentionally
or unexpectedly. Both the client and the server need to know how to handle such
events.

Server Disconnection
^^^^^^^^^^^^^^^^^^^^
A server disconnecting from the client may indicate that:

1) A virtual device has been restarted, either intentionally (e.g. because of a
   device update) or unintentionally (e.g. because of a crash).
2) A virtual device has been shut down with no intention to be restarted.

It is impossible for the client to know whether or not a failure is
intermittent or innocuous and should be retried, therefore the client should
reset the VFIO device when it detects the socket has been disconnected.
Error recovery will be driven by the guest's device error handling
behavior.

Client Disconnection
^^^^^^^^^^^^^^^^^^^^
The client disconnecting from the server primarily means that the client
has exited. Currently, this means that the guest is shut down so the device is
no longer needed therefore the server can automatically exit. However, there
can be cases where a client disconnection should not result in a server exit:

1) A single server serving multiple clients.
2) A multi-process QEMU upgrading itself step by step, which is not yet
   implemented.

Therefore in order for the protocol to be forward compatible the server should
take no action when the client disconnects. If anything happens to the client
the control stack will know about it and can clean up resources
accordingly.

Live Migration
^^^^^^^^^^^^^^
A future version of the protocol will support client live migration.  This action
will require the socket to be quiesced before it is disconnected,  This mechanism
will be defined when live migration support is added.

Request Retry and Response Timeout
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A failed command is a command that has been successfully sent and has been
responded to with an error code. Failure to send the command in the first place
(e.g. because the socket is disconnected) is a different type of error examined
earlier in the disconnect section.

.. Note::
   QEMU's VFIO retries certain operations if they fail. While this makes sense
   for real HW, we don't know for sure whether it makes sense for virtual
   devices.

Defining a retry and timeout scheme is deferred to a future version of the
protocol.

.. _Commands:

Commands
--------
The following table lists the VFIO message command IDs, and whether the
message command is sent from the client or the server.

+----------------------------------+---------+-------------------+
| Name                             | Command | Request Direction |
+==================================+=========+===================+
| VFIO_USER_VERSION                | 1       | server -> client  |
+----------------------------------+---------+-------------------+
| VFIO_USER_DMA_MAP                | 2       | client -> server  |
+----------------------------------+---------+-------------------+
| VFIO_USER_DMA_UNMAP              | 3       | client -> server  |
+----------------------------------+---------+-------------------+
| VFIO_USER_DEVICE_GET_INFO        | 4       | client -> server  |
+----------------------------------+---------+-------------------+
| VFIO_USER_DEVICE_GET_REGION_INFO | 5       | client -> server  |
+----------------------------------+---------+-------------------+
| VFIO_USER_DEVICE_GET_IRQ_INFO    | 6       | client -> server  |
+----------------------------------+---------+-------------------+
| VFIO_USER_DEVICE_SET_IRQS        | 7       | client -> server  |
+----------------------------------+---------+-------------------+
| VFIO_USER_REGION_READ            | 8       | client -> server  |
+----------------------------------+---------+-------------------+
| VFIO_USER_REGION_WRITE           | 9       | client -> server  |
+----------------------------------+---------+-------------------+
| VFIO_USER_DMA_READ               | 10      | server -> client  |
+----------------------------------+---------+-------------------+
| VFIO_USER_DMA_WRITE              | 11      | server -> client  |
+----------------------------------+---------+-------------------+
| VFIO_USER_VM_INTERRUPT           | 12      | server -> client  |
+----------------------------------+---------+-------------------+
| VFIO_USER_DEVICE_RESET           | 13      | client -> server  |
+----------------------------------+---------+-------------------+

.. Note:: Some VFIO defines cannot be reused since their values are
   architecture-specific (e.g. VFIO_IOMMU_MAP_DMA).

Header
------
All messages, both command messages and reply messages, are preceded by a
header that contains basic information about the message. The header is
followed by message-specific data described in the sections below.

+----------------+---------+-------------+
| Name           | Offset  | Size        |
+================+=========+=============+
| Message ID     | 0       | 2           |
+----------------+---------+-------------+
| Command        | 2       | 2           |
+----------------+---------+-------------+
| Message size   | 4       | 4           |
+----------------+---------+-------------+
| Flags          | 8       | 4           |
+----------------+---------+-------------+
|                | +------+------------+ |
|                | | Bit  | Definition | |
|                | +======+============+ |
|                | | 0-3  | Type       | |
|                | +------+------------+ |
|                | | 4    | No_reply   | |
|                | +------+------------+ |
|                | | 5    | Error      | |
|                | +------+------------+ |
+----------------+---------+-------------+
| Errno          | 12      | 4           |
+----------------+---------+-------------+
| <message data> | 16      | variable    |
+----------------+---------+-------------+

* *Message ID* identifies the message, and is echoed in the command's reply message.
* *Command* specifies the command to be executed, listed in Commands_.
* *Message size* contains the size of the entire message, including the header.
* *Flags* contains attributes of the message:

  * The *Type* bits indicate the message type.

    *  *Command* (value 0x0) indicates a command message.
    *  *Reply* (value 0x1) indicates a reply message acknowledging a previous
       command with the same message ID.
  * *No_reply* in a command message indicates that no reply is needed for this command.
    This is commonly used when multiple commands are sent, and only the last needs
    acknowledgement.
  * *Error* in a reply message indicates the command being acknowledged had
    an error. In this case, the *Errno* field will be valid.

* *Errno* in a reply message is a UNIX errno value. It is reserved in a command message.

Each command message in Commands_ must be replied to with a reply message, unless the
message sets the *No_Reply* bit.  The reply consists of the header with the *Reply*
bit set, plus any additional data.

VFIO_USER_VERSION
-----------------

Message format
^^^^^^^^^^^^^^

+--------------+------------------------+
| Name         | Value                  |
+==============+========================+
| Message ID   | <ID>                   |
+--------------+------------------------+
| Command      | 1                      |
+--------------+------------------------+
| Message size | 16 + version length    |
+--------------+------------------------+
| Flags        | Reply bit set in reply |
+--------------+------------------------+
| Errno        | 0/errno                |
+--------------+------------------------+
| Version      | JSON byte array        |
+--------------+------------------------+

This is the initial message sent by the server after the socket connection is
established. The version is in JSON format, and the following objects must be
included:

+--------------+--------+---------------------------------------------------+
| Name         | Type   | Description                                       |
+==============+========+===================================================+
| version      | object | ``{"major": <number>, "minor": <number>}``        |
|              |        |                                                   |
|              |        | Version supported by the sender, e.g. "0.1".      |
+--------------+--------+---------------------------------------------------+
| capabilities | array  | Reserved. Can be omitted for v0.1, otherwise must |
|              |        | be empty.                                         |
+--------------+--------+---------------------------------------------------+

.. _Version:

Versioning and Feature Support
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Upon accepting a connection, the server must send a VFIO_USER_VERSION message
proposing a protocol version and a set of capabilities. The client compares
these with the versions and capabilities it supports and sends a
VFIO_USER_VERSION reply according to the following rules.

* The major version in the reply must be the same as proposed. If the client
  does not support the proposed major, it closes the connection.
* The minor version in the reply must be equal to or less than the minor
  version proposed.
* The capability list must be a subset of those proposed. If the client
  requires a capability the server did not include, it closes the connection.

The protocol major version will only change when incompatible protocol changes
are made, such as changing the message format. The minor version may change
when compatible changes are made, such as adding new messages or capabilities,
Both the client and server must support all minor versions less than the
maximum minor version it supports. E.g., an implementation that supports
version 1.3 must also support 1.0 through 1.2.

When making a change to this specification, the protocol version number must
be included in the form "added in version X.Y"


VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP
-----------------------------------------

Message Format
^^^^^^^^^^^^^^

+--------------+------------------------+
| Name         | Value                  |
+==============+========================+
| Message ID   | <ID>                   |
+--------------+------------------------+
| Command      | MAP=2, UNMAP=3         |
+--------------+------------------------+
| Message size | 16 + table size        |
+--------------+------------------------+
| Flags        | Reply bit set in reply |
+--------------+------------------------+
| Errno        | 0/errno                |
+--------------+------------------------+
| Table        | array of table entries |
+--------------+------------------------+

This command message is sent by the client to the server to inform it of the
memory regions the server can access. It must be sent before the server can
perform any DMA to the client. It is normally sent directly after the version
handshake is completed, but may also occur when memory is added to or
subtracted from the client, or if the client uses a vIOMMU. If the client does
not expect the server to perform DMA then it does not need to send to the
server VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP commands. If the server does
not need to perform DMA the then it can ignore such commands but it must still
reply to them. The table is an array of the following structure.  This
structure is 32 bytes in size, so the message size is:
16 + (# of table entries * 32).

Table entry format
^^^^^^^^^^^^^^^^^^

+-------------+--------+-------------+
| Name        | Offset | Size        |
+=============+========+=============+
| Address     | 0      | 8           |
+-------------+--------+-------------+
| Size        | 8      | 8           |
+-------------+--------+-------------+
| Offset      | 16     | 8           |
+-------------+--------+-------------+
| Protections | 24     | 4           |
+-------------+--------+-------------+
| Flags       | 28     | 4           |
+-------------+--------+-------------+
|             | +-----+------------+ |
|             | | Bit | Definition | |
|             | +=====+============+ |
|             | | 0   | Mappable   | |
|             | +-----+------------+ |
+-------------+--------+-------------+

* *Address* is the base DMA address of the region.
* *Size* is the size of the region.
* *Offset* is the file offset of the region with respect to the associated file
  descriptor.
* *Protections* are the region's protection attributes as encoded in
  ``<sys/mman.h>``.
* *Flags* contain the following region attributes:

  * *Mappable* indicates that the region can be mapped via the mmap() system call
    using the file descriptor provided in the message meta-data.

VFIO_USER_DMA_MAP
"""""""""""""""""
If a DMA region being added can be directly mapped by the server, an array of
file descriptors must be sent as part of the message meta-data. Each region
entry must have a corresponding file descriptor. On AF_UNIX sockets, the file
descriptors must be passed as SCM_RIGHTS type ancillary data. Otherwise, if a
DMA region cannot be directly mapped by the server, it can be accessed by the
server using VFIO_USER_DMA_READ and VFIO_USER_DMA_WRITE messages, explained in
`Read and Write Operations`_. A command to map over an existing region must be
failed by the server with ``EEXIST`` set in error field in the reply.

VFIO_USER_DMA_UNMAP
"""""""""""""""""""
Upon receiving a VFIO_USER_DMA_UNMAP command, if the file descriptor is mapped
then the server must release all references to that DMA region before replying,
which includes potentially in flight DMA transactions. Removing a portion of a
DMA region is possible. 

VFIO_USER_DEVICE_GET_INFO
-------------------------

Message format
^^^^^^^^^^^^^^

+--------------+----------------------------+
| Name         | Value                      |
+==============+============================+
| Message ID   | <ID>                       |
+--------------+----------------------------+
| Command      | 4                          |
+--------------+----------------------------+
| Message size | 16 in command, 32 in reply |
+--------------+----------------------------+
| Flags        | Reply bit set in reply     |
+--------------+----------------------------+
| Errno        | 0/errno                    |
+--------------+----------------------------+
| Device info  | VFIO device info           |
+--------------+----------------------------+

This command message is sent by the client to the server to query for basic
information about the device. Only the message header is needed in the command
message.  The VFIO device info structure is defined in ``<linux/vfio.h>``
(``struct vfio_device_info``).

VFIO device info format
^^^^^^^^^^^^^^^^^^^^^^^

+-------------+--------+--------------------------+
| Name        | Offset | Size                     |
+=============+========+==========================+
| argsz       | 16     | 4                        |
+-------------+--------+--------------------------+
| flags       | 20     | 4                        |
+-------------+--------+--------------------------+
|             | +-----+-------------------------+ |
|             | | Bit | Definition              | |
|             | +=====+=========================+ |
|             | | 0   | VFIO_DEVICE_FLAGS_RESET | |
|             | +-----+-------------------------+ |
|             | | 1   | VFIO_DEVICE_FLAGS_PCI   | |
|             | +-----+-------------------------+ |
+-------------+--------+--------------------------+
| num_regions | 24     | 4                        |
+-------------+--------+--------------------------+
| num_irqs    | 28     | 4                        |
+-------------+--------+--------------------------+

* *argsz* is the size of the VFIO device info structure.
* *flags* contains the following device attributes.

  * VFIO_DEVICE_FLAGS_RESET indicates that the device supports the
    VFIO_USER_DEVICE_RESET message.
  * VFIO_DEVICE_FLAGS_PCI indicates that the device is a PCI device.

* *num_regions* is the number of memory regions that the device exposes.
* *num_irqs* is the number of distinct interrupt types that the device supports.

This version of the protocol only supports PCI devices. Additional devices may
be supported in future versions.

VFIO_USER_DEVICE_GET_REGION_INFO
--------------------------------

Message format
^^^^^^^^^^^^^^

+--------------+------------------------+
| Name         | Value                  |
+==============+========================+
| Message ID   | <ID>                   |
+--------------+------------------------+
| Command      | 5                      |
+--------------+------------------------+
| Message size | 48 + any caps          |
+--------------+------------------------+
| Flags        | Reply bit set in reply |
+--------------+------------------------+
| Errno        | 0/errno                |
+--------------+------------------------+
| Region info  | VFIO region info       |
+--------------+------------------------+

This command message is sent by the client to the server to query for
information about device memory regions. The VFIO region info structure is
defined in ``<linux/vfio.h>`` (``struct vfio_region_info``). Since the client
does not know the size of the capabilities, the size of the reply it should
expect is 48 plus any capabilities whose size is indicated in the size field of
the reply header.

VFIO region info format
^^^^^^^^^^^^^^^^^^^^^^^

+------------+--------+------------------------------+
| Name       | Offset | Size                         |
+============+========+==============================+
| argsz      | 16     | 4                            |
+------------+--------+------------------------------+
| flags      | 20     | 4                            |
+------------+--------+------------------------------+
|            | +-----+-----------------------------+ |
|            | | Bit | Definition                  | |
|            | +=====+=============================+ |
|            | | 0   | VFIO_REGION_INFO_FLAG_READ  | |
|            | +-----+-----------------------------+ |
|            | | 1   | VFIO_REGION_INFO_FLAG_WRITE | |
|            | +-----+-----------------------------+ |
|            | | 2   | VFIO_REGION_INFO_FLAG_MMAP  | |
|            | +-----+-----------------------------+ |
|            | | 3   | VFIO_REGION_INFO_FLAG_CAPS  | |
|            | +-----+-----------------------------+ |
+------------+--------+------------------------------+
| index      | 24     | 4                            |
+------------+--------+------------------------------+
| cap_offset | 28     | 4                            |
+------------+--------+------------------------------+
| size       | 32     | 8                            |
+------------+--------+------------------------------+
| offset     | 40     | 8                            |
+------------+--------+------------------------------+

* *argsz* is the size of the VFIO region info structure plus the
  size of any region capabilities returned.
* *flags* are attributes of the region:

  * *VFIO_REGION_INFO_FLAG_READ* allows client read access to the region.
  * *VFIO_REGION_INFO_FLAG_WRITE* allows client write access to the region.
  * *VFIO_REGION_INFO_FLAG_MMAP* specifies the client can mmap() the region.
    When this flag is set, the reply will include a file descriptor in its
    meta-data. On AF_UNIX sockets, the file descriptors will be passed as
    SCM_RIGHTS type ancillary data.
  * *VFIO_REGION_INFO_FLAG_CAPS* indicates additional capabilities found in the
    reply.

* *index* is the index of memory region being queried, it is the only field
  that is required to be set in the command message.
* *cap_offset* describes where additional region capabilities can be found.
  cap_offset is relative to the beginning of the VFIO region info structure.
  The data structure it points is a VFIO cap header defined in
  ``<linux/vfio.h>``.
* *size* is the size of the region.
* *offset* is the offset given to the mmap() system call for regions with the
  MMAP attribute. It is also used as the base offset when mapping a VFIO
  sparse mmap area, described below.

VFIO Region capabilities
^^^^^^^^^^^^^^^^^^^^^^^^
The VFIO region information can also include a capabilities list. This list is
similar to a PCI capability list - each entry has a common header that
identifies a capability and where the next capability in the list can be found.
The VFIO capability header format is defined in ``<linux/vfio.h>`` (``struct
vfio_info_cap_header``).

VFIO cap header format
^^^^^^^^^^^^^^^^^^^^^^

+---------+--------+------+
| Name    | Offset | Size |
+=========+========+======+
| id      | 0      | 2    |
+---------+--------+------+
| version | 2      | 2    |
+---------+--------+------+
| next    | 4      | 4    |
+---------+--------+------+

* *id* is the capability identity.
* *version* is a capability-specific version number.
* *next* specifies the offset of the next capability in the capability list. It
  is relative to the beginning of the VFIO region info structure.

VFIO sparse mmap
^^^^^^^^^^^^^^^^

+------------------+----------------------------------+
| Name             | Value                            |
+==================+==================================+
| id               | VFIO_REGION_INFO_CAP_SPARSE_MMAP |
+------------------+----------------------------------+
| version          | 0x1                              |
+------------------+----------------------------------+
| next             | <next>                           |
+------------------+----------------------------------+
| sparse mmap info | VFIO region info sparse mmap     |
+------------------+----------------------------------+

The only capability supported in this version of the protocol is for sparse
mmap. This capability is defined when only a subrange of the region supports
direct access by the client via mmap(). The VFIO sparse mmap area is defined in
``<linux/vfio.h>`` (``struct vfio_region_sparse_mmap_area``).

VFIO region info cap sparse mmap
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+----------+--------+------+
| Name     | Offset | Size |
+==========+========+======+
| nr_areas | 0      | 4    |
+----------+--------+------+
| reserved | 4      | 4    |
+----------+--------+------+
| offset   | 8      | 8    |
+----------+--------+------+
| size     | 16     | 9    |
+----------+--------+------+
| ...      |        |      |
+----------+--------+------+

* *nr_areas* is the number of sparse mmap areas in the region.
* *offset* and size describe a single area that can be mapped by the client.
  There will be nr_areas pairs of offset and size. The offset will be added to
  the base offset given in the VFIO_USER_DEVICE_GET_REGION_INFO to form the
  offset argument of the subsequent mmap() call.

The VFIO sparse mmap area is defined in ``<linux/vfio.h>`` (``struct
vfio_region_info_cap_sparse_mmap``).

VFIO_USER_DEVICE_GET_IRQ_INFO
-----------------------------

Message format
^^^^^^^^^^^^^^

+--------------+------------------------+
| Name         | Value                  |
+==============+========================+
| Message ID   | <ID>                   |
+--------------+------------------------+
| Command      | 6                      |
+--------------+------------------------+
| Message size | 32                     |
+--------------+------------------------+
| Flags        | Reply bit set in reply |
+--------------+------------------------+
| Errno        | 0/errno                |
+--------------+------------------------+
| IRQ info     | VFIO IRQ info          |
+--------------+------------------------+

This command message is sent by the client to the server to query for
information about device interrupt types. The VFIO IRQ info structure is
defined in ``<linux/vfio.h>`` (``struct vfio_irq_info``).

VFIO IRQ info format
^^^^^^^^^^^^^^^^^^^^

+-------+--------+---------------------------+
| Name  | Offset | Size                      |
+=======+========+===========================+
| argsz | 16     | 4                         |
+-------+--------+---------------------------+
| flags | 20     | 4                         |
+-------+--------+---------------------------+
|       | +-----+--------------------------+ |
|       | | Bit | Definition               | |
|       | +=====+==========================+ |
|       | | 0   | VFIO_IRQ_INFO_EVENTFD    | |
|       | +-----+--------------------------+ |
|       | | 1   | VFIO_IRQ_INFO_MASKABLE   | |
|       | +-----+--------------------------+ |
|       | | 2   | VFIO_IRQ_INFO_AUTOMASKED | |
|       | +-----+--------------------------+ |
|       | | 3   | VFIO_IRQ_INFO_NORESIZE   | |
|       | +-----+--------------------------+ |
+-------+--------+---------------------------+
| index | 24     | 4                         |
+-------+--------+---------------------------+
| count | 28     | 4                         |
+-------+--------+---------------------------+

* *argsz* is the size of the VFIO IRQ info structure.
* *flags* defines IRQ attributes:

  * *VFIO_IRQ_INFO_EVENTFD* indicates the IRQ type can support server eventfd
    signalling.
  * *VFIO_IRQ_INFO_MASKABLE* indicates that the IRQ type supports the MASK and
    UNMASK actions in a VFIO_USER_DEVICE_SET_IRQS message.
  * *VFIO_IRQ_INFO_AUTOMASKED* indicates the IRQ type masks itself after being
    triggered, and the client must send an UNMASK action to receive new
    interrupts.
  * *VFIO_IRQ_INFO_NORESIZE* indicates VFIO_USER_SET_IRQS operations setup
    interrupts as a set, and new sub-indexes cannot be enabled without disabling
    the entire type.

* index is the index of IRQ type being queried, it is the only field that is
  required to be set in the command message.
* count describes the number of interrupts of the queried type.

VFIO_USER_DEVICE_SET_IRQS
-------------------------

Message format
^^^^^^^^^^^^^^

+--------------+------------------------+
| Name         | Value                  |
+==============+========================+
| Message ID   | <ID>                   |
+--------------+------------------------+
| Command      | 7                      |
+--------------+------------------------+
| Message size | 36 + any data          |
+--------------+------------------------+
| Flags        | Reply bit set in reply |
+--------------+------------------------+
| Errno        | 0/errno                |
+--------------+------------------------+
| IRQ set      | VFIO IRQ set           |
+--------------+------------------------+

This command message is sent by the client to the server to set actions for
device interrupt types. The VFIO IRQ set structure is defined in
``<linux/vfio.h>`` (``struct vfio_irq_set``).

VFIO IRQ set format
^^^^^^^^^^^^^^^^^^^

+-------+--------+------------------------------+
| Name  | Offset | Size                         |
+=======+========+==============================+
| argsz | 16     | 4                            |
+-------+--------+------------------------------+
| flags | 20     | 4                            |
+-------+--------+------------------------------+
|       | +-----+-----------------------------+ |
|       | | Bit | Definition                  | |
|       | +=====+=============================+ |
|       | | 0   | VFIO_IRQ_SET_DATA_NONE      | |
|       | +-----+-----------------------------+ |
|       | | 1   | VFIO_IRQ_SET_DATA_BOOL      | |
|       | +-----+-----------------------------+ |
|       | | 2   | VFIO_IRQ_SET_DATA_EVENTFD   | |
|       | +-----+-----------------------------+ |
|       | | 3   | VFIO_IRQ_SET_ACTION_MASK    | |
|       | +-----+-----------------------------+ |
|       | | 4   | VFIO_IRQ_SET_ACTION_UNMASK  | |
|       | +-----+-----------------------------+ |
|       | | 5   | VFIO_IRQ_SET_ACTION_TRIGGER | |
|       | +-----+-----------------------------+ |
+-------+--------+------------------------------+
| index | 24     | 4                            |
+-------+--------+------------------------------+
| start | 28     | 4                            |
+-------+--------+------------------------------+
| count | 32     | 4                            |
+-------+--------+------------------------------+
| data  | 36     | variable                     |
+-------+--------+------------------------------+

* *argsz* is the size of the VFIO IRQ set structure, including any *data* field.
* *flags* defines the action performed on the interrupt range. The DATA flags
  describe the data field sent in the message; the ACTION flags describe the
  action to be performed. The flags are mutually exclusive for both sets.

  * *VFIO_IRQ_SET_DATA_NONE* indicates there is no data field in the command.
    The action is performed unconditionally.
  * *VFIO_IRQ_SET_DATA_BOOL* indicates the data field is an array of boolean
    bytes. The action is performed if the corresponding boolean is true.
  * *VFIO_IRQ_SET_DATA_EVENTFD* indicates an array of event file descriptors
    was sent in the message meta-data. These descriptors will be signalled when
    the action defined by the action flags occurs. In AF_UNIX sockets, the
    descriptors are sent as SCM_RIGHTS type ancillary data.
  * *VFIO_IRQ_SET_ACTION_MASK* indicates a masking event. It can be used with
    VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE to mask an interrupt, or
    with VFIO_IRQ_SET_DATA_EVENTFD to generate an event when the guest masks
    the interrupt.
  * *VFIO_IRQ_SET_ACTION_UNMASK* indicates an unmasking event. It can be used
    with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE to unmask an
    interrupt, or with VFIO_IRQ_SET_DATA_EVENTFD to generate an event when the
    guest unmasks the interrupt.
  * *VFIO_IRQ_SET_ACTION_TRIGGER* indicates a triggering event. It can be used
    with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE to trigger an
    interrupt, or with VFIO_IRQ_SET_DATA_EVENTFD to generate an event when the
    server triggers the interrupt.

* *index* is the index of IRQ type being setup.
* *start* is the start of the sub-index being set.
* *count* describes the number of sub-indexes being set. As a special case, a
  count of 0 with data flags of VFIO_IRQ_SET_DATA_NONE disables all interrupts
  of the index.
* *data* is an optional field included when the
  VFIO_IRQ_SET_DATA_BOOL flag is present. It contains an array of booleans
  that specify whether the action is to be performed on the corresponding
  index. It's used when the action is only performed on a subset of the range
  specified.

Not all interrupt types support every combination of data and action flags.
The client must know the capabilities of the device and IRQ index before it
sends a VFIO_USER_DEVICE_SET_IRQ message.

.. _Read and Write Operations:

Read and Write Operations
-------------------------

Not all I/O operations between the client and server can be done via direct
access of memory mapped with an mmap() call. In these cases, the client and
server use messages sent over the socket. It is expected that these operations
will have lower performance than direct access.

The client can access server memory with VFIO_USER_REGION_READ and
VFIO_USER_REGION_WRITE commands. These share a common data structure that
appears after the message header.

REGION Read/Write Data
^^^^^^^^^^^^^^^^^^^^^^

+--------+--------+----------+
| Name   | Offset | Size     |
+========+========+==========+
| Offset | 16     | 8        |
+--------+--------+----------+
| Region | 24     | 4        |
+--------+--------+----------+
| Count  | 28     | 4        |
+--------+--------+----------+
| Data   | 32     | variable |
+--------+--------+----------+

* *Offset* into the region being accessed.
* *Region* is the index of the region being accessed.
* *Count* is the size of the data to be transferred.
* *Data* is the data to be read or written.

The server can access client memory with VFIO_USER_DMA_READ and
VFIO_USER_DMA_WRITE messages. These also share a common data structure that
appears after the message header.

DMA Read/Write Data
^^^^^^^^^^^^^^^^^^^

+---------+--------+----------+
| Name    | Offset | Size     |
+=========+========+==========+
| Address | 16     | 8        |
+---------+--------+----------+
| Count   | 24     | 4        |
+---------+--------+----------+
| Data    | 28     | variable |
+---------+--------+----------+

* *Address* is the area of client memory being accessed. This address must have
  been previously exported to the server with a VFIO_USER_DMA_MAP message.
* *Count* is the size of the data to be transferred.
* *Data* is the data to be read or written.

VFIO_USER_REGION_READ
---------------------

Message format
^^^^^^^^^^^^^^

+--------------+------------------------+
| Name         | Value                  |
+==============+========================+
| Message ID   | <ID>                   |
+--------------+------------------------+
| Command      | 8                      |
+--------------+------------------------+
| Message size | 32 + data size         |
+--------------+------------------------+
| Flags        | Reply bit set in reply |
+--------------+------------------------+
| Errno        | 0/errno                |
+--------------+------------------------+
| Read info    | REGION read/write data |
+--------------+------------------------+

This command message is sent from the client to the server to read from server
memory.  In the command messages, there is no data, and the count is the amount
of data to be read. The reply message must include the data read, and its count
field is the amount of data read.

VFIO_USER_REGION_WRITE
----------------------

Message format
^^^^^^^^^^^^^^

+--------------+------------------------+
| Name         | Value                  |
+==============+========================+
| Message ID   | <ID>                   |
+--------------+------------------------+
| Command      | 9                      |
+--------------+------------------------+
| Message size | 32 + data size         |
+--------------+------------------------+
| Flags        | Reply bit set in reply |
+--------------+------------------------+
| Errno        | 0/errno                |
+--------------+------------------------+
| Write info   | REGION read/write data |
+--------------+------------------------+

This command message is sent from the client to the server to write to server
memory.  The command message must contain the data to be written, and its count
field must contain the amount of write data. The count field in the reply
message must be zero.

VFIO_USER_DMA_READ
------------------

Message format
^^^^^^^^^^^^^^

+--------------+------------------------+
| Name         | Value                  |
+==============+========================+
| Message ID   | <ID>                   |
+--------------+------------------------+
| Command      | 10                     |
+--------------+------------------------+
| Message size | 28 + data size         |
+--------------+------------------------+
| Flags        | Reply bit set in reply |
+--------------+------------------------+
| Errno        | 0/errno                |
+--------------+------------------------+
| DMA info     | DMA read/write data    |
+--------------+------------------------+

This command message is sent from the server to the client to read from client
memory.  In the command message, there is no data, and the count must will be
the amount of data to be read. The reply message must include the data read,
and its count field must be the amount of data read.

VFIO_USER_DMA_WRITE
-------------------

Message format
^^^^^^^^^^^^^^

+--------------+------------------------+
| Name         | Value                  |
+==============+========================+
| Message ID   | <ID>                   |
+--------------+------------------------+
| Command      | 11                     |
+--------------+------------------------+
| Message size | 28 + data size         |
+--------------+------------------------+
| Flags        | Reply bit set in reply |
+--------------+------------------------+
| Errno        | 0/errno                |
+--------------+------------------------+
| DMA info     | DMA read/write data    |
+--------------+------------------------+

This command message is sent from the server to the client to write to server
memory.  The command message must contain the data to be written, and its count
field must contain the amount of write data. The count field in the reply
message must be zero.

VFIO_USER_VM_INTERRUPT
----------------------

Message format
^^^^^^^^^^^^^^

+----------------+------------------------+
| Name           | Value                  |
+================+========================+
| Message ID     | <ID>                   |
+----------------+------------------------+
| Command        | 12                     |
+----------------+------------------------+
| Message size   | 24                     |
+----------------+------------------------+
| Flags          | Reply bit set in reply |
+----------------+------------------------+
| Errno          | 0/errno                |
+----------------+------------------------+
| Interrupt info | <interrupt>            |
+----------------+------------------------+

This command message is sent from the server to the client to signal the device
has raised an interrupt.

Interrupt info format
^^^^^^^^^^^^^^^^^^^^^

+-----------+--------+------+
| Name      | Offset | Size |
+===========+========+======+
| Index     | 16     | 4    |
+-----------+--------+------+
| Sub-index | 20     | 4    |
+-----------+--------+------+

* *Index* is the interrupt index; it is the same value used in
  VFIO_USER_SET_IRQS.
* *Sub-index* is relative to the index, e.g., the vector number used in PCI
  MSI/X type interrupts.

VFIO_USER_DEVICE_RESET
----------------------

Message format
^^^^^^^^^^^^^^

+--------------+------------------------+
| Name         | Value                  |
+==============+========================+
| Message ID   | <ID>                   |
+--------------+------------------------+
| Command      | 13                     |
+--------------+------------------------+
| Message size | 16                     |
+--------------+------------------------+
| Flags        | Reply bit set in reply |
+--------------+------------------------+
| Errno        | 0/errno                |
+--------------+------------------------+

This command message is sent from the client to the server to reset the device.

Appendices
==========

Unused VFIO ioctl() commands
----------------------------

The following VFIO commands do not have an equivalent vfio-user command:

* VFIO_GET_API_VERSION
* VFIO_CHECK_EXTENSION
* VFIO_SET_IOMMU
* VFIO_GROUP_GET_STATUS
* VFIO_GROUP_SET_CONTAINER
* VFIO_GROUP_UNSET_CONTAINER
* VFIO_GROUP_GET_DEVICE_FD
* VFIO_IOMMU_GET_INFO

However, once support for live migration for VFIO devices is finalized some
of the above commands may have to be handled by the client in their
corresponding vfio-user form. This will be addressed in a future protocol
version.

Live Migration
--------------
Currently live migration is not supported for devices passed through via VFIO,
therefore it is not supported for vfio-user, either. This is being actively
worked on in the `Add migration support for VFIO devices (v25) 
<https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06463.html>`_
patch series.

VFIO groups and containers
^^^^^^^^^^^^^^^^^^^^^^^^^^

The current VFIO implementation includes group and container idioms that
describe how a device relates to the host IOMMU. In the vfio-user
implementation, the IOMMU is implemented in SW by the client, and is not
visible to the server. The simplest idea would be that the client put each
device into its own group and container.

Backend Program Conventions
---------------------------

vfio-user backend program conventions are based on the vhost-user ones.

* The backend program must not daemonize itself.
* No assumptions must be made as to what access the backend program has on the
  system.
* File descriptors 0, 1 and 2 must exist, must have regular
  stdin/stdout/stderr semantics, and can be redirected.
* The backend program must honor the SIGTERM signal.
* The backend program must accept the following commands line options:

  * ``--socket-path=PATH``: path to UNIX domain socket,
  * ``--fd=FDNUM``: file descriptor for UNIX domain socket, incompatible with
    ``--socket-path``
* The backend program must be accompanied with a JSON file stored under
  ``/usr/share/vfio-user``.

--Apple-Mail=_0078527D-57B0-458F-941A-A3B6210ACFA0
Content-Disposition: attachment;
	filename=vfio-user.html
Content-Type: text/html;
	x-unix-mode=0644;
	name="vfio-user.html"
Content-Transfer-Encoding: 7bit

<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="generator" content="Docutils 0.11: http://docutils.sourceforge.net/" />
<title>vfio-user Protocol Specification</title>
<style type="text/css">

/*
:Author: David Goodger (goodger@python.org)
:Id: $Id: html4css1.css 7614 2013-02-21 15:55:51Z milde $
:Copyright: This stylesheet has been placed in the public domain.

Default cascading style sheet for the HTML output of Docutils.

See http://docutils.sf.net/docs/howto/html-stylesheets.html for how to
customize this style sheet.
*/

/* used to remove borders from tables and images */
.borderless, table.borderless td, table.borderless th {
  border: 0 }

table.borderless td, table.borderless th {
  /* Override padding for "table.docutils td" with "! important".
     The right padding separates the table cells. */
  padding: 0 0.5em 0 0 ! important }

.first {
  /* Override more specific margin styles with "! important". */
  margin-top: 0 ! important }

.last, .with-subtitle {
  margin-bottom: 0 ! important }

.hidden {
  display: none }

a.toc-backref {
  text-decoration: none ;
  color: black }

blockquote.epigraph {
  margin: 2em 5em ; }

dl.docutils dd {
  margin-bottom: 0.5em }

object[type="image/svg+xml"], object[type="application/x-shockwave-flash"] {
  overflow: hidden;
}

/* Uncomment (and remove this text!) to get bold-faced definition list terms
dl.docutils dt {
  font-weight: bold }
*/

div.abstract {
  margin: 2em 5em }

div.abstract p.topic-title {
  font-weight: bold ;
  text-align: center }

div.admonition, div.attention, div.caution, div.danger, div.error,
div.hint, div.important, div.note, div.tip, div.warning {
  margin: 2em ;
  border: medium outset ;
  padding: 1em }

div.admonition p.admonition-title, div.hint p.admonition-title,
div.important p.admonition-title, div.note p.admonition-title,
div.tip p.admonition-title {
  font-weight: bold ;
  font-family: sans-serif }

div.attention p.admonition-title, div.caution p.admonition-title,
div.danger p.admonition-title, div.error p.admonition-title,
div.warning p.admonition-title, .code .error {
  color: red ;
  font-weight: bold ;
  font-family: sans-serif }

/* Uncomment (and remove this text!) to get reduced vertical space in
   compound paragraphs.
div.compound .compound-first, div.compound .compound-middle {
  margin-bottom: 0.5em }

div.compound .compound-last, div.compound .compound-middle {
  margin-top: 0.5em }
*/

div.dedication {
  margin: 2em 5em ;
  text-align: center ;
  font-style: italic }

div.dedication p.topic-title {
  font-weight: bold ;
  font-style: normal }

div.figure {
  margin-left: 2em ;
  margin-right: 2em }

div.footer, div.header {
  clear: both;
  font-size: smaller }

div.line-block {
  display: block ;
  margin-top: 1em ;
  margin-bottom: 1em }

div.line-block div.line-block {
  margin-top: 0 ;
  margin-bottom: 0 ;
  margin-left: 1.5em }

div.sidebar {
  margin: 0 0 0.5em 1em ;
  border: medium outset ;
  padding: 1em ;
  background-color: #ffffee ;
  width: 40% ;
  float: right ;
  clear: right }

div.sidebar p.rubric {
  font-family: sans-serif ;
  font-size: medium }

div.system-messages {
  margin: 5em }

div.system-messages h1 {
  color: red }

div.system-message {
  border: medium outset ;
  padding: 1em }

div.system-message p.system-message-title {
  color: red ;
  font-weight: bold }

div.topic {
  margin: 2em }

h1.section-subtitle, h2.section-subtitle, h3.section-subtitle,
h4.section-subtitle, h5.section-subtitle, h6.section-subtitle {
  margin-top: 0.4em }

h1.title {
  text-align: center }

h2.subtitle {
  text-align: center }

hr.docutils {
  width: 75% }

img.align-left, .figure.align-left, object.align-left {
  clear: left ;
  float: left ;
  margin-right: 1em }

img.align-right, .figure.align-right, object.align-right {
  clear: right ;
  float: right ;
  margin-left: 1em }

img.align-center, .figure.align-center, object.align-center {
  display: block;
  margin-left: auto;
  margin-right: auto;
}

.align-left {
  text-align: left }

.align-center {
  clear: both ;
  text-align: center }

.align-right {
  text-align: right }

/* reset inner alignment in figures */
div.align-right {
  text-align: inherit }

/* div.align-center * { */
/*   text-align: left } */

ol.simple, ul.simple {
  margin-bottom: 1em }

ol.arabic {
  list-style: decimal }

ol.loweralpha {
  list-style: lower-alpha }

ol.upperalpha {
  list-style: upper-alpha }

ol.lowerroman {
  list-style: lower-roman }

ol.upperroman {
  list-style: upper-roman }

p.attribution {
  text-align: right ;
  margin-left: 50% }

p.caption {
  font-style: italic }

p.credits {
  font-style: italic ;
  font-size: smaller }

p.label {
  white-space: nowrap }

p.rubric {
  font-weight: bold ;
  font-size: larger ;
  color: maroon ;
  text-align: center }

p.sidebar-title {
  font-family: sans-serif ;
  font-weight: bold ;
  font-size: larger }

p.sidebar-subtitle {
  font-family: sans-serif ;
  font-weight: bold }

p.topic-title {
  font-weight: bold }

pre.address {
  margin-bottom: 0 ;
  margin-top: 0 ;
  font: inherit }

pre.literal-block, pre.doctest-block, pre.math, pre.code {
  margin-left: 2em ;
  margin-right: 2em }

pre.code .ln { color: grey; } /* line numbers */
pre.code, code { background-color: #eeeeee }
pre.code .comment, code .comment { color: #5C6576 }
pre.code .keyword, code .keyword { color: #3B0D06; font-weight: bold }
pre.code .literal.string, code .literal.string { color: #0C5404 }
pre.code .name.builtin, code .name.builtin { color: #352B84 }
pre.code .deleted, code .deleted { background-color: #DEB0A1}
pre.code .inserted, code .inserted { background-color: #A3D289}

span.classifier {
  font-family: sans-serif ;
  font-style: oblique }

span.classifier-delimiter {
  font-family: sans-serif ;
  font-weight: bold }

span.interpreted {
  font-family: sans-serif }

span.option {
  white-space: nowrap }

span.pre {
  white-space: pre }

span.problematic {
  color: red }

span.section-subtitle {
  /* font-size relative to parent (h1..h6 element) */
  font-size: 80% }

table.citation {
  border-left: solid 1px gray;
  margin-left: 1px }

table.docinfo {
  margin: 2em 4em }

table.docutils {
  margin-top: 0.5em ;
  margin-bottom: 0.5em }

table.footnote {
  border-left: solid 1px black;
  margin-left: 1px }

table.docutils td, table.docutils th,
table.docinfo td, table.docinfo th {
  padding-left: 0.5em ;
  padding-right: 0.5em ;
  vertical-align: top }

table.docutils th.field-name, table.docinfo th.docinfo-name {
  font-weight: bold ;
  text-align: left ;
  white-space: nowrap ;
  padding-left: 0 }

/* "booktabs" style (no vertical lines) */
table.docutils.booktabs {
  border: 0px;
  border-top: 2px solid;
  border-bottom: 2px solid;
  border-collapse: collapse;
}
table.docutils.booktabs * {
  border: 0px;
}
table.docutils.booktabs th {
  border-bottom: thin solid;
  text-align: left;
}

h1 tt.docutils, h2 tt.docutils, h3 tt.docutils,
h4 tt.docutils, h5 tt.docutils, h6 tt.docutils {
  font-size: 100% }

ul.auto-toc {
  list-style-type: none }

</style>
</head>
<body>
<div class="document" id="vfio-user-protocol-specification">
<h1 class="title">vfio-user Protocol Specification</h1>
<h2 class="subtitle" id="version-0-1"><a class="reference internal" href="#version">Version</a> 0.1</h2>

<div class="contents topic" id="table-of-contents">
<p class="topic-title first">Table of Contents</p>
<ul class="simple">
<li><a class="reference internal" href="#introduction" id="id15">Introduction</a></li>
<li><a class="reference internal" href="#vfio" id="id16">VFIO</a><ul>
<li><a class="reference internal" href="#vfio-device-model" id="id17">VFIO Device Model</a><ul>
<li><a class="reference internal" href="#connection-initiation" id="id18">Connection Initiation</a></li>
<li><a class="reference internal" href="#dma-memory-configuration" id="id19">DMA Memory Configuration</a></li>
<li><a class="reference internal" href="#device-information" id="id20">Device Information</a></li>
<li><a class="reference internal" href="#region-information" id="id21">Region Information</a><ul>
<li><a class="reference internal" href="#region-capabilities" id="id22">Region Capabilities</a></li>
<li><a class="reference internal" href="#sparse-regions" id="id23">Sparse Regions</a></li>
</ul>
</li>
<li><a class="reference internal" href="#interrupts" id="id24">Interrupts</a></li>
<li><a class="reference internal" href="#device-read-and-write" id="id25">Device Read and Write</a></li>
<li><a class="reference internal" href="#dma" id="id26">DMA</a></li>
</ul>
</li>
</ul>
</li>
<li><a class="reference internal" href="#protocol-specification" id="id27">Protocol Specification</a><ul>
<li><a class="reference internal" href="#socket" id="id28">Socket</a></li>
<li><a class="reference internal" href="#authentication" id="id29">Authentication</a></li>
<li><a class="reference internal" href="#command-concurrency" id="id30">Command Concurrency</a></li>
<li><a class="reference internal" href="#socket-disconnection-behavior" id="id31">Socket Disconnection Behavior</a><ul>
<li><a class="reference internal" href="#server-disconnection" id="id32">Server Disconnection</a></li>
<li><a class="reference internal" href="#client-disconnection" id="id33">Client Disconnection</a></li>
<li><a class="reference internal" href="#live-migration" id="id34">Live Migration</a></li>
<li><a class="reference internal" href="#request-retry-and-response-timeout" id="id35">Request Retry and Response Timeout</a></li>
</ul>
</li>
<li><a class="reference internal" href="#id1" id="id36">Commands</a></li>
<li><a class="reference internal" href="#header" id="id37">Header</a></li>
<li><a class="reference internal" href="#vfio-user-version" id="id38">VFIO_USER_VERSION</a><ul>
<li><a class="reference internal" href="#message-format" id="id39">Message format</a></li>
<li><a class="reference internal" href="#versioning-and-feature-support" id="id40">Versioning and Feature Support</a></li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-dma-map-and-vfio-user-dma-unmap" id="id41">VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP</a><ul>
<li><a class="reference internal" href="#id2" id="id42">Message Format</a></li>
<li><a class="reference internal" href="#table-entry-format" id="id43">Table entry format</a><ul>
<li><a class="reference internal" href="#vfio-user-dma-map" id="id44">VFIO_USER_DMA_MAP</a></li>
<li><a class="reference internal" href="#vfio-user-dma-unmap" id="id45">VFIO_USER_DMA_UNMAP</a></li>
</ul>
</li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-device-get-info" id="id46">VFIO_USER_DEVICE_GET_INFO</a><ul>
<li><a class="reference internal" href="#id3" id="id47">Message format</a></li>
<li><a class="reference internal" href="#vfio-device-info-format" id="id48">VFIO device info format</a></li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-device-get-region-info" id="id49">VFIO_USER_DEVICE_GET_REGION_INFO</a><ul>
<li><a class="reference internal" href="#id4" id="id50">Message format</a></li>
<li><a class="reference internal" href="#vfio-region-info-format" id="id51">VFIO region info format</a></li>
<li><a class="reference internal" href="#vfio-region-capabilities" id="id52">VFIO Region capabilities</a></li>
<li><a class="reference internal" href="#vfio-cap-header-format" id="id53">VFIO cap header format</a></li>
<li><a class="reference internal" href="#vfio-sparse-mmap" id="id54">VFIO sparse mmap</a></li>
<li><a class="reference internal" href="#vfio-region-info-cap-sparse-mmap" id="id55">VFIO region info cap sparse mmap</a></li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-device-get-irq-info" id="id56">VFIO_USER_DEVICE_GET_IRQ_INFO</a><ul>
<li><a class="reference internal" href="#id5" id="id57">Message format</a></li>
<li><a class="reference internal" href="#vfio-irq-info-format" id="id58">VFIO IRQ info format</a></li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-device-set-irqs" id="id59">VFIO_USER_DEVICE_SET_IRQS</a><ul>
<li><a class="reference internal" href="#id6" id="id60">Message format</a></li>
<li><a class="reference internal" href="#vfio-irq-set-format" id="id61">VFIO IRQ set format</a></li>
</ul>
</li>
<li><a class="reference internal" href="#id7" id="id62">Read and Write Operations</a><ul>
<li><a class="reference internal" href="#region-read-write-data" id="id63">REGION Read/Write Data</a></li>
<li><a class="reference internal" href="#dma-read-write-data" id="id64">DMA Read/Write Data</a></li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-region-read" id="id65">VFIO_USER_REGION_READ</a><ul>
<li><a class="reference internal" href="#id8" id="id66">Message format</a></li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-region-write" id="id67">VFIO_USER_REGION_WRITE</a><ul>
<li><a class="reference internal" href="#id9" id="id68">Message format</a></li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-dma-read" id="id69">VFIO_USER_DMA_READ</a><ul>
<li><a class="reference internal" href="#id10" id="id70">Message format</a></li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-dma-write" id="id71">VFIO_USER_DMA_WRITE</a><ul>
<li><a class="reference internal" href="#id11" id="id72">Message format</a></li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-vm-interrupt" id="id73">VFIO_USER_VM_INTERRUPT</a><ul>
<li><a class="reference internal" href="#id12" id="id74">Message format</a></li>
<li><a class="reference internal" href="#interrupt-info-format" id="id75">Interrupt info format</a></li>
</ul>
</li>
<li><a class="reference internal" href="#vfio-user-device-reset" id="id76">VFIO_USER_DEVICE_RESET</a><ul>
<li><a class="reference internal" href="#id13" id="id77">Message format</a></li>
</ul>
</li>
</ul>
</li>
<li><a class="reference internal" href="#appendices" id="id78">Appendices</a><ul>
<li><a class="reference internal" href="#unused-vfio-ioctl-commands" id="id79">Unused VFIO ioctl() commands</a></li>
<li><a class="reference internal" href="#id14" id="id80">Live Migration</a><ul>
<li><a class="reference internal" href="#vfio-groups-and-containers" id="id81">VFIO groups and containers</a></li>
</ul>
</li>
<li><a class="reference internal" href="#backend-program-conventions" id="id82">Backend Program Conventions</a></li>
</ul>
</li>
</ul>
</div>
<div class="section" id="introduction">
<h1><a class="toc-backref" href="#id15">Introduction</a></h1>
<p>vfio-user is a protocol that allows a device to be emulated in a separate
process outside of a Virtual Machine Monitor (VMM). vfio-user devices consist
of a generic VFIO device type, living inside the VMM, which we call the client,
and the core device implementation, living outside the VMM, which we call the
server.</p>
<p>The <a class="reference external" href="https://www.kernel.org/doc/html/latest/driver-api/vfio.html">Linux VFIO ioctl interface</a>
been chosen as the base for this protocol for the following reasons:</p>
<ol class="arabic simple">
<li>It is a mature and stable API, backed by an extensively used framework.</li>
<li>The existing VFIO client implementation in QEMU (qemu/hw/vfio/) can be
largely reused.</li>
</ol>
<div class="note">
<p class="first admonition-title">Note</p>
<p class="last">In a proof of concept implementation it has been demonstrated that using VFIO
over a UNIX domain socket is a viable option. vfio-user is designed with
QEMU in mind, however it could be used by other client applications. The
vfio-user protocol does not require that QEMU's VFIO client  implementation
is used in QEMU.</p>
</div>
<p>None of the VFIO kernel modules are required for supporting the protocol,
neither in the client nor the server, only the source header files are used.</p>
<p>The main idea is to allow a virtual device to function in a separate process in
the same host over a UNIX domain socket. A UNIX domain socket (AF_UNIX) is
chosen because file descriptors can be trivially sent over it, which in turn
allows:</p>
<ul class="simple">
<li>Sharing of client memory for DMA with the server.</li>
<li>Sharing of server memory with the client for fast MMIO.</li>
<li>Efficient sharing of eventfd's for triggering interrupts.</li>
</ul>
<p>Other socket types could be used which allow the server to run in a separate
guest in the same host (AF_VSOCK) or remotely (AF_INET). Theoretically the
underlying transport does not necessarily have to be a socket, however we do
not examine such alternatives. In this protocol version we focus on using a
UNIX domain socket and introduce basic support for the other two types of
sockets without considering performance implications.</p>
<p>While passing of file descriptors is desirable for performance reasons, it is
not necessary neither for the client nor for the server to support it in order
to implement the protocol. There is always an in-band, message-passing fall
back mechanism.</p>
</div>
<div class="section" id="vfio">
<h1><a class="toc-backref" href="#id16">VFIO</a></h1>
<p>VFIO is a framework that allows a physical device to be securely passed through
to a user space process; the device-specific kernel driver does not drive the
device at all.  Typically, the user space process is a VMM and the device is
passed through to it in order to achieve high performance. VFIO provides an API
and the required functionality in the kernel. QEMU has adopted VFIO to allow a
guest to directly access physical devices, instead of emulating them in
software.</p>
<p>vfio-user reuses the core VFIO concepts defined in its API, but implements them
as messages to be sent over a socket. It does not change the kernel-based VFIO
in any way, in fact none of the VFIO kernel modules need to be loaded to use
vfio-user. It is also possible for the client to concurrently use the current
kernel-based VFIO for one device, and vfio-user for another device.</p>
<div class="section" id="vfio-device-model">
<h2><a class="toc-backref" href="#id17">VFIO Device Model</a></h2>
<p>A device under VFIO presents a standard interface to the user process. Many of
the VFIO operations in the existing interface use the ioctl() system call, and
references to the existing interface are called the ioctl() implementation in
this document.</p>
<p>The following sections describe the set of messages that implement the VFIO
interface over a socket. In many cases, the messages are direct translations of
data structures used in the ioctl() implementation. Messages derived from
ioctl()s will have a name derived from the ioctl() command name.  E.g., the
VFIO_GET_INFO ioctl() command becomes a VFIO_USER_GET_INFO message.  The
purpose of this reuse is to share as much code as feasible with the ioctl()
implementation.</p>
<div class="section" id="connection-initiation">
<h3><a class="toc-backref" href="#id18">Connection Initiation</a></h3>
<p>After the client connects to the server, the initial server message is
VFIO_USER_VERSION to propose a protocol version and set of capabilities to
apply to the session. The client replies with a compatible version and set of
capabilities it supports, or closes the connection if it cannot support the
advertised version.</p>
</div>
<div class="section" id="dma-memory-configuration">
<h3><a class="toc-backref" href="#id19">DMA Memory Configuration</a></h3>
<p>The client uses VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP messages to inform
the server of the valid DMA ranges that the server can access on behalf
of a device. DMA memory may be accessed by the server via VFIO_USER_DMA_READ
and VFIO_USER_DMA_WRITE messages over the socket.</p>
<p>An optimization for server access to client memory is for the client to provide
file descriptors the server can mmap() to directly access client memory. Note
that mmap() privileges cannot be revoked by the client, therefore file
descriptors should only be exported in environments where the client trusts the
server not to corrupt guest memory.</p>
</div>
<div class="section" id="device-information">
<h3><a class="toc-backref" href="#id20">Device Information</a></h3>
<p>The client uses a VFIO_USER_DEVICE_GET_INFO message to query the server for
information about the device. This information includes:</p>
<ul class="simple">
<li>The device type and capabilities,</li>
<li>the number of device regions, and</li>
<li>the device presents to the client the number of interrupt types the device
supports.</li>
</ul>
</div>
<div class="section" id="region-information">
<h3><a class="toc-backref" href="#id21">Region Information</a></h3>
<p>The client uses VFIO_USER_DEVICE_GET_REGION_INFO messages to query the server
for information about the device's memory regions. This information describes:</p>
<ul class="simple">
<li>Read and write permissions, whether it can be memory mapped, and whether it
supports additional capabilities.</li>
<li>Region index, size, and offset.</li>
</ul>
<p>When a region can be mapped by the client, the server provides a file
descriptor which the client can mmap(). The server is responsible for polling
for client updates to memory mapped regions.</p>
<div class="section" id="region-capabilities">
<h4><a class="toc-backref" href="#id22">Region Capabilities</a></h4>
<p>Some regions have additional capabilities that cannot be described adequately
by the region info data structure. These capabilities are returned in the
region info reply in a list similar to PCI capabilities in a PCI device's
configuration space.</p>
</div>
<div class="section" id="sparse-regions">
<h4><a class="toc-backref" href="#id23">Sparse Regions</a></h4>
<p>A region can be memory-mappable in whole or in part. When only a subset of a
region can be mapped by the client, a VFIO_REGION_INFO_CAP_SPARSE_MMAP
capability is included in the region info reply. This capability describes
which portions can be mapped by the client.</p>
<div class="note">
<p class="first admonition-title">Note</p>
<p class="last">For example, in a virtual NVMe controller, sparse regions can be used so
that accesses to the NVMe registers (found in the beginning of BAR0) are
trapped (an infrequent event), while allowing direct access to the doorbells
(an extremely frequent event as every I/O submission requires a write to
BAR0), found right after the NVMe registers in BAR0.</p>
</div>
</div>
</div>
<div class="section" id="interrupts">
<h3><a class="toc-backref" href="#id24">Interrupts</a></h3>
<p>The client uses VFIO_USER_DEVICE_GET_IRQ_INFO messages to query the server for
the device's interrupt types. The interrupt types are specific to the bus the
device is attached to, and the client is expected to know the capabilities of
each interrupt type. The server can signal an interrupt either with
VFIO_USER_VM_INTERRUPT messages over the socket, or can directly inject
interrupts into the guest via an event file descriptor. The client configures
how the server signals an interrupt with VFIO_USER_SET_IRQS messages.</p>
</div>
<div class="section" id="device-read-and-write">
<h3><a class="toc-backref" href="#id25">Device Read and Write</a></h3>
<p>When the guest executes load or store operations to device memory, the client
forwards these operations to the server with VFIO_USER_REGION_READ or
VFIO_USER_REGION_WRITE messages. The server will reply with data from the
device on read operations or an acknowledgement on write operations.</p>
</div>
<div class="section" id="dma">
<h3><a class="toc-backref" href="#id26">DMA</a></h3>
<p>When a device performs DMA accesses to guest memory, the server will forward
them to the client with VFIO_USER_DMA_READ and VFIO_USER_DMA_WRITE messages.
These messages can only be used to access guest memory the client has
configured into the server.</p>
</div>
</div>
</div>
<div class="section" id="protocol-specification">
<h1><a class="toc-backref" href="#id27">Protocol Specification</a></h1>
<p>To distinguish from the base VFIO symbols, all vfio-user symbols are prefixed
with vfio_user or VFIO_USER. In revision 0.1, all data is in the little-endian
format, although this may be relaxed in future revision in cases where the
client and server are both big-endian. The messages are formatted for seamless
reuse of the native VFIO structs.</p>
<div class="section" id="socket">
<h2><a class="toc-backref" href="#id28">Socket</a></h2>
<p>A server can serve:</p>
<ol class="arabic simple">
<li>one or more clients, and/or</li>
<li>one or more virtual devices, belonging to one or more clients.</li>
</ol>
<p>The current protocol specification requires a dedicated socket per
client/server connection. It is a server-side implementation detail whether a
single server handles multiple virtual devices from the same or multiple
clients. The location of the socket is implementation-specific. Multiplexing
clients, devices, and servers over the same socket is not supported in this
version of the protocol.</p>
</div>
<div class="section" id="authentication">
<h2><a class="toc-backref" href="#id29">Authentication</a></h2>
<p>For AF_UNIX, we rely on OS mandatory access controls on the socket files,
therefore it is up to the management layer to set up the socket as required.
Socket types than span guests or hosts will require a proper authentication
mechanism. Defining that mechanism is deferred to a future version of the
protocol.</p>
</div>
<div class="section" id="command-concurrency">
<h2><a class="toc-backref" href="#id30">Command Concurrency</a></h2>
<p>A client may pipeline multiple commands without waiting for previous command
replies.  The server will process commands in the order they are received.
A consequence of this is if a client issues a command with the <em>No_reply</em> bit,
then subseqently issues a command without <em>No_reply</em>, the older command will
have been processed before the reply to the younger command is sent by the
server.  The client must be aware of the device's capability to process concurrent
commands if pipelining is used.  For example, pipelining allows multiple client
threads to concurently access device memory; the client must ensure these acceses
obey device semantics.</p>
<p>An example is a frame buffer device, where the device may allow concurrent access
to different areas of video memory, but may have indeterminate behavior if concurrent
acceses are performed to command or status registers.</p>
</div>
<div class="section" id="socket-disconnection-behavior">
<h2><a class="toc-backref" href="#id31">Socket Disconnection Behavior</a></h2>
<p>The server and the client can disconnect from each other, either intentionally
or unexpectedly. Both the client and the server need to know how to handle such
events.</p>
<div class="section" id="server-disconnection">
<h3><a class="toc-backref" href="#id32">Server Disconnection</a></h3>
<p>A server disconnecting from the client may indicate that:</p>
<ol class="arabic simple">
<li>A virtual device has been restarted, either intentionally (e.g. because of a
device update) or unintentionally (e.g. because of a crash).</li>
<li>A virtual device has been shut down with no intention to be restarted.</li>
</ol>
<p>It is impossible for the client to know whether or not a failure is
intermittent or innocuous and should be retried, therefore the client should
reset the VFIO device when it detects the socket has been disconnected.
Error recovery will be driven by the guest's device error handling
behavior.</p>
</div>
<div class="section" id="client-disconnection">
<h3><a class="toc-backref" href="#id33">Client Disconnection</a></h3>
<p>The client disconnecting from the server primarily means that the client
has exited. Currently, this means that the guest is shut down so the device is
no longer needed therefore the server can automatically exit. However, there
can be cases where a client disconnection should not result in a server exit:</p>
<ol class="arabic simple">
<li>A single server serving multiple clients.</li>
<li>A multi-process QEMU upgrading itself step by step, which is not yet
implemented.</li>
</ol>
<p>Therefore in order for the protocol to be forward compatible the server should
take no action when the client disconnects. If anything happens to the client
the control stack will know about it and can clean up resources
accordingly.</p>
</div>
<div class="section" id="live-migration">
<h3><a class="toc-backref" href="#id34">Live Migration</a></h3>
<p>A future version of the protocol will support client live migration.  This action
will require the socket to be quiesced before it is disconnected,  This mechanism
will be defined when live migration support is added.</p>
</div>
<div class="section" id="request-retry-and-response-timeout">
<h3><a class="toc-backref" href="#id35">Request Retry and Response Timeout</a></h3>
<p>A failed command is a command that has been successfully sent and has been
responded to with an error code. Failure to send the command in the first place
(e.g. because the socket is disconnected) is a different type of error examined
earlier in the disconnect section.</p>
<div class="note">
<p class="first admonition-title">Note</p>
<p class="last">QEMU's VFIO retries certain operations if they fail. While this makes sense
for real HW, we don't know for sure whether it makes sense for virtual
devices.</p>
</div>
<p>Defining a retry and timeout scheme is deferred to a future version of the
protocol.</p>
</div>
</div>
<div class="section" id="id1">
<span id="commands"></span><h2><a class="toc-backref" href="#id36">Commands</a></h2>
<p>The following table lists the VFIO message command IDs, and whether the
message command is sent from the client or the server.</p>
<table border="1" class="docutils">
<colgroup>
<col width="55%" />
<col width="15%" />
<col width="31%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Command</th>
<th class="head">Request Direction</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>VFIO_USER_VERSION</td>
<td>1</td>
<td>server -&gt; client</td>
</tr>
<tr><td>VFIO_USER_DMA_MAP</td>
<td>2</td>
<td>client -&gt; server</td>
</tr>
<tr><td>VFIO_USER_DMA_UNMAP</td>
<td>3</td>
<td>client -&gt; server</td>
</tr>
<tr><td>VFIO_USER_DEVICE_GET_INFO</td>
<td>4</td>
<td>client -&gt; server</td>
</tr>
<tr><td>VFIO_USER_DEVICE_GET_REGION_INFO</td>
<td>5</td>
<td>client -&gt; server</td>
</tr>
<tr><td>VFIO_USER_DEVICE_GET_IRQ_INFO</td>
<td>6</td>
<td>client -&gt; server</td>
</tr>
<tr><td>VFIO_USER_DEVICE_SET_IRQS</td>
<td>7</td>
<td>client -&gt; server</td>
</tr>
<tr><td>VFIO_USER_REGION_READ</td>
<td>8</td>
<td>client -&gt; server</td>
</tr>
<tr><td>VFIO_USER_REGION_WRITE</td>
<td>9</td>
<td>client -&gt; server</td>
</tr>
<tr><td>VFIO_USER_DMA_READ</td>
<td>10</td>
<td>server -&gt; client</td>
</tr>
<tr><td>VFIO_USER_DMA_WRITE</td>
<td>11</td>
<td>server -&gt; client</td>
</tr>
<tr><td>VFIO_USER_VM_INTERRUPT</td>
<td>12</td>
<td>server -&gt; client</td>
</tr>
<tr><td>VFIO_USER_DEVICE_RESET</td>
<td>13</td>
<td>client -&gt; server</td>
</tr>
</tbody>
</table>
<div class="note">
<p class="first admonition-title">Note</p>
<p class="last">Some VFIO defines cannot be reused since their values are
architecture-specific (e.g. VFIO_IOMMU_MAP_DMA).</p>
</div>
</div>
<div class="section" id="header">
<h2><a class="toc-backref" href="#id37">Header</a></h2>
<p>All messages, both command messages and reply messages, are preceded by a
header that contains basic information about the message. The header is
followed by message-specific data described in the sections below.</p>
<table border="1" class="docutils">
<colgroup>
<col width="42%" />
<col width="24%" />
<col width="34%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>0</td>
<td>2</td>
</tr>
<tr><td>Command</td>
<td>2</td>
<td>2</td>
</tr>
<tr><td>Message size</td>
<td>4</td>
<td>4</td>
</tr>
<tr><td>Flags</td>
<td>8</td>
<td>4</td>
</tr>
<tr><td>&nbsp;</td>
<td colspan="2"><table border="1" class="first last docutils">
<colgroup>
<col width="33%" />
<col width="67%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Bit</th>
<th class="head">Definition</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>0-3</td>
<td>Type</td>
</tr>
<tr><td>4</td>
<td>No_reply</td>
</tr>
<tr><td>5</td>
<td>Error</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr><td>Errno</td>
<td>12</td>
<td>4</td>
</tr>
<tr><td>&lt;message data&gt;</td>
<td>16</td>
<td>variable</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>Message ID</em> identifies the message, and is echoed in the command's reply message.</li>
<li><em>Command</em> specifies the command to be executed, listed in <a class="reference internal" href="#commands">Commands</a>.</li>
<li><em>Message size</em> contains the size of the entire message, including the header.</li>
<li><em>Flags</em> contains attributes of the message:<ul>
<li>The <em>Type</em> bits indicate the message type.<ul>
<li><em>Command</em> (value 0x0) indicates a command message.</li>
<li><em>Reply</em> (value 0x1) indicates a reply message acknowledging a previous
command with the same message ID.</li>
</ul>
</li>
<li><em>No_reply</em> in a command message indicates that no reply is needed for this command.
This is commonly used when multiple commands are sent, and only the last needs
acknowledgement.</li>
<li><em>Error</em> in a reply message indicates the command being acknowledged had
an error. In this case, the <em>Errno</em> field will be valid.</li>
</ul>
</li>
<li><em>Errno</em> in a reply message is a UNIX errno value. It is reserved in a command message.</li>
</ul>
<p>Each command message in <a class="reference internal" href="#commands">Commands</a> must be replied to with a reply message, unless the
message sets the <em>No_Reply</em> bit.  The reply consists of the header with the <em>Reply</em>
bit set, plus any additional data.</p>
</div>
<div class="section" id="vfio-user-version">
<h2><a class="toc-backref" href="#id38">VFIO_USER_VERSION</a></h2>
<div class="section" id="message-format">
<h3><a class="toc-backref" href="#id39">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="37%" />
<col width="63%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>1</td>
</tr>
<tr><td>Message size</td>
<td>16 + version length</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>Version</td>
<td>JSON byte array</td>
</tr>
</tbody>
</table>
<p>This is the initial message sent by the server after the socket connection is
established. The version is in JSON format, and the following objects must be
included:</p>
<table border="1" class="docutils">
<colgroup>
<col width="19%" />
<col width="11%" />
<col width="70%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Type</th>
<th class="head">Description</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>version</td>
<td>object</td>
<td><p class="first"><tt class="docutils literal">{&quot;major&quot;: &lt;number&gt;, &quot;minor&quot;: &lt;number&gt;}</tt></p>
<p class="last">Version supported by the sender, e.g. &quot;0.1&quot;.</p>
</td>
</tr>
<tr><td>capabilities</td>
<td>array</td>
<td>Reserved. Can be omitted for v0.1, otherwise must
be empty.</td>
</tr>
</tbody>
</table>
</div>
<div class="section" id="versioning-and-feature-support">
<span id="version"></span><h3><a class="toc-backref" href="#id40">Versioning and Feature Support</a></h3>
<p>Upon accepting a connection, the server must send a VFIO_USER_VERSION message
proposing a protocol version and a set of capabilities. The client compares
these with the versions and capabilities it supports and sends a
VFIO_USER_VERSION reply according to the following rules.</p>
<ul class="simple">
<li>The major version in the reply must be the same as proposed. If the client
does not support the proposed major, it closes the connection.</li>
<li>The minor version in the reply must be equal to or less than the minor
version proposed.</li>
<li>The capability list must be a subset of those proposed. If the client
requires a capability the server did not include, it closes the connection.</li>
</ul>
<p>The protocol major version will only change when incompatible protocol changes
are made, such as changing the message format. The minor version may change
when compatible changes are made, such as adding new messages or capabilities,
Both the client and server must support all minor versions less than the
maximum minor version it supports. E.g., an implementation that supports
version 1.3 must also support 1.0 through 1.2.</p>
<p>When making a change to this specification, the protocol version number must
be included in the form &quot;added in version X.Y&quot;</p>
</div>
</div>
<div class="section" id="vfio-user-dma-map-and-vfio-user-dma-unmap">
<h2><a class="toc-backref" href="#id41">VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP</a></h2>
<div class="section" id="id2">
<h3><a class="toc-backref" href="#id42">Message Format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="37%" />
<col width="63%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>MAP=2, UNMAP=3</td>
</tr>
<tr><td>Message size</td>
<td>16 + table size</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>Table</td>
<td>array of table entries</td>
</tr>
</tbody>
</table>
<p>This command message is sent by the client to the server to inform it of the
memory regions the server can access. It must be sent before the server can
perform any DMA to the client. It is normally sent directly after the version
handshake is completed, but may also occur when memory is added to or
subtracted from the client, or if the client uses a vIOMMU. If the client does
not expect the server to perform DMA then it does not need to send to the
server VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP commands. If the server does
not need to perform DMA the then it can ignore such commands but it must still
reply to them. The table is an array of the following structure.  This
structure is 32 bytes in size, so the message size is:
16 + (# of table entries * 32).</p>
</div>
<div class="section" id="table-entry-format">
<h3><a class="toc-backref" href="#id43">Table entry format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="38%" />
<col width="24%" />
<col width="38%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Address</td>
<td>0</td>
<td>8</td>
</tr>
<tr><td>Size</td>
<td>8</td>
<td>8</td>
</tr>
<tr><td>Offset</td>
<td>16</td>
<td>8</td>
</tr>
<tr><td>Protections</td>
<td>24</td>
<td>4</td>
</tr>
<tr><td>Flags</td>
<td>28</td>
<td>4</td>
</tr>
<tr><td>&nbsp;</td>
<td colspan="2"><table border="1" class="first last docutils">
<colgroup>
<col width="29%" />
<col width="71%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Bit</th>
<th class="head">Definition</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>0</td>
<td>Mappable</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>Address</em> is the base DMA address of the region.</li>
<li><em>Size</em> is the size of the region.</li>
<li><em>Offset</em> is the file offset of the region with respect to the associated file
descriptor.</li>
<li><em>Protections</em> are the region's protection attributes as encoded in
<tt class="docutils literal">&lt;sys/mman.h&gt;</tt>.</li>
<li><em>Flags</em> contain the following region attributes:<ul>
<li><em>Mappable</em> indicates that the region can be mapped via the mmap() system call
using the file descriptor provided in the message meta-data.</li>
</ul>
</li>
</ul>
<div class="section" id="vfio-user-dma-map">
<h4><a class="toc-backref" href="#id44">VFIO_USER_DMA_MAP</a></h4>
<p>If a DMA region being added can be directly mapped by the server, an array of
file descriptors must be sent as part of the message meta-data. Each region
entry must have a corresponding file descriptor. On AF_UNIX sockets, the file
descriptors must be passed as SCM_RIGHTS type ancillary data. Otherwise, if a
DMA region cannot be directly mapped by the server, it can be accessed by the
server using VFIO_USER_DMA_READ and VFIO_USER_DMA_WRITE messages, explained in
<a class="reference internal" href="#read-and-write-operations">Read and Write Operations</a>. A command to map over an existing region must be
failed by the server with <tt class="docutils literal">EEXIST</tt> set in error field in the reply.</p>
</div>
<div class="section" id="vfio-user-dma-unmap">
<h4><a class="toc-backref" href="#id45">VFIO_USER_DMA_UNMAP</a></h4>
<p>Upon receiving a VFIO_USER_DMA_UNMAP command, if the file descriptor is mapped
then the server must release all references to that DMA region before replying,
which includes potentially in flight DMA transactions. Removing a portion of a
DMA region is possible.</p>
</div>
</div>
</div>
<div class="section" id="vfio-user-device-get-info">
<h2><a class="toc-backref" href="#id46">VFIO_USER_DEVICE_GET_INFO</a></h2>
<div class="section" id="id3">
<h3><a class="toc-backref" href="#id47">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="33%" />
<col width="67%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>4</td>
</tr>
<tr><td>Message size</td>
<td>16 in command, 32 in reply</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>Device info</td>
<td>VFIO device info</td>
</tr>
</tbody>
</table>
<p>This command message is sent by the client to the server to query for basic
information about the device. Only the message header is needed in the command
message.  The VFIO device info structure is defined in <tt class="docutils literal">&lt;linux/vfio.h&gt;</tt>
(<tt class="docutils literal">struct vfio_device_info</tt>).</p>
</div>
<div class="section" id="vfio-device-info-format">
<h3><a class="toc-backref" href="#id48">VFIO device info format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="28%" />
<col width="17%" />
<col width="55%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>argsz</td>
<td>16</td>
<td>4</td>
</tr>
<tr><td>flags</td>
<td>20</td>
<td>4</td>
</tr>
<tr><td>&nbsp;</td>
<td colspan="2"><table border="1" class="first last docutils">
<colgroup>
<col width="17%" />
<col width="83%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Bit</th>
<th class="head">Definition</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>0</td>
<td>VFIO_DEVICE_FLAGS_RESET</td>
</tr>
<tr><td>1</td>
<td>VFIO_DEVICE_FLAGS_PCI</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr><td>num_regions</td>
<td>24</td>
<td>4</td>
</tr>
<tr><td>num_irqs</td>
<td>28</td>
<td>4</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>argsz</em> is the size of the VFIO device info structure.</li>
<li><em>flags</em> contains the following device attributes.<ul>
<li>VFIO_DEVICE_FLAGS_RESET indicates that the device supports the
VFIO_USER_DEVICE_RESET message.</li>
<li>VFIO_DEVICE_FLAGS_PCI indicates that the device is a PCI device.</li>
</ul>
</li>
<li><em>num_regions</em> is the number of memory regions that the device exposes.</li>
<li><em>num_irqs</em> is the number of distinct interrupt types that the device supports.</li>
</ul>
<p>This version of the protocol only supports PCI devices. Additional devices may
be supported in future versions.</p>
</div>
</div>
<div class="section" id="vfio-user-device-get-region-info">
<h2><a class="toc-backref" href="#id49">VFIO_USER_DEVICE_GET_REGION_INFO</a></h2>
<div class="section" id="id4">
<h3><a class="toc-backref" href="#id50">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="37%" />
<col width="63%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>5</td>
</tr>
<tr><td>Message size</td>
<td>48 + any caps</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>Region info</td>
<td>VFIO region info</td>
</tr>
</tbody>
</table>
<p>This command message is sent by the client to the server to query for
information about device memory regions. The VFIO region info structure is
defined in <tt class="docutils literal">&lt;linux/vfio.h&gt;</tt> (<tt class="docutils literal">struct vfio_region_info</tt>). Since the client
does not know the size of the capabilities, the size of the reply it should
expect is 48 plus any capabilities whose size is indicated in the size field of
the reply header.</p>
</div>
<div class="section" id="vfio-region-info-format">
<h3><a class="toc-backref" href="#id51">VFIO region info format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="24%" />
<col width="16%" />
<col width="60%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>argsz</td>
<td>16</td>
<td>4</td>
</tr>
<tr><td>flags</td>
<td>20</td>
<td>4</td>
</tr>
<tr><td>&nbsp;</td>
<td colspan="2"><table border="1" class="first last docutils">
<colgroup>
<col width="15%" />
<col width="85%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Bit</th>
<th class="head">Definition</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>0</td>
<td>VFIO_REGION_INFO_FLAG_READ</td>
</tr>
<tr><td>1</td>
<td>VFIO_REGION_INFO_FLAG_WRITE</td>
</tr>
<tr><td>2</td>
<td>VFIO_REGION_INFO_FLAG_MMAP</td>
</tr>
<tr><td>3</td>
<td>VFIO_REGION_INFO_FLAG_CAPS</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr><td>index</td>
<td>24</td>
<td>4</td>
</tr>
<tr><td>cap_offset</td>
<td>28</td>
<td>4</td>
</tr>
<tr><td>size</td>
<td>32</td>
<td>8</td>
</tr>
<tr><td>offset</td>
<td>40</td>
<td>8</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>argsz</em> is the size of the VFIO region info structure plus the
size of any region capabilities returned.</li>
<li><em>flags</em> are attributes of the region:<ul>
<li><em>VFIO_REGION_INFO_FLAG_READ</em> allows client read access to the region.</li>
<li><em>VFIO_REGION_INFO_FLAG_WRITE</em> allows client write access to the region.</li>
<li><em>VFIO_REGION_INFO_FLAG_MMAP</em> specifies the client can mmap() the region.
When this flag is set, the reply will include a file descriptor in its
meta-data. On AF_UNIX sockets, the file descriptors will be passed as
SCM_RIGHTS type ancillary data.</li>
<li><em>VFIO_REGION_INFO_FLAG_CAPS</em> indicates additional capabilities found in the
reply.</li>
</ul>
</li>
<li><em>index</em> is the index of memory region being queried, it is the only field
that is required to be set in the command message.</li>
<li><em>cap_offset</em> describes where additional region capabilities can be found.
cap_offset is relative to the beginning of the VFIO region info structure.
The data structure it points is a VFIO cap header defined in
<tt class="docutils literal">&lt;linux/vfio.h&gt;</tt>.</li>
<li><em>size</em> is the size of the region.</li>
<li><em>offset</em> is the offset given to the mmap() system call for regions with the
MMAP attribute. It is also used as the base offset when mapping a VFIO
sparse mmap area, described below.</li>
</ul>
</div>
<div class="section" id="vfio-region-capabilities">
<h3><a class="toc-backref" href="#id52">VFIO Region capabilities</a></h3>
<p>The VFIO region information can also include a capabilities list. This list is
similar to a PCI capability list - each entry has a common header that
identifies a capability and where the next capability in the list can be found.
The VFIO capability header format is defined in <tt class="docutils literal">&lt;linux/vfio.h&gt;</tt> (<tt class="docutils literal">struct
vfio_info_cap_header</tt>).</p>
</div>
<div class="section" id="vfio-cap-header-format">
<h3><a class="toc-backref" href="#id53">VFIO cap header format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="39%" />
<col width="35%" />
<col width="26%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>id</td>
<td>0</td>
<td>2</td>
</tr>
<tr><td>version</td>
<td>2</td>
<td>2</td>
</tr>
<tr><td>next</td>
<td>4</td>
<td>4</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>id</em> is the capability identity.</li>
<li><em>version</em> is a capability-specific version number.</li>
<li><em>next</em> specifies the offset of the next capability in the capability list. It
is relative to the beginning of the VFIO region info structure.</li>
</ul>
</div>
<div class="section" id="vfio-sparse-mmap">
<h3><a class="toc-backref" href="#id54">VFIO sparse mmap</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="35%" />
<col width="65%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>id</td>
<td>VFIO_REGION_INFO_CAP_SPARSE_MMAP</td>
</tr>
<tr><td>version</td>
<td>0x1</td>
</tr>
<tr><td>next</td>
<td>&lt;next&gt;</td>
</tr>
<tr><td>sparse mmap info</td>
<td>VFIO region info sparse mmap</td>
</tr>
</tbody>
</table>
<p>The only capability supported in this version of the protocol is for sparse
mmap. This capability is defined when only a subrange of the region supports
direct access by the client via mmap(). The VFIO sparse mmap area is defined in
<tt class="docutils literal">&lt;linux/vfio.h&gt;</tt> (<tt class="docutils literal">struct vfio_region_sparse_mmap_area</tt>).</p>
</div>
<div class="section" id="vfio-region-info-cap-sparse-mmap">
<h3><a class="toc-backref" href="#id55">VFIO region info cap sparse mmap</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="42%" />
<col width="33%" />
<col width="25%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>nr_areas</td>
<td>0</td>
<td>4</td>
</tr>
<tr><td>reserved</td>
<td>4</td>
<td>4</td>
</tr>
<tr><td>offset</td>
<td>8</td>
<td>8</td>
</tr>
<tr><td>size</td>
<td>16</td>
<td>9</td>
</tr>
<tr><td>...</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>nr_areas</em> is the number of sparse mmap areas in the region.</li>
<li><em>offset</em> and size describe a single area that can be mapped by the client.
There will be nr_areas pairs of offset and size. The offset will be added to
the base offset given in the VFIO_USER_DEVICE_GET_REGION_INFO to form the
offset argument of the subsequent mmap() call.</li>
</ul>
<p>The VFIO sparse mmap area is defined in <tt class="docutils literal">&lt;linux/vfio.h&gt;</tt> (<tt class="docutils literal">struct
vfio_region_info_cap_sparse_mmap</tt>).</p>
</div>
</div>
<div class="section" id="vfio-user-device-get-irq-info">
<h2><a class="toc-backref" href="#id56">VFIO_USER_DEVICE_GET_IRQ_INFO</a></h2>
<div class="section" id="id5">
<h3><a class="toc-backref" href="#id57">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="37%" />
<col width="63%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>6</td>
</tr>
<tr><td>Message size</td>
<td>32</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>IRQ info</td>
<td>VFIO IRQ info</td>
</tr>
</tbody>
</table>
<p>This command message is sent by the client to the server to query for
information about device interrupt types. The VFIO IRQ info structure is
defined in <tt class="docutils literal">&lt;linux/vfio.h&gt;</tt> (<tt class="docutils literal">struct vfio_irq_info</tt>).</p>
</div>
<div class="section" id="vfio-irq-info-format">
<h3><a class="toc-backref" href="#id58">VFIO IRQ info format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="17%" />
<col width="19%" />
<col width="64%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>argsz</td>
<td>16</td>
<td>4</td>
</tr>
<tr><td>flags</td>
<td>20</td>
<td>4</td>
</tr>
<tr><td>&nbsp;</td>
<td colspan="2"><table border="1" class="first last docutils">
<colgroup>
<col width="16%" />
<col width="84%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Bit</th>
<th class="head">Definition</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>0</td>
<td>VFIO_IRQ_INFO_EVENTFD</td>
</tr>
<tr><td>1</td>
<td>VFIO_IRQ_INFO_MASKABLE</td>
</tr>
<tr><td>2</td>
<td>VFIO_IRQ_INFO_AUTOMASKED</td>
</tr>
<tr><td>3</td>
<td>VFIO_IRQ_INFO_NORESIZE</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr><td>index</td>
<td>24</td>
<td>4</td>
</tr>
<tr><td>count</td>
<td>28</td>
<td>4</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>argsz</em> is the size of the VFIO IRQ info structure.</li>
<li><em>flags</em> defines IRQ attributes:<ul>
<li><em>VFIO_IRQ_INFO_EVENTFD</em> indicates the IRQ type can support server eventfd
signalling.</li>
<li><em>VFIO_IRQ_INFO_MASKABLE</em> indicates that the IRQ type supports the MASK and
UNMASK actions in a VFIO_USER_DEVICE_SET_IRQS message.</li>
<li><em>VFIO_IRQ_INFO_AUTOMASKED</em> indicates the IRQ type masks itself after being
triggered, and the client must send an UNMASK action to receive new
interrupts.</li>
<li><em>VFIO_IRQ_INFO_NORESIZE</em> indicates VFIO_USER_SET_IRQS operations setup
interrupts as a set, and new sub-indexes cannot be enabled without disabling
the entire type.</li>
</ul>
</li>
<li>index is the index of IRQ type being queried, it is the only field that is
required to be set in the command message.</li>
<li>count describes the number of interrupts of the queried type.</li>
</ul>
</div>
</div>
<div class="section" id="vfio-user-device-set-irqs">
<h2><a class="toc-backref" href="#id59">VFIO_USER_DEVICE_SET_IRQS</a></h2>
<div class="section" id="id6">
<h3><a class="toc-backref" href="#id60">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="37%" />
<col width="63%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>7</td>
</tr>
<tr><td>Message size</td>
<td>36 + any data</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>IRQ set</td>
<td>VFIO IRQ set</td>
</tr>
</tbody>
</table>
<p>This command message is sent by the client to the server to set actions for
device interrupt types. The VFIO IRQ set structure is defined in
<tt class="docutils literal">&lt;linux/vfio.h&gt;</tt> (<tt class="docutils literal">struct vfio_irq_set</tt>).</p>
</div>
<div class="section" id="vfio-irq-set-format">
<h3><a class="toc-backref" href="#id61">VFIO IRQ set format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="16%" />
<col width="18%" />
<col width="67%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>argsz</td>
<td>16</td>
<td>4</td>
</tr>
<tr><td>flags</td>
<td>20</td>
<td>4</td>
</tr>
<tr><td>&nbsp;</td>
<td colspan="2"><table border="1" class="first last docutils">
<colgroup>
<col width="15%" />
<col width="85%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Bit</th>
<th class="head">Definition</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>0</td>
<td>VFIO_IRQ_SET_DATA_NONE</td>
</tr>
<tr><td>1</td>
<td>VFIO_IRQ_SET_DATA_BOOL</td>
</tr>
<tr><td>2</td>
<td>VFIO_IRQ_SET_DATA_EVENTFD</td>
</tr>
<tr><td>3</td>
<td>VFIO_IRQ_SET_ACTION_MASK</td>
</tr>
<tr><td>4</td>
<td>VFIO_IRQ_SET_ACTION_UNMASK</td>
</tr>
<tr><td>5</td>
<td>VFIO_IRQ_SET_ACTION_TRIGGER</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr><td>index</td>
<td>24</td>
<td>4</td>
</tr>
<tr><td>start</td>
<td>28</td>
<td>4</td>
</tr>
<tr><td>count</td>
<td>32</td>
<td>4</td>
</tr>
<tr><td>data</td>
<td>36</td>
<td>variable</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>argsz</em> is the size of the VFIO IRQ set structure, including any <em>data</em> field.</li>
<li><em>flags</em> defines the action performed on the interrupt range. The DATA flags
describe the data field sent in the message; the ACTION flags describe the
action to be performed. The flags are mutually exclusive for both sets.<ul>
<li><em>VFIO_IRQ_SET_DATA_NONE</em> indicates there is no data field in the command.
The action is performed unconditionally.</li>
<li><em>VFIO_IRQ_SET_DATA_BOOL</em> indicates the data field is an array of boolean
bytes. The action is performed if the corresponding boolean is true.</li>
<li><em>VFIO_IRQ_SET_DATA_EVENTFD</em> indicates an array of event file descriptors
was sent in the message meta-data. These descriptors will be signalled when
the action defined by the action flags occurs. In AF_UNIX sockets, the
descriptors are sent as SCM_RIGHTS type ancillary data.</li>
<li><em>VFIO_IRQ_SET_ACTION_MASK</em> indicates a masking event. It can be used with
VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE to mask an interrupt, or
with VFIO_IRQ_SET_DATA_EVENTFD to generate an event when the guest masks
the interrupt.</li>
<li><em>VFIO_IRQ_SET_ACTION_UNMASK</em> indicates an unmasking event. It can be used
with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE to unmask an
interrupt, or with VFIO_IRQ_SET_DATA_EVENTFD to generate an event when the
guest unmasks the interrupt.</li>
<li><em>VFIO_IRQ_SET_ACTION_TRIGGER</em> indicates a triggering event. It can be used
with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE to trigger an
interrupt, or with VFIO_IRQ_SET_DATA_EVENTFD to generate an event when the
server triggers the interrupt.</li>
</ul>
</li>
<li><em>index</em> is the index of IRQ type being setup.</li>
<li><em>start</em> is the start of the sub-index being set.</li>
<li><em>count</em> describes the number of sub-indexes being set. As a special case, a
count of 0 with data flags of VFIO_IRQ_SET_DATA_NONE disables all interrupts
of the index.</li>
<li><em>data</em> is an optional field included when the
VFIO_IRQ_SET_DATA_BOOL flag is present. It contains an array of booleans
that specify whether the action is to be performed on the corresponding
index. It's used when the action is only performed on a subset of the range
specified.</li>
</ul>
<p>Not all interrupt types support every combination of data and action flags.
The client must know the capabilities of the device and IRQ index before it
sends a VFIO_USER_DEVICE_SET_IRQ message.</p>
</div>
</div>
<div class="section" id="id7">
<span id="read-and-write-operations"></span><h2><a class="toc-backref" href="#id62">Read and Write Operations</a></h2>
<p>Not all I/O operations between the client and server can be done via direct
access of memory mapped with an mmap() call. In these cases, the client and
server use messages sent over the socket. It is expected that these operations
will have lower performance than direct access.</p>
<p>The client can access server memory with VFIO_USER_REGION_READ and
VFIO_USER_REGION_WRITE commands. These share a common data structure that
appears after the message header.</p>
<div class="section" id="region-read-write-data">
<h3><a class="toc-backref" href="#id63">REGION Read/Write Data</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="31%" />
<col width="31%" />
<col width="38%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Offset</td>
<td>16</td>
<td>8</td>
</tr>
<tr><td>Region</td>
<td>24</td>
<td>4</td>
</tr>
<tr><td>Count</td>
<td>28</td>
<td>4</td>
</tr>
<tr><td>Data</td>
<td>32</td>
<td>variable</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>Offset</em> into the region being accessed.</li>
<li><em>Region</em> is the index of the region being accessed.</li>
<li><em>Count</em> is the size of the data to be transferred.</li>
<li><em>Data</em> is the data to be read or written.</li>
</ul>
<p>The server can access client memory with VFIO_USER_DMA_READ and
VFIO_USER_DMA_WRITE messages. These also share a common data structure that
appears after the message header.</p>
</div>
<div class="section" id="dma-read-write-data">
<h3><a class="toc-backref" href="#id64">DMA Read/Write Data</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="33%" />
<col width="30%" />
<col width="37%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Address</td>
<td>16</td>
<td>8</td>
</tr>
<tr><td>Count</td>
<td>24</td>
<td>4</td>
</tr>
<tr><td>Data</td>
<td>28</td>
<td>variable</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>Address</em> is the area of client memory being accessed. This address must have
been previously exported to the server with a VFIO_USER_DMA_MAP message.</li>
<li><em>Count</em> is the size of the data to be transferred.</li>
<li><em>Data</em> is the data to be read or written.</li>
</ul>
</div>
</div>
<div class="section" id="vfio-user-region-read">
<h2><a class="toc-backref" href="#id65">VFIO_USER_REGION_READ</a></h2>
<div class="section" id="id8">
<h3><a class="toc-backref" href="#id66">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="37%" />
<col width="63%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>8</td>
</tr>
<tr><td>Message size</td>
<td>32 + data size</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>Read info</td>
<td>REGION read/write data</td>
</tr>
</tbody>
</table>
<p>This command message is sent from the client to the server to read from server
memory.  In the command messages, there is no data, and the count is the amount
of data to be read. The reply message must include the data read, and its count
field is the amount of data read.</p>
</div>
</div>
<div class="section" id="vfio-user-region-write">
<h2><a class="toc-backref" href="#id67">VFIO_USER_REGION_WRITE</a></h2>
<div class="section" id="id9">
<h3><a class="toc-backref" href="#id68">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="37%" />
<col width="63%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>9</td>
</tr>
<tr><td>Message size</td>
<td>32 + data size</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>Write info</td>
<td>REGION read/write data</td>
</tr>
</tbody>
</table>
<p>This command message is sent from the client to the server to write to server
memory.  The command message must contain the data to be written, and its count
field must contain the amount of write data. The count field in the reply
message must be zero.</p>
</div>
</div>
<div class="section" id="vfio-user-dma-read">
<h2><a class="toc-backref" href="#id69">VFIO_USER_DMA_READ</a></h2>
<div class="section" id="id10">
<h3><a class="toc-backref" href="#id70">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="37%" />
<col width="63%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>10</td>
</tr>
<tr><td>Message size</td>
<td>28 + data size</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>DMA info</td>
<td>DMA read/write data</td>
</tr>
</tbody>
</table>
<p>This command message is sent from the server to the client to read from client
memory.  In the command message, there is no data, and the count must will be
the amount of data to be read. The reply message must include the data read,
and its count field must be the amount of data read.</p>
</div>
</div>
<div class="section" id="vfio-user-dma-write">
<h2><a class="toc-backref" href="#id71">VFIO_USER_DMA_WRITE</a></h2>
<div class="section" id="id11">
<h3><a class="toc-backref" href="#id72">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="37%" />
<col width="63%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>11</td>
</tr>
<tr><td>Message size</td>
<td>28 + data size</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>DMA info</td>
<td>DMA read/write data</td>
</tr>
</tbody>
</table>
<p>This command message is sent from the server to the client to write to server
memory.  The command message must contain the data to be written, and its count
field must contain the amount of write data. The count field in the reply
message must be zero.</p>
</div>
</div>
<div class="section" id="vfio-user-vm-interrupt">
<h2><a class="toc-backref" href="#id73">VFIO_USER_VM_INTERRUPT</a></h2>
<div class="section" id="id12">
<h3><a class="toc-backref" href="#id74">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="40%" />
<col width="60%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>12</td>
</tr>
<tr><td>Message size</td>
<td>24</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
<tr><td>Interrupt info</td>
<td>&lt;interrupt&gt;</td>
</tr>
</tbody>
</table>
<p>This command message is sent from the server to the client to signal the device
has raised an interrupt.</p>
</div>
<div class="section" id="interrupt-info-format">
<h3><a class="toc-backref" href="#id75">Interrupt info format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="44%" />
<col width="32%" />
<col width="24%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Offset</th>
<th class="head">Size</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Index</td>
<td>16</td>
<td>4</td>
</tr>
<tr><td>Sub-index</td>
<td>20</td>
<td>4</td>
</tr>
</tbody>
</table>
<ul class="simple">
<li><em>Index</em> is the interrupt index; it is the same value used in
VFIO_USER_SET_IRQS.</li>
<li><em>Sub-index</em> is relative to the index, e.g., the vector number used in PCI
MSI/X type interrupts.</li>
</ul>
</div>
</div>
<div class="section" id="vfio-user-device-reset">
<h2><a class="toc-backref" href="#id76">VFIO_USER_DEVICE_RESET</a></h2>
<div class="section" id="id13">
<h3><a class="toc-backref" href="#id77">Message format</a></h3>
<table border="1" class="docutils">
<colgroup>
<col width="37%" />
<col width="63%" />
</colgroup>
<thead valign="bottom">
<tr><th class="head">Name</th>
<th class="head">Value</th>
</tr>
</thead>
<tbody valign="top">
<tr><td>Message ID</td>
<td>&lt;ID&gt;</td>
</tr>
<tr><td>Command</td>
<td>13</td>
</tr>
<tr><td>Message size</td>
<td>16</td>
</tr>
<tr><td>Flags</td>
<td>Reply bit set in reply</td>
</tr>
<tr><td>Errno</td>
<td>0/errno</td>
</tr>
</tbody>
</table>
<p>This command message is sent from the client to the server to reset the device.</p>
</div>
</div>
</div>
<div class="section" id="appendices">
<h1><a class="toc-backref" href="#id78">Appendices</a></h1>
<div class="section" id="unused-vfio-ioctl-commands">
<h2><a class="toc-backref" href="#id79">Unused VFIO ioctl() commands</a></h2>
<p>The following VFIO commands do not have an equivalent vfio-user command:</p>
<ul class="simple">
<li>VFIO_GET_API_VERSION</li>
<li>VFIO_CHECK_EXTENSION</li>
<li>VFIO_SET_IOMMU</li>
<li>VFIO_GROUP_GET_STATUS</li>
<li>VFIO_GROUP_SET_CONTAINER</li>
<li>VFIO_GROUP_UNSET_CONTAINER</li>
<li>VFIO_GROUP_GET_DEVICE_FD</li>
<li>VFIO_IOMMU_GET_INFO</li>
</ul>
<p>However, once support for live migration for VFIO devices is finalized some
of the above commands may have to be handled by the client in their
corresponding vfio-user form. This will be addressed in a future protocol
version.</p>
</div>
<div class="section" id="id14">
<h2><a class="toc-backref" href="#id80">Live Migration</a></h2>
<p>Currently live migration is not supported for devices passed through via VFIO,
therefore it is not supported for vfio-user, either. This is being actively
worked on in the <a class="reference external" href="https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06463.html">Add migration support for VFIO devices (v25)</a>
patch series.</p>
<div class="section" id="vfio-groups-and-containers">
<h3><a class="toc-backref" href="#id81">VFIO groups and containers</a></h3>
<p>The current VFIO implementation includes group and container idioms that
describe how a device relates to the host IOMMU. In the vfio-user
implementation, the IOMMU is implemented in SW by the client, and is not
visible to the server. The simplest idea would be that the client put each
device into its own group and container.</p>
</div>
</div>
<div class="section" id="backend-program-conventions">
<h2><a class="toc-backref" href="#id82">Backend Program Conventions</a></h2>
<p>vfio-user backend program conventions are based on the vhost-user ones.</p>
<ul class="simple">
<li>The backend program must not daemonize itself.</li>
<li>No assumptions must be made as to what access the backend program has on the
system.</li>
<li>File descriptors 0, 1 and 2 must exist, must have regular
stdin/stdout/stderr semantics, and can be redirected.</li>
<li>The backend program must honor the SIGTERM signal.</li>
<li>The backend program must accept the following commands line options:<ul>
<li><tt class="docutils literal"><span class="pre">--socket-path=PATH</span></tt>: path to UNIX domain socket,</li>
<li><tt class="docutils literal"><span class="pre">--fd=FDNUM</span></tt>: file descriptor for UNIX domain socket, incompatible with
<tt class="docutils literal"><span class="pre">--socket-path</span></tt></li>
</ul>
</li>
<li>The backend program must be accompanied with a JSON file stored under
<tt class="docutils literal"><span class="pre">/usr/share/vfio-user</span></tt>.</li>
</ul>
</div>
</div>
</div>
</body>
</html>

--Apple-Mail=_0078527D-57B0-458F-941A-A3B6210ACFA0--

