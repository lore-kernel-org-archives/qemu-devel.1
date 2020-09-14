Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39CBC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633EE20759
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633EE20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnj6-0008Ib-Fn
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhY-0006SW-27
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:20 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:31930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhW-0000Zi-9r
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:19 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-LCyeZRnMPoCPDQ9v4JImlA-1; Mon, 14 Sep 2020 08:35:09 -0400
X-MC-Unique: LCyeZRnMPoCPDQ9v4JImlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09B621021D23;
 Mon, 14 Sep 2020 12:35:08 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 518021002D52;
 Mon, 14 Sep 2020 12:35:06 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/15] spapr: Error handling fixes and cleanups (round 2)
Date: Mon, 14 Sep 2020 14:34:50 +0200
Message-Id: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 08:35:13
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
Cc: Greg Kurz <groug@kaod.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yet another round of sanitizing the error handling in spapr. I've=0D
identified locations that needed fixing with the errp-guard.cocci=0D
coccinelle script. It turns out that a better result is achieved=0D
by fixing manually, especially by converting some void functions=0D
to indicate success/failure with a return value.=0D
=0D
Greg Kurz (15):=0D
  spapr: Fix error leak in spapr_realize_vcpu()=0D
  ppc: Add a return value to ppc_set_compat() and ppc_set_compat_all()=0D
  ppc: Fix return value in cpu_post_load() error path=0D
  spapr: Simplify error handling in callers of ppc_set_compat()=0D
  spapr: Get rid of cas_check_pvr() error reporting=0D
  spapr: Simplify error handling in do_client_architecture_support()=0D
  spapr: Simplify error handling in spapr_vio_busdev_realize()=0D
  spapr: Add a return value to spapr_drc_attach()=0D
  spapr: Simplify error handling in prop_get_fdt()=0D
  spapr: Add a return value to spapr_set_vcpu_id()=0D
  spapr: Simplify error handling in spapr_cpu_core_realize()=0D
  spapr: Add a return value to spapr_nvdimm_validate()=0D
  spapr: Add a return value to spapr_check_pagesize()=0D
  spapr: Simplify error handling in spapr_memory_plug()=0D
  spapr: Simplify error handling in spapr_memory_unplug_request()=0D
=0D
 include/hw/ppc/spapr.h        |  4 +-=0D
 include/hw/ppc/spapr_drc.h    |  2 +-=0D
 include/hw/ppc/spapr_nvdimm.h |  4 +-=0D
 target/ppc/cpu.h              |  4 +-=0D
 hw/ppc/spapr.c                | 76 ++++++++++++-----------------------=0D
 hw/ppc/spapr_caps.c           |  7 +++-=0D
 hw/ppc/spapr_cpu_core.c       | 24 +++++------=0D
 hw/ppc/spapr_drc.c            | 17 ++++----=0D
 hw/ppc/spapr_hcall.c          | 34 +++++++---------=0D
 hw/ppc/spapr_nvdimm.c         | 24 +++++------=0D
 hw/ppc/spapr_pci.c            |  5 +--=0D
 hw/ppc/spapr_vio.c            | 12 +++---=0D
 target/ppc/compat.c           | 26 +++++++-----=0D
 target/ppc/machine.c          |  9 +++--=0D
 14 files changed, 108 insertions(+), 140 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


