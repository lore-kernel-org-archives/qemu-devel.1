Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6465BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2E220825
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="zUsNAys3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2E220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1Kj-0001Fk-8j
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1JA-0008CN-Ae
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:20 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:4996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1J8-000301-Nm
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:mime-version:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=vfgPDRwW1uFrmvCSv4Ej4okp6F/Dbk2y7gevgqGA0JM=;
 b=zUsNAys3dRXu8maNOEBnCWgAXH+uANV3Vh/xoBqLmHaO9Ly9nOPGkUAlPiKvtDodyLG0
 o996zmtSpS7JX53o3FnolefpszpuxgG2sZL91BCLFnYIazdbPUXKG6fH4O5f4uH3AkInXi
 2pKxVt/LNfPfCpeulBGpz6EN5EuZ+8qqk=
Received: by filterdrecv-p3iad2-8ddf98858-szfkb with SMTP id
 filterdrecv-p3iad2-8ddf98858-szfkb-20-5EC3D02A-7F
 2020-05-19 12:25:15.073298809 +0000 UTC m=+4706263.890422383
Received: from localhost.localdomain.com (unknown)
 by ismtpd0002p1lon1.sendgrid.net (SG) with ESMTP
 id or3zpfFGSY2ckPwnH7ghjg Tue, 19 May 2020 12:25:14.678 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v3 00/10] vhost-user: Lift Max Ram Slots Limitation
Date: Tue, 19 May 2020 12:25:15 +0000 (UTC)
Message-Id: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zXfguk7SfszBwU+A+?=
 =?us-ascii?Q?hypjKqB45=2FEuaZVY9NFVuEwVS1jl2RPWRO=2FQpFU?=
 =?us-ascii?Q?8t=2Fv795hE7EneJ7OG7h4+B9l+lEj=2F6KkGabeJSr?=
 =?us-ascii?Q?6vgDvXQVRzYFLCrotGbj4DJ26YJ+gef4ghefsAG?=
 =?us-ascii?Q?uiIbfKlnySj1pZTcqxGhMie+LOpAd6a7=2FZlrjTn?=
 =?us-ascii?Q?jz8t0vaeSFWUPTfeQWOFQ=3D=3D?=
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 08:25:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: raphael.s.norwitz@gmail.com, marcandre.lureau@gmail.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In QEMU today, a VM with a vhost-user device can hot add memory a
maximum of 8 times. See these threads, among others:

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01046.html
    https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01236.html

[2] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04656.html

This series introduces a new protocol feature
VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS which, when enabled, lifts the
restriction on the maximum number RAM slots imposed by vhost-user.

Without vhost-user, a Qemu VM can support 256 ram slots (for ACPI targets),
or potentially more (the KVM max is 512). With each region, a file descriptor
must be sent over the socket. If that many regions are sent in a single message
there could be upwards of 256 file descriptors being opened in the backend process
at once. Opening that many fds could easily push the process past the open fd limit,
especially considering one backend process could have multiple vhost threads,
exposing different devices to different Qemu instances. Therefore to safely lift the
limit, transmitting regions should be split up over multiple messages.

In addition, the VHOST_USER_SET_MEM_TABLE message was not reused because
as the number of regions grows, the message becomes very large. In practice, such
large messages caused problems (truncated messages) and in the past it seems
the community has opted for smaller fixed size messages where possible. VRINGs,
for example, are sent to the backend individually instead of in one massive
message.

The implementation details are explained in more detail in the commit
messages, but at a high level the new protocol feature works as follows:
- If the VHOST_USER_PROTCOL_F_CONFIGURE_MEM_SLOTS feature is enabled,
  QEMU will send multiple VHOST_USER_ADD_MEM_REG and
  VHOST_USER_REM_MEM_REG messages to map and unmap individual memory
 regions instead of one large VHOST_USER_SET_MEM_TABLE message containing
  all memory regions.
- The vhost-user struct maintains a ’shadow state’ of memory regions
  already sent to the guest. Each time vhost_user_set_mem_table is called,
  the shadow state is compared with the new device state. A
  VHOST_USER_REM_MEM_REG will be sent for each region in the shadow state
  not in the device state. Then, a VHOST_USER_ADD_MEM_REG will be sent
  for each region in the device state but not the shadow state. After
  these messages have been sent, the shadow state will be updated to
  reflect the new device state.

The series consists of 10 changes:
1. Add helper to populate vhost-user message regions:
    This change adds a helper to populate a VhostUserMemoryRegion from a
    struct vhost_memory_region, which needs to be done in multiple places in
    in this series.

2. Add vhost-user helper to get MemoryRegion data
    This changes adds a helper to get a pointer to a MemoryRegion struct, along
    with it's offset address and associated file descriptor. This helper is used to
    simplify other vhost-user code paths and will be needed elsewhere in this
    series.

3. Add VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
    This change adds the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
    protocol feature. At this point, if negotiated, the feature only allows the
    backend to limit the number of max ram slots to a number less than
    VHOST_MEMORY_MAX_NREGIONS = 8.

4. Transmit vhost-user memory regions individually
    With this change, if the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
    protocol feature is enabled, Qemu will send regions to the backend using
    individual VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG
    messages.
    The max number of ram slots supported is still limited to 8.

5. Lift max memory slots imposed by vhost-user
    With this change, if the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
    protocol feature is enabled, the backend can support a configurable number of
    ram slots up to the maximum allowed by the target platform.

6. Refactor out libvhost-user fault generation logic
    This cleanup moves some logic from vu_set_mem_table_exec_postcopy() to a
    separate helper, which will be needed elsewhere.

7. Support ram slot configuration in libvhost-user
   This change adds support for processing VHOST_USER_GET_MAX_MEMSLOTS
    messages in libvhost-user.
    The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol is not yet
    enabled in libvhost-user, so at this point this change is non-functional.

8. Support adding individual regions in libvhost-user
    This change adds libvhost-user support for mapping in new memory regions
    when receiving VHOST_USER_ADD_MEM_REG messages.
    The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol is not yet
    enabled in libvhost-user, so at this point this change is non-functional.

9. Support individual region unmap in libvhost-user
    This change adds libvhost-user support for unmapping removed memory regions
    when receiving VHOST_USER_REM_MEM_REG messages.
    The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol is not yet
    enabled in libvhost-user, so at this point this change is non-functional.

10. Lift max ram slots limit in libvhost-user
   This change makes libvhost-user try to negotiate the
   VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, and adds support for
   backends built using libvhost-user to support hot adding memory up to the
   32 times.

The changes were tested with the vhost-user-bridge sample.

Changes since V2:
    * Add support for VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
       for backends build with libvhost-user
    * Add support for postcopy live-migration when the
       VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol feature has
       been negotiated.
    * Add support for backends which want to support both
       VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS and
       VHOST_USER_PROTOCOL_F_REPLY_ACK
    * Change feature name from VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS
        to VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, and any associated
        variable names.
    *Log a more descriptive message if the backend lowers the max ram slots limit
       on reconnect.

Changes since V1:
    * Kept the assert in vhost_user_set_mem_table_postcopy, but moved it
      to prevent corruption
    * Made QEMU send a single VHOST_USER_GET_MAX_MEMSLOTS message at
      startup and cache the returned value so that QEMU does not need to
      query the backend every time vhost_backend_memslots_limit is called.

Best,
Raphael

Raphael Norwitz (10):
  Add helper to populate vhost-user message regions
  Add vhost-user helper to get MemoryRegion data
  Add VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
  Transmit vhost-user memory regions individually
  Lift max memory slots limit imposed by vhost-user
  Refactor out libvhost-user fault generation logic
  Support ram slot configuration in libvhost-user
  Support adding individual regions in libvhost-user
  Support individual region unmap in libvhost-user
  Lift max ram slots limit in libvhost-user

 contrib/libvhost-user/libvhost-user.c | 341 ++++++++++++++----
 contrib/libvhost-user/libvhost-user.h |  24 +-
 docs/interop/vhost-user.rst           |  44 +++
 hw/virtio/vhost-user.c                | 634 ++++++++++++++++++++++++++++------
 include/hw/virtio/vhost-user.h        |   1 +
 5 files changed, 869 insertions(+), 175 deletions(-)

-- 
1.8.3.1


