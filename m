Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D3FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC6320657
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5qPn/U0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC6320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvx3-0002yL-Nj
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtvjF-0001zl-2D
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:18:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25416
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtvjD-0005ZD-HF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594397902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GNhRONvgSchpmOBnztX5CiUSmt4KFErMB1zOVJIATW0=;
 b=b5qPn/U0hAbURqzRsVlFjpg1n2uKAiOyN2iqBuoG5sWym0QSRJB4E16UmvcoW7e0iL2a3w
 BKs3GL/FGfkfJ4ZmxxdmZ7WsrHIAMO6pOmhv11YoMwJvv8Iyhyn2W7/Za4Wm35ZgIuanAx
 tD+oZeTEghKfd6GZ2L+fVTfDtyFocvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-yxo3UxxlNtui2jN0RMoCjA-1; Fri, 10 Jul 2020 12:17:09 -0400
X-MC-Unique: yxo3UxxlNtui2jN0RMoCjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82EE110059A9;
 Fri, 10 Jul 2020 16:17:08 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 804BD7EF9E;
 Fri, 10 Jul 2020 16:17:07 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 0/3] x86: fix cpu hotplug with secure boot
Date: Fri, 10 Jul 2020 12:17:01 -0400
Message-Id: <20200710161704.309824-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lersek@redhat.com, boris.ostrovsky@oracle.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPU hotplug with Secure Boot was not really supported and firmware wasn't aware
of hotplugged CPUs (which might lead to guest crashes). During 4.2 we introduced
locked SMI handler RAM arrea to make sure that guest OS wasn't able to inject
its own SMI handler and OVMF added initial CPU hotplug support.

This series is QEMU part of that support [1] which lets QMVF tell QEMU that
CPU hotplug with SMI broadcast enabled is supported so that QEMU would be able
to prevent hotplug in case it's not supported and trigger SMI on hotplug when
it's necessary. 

1) CPU hotplug negotiation part was introduced later so it might not be
in upstream OVMF yet or I might have missed the patch on edk2-devel
(Laszlo will point out to it/post formal patch)

Igor Mammedov (3):
  x86: lpc9: let firmware negotiate CPU hotplug SMI feature
  x86: cphp: prevent guest crash on CPU hotplug when broadcast SMI is in
    use
  x68: acpi: trigger SMI before scanning for hotplugged CPUs

 include/hw/acpi/cpu.h  |  1 +
 include/hw/i386/ich9.h |  1 +
 hw/acpi/cpu.c          |  6 ++++++
 hw/acpi/ich9.c         | 12 +++++++++++-
 hw/i386/acpi-build.c   | 33 ++++++++++++++++++++++++++++++++-
 hw/i386/pc.c           | 15 ++++++++++++++-
 hw/isa/lpc_ich9.c      | 10 ++++++++++
 7 files changed, 75 insertions(+), 3 deletions(-)

-- 
2.26.2


