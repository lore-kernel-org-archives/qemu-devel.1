Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78A4C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6972920637
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIyUGwBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6972920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j958E-00051Q-JV
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1j957R-000470-Sy
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1j957Q-0003xt-TF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:49:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1j957Q-0003xG-Q8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583232583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nzDY5PVwzLCc2gOcpwsBf8jpLCI7EEXZYyhhj/Czpfk=;
 b=GIyUGwBz8aEpt2JyKDi8kozCDWqoaxfdoy7A9zpUB7E/3lKWwc63AkUab6ZuWVuLHW+IuS
 l33rimeKA9Gg+sHGMBogOnEzAX9pwbYzw7HiNstpOktG8KBpG8PyQWIvYbdoF0vCDNoT4Z
 4s/4Pol757G7NLpjc6Wj0npwjWL6nSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-zk6m2xYzM96G5jNla30rCw-1; Tue, 03 Mar 2020 05:49:39 -0500
X-MC-Unique: zk6m2xYzM96G5jNla30rCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6862780573B;
 Tue,  3 Mar 2020 10:49:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-177.sin2.redhat.com
 [10.67.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FE9D5C1D6;
 Tue,  3 Mar 2020 10:49:29 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 0/2] net: tulip: add checks to avoid OOB access
Date: Tue,  3 Mar 2020 16:17:22 +0530
Message-Id: <20200303104724.233375-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Ziming Zhang <ezrakiez@gmail.com>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

* This series adds checks to avoid potential OOB access and infinite loop
  issues while processing rx/tx data.

* Tulip tx descriptors are capped at 128 to avoid infinite loop in
  tulip_xmit_list_update(), wrt Tulip kernel driver
  -> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/net/ethernet/dec/tulip/tulip.h#n319

* Update v3: add .can_receive routine
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html

Thank you.
--
Prasad J Pandit (2):
  net: tulip: check frame size and r/w data length
  net: tulip: add .can_recieve routine

 hw/net/tulip.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

--
2.24.1


