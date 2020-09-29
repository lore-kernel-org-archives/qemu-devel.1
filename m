Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F481C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4D72076D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4D72076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNIYg-0004Sr-Mw
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 12:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kNIWb-0002zd-3z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 12:30:45 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:32146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kNIWY-0003qZ-S3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 12:30:44 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-Zle2tyG7M42IAyhjs9qLRQ-1; Tue, 29 Sep 2020 12:30:27 -0400
X-MC-Unique: Zle2tyG7M42IAyhjs9qLRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33FBC8015C5;
 Tue, 29 Sep 2020 16:30:26 +0000 (UTC)
Received: from bahia.lan (ovpn-113-41.ams2.redhat.com [10.36.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAF9E1972A;
 Tue, 29 Sep 2020 16:30:20 +0000 (UTC)
Subject: [PATCH v2 0/2] vhost: Skip access checks on GIOVAs
From: Greg Kurz <groug@kaod.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Sep 2020 18:30:20 +0200
Message-ID: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 12:30:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series addresses some misuse around vring addresses provided by
userspace when using an IOTLB device. The misuse cause failures of
the VHOST_SET_VRING_ADDR ioctl on POWER, which in turn causes QEMU
to crash at migration time.

While digging some more I realized that log_access_ok() can also be=20
passed a GIOVA (vq->log_addr) even though log_used() will never log
anything at that address. I could observe addresses beyond the end
of the log bitmap being passed to access_ok(), but it didn't have any
impact because the addresses were still acceptable from an access_ok()
standpoint. Adding a second patch to fix that anyway.

Note that I've also posted a patch for QEMU so that it skips the used
structure GIOVA when allocating the log bitmap. Otherwise QEMU fails to
allocate it because POWER puts GIOVAs very high in the address space (ie.
over 0x800000000000000ULL).

https://patchwork.ozlabs.org/project/qemu-devel/patch/160105498386.68108.21=
45229309875282336.stgit@bahia.lan/

v2:
 - patch 1: move the (vq->ioltb) check from vhost_vq_access_ok() to
            vq_access_ok() as suggested by MST
 - patch 2: new patch

---

Greg Kurz (2):
      vhost: Don't call access_ok() when using IOTLB
      vhost: Don't call log_access_ok() when using IOTLB


 drivers/vhost/vhost.c |   32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

--
Greg


