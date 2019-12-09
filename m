Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28947C2D0C3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 01:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0101C2082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 01:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0101C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih26r-0003Sf-0A
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 20:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ih25g-0002E9-Iu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 20:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ih25f-0001SM-5h
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 20:56:00 -0500
Received: from [192.146.154.1] (port=53222 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ih25e-0001Oj-UO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 20:55:59 -0500
Received: from localhost.corp.nutanix.com (unknown [10.40.33.233])
 by mcp01.nutanix.com (Postfix) with ESMTP id 563BE1008B6E;
 Tue, 17 Dec 2019 01:55:54 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 0/3] vhost-user: Lift Max Ram Slots Limitation
Date: Mon,  9 Dec 2019 02:00:44 -0500
Message-Id: <1575874847-5792-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.146.154.1
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
Cc: raphael.s.norwitz@gmail.com, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In QEMU today, a VM with a vhost-user device can hot add memory a
maximum of 8 times. See these threads, among others:

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01046.html
    https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01236.html

[2] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04656.html

This RFC/patch set introduces a new protocol feature
VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS which, when enabled, lifts the
restriction on the maximum number RAM slots imposed by vhost-user.

The patch consists of 3 changes:
1. Fixed Error Handling in vhost_user_set_mem_table_postcopy:
   This is a bug fix in the postcopy migration path
2. vhost-user: Refactor vhost_user_set_mem_table Functions:
   This is a non-functional change refractoring the
   vhost_user_set_mem_table and vhost_user_set_mem_table_postcopy
   functions such that the feature can be more cleanly added.
3. Introduce Configurable Number of Memory Slots Exposed by vhost-user:
   This change introduces the new protocol feature
   VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS.

The implementation details are explained in more detail in the commit
messages, but at a high level the new protocol feature works as follows:
- If the VHOST_USER_PROTCOL_F_CONFIGURE_SLOTS feature is enabled, QEMU wi=
ll
  send multiple VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG
  messages to map and unmap individual memory regions instead of one larg=
e
  VHOST_USER_SET_MEM_TABLE message containing all memory regions.
- The vhost-user struct maintains a =E2=80=99shadow state=E2=80=99 of mem=
ory regions
  already sent to the guest. Each time vhost_user_set_mem_table is called=
,
  the shadow state is compared with the new device state. A
  VHOST_USER_REM_MEM_REG will be sent for each region in the shadow state
  not in the device state. Then, a VHOST_USER_ADD_MEM_REG will be sent
  for each region in the device state but not the shadow state. After
  these messages have been sent, the shadow state will be updated to
  reflect the new device state.

The VHOST_USER_SET_MEM_TABLE message was not reused because as the number=
 of
regions grows, the message becomes very large. In practice, such large
messages caused problems (truncated messages) and in the past it seems th=
e
community has opted for smaller fixed size messages where possible. VRING=
s,
for example, are sent to the backend individually instead of in one massi=
ve
message.

Current Limitations:
- postcopy migration is not supported when the
  VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS has been negotiated.=20
- VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS cannot be negotiated when
  VHOST_USER_PROTOCOL_F_REPLY_ACK has also been negotiated.

Both of these limitations are due to resource contraints. They are not
imposed for technical reasons.

Questions:
- In the event transmitting a VHOST_USER_ADD_MEM_REG or
  VHOST_USER_REM_REG message fails, is there any reason the error handlin=
g
  should differ from when transmitting VHOST_USER_SET_MEM_TABLE message f=
ails?
- Is there a cleaner way to ensure to ensure a postcopy migration cannot =
be
  started with this protocol feature enabled?

Best,
Raphael

Raphael Norwitz (3):
  Fixed Error Handling in vhost_user_set_mem_table_postcopy
  vhost-user: Refactor vhost_user_set_mem_table Functions
  Introduce Configurable Number of Memory Slots Exposed by vhost-user:

 docs/interop/vhost-user.rst |  43 +++++
 hw/virtio/vhost-user.c      | 384 +++++++++++++++++++++++++++++++++-----=
------
 2 files changed, 335 insertions(+), 92 deletions(-)

--=20
1.8.3.1


