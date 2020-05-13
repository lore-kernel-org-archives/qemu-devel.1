Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B07C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263B8206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NX5Urqdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263B8206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYx4u-0002z3-Dk
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 15:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYx2y-00008h-F7
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:28:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26126
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYx2x-0000eo-3W
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589398082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uoAzosgzULYpNz4S8TNAQkZgf4gmCDtoXtm7+RodRjk=;
 b=NX5Urqdgi3g6qieYaKC3el9h5aKL/Jouk83QlP7jrY7Aivad1TWIhK0Qe+rUG3j8XzY8Wz
 0ExuZtKYAFl+abT9rK7eKpS2/GB6Uj/vvtid4inVoB2cu229ib1qA0exXXrPLdjfJaFrfc
 LsiXSqvh+w5fDGawHaWhovO2tVtursY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-zGDgVxkpP_iggwdDkjjjMA-1; Wed, 13 May 2020 15:27:57 -0400
X-MC-Unique: zGDgVxkpP_iggwdDkjjjMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67FBE801503;
 Wed, 13 May 2020 19:27:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.9.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85DF6707CE;
 Wed, 13 May 2020 19:27:48 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/3] Megasas: fix OOB access and NULL dereference issues
Date: Thu, 14 May 2020 00:55:37 +0530
Message-Id: <20200513192540.1583887-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ding Ren <rding@gatech.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

 Hello,

* First patch fixes an OOB access issue which may occur when a guest user
  sets 'reply_queue_head' field to a negative or large positive value,
  via 'struct mfi_init_qinfo' object in megasas_init_firmware(), such that
  'index' variables in megasas_lookup_frame() goes beyond the
  s->frames[MEGASAS_MAX_FRAMES=2048] array bounds.
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03131.html

* Second patch fixes a NULL pointer dereference issue which may occur
  if megasas_enqueue_frame() routine returns a NULL frame for a given
  'frame_addr' address.
  -> https://bugs.launchpad.net/qemu/+bug/1878259

* Third patch updates other numeric fields of MegasasState to unsigned type.

Thank you.
--
Prasad J Pandit (3):
  megasas: use unsigned type for reply_queue_head and check index
  megasas: avoid NULL pointer dereference
  megasas: use unsigned type for positive numeric fields

 hw/scsi/megasas.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

--
2.25.4


