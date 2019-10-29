Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FA0CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 23:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE36F2087F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 23:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE36F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQKFI-00057X-RX
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 19:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1iQKEJ-0004F5-82
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1iQKEH-0003ns-B5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:51:50 -0400
Received: from [192.146.154.1] (port=24405 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1iQKEH-0003m9-59
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:51:49 -0400
Received: from localhost.corp.nutanix.com (unknown [10.40.36.164])
 by mcp01.nutanix.com (Postfix) with ESMTP id 150B010081F6;
 Thu, 31 Oct 2019 23:51:48 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] vhost-user: add message for device reset 
Date: Tue, 29 Oct 2019 17:38:01 -0400
Message-Id: <1572385083-5254-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have updated patches [1] sent by David Vrabel last year:

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05077.html

This change adds a new =E2=80=9Creset device=E2=80=9D feature to the vhos=
t-user protocol
and a corresponding VHOST_USER_RESET_DEVICE message to notify vhost-user
backends when a virtio scsi device is reset by a guest.
It also adds support for this new feature/message in vhost-user-scsi.

Now, iff a vhost-user-scsi backend reports that it supports the new
"reset device" feature, QEMU will send a VHOST_USER_RESET_DEVICE
message when the guest resets the virtio device. Existing backends
will be unaffected.

Other types vhost-user backends can benefit from using this new message.
Those built using libvhost-user, for example, rely on the depricated
VHOST_USER_RESET_OWNER message to notify vhost-user backends about
device resets and can be updated to use this new supported message.

Raphael

Raphael Norwitz (2):
  vhost-user: add VHOST_USER_RESET_DEVICE to reset devices
  vhost-user-scsi: reset the device if supported

 docs/interop/vhost-user.rst | 15 +++++++++++++++
 hw/scsi/vhost-user-scsi.c   | 24 ++++++++++++++++++++++++
 hw/virtio/vhost-user.c      |  8 +++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

--=20
1.8.3.1


