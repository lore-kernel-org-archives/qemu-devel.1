Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD56C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55852071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxZ1st6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55852071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZtQ-0001Ab-0U
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyZsE-0008Km-4j
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:58:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyZsB-0005cI-VR
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595505531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V+XeMEhX5Qae+J3ZPYKu1EUMJ8rBDpFyK54taYKfPEI=;
 b=IxZ1st6ROsNErziS9UDpMwztf8noHzfDja9jsUdiPcpLlq7rcnMWQCq6TSLA6h1sgR373V
 Ha25pzlVNmhS5J6CpBBMeG69yXpNP2dyqQ6y7oGc25yp66XvwpDe9Mvs1RTz2QdffGL/+N
 cdiS7ZSTT4ndl0RUfcd6ekWgXKYLKQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-EOP42UYIPrWUkYHD7BYXyg-1; Thu, 23 Jul 2020 07:58:48 -0400
X-MC-Unique: EOP42UYIPrWUkYHD7BYXyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D58480183C;
 Thu, 23 Jul 2020 11:58:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 521D55D9D3;
 Thu, 23 Jul 2020 11:58:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3783111CA26; Thu, 23 Jul 2020 13:58:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 0/2] tpm: Fix error reporting, improve help
Date: Thu, 23 Jul 2020 13:58:43 +0200
Message-Id: <20200723115845.1865886-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
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
Cc: philmd@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The alternative to PATCH 1 is a proper conversion to Error, as
discussed in

    Subject: Re: What is TYPE_TPM_TIS_ISA? (Not an ISA Device)
    Message-ID: <87tuxyoauy.fsf@dusky.pond.sub.org>

Such a conversion would be much too invasive for 5.1.  Going the other
way, like PATCH 1 does, is simple enough to be considered for 5.1.

To make this series a complete alternative to Philippe's
"[PATCH-for-5.1 v2 0/2] tpm: Improve error reporting", PATCH 2
improves help.

Markus Armbruster (2):
  Revert "tpm: Clean up error reporting in tpm_init_tpmdev()"
  tpm: Improve help on TPM types when none are available

 include/sysemu/tpm.h |  2 +-
 softmmu/vl.c         |  4 +++-
 stubs/tpm.c          |  3 ++-
 tpm.c                | 43 ++++++++++++++++++++++++++++++-------------
 4 files changed, 36 insertions(+), 16 deletions(-)

-- 
2.26.2


