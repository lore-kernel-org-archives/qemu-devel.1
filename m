Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A0DC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C552075A
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx+s3EK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C552075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8m3-00085m-5j
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 14:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ib8dx-0006aA-R0
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ib8du-0005DD-Uf
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ib8du-0005Bm-L6
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575142977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gdd4Q4RMRSDm5tLmjp/rTzPoz4CH3l8cFoEEj9kufmM=;
 b=Tx+s3EK0eSHtxdLPDobsViG/I2cnt/82NhjvEvlYyFTCawosY5l5cagAWJPPsagoVyPfk4
 oEWjc3oj6hJUeDRM6Z0a9RIXcaB7dyiBeLbThu3D/r4Xl4gPBU5w89+rtVJHMfk/TzlQ6A
 0lxb26oxMtyER8IdhKQ3JDkm7hA+QXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-q2tjNsQpPReh9ZZkLbu7ww-1; Sat, 30 Nov 2019 14:42:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CAF780183C;
 Sat, 30 Nov 2019 19:42:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59C1E6404A;
 Sat, 30 Nov 2019 19:42:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 058361138606; Sat, 30 Nov 2019 20:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/21] Error handling fixes, may contain 4.2 material
Date: Sat, 30 Nov 2019 20:42:19 +0100
Message-Id: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: q2tjNsQpPReh9ZZkLbu7ww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 vsementsov@virtuozzo.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Nishanth Aravamudan <naravamudan@digitalocean.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PATCH 2-4 fix crash bugs.  Including them would be a no-brainer at
-rc0.  But we're post -rc3, and even for crash bugs we require a
certain likelihood of users getting bitten.

Jens, please assess impact of PATCH 2's crash bug.

Kevin, please do the same for PATCH 3.

Daniel, please do the same for PATCH 4.

The remainder is definitely not 4.2 material.

Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Corey Minyard <cminyard@mvista.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Jens Freimann <jfreimann@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

Markus Armbruster (21):
  net/virtio: Drop useless n->primary_dev not null checks
  net/virtio: Fix failover error handling crash bugs
  block/file-posix: Fix laio_init() error handling crash bug
  crypto: Fix certificate file error handling crash bug
  crypto: Fix typo in QCryptoTLSSession's <example> comment
  io: Fix Error usage in a comment <example>
  tests: Clean up initialization of Error *err variables
  exec: Fix latent file_ram_alloc() error handling bug
  hw/acpi: Fix latent legacy CPU plug error handling bug
  hw/core: Fix latent fit_load_fdt() error handling bug
  hw/ipmi: Fix latent realize() error handling bugs
  qga: Fix latent guest-get-fsinfo error handling bug
  memory-device: Fix latent memory pre-plug error handling bugs
  s390x/event-facility: Fix latent realize() error handling bug
  s390x/cpu_models: Fix latent feature property error handling bugs
  s390/cpu_modules: Fix latent realize() error handling bugs
  s390x: Fix latent query-cpu-model-FOO error handling bugs
  s390x: Fix latent query-cpu-definitions error handling bug
  error: Clean up unusual names of Error * variables
  hw/intc/s390: Simplify error handling in kvm_s390_flic_realize()
  tests-blockjob: Use error_free_or_abort()

 include/crypto/tlssession.h         |  2 +-
 include/io/task.h                   |  2 +-
 block/file-posix.c                  |  2 +-
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
 hw/net/virtio-net.c                 | 27 ++++----
 hw/ppc/spapr_pci.c                  | 16 ++---
 hw/ppc/spapr_pci_nvlink2.c          | 10 +--
 hw/s390x/event-facility.c           |  6 +-
 qga/commands-posix.c                |  6 +-
 target/s390x/cpu_models.c           | 98 +++++++++++++++++------------
 tests/test-blockjob.c               | 15 +++--
 tests/test-qobject-output-visitor.c |  8 +--
 tests/test-string-output-visitor.c  |  4 +-
 22 files changed, 154 insertions(+), 123 deletions(-)

--=20
2.21.0


