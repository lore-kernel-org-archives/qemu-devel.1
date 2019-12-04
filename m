Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC7C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DED205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxo4fDeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DED205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icRgy-0003yv-JM
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 05:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icR5X-0007FT-50
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icR5N-0000gL-DW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45018
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icR5M-0000Nk-5f
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575452196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u+MJwS7c7yhwQdy44zu30iMRRHItrHA82k/aWR1ji0c=;
 b=bxo4fDeUYwRNnb6DhBAoOG+KXd3prJrmj/Y6T5o3o65qgoRPG4z0URnUIODpPV3qsjxEiv
 2ozy3rDvCeHpWUi+TOl1PcISNNKrVI/owjGry2OMHCDwls86TqjhMdBDpXkR/pgJCtEJPT
 fCPB2grWttVacGL67i9zb2M66+xjLrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-Trwm_rFkMsO8jAyoN29nzA-1; Wed, 04 Dec 2019 04:36:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE5C7DC22;
 Wed,  4 Dec 2019 09:36:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00A7D1D1;
 Wed,  4 Dec 2019 09:36:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 837F11138606; Wed,  4 Dec 2019 10:36:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/18] Error handling fixes
Date: Wed,  4 Dec 2019 10:36:07 +0100
Message-Id: <20191204093625.14836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Trwm_rFkMsO8jAyoN29nzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
* Old PATCH 01-03 have been merged for 4.2
* PATCH 05-15: Commit message rephrased [David], R-bys kept

Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Corey Minyard <cminyard@mvista.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

Markus Armbruster (18):
  crypto: Fix certificate file error handling crash bug
  crypto: Fix typo in QCryptoTLSSession's <example> comment
  io: Fix Error usage in a comment <example>
  tests: Clean up initialization of Error *err variables
  exec: Fix file_ram_alloc() error API violations
  hw/acpi: Fix legacy CPU plug error API violations
  hw/core: Fix fit_load_fdt() error handling violations
  hw/ipmi: Fix realize() error API violations
  qga: Fix guest-get-fsinfo error API violations
  memory-device: Fix memory pre-plug error API violations
  s390x/event-facility: Fix realize() error API violations
  s390x/cpumodel: Fix feature property error API violations
  s390x/cpumodel: Fix realize() error API violations
  s390x/cpumodel: Fix query-cpu-model-FOO error API violations
  s390x/cpumodel: Fix query-cpu-definitions error API violations
  error: Clean up unusual names of Error * variables
  hw/intc/s390: Simplify error handling in kvm_s390_flic_realize()
  tests-blockjob: Use error_free_or_abort()

 include/crypto/tlssession.h         |  2 +-
 include/io/task.h                   |  2 +-
 crypto/tlscredsx509.c               |  2 +-
 exec.c                              |  6 +-
 hw/acpi/cpu_hotplug.c               | 10 +--
 hw/core/loader-fit.c                | 15 ++---
 hw/intc/s390_flic_kvm.c             | 16 +++--
 hw/ipmi/isa_ipmi_bt.c               |  7 ++-
 hw/ipmi/isa_ipmi_kcs.c              |  7 ++-
 hw/ipmi/pci_ipmi_bt.c               |  6 +-
 hw/ipmi/pci_ipmi_kcs.c              |  6 +-
 hw/mem/memory-device.c              |  6 +-
 hw/ppc/spapr_pci.c                  | 16 ++---
 hw/ppc/spapr_pci_nvlink2.c          | 10 +--
 hw/s390x/event-facility.c           |  6 +-
 qga/commands-posix.c                |  6 +-
 target/s390x/cpu_models.c           | 98 +++++++++++++++++------------
 tests/test-blockjob.c               | 15 +++--
 tests/test-qobject-output-visitor.c |  8 +--
 tests/test-string-output-visitor.c  |  4 +-
 20 files changed, 139 insertions(+), 109 deletions(-)

--=20
2.21.0


