Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E43C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2C0208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0ZwU2HT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2C0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy6a8-0004SW-In
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 00:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jy6Ya-0002pu-Cn
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:40:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20643
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jy6YW-0002lR-J0
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595392835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gie2xVhUM0ObBNJITOJvdmDagLoNjdICuvMGp+nPAR0=;
 b=h0ZwU2HToMHH3yoazOi7gFHIhx8i8j3y23osZ5LaoM8RrE3m31oNKxsGEjT2houKtbX2fY
 Mi65/X3DUNvisEeN55D26j1nsKYsHduoGgX4L40Te5PQuFauhVst3utsPZsdBkEKjDvRlj
 S6KQuGTWt3xy4lMpsP6pqAWjskj05rU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-BpFW5PwQPkuFM1ddC3OnIA-1; Wed, 22 Jul 2020 00:40:32 -0400
X-MC-Unique: BpFW5PwQPkuFM1ddC3OnIA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8711658;
 Wed, 22 Jul 2020 04:40:31 +0000 (UTC)
Received: from thuth.com (ovpn-112-92.ams2.redhat.com [10.36.112.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 139C87268C;
 Wed, 22 Jul 2020 04:40:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH v2 0/4] Allow guest-get-fsinfo also for non-PCI devices
Date: Wed, 22 Jul 2020 06:40:24 +0200
Message-Id: <20200722044028.4059-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The information that can be retrieved via UDEV is also usable for non-PCI
devices. So let's allow build_guest_fsinfo_for_real_device() on non-PCI
devices, too. This is required to fix the bug that CCW devices show up
without "Target" when running libvirt's "virsh domfsinfo" command (see
https://bugzilla.redhat.com/show_bug.cgi?id=1755075 for details).

v2:
 - Use g_new0 instead of g_malloc0 (as suggested by Daniel)
 - Init fields to -1 explicitely, not via memset (Daniel)
 - Add the fourth patch to also fill in virtio information on s390x

Thomas Huth (4):
  qga/qapi-schema: Document -1 for invalid PCI address fields
  qga/commands-posix: Rework build_guest_fsinfo_for_real_device()
    function
  qga/commands-posix: Move the udev code from the pci to the generic
    function
  qga/commands-posix: Support fsinfo for non-PCI virtio devices, too

 qga/commands-posix.c | 157 ++++++++++++++++++++++++++++++-------------
 qga/qapi-schema.json |   2 +-
 2 files changed, 110 insertions(+), 49 deletions(-)

-- 
2.18.1


