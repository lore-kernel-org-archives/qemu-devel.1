Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37C4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD66920786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn8PvPv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD66920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0UUo-0008F6-UT
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 14:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0UTy-0007WR-SQ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 14:37:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0UTw-0005Hv-I4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 14:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595961463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=Je1d1/ttsMScK0Je70KVWM9CX7rUdIjqmlkc76WpITQ=;
 b=bn8PvPv5KVOFEfr5nWvRCO36yAMXpQp/4cq07VEYcNK8IzjfDGIAwyAdAAIiycVbl2OpWE
 6i5ZSAK4C0PkusaqLVyg8e9+rq0FGkIPgcJp4oZ6LI4qLqNCk0DTnsPHeGUXbs8vcJw6eW
 /HSVrKD7w1skYc3P8QObebi2o4PHfiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-X7zhuS2JN6WxNwLfjnnHbw-1; Tue, 28 Jul 2020 14:37:41 -0400
X-MC-Unique: X7zhuS2JN6WxNwLfjnnHbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94FC98015CE;
 Tue, 28 Jul 2020 18:37:39 +0000 (UTC)
Received: from thuth.com (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D65E60BF4;
 Tue, 28 Jul 2020 18:37:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.2 0/6] Continue booting in case the first device is not
 bootable
Date: Tue, 28 Jul 2020 20:37:28 +0200
Message-Id: <20200728183734.7838-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Collin Walling <walling@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the user did not specify a "bootindex" property, the s390-ccw bios
tries to find a bootable device on its own. Unfortunately, it alwasy
stops at the very first device that it can find, no matter whether it's
bootable or not. That causes some weird behavior, for example while

 qemu-system-s390x -hda bootable.qcow2

boots perfectly fine, the bios refuses to work if you just specify
a virtio-scsi controller in front of it:

 qemu-system-s390x -device virtio-scsi -hda bootable.qcow2

Since this is quite uncomfortable and confusing for the users, and
all major firmwares on other architectures correctly boot in such
cases, too, let's also try to teach the s390-ccw bios how to boot
in such cases.

For this, we have to get rid of the various panic()s and IPL_assert()
statements at the "low-level" function and let the main code handle
the decision instead whether a boot from a device should fail or not,
so that the main code can continue searching in case it wants to.

 Thomas

Thomas Huth (6):
  pc-bios/s390-ccw/Makefile: Compile with -std=gnu99, -fwrapv and
    -fno-common
  pc-bios/s390-ccw: Move ipl-related code from main() into a separate
    function
  pc-bios/s390-ccw: Move the inner logic of find_subch() to a separate
    function
  pc-bios/s390-ccw: Do not bail out early if not finding a SCSI disk
  pc-bios/s390-ccw: Scan through all boot devices if none has been
    specified
  pc-bios/s390-ccw: Allow booting in case the first virtio-blk disk is
    bad

 pc-bios/s390-ccw/Makefile        |   7 +-
 pc-bios/s390-ccw/bootmap.c       |  34 ++++--
 pc-bios/s390-ccw/main.c          | 172 +++++++++++++++++++------------
 pc-bios/s390-ccw/s390-ccw.h      |   2 +-
 pc-bios/s390-ccw/virtio-blkdev.c |   7 +-
 pc-bios/s390-ccw/virtio-scsi.c   |  25 +++--
 pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
 7 files changed, 157 insertions(+), 92 deletions(-)

-- 
2.18.1


