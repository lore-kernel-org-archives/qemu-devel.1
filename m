Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8E1C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37922220D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTFU2SDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37922220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKomr-0002zZ-UU
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 16:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKolF-0001xk-H5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKolC-00082e-Tv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600805973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9x1hlobF7KdJZj9Gxk1LjuIS+slLQ+pwDxPhU6e65XM=;
 b=PTFU2SDdUQQ67SQzGisHHYk75sge+GvSZ8REiUK19OFvlBPdGYBv0RcIMwOae0XaPTEJKl
 IuAL4sCZL1GBDRh7OPTx1UIbSWlr4o5dmN9xk5pj/E854UpBLIv/mBeq0UOy13dpVFY8mI
 PLMELVcD6B2THaCavPqucw+ZicFh5b0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-Bz2zwGMvOnmXRDFrPmH-aw-1; Tue, 22 Sep 2020 16:19:31 -0400
X-MC-Unique: Bz2zwGMvOnmXRDFrPmH-aw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF4C118B9ECB;
 Tue, 22 Sep 2020 20:19:29 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 946A519D6C;
 Tue, 22 Sep 2020 20:19:23 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] i386/kvm: Assume IRQ routing is always available
Date: Tue, 22 Sep 2020 16:19:19 -0400
Message-Id: <20200922201922.2153598-1-ehabkost@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Sergio Lopez <slp@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM_CAP_IRQ_ROUTING is available since 2019 (Linux v2.6.30), so=0D
we can safely assume it's always present and remove some runtime=0D
checks.=0D
=0D
Eduardo Habkost (3):=0D
  i386/kvm: Require KVM_CAP_IRQ_ROUTING=0D
  i386/kvm: Remove IRQ routing support checks=0D
  i386/kvm: Delete kvm_allows_irq0_override()=0D
=0D
 target/i386/kvm_i386.h |  1 -=0D
 hw/i386/fw_cfg.c       |  2 +-=0D
 hw/i386/kvm/apic.c     |  5 ++---=0D
 hw/i386/kvm/ioapic.c   | 33 ++++++++++++++++-----------------=0D
 hw/i386/microvm.c      |  2 +-=0D
 hw/i386/pc.c           |  2 +-=0D
 target/i386/kvm-stub.c |  5 -----=0D
 target/i386/kvm.c      | 17 +++++------------=0D
 8 files changed, 26 insertions(+), 41 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D


