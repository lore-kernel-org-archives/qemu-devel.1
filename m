Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70824C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F8F20723
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqRBi73Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F8F20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZdf-0005D1-CB
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeZcn-0003sG-MQ
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:40:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeZcm-0001mu-SG
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590738015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pQn0bGDZvr2S3O3jxeuAg3AzJn+Iii0I+O8+ViqeBjo=;
 b=SqRBi73QcIL5NcVeB4u3EvriEeKDSGPFd/PAvU61uYSDUvRqwqcPSXQlDSzSHn5yzsBHkN
 GRcEEBWCWjIjeDYR19ZQm8H3uuoNotltZ9mCNCHBv0yxYxNtpnmeszq3tNnlPDyCGBmMSV
 l7saN9urTortR/fOYqlbU2sggbuGZJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-j2IMzAvKPCG-RW4t-W3vUw-1; Fri, 29 May 2020 03:40:14 -0400
X-MC-Unique: j2IMzAvKPCG-RW4t-W3vUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF73D800D24;
 Fri, 29 May 2020 07:40:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EB1FA1035;
 Fri, 29 May 2020 07:39:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3314616E2C; Fri, 29 May 2020 09:39:57 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] microvm: memory config tweaks
Date: Fri, 29 May 2020 09:39:53 +0200
Message-Id: <20200529073957.8018-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 imammedo@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With more microvm memory config tweaks split this into its owns series,
the microvm acpi patch series is already big enough ...

v2:
 - use 3G split.
 - add patch to move virtio-mmio region.
 - pick up acks & reviews.
v3:
 - fix xen build.
 - pick up acks & reviews.

take care,
  Gerd

Gerd Hoffmann (4):
  microvm: use 3G split unconditionally
  microvm: drop max-ram-below-4g support
  x86: move max-ram-below-4g to pc
  microvm: move virtio base to 0xfeb00000

 include/hw/i386/microvm.h |  2 +-
 include/hw/i386/pc.h      |  2 ++
 include/hw/i386/x86.h     |  4 ----
 hw/i386/microvm.c         | 35 +----------------------------
 hw/i386/pc.c              | 46 +++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c         | 10 ++++-----
 hw/i386/pc_q35.c          | 10 ++++-----
 hw/i386/x86.c             | 46 ---------------------------------------
 hw/i386/xen/xen-hvm.c     |  2 +-
 9 files changed, 61 insertions(+), 96 deletions(-)

-- 
2.18.4


