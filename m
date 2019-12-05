Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9AC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C55120801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hF+ggO4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C55120801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictjn-0006XS-AD
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ictfb-0002yE-Tc
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ictfV-0001Hc-VY
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28832
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ictfR-0001Eq-LO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575562068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z67tXxs5nIPzW/9TpfEx63F3ereREtoclSWJP8apRwg=;
 b=hF+ggO4ywV7sNyd1eaHWhHTWwK0hIKGqhoZQAb6L+xWwgmmgy3O+WgAov/KBX3K+OXwJKr
 2l+bjWopPaLMqbfb8/KKQQe4f2VsQ5pPupL0qeW3DuDwCwAS2SCQyEaq5X2y4NhHlsBbr8
 spgw6+OoHdN4PqEc2HjPZg5yNhLYS/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-LJWV04W7MP215N_rPVDUvw-1; Thu, 05 Dec 2019 11:07:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D9841B18BC2;
 Thu,  5 Dec 2019 16:07:44 +0000 (UTC)
Received: from gondolin (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD131600D1;
 Thu,  5 Dec 2019 16:07:33 +0000 (UTC)
Date: Thu, 5 Dec 2019 17:07:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 00/18] Error handling fixes
Message-ID: <20191205170730.0d170c0f.cohuck@redhat.com>
In-Reply-To: <20191204093625.14836-1-armbru@redhat.com>
References: <20191204093625.14836-1-armbru@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: LJWV04W7MP215N_rPVDUvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  4 Dec 2019 10:36:07 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> v2:
> * Old PATCH 01-03 have been merged for 4.2
> * PATCH 05-15: Commit message rephrased [David], R-bys kept

Thanks, queued patches 11-15 to s390-next.

Patch 17 depends on patch 16, so I'll leave merging that one to you.

>=20
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Corey Minyard <cminyard@mvista.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> Markus Armbruster (18):
>   crypto: Fix certificate file error handling crash bug
>   crypto: Fix typo in QCryptoTLSSession's <example> comment
>   io: Fix Error usage in a comment <example>
>   tests: Clean up initialization of Error *err variables
>   exec: Fix file_ram_alloc() error API violations
>   hw/acpi: Fix legacy CPU plug error API violations
>   hw/core: Fix fit_load_fdt() error handling violations
>   hw/ipmi: Fix realize() error API violations
>   qga: Fix guest-get-fsinfo error API violations
>   memory-device: Fix memory pre-plug error API violations
>   s390x/event-facility: Fix realize() error API violations
>   s390x/cpumodel: Fix feature property error API violations
>   s390x/cpumodel: Fix realize() error API violations
>   s390x/cpumodel: Fix query-cpu-model-FOO error API violations
>   s390x/cpumodel: Fix query-cpu-definitions error API violations
>   error: Clean up unusual names of Error * variables
>   hw/intc/s390: Simplify error handling in kvm_s390_flic_realize()
>   tests-blockjob: Use error_free_or_abort()
>=20
>  include/crypto/tlssession.h         |  2 +-
>  include/io/task.h                   |  2 +-
>  crypto/tlscredsx509.c               |  2 +-
>  exec.c                              |  6 +-
>  hw/acpi/cpu_hotplug.c               | 10 +--
>  hw/core/loader-fit.c                | 15 ++---
>  hw/intc/s390_flic_kvm.c             | 16 +++--
>  hw/ipmi/isa_ipmi_bt.c               |  7 ++-
>  hw/ipmi/isa_ipmi_kcs.c              |  7 ++-
>  hw/ipmi/pci_ipmi_bt.c               |  6 +-
>  hw/ipmi/pci_ipmi_kcs.c              |  6 +-
>  hw/mem/memory-device.c              |  6 +-
>  hw/ppc/spapr_pci.c                  | 16 ++---
>  hw/ppc/spapr_pci_nvlink2.c          | 10 +--
>  hw/s390x/event-facility.c           |  6 +-
>  qga/commands-posix.c                |  6 +-
>  target/s390x/cpu_models.c           | 98 +++++++++++++++++------------
>  tests/test-blockjob.c               | 15 +++--
>  tests/test-qobject-output-visitor.c |  8 +--
>  tests/test-string-output-visitor.c  |  4 +-
>  20 files changed, 139 insertions(+), 109 deletions(-)
>=20


