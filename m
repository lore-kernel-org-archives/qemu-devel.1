Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4974CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D628214F1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D628214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5B4z-0006RG-Sn
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 12:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B3q-0004vS-EL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B3o-0000fS-FM
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:10 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330--O7t_ejiMSOlC3mCQWJQUQ-1; Mon, 10 Aug 2020 12:53:54 -0400
X-MC-Unique: -O7t_ejiMSOlC3mCQWJQUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4837680183C;
 Mon, 10 Aug 2020 16:53:53 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61D5E5F1E4;
 Mon, 10 Aug 2020 16:53:51 +0000 (UTC)
Subject: [PATCH 00/14] ppc/spapr: Error handling fixes and cleanups
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:53:50 +0200
Message-ID: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.61; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series aims to be a follow up to Markus Ambruster's massive
work to sanitize error handling. It focuses on the following:
- check return values rather than a pointer to a local Error object
- get rid of the local_err + error_propagate() boilerplate when
  possible
- propage negative errnos to vmstate instead of -1

---

Greg Kurz (14):
      spapr: Simplify error handling in spapr_phb_realize()
      spapr/xive: Rework error handling of kvmppc_xive_cpu_connect()
      spapr/xive: Rework error handling of kvmppc_xive_source_reset()
      spapr/xive: Rework error handling of kvmppc_xive_mmap()
      spapr/xive: Rework error handling of kvmppc_xive_cpu_[gs]et_state()
      spapr/xive: Rework error handling of kvmppc_xive_[gs]et_queue_config(=
)
      spapr/xive: Rework error handling in kvmppc_xive_get_queues()
      spapr/xive: Rework error handling of kvmppc_xive_set_source_config()
      spapr/kvm: Fix error handling in kvmppc_xive_pre_save()
      spapr/xive: Fix error handling in kvmppc_xive_post_load()
      ppc/xive: Fix error handling in vmstate_xive_tctx_*() callbacks
      spapr/xive: Simplify error handling in kvmppc_xive_connect()
      ppc/xive: Simplify error handling in xive_tctx_realize()
      spapr/xive: Simplify error handling of kvmppc_xive_cpu_synchronize_st=
ate()


 hw/intc/spapr_xive_kvm.c    |  202 ++++++++++++++++++++++-----------------=
----
 hw/intc/xive.c              |   19 ++--
 hw/ppc/spapr_pci.c          |   16 +--
 include/hw/ppc/spapr_xive.h |    8 +-
 include/hw/ppc/xive.h       |    8 +-
 5 files changed, 125 insertions(+), 128 deletions(-)

--
Greg


