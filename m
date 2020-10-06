Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA660C4727E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC1F20866
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlBh4eUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC1F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPj9X-0006Zw-T8
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPj88-0005ZS-90
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPj84-0007aF-WA
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601975967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j7/T3o68oYJBd3geI0S7e/gbZnfUWPM8d4y/Pnk409k=;
 b=AlBh4eUXuIJYc+v/U2AzX2AA5akJPYApPctqNITyYx/sEWcIkAlculV6Gx4bEYOrdOZFv1
 rX8okiDbIjR3Ls/5EVsm91GNEPaIPKQL+6n9D7RUCdFDI+HmbWqMUDMX+HufdPWr6cnmRF
 g2ylhQA2Dq6x/M9rAggRuM53OOxPzWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-gbf8CLKcMWycpHhN3BMsIA-1; Tue, 06 Oct 2020 05:19:24 -0400
X-MC-Unique: gbf8CLKcMWycpHhN3BMsIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CAE88D9843
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 09:19:23 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F80B10013BD
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 09:19:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Move more code to softmmu/
Date: Tue,  6 Oct 2020 05:19:20 -0400
Message-Id: <20201006091922.331832-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This small series moves more files to the softmmu/ directory.
Patch 1 covers files that can be moved completely, while
patch 2 splits exec.c into common and softmmu parts.

Based-on: <20201006072947.487729-1-pbonzini@redhat.com>

Paolo Bonzini (2):
  softmmu: move more files to softmmu/
  exec: split out non-softmmu-specific parts

 MAINTAINERS                              |   4 +-
 cpu.c                                    | 452 ++++++++++++++++++++++
 include/exec/cpu-common.h                |   3 +
 meson.build                              |  12 +-
 bootdevice.c => softmmu/bootdevice.c     |   0
 device_tree.c => softmmu/device_tree.c   |   0
 dma-helpers.c => softmmu/dma-helpers.c   |   0
 softmmu/meson.build                      |  11 +
 exec.c => softmmu/physmem.c              | 454 +----------------------
 qdev-monitor.c => softmmu/qdev-monitor.c |   0
 qemu-seccomp.c => softmmu/qemu-seccomp.c |   0
 tpm.c => softmmu/tpm.c                   |   0
 12 files changed, 476 insertions(+), 460 deletions(-)
 create mode 100644 cpu.c
 rename bootdevice.c => softmmu/bootdevice.c (100%)
 rename device_tree.c => softmmu/device_tree.c (100%)
 rename dma-helpers.c => softmmu/dma-helpers.c (100%)
 rename exec.c => softmmu/physmem.c (91%)
 rename qdev-monitor.c => softmmu/qdev-monitor.c (100%)
 rename qemu-seccomp.c => softmmu/qemu-seccomp.c (100%)
 rename tpm.c => softmmu/tpm.c (100%)

-- 
2.26.2


