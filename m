Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEA32100A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gk6knFUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEA32100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef9x-0005Ji-HN
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jef96-0003e8-5F
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:34:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jef94-0000T6-Pa
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s+pe4E8ECkXT6PMyvQdZMCuSpqaCwOBxyjgGiD6xwy4=;
 b=gk6knFUwSnRHW7QsEb0gJU5c2LJA/Il8zoz8mUfP1TSBYEykGopYwZ50RwwEYPwVBp5ZtL
 JNiAui9tVMGbhPZScdk5RzVcD6qDsIzqMXVtvXiBH3IunBDAKm+ZShoxeiLJgsRbOzuRTb
 ARd60j+Ni712HHmwAoYJd+87Sb1KPf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-X6ymZMj_MzWVI5a99-ri5A-1; Fri, 29 May 2020 09:33:53 -0400
X-MC-Unique: X6ymZMj_MzWVI5a99-ri5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C401800688;
 Fri, 29 May 2020 13:33:52 +0000 (UTC)
Received: from lisa.redhat.com (unknown [10.40.192.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D613F5D9D5;
 Fri, 29 May 2020 13:33:50 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Couple of HMAT fixes
Date: Fri, 29 May 2020 15:33:45 +0200
Message-Id: <cover.1590753455.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've started working on libvirt side of this feature. WIP patches can be
found here:

https://github.com/zippy2/libvirt/commits/hmat

I've gotten to a point where libvirt generates cmd line but QEMU refuses
it. Problem is that I was looking into qemu-options.hx instead of
qapi/machine.json and thus found some irregularities between these two.

I'm not necessarily stating that all these patches are correct (I have
some doubts about 3/3 because nearly identical code can be found in
machine_set_cpu_numa_node(), but I have no idea if it's a coincidence).

Michal Privoznik (3):
  qapi: Make @associativity, @policy and @line of NumaHmatCacheOptions
    optional
  numa: Allow HMAT cache to be defined before HMAT latency/bandwidth
  numa: Initialize node initiator with respect to .has_cpu

 hw/core/numa.c    | 22 +++++++++-------------
 qapi/machine.json |  6 +++---
 2 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.26.2


