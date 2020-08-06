Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855BFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9058723130
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ip3Y+Gpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9058723130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ggc-0006OH-LJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 10:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3geQ-0003lq-1T
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:13:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25788
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3geN-0007QT-09
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596723222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VzI4yV+L0ikiFjdv2+7+IC9OSAGMwImq9WRdu68RiTY=;
 b=ip3Y+Gpfg1WSY3xIOUuAHEwENXd/pylR9WjguZZpNlVL4CGqPxSgEF4i3DfhiVAkN1CHc4
 7BWh44ztNxC4Cv4+jPA/L8piCQWgPGKbNZKncT8NONNIFDzA4cUorxrQeqyGUwuntScY6p
 L6jEY2yDSJrjSDGcKmLXtub0n8/12Jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-6PWWdHDOPtezQBq4nR6J8A-1; Thu, 06 Aug 2020 10:13:40 -0400
X-MC-Unique: 6PWWdHDOPtezQBq4nR6J8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 677471005510
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 14:13:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A16C17C0E5;
 Thu,  6 Aug 2020 14:13:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16CBA1132801; Thu,  6 Aug 2020 16:13:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] trace-events: Clean up
Date: Thu,  6 Aug 2020 16:13:30 +0200
Message-Id: <20200806141334.3646302-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: philmd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe's "[PATCH] softmmu: Add missing trace-events file" made me
look for more.  Enjoy!

Based-on: <20200805130221.24487-1-philmd@redhat.com>

Markus Armbruster (4):
  scripts/cleanup-trace-events: Fix for vcpu property
  scripts/cleanup-trace-events: Emit files in alphabetical order
  trace-events: Delete unused trace points
  trace-events: Fix attribution of trace points to source

 audio/trace-events              |  3 ---
 block/trace-events              |  8 ++-----
 hw/block/trace-events           |  2 +-
 hw/char/trace-events            |  2 +-
 hw/display/trace-events         |  4 +++-
 hw/hyperv/trace-events          |  2 +-
 hw/mips/trace-events            |  2 +-
 hw/misc/trace-events            |  9 ++++----
 hw/ppc/trace-events             | 10 ++-------
 hw/riscv/trace-events           |  2 +-
 hw/rtc/trace-events             |  2 +-
 hw/timer/trace-events           |  1 -
 hw/tpm/trace-events             |  2 +-
 hw/usb/trace-events             |  4 +++-
 hw/vfio/trace-events            | 10 +++++----
 hw/virtio/trace-events          |  2 +-
 migration/trace-events          | 37 +++++++++++++++++----------------
 scripts/cleanup-trace-events.pl | 23 ++++++++++++--------
 target/ppc/trace-events         |  1 -
 target/riscv/trace-events       |  2 +-
 trace-events                    |  5 +++--
 ui/trace-events                 |  6 +++---
 util/trace-events               |  4 +++-
 23 files changed, 72 insertions(+), 71 deletions(-)

-- 
2.26.2


