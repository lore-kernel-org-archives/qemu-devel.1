Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93818C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6239320671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xypvh5QX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6239320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQO0-00005l-Ia
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbQNL-0007eg-2Y
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:11:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbQNJ-0000O6-Uo
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589987475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H+VqHMnoUsUmSLlqYe+yF671Xo0R1cJZx6dSNOy88rM=;
 b=Xypvh5QXOos0KBtmeEWLRatSeQEF1U/3goH2Bu3VXF69xFfD1+rFt5qhHg9fp4QFMGyP8i
 qg8gYZmA7lEN93YPS/PQh7Pfh91StKugVRtYmZUDtyhvBq7fAWgMdzoT7ugvLrURcTkXCP
 7QY8u42K3ql99SbdEV8ZNcnLdzEDIRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-kY0LMa_6OZSxP_ex4a3a7w-1; Wed, 20 May 2020 11:11:12 -0400
X-MC-Unique: kY0LMa_6OZSxP_ex4a3a7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D62C8474;
 Wed, 20 May 2020 15:11:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-169.ams2.redhat.com
 [10.36.114.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A876A600E3;
 Wed, 20 May 2020 15:11:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	armbru@redhat.com
Subject: [PATCH 0/2] HMP: qom-get and set
Date: Wed, 20 May 2020 16:11:06 +0100
Message-Id: <20200520151108.160598-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, clg@kaod.org, afaerber@suse.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

HMP has had a qom-set for a long time, but not a matching qom-get;
various attempts have been made to add one over the last 5 years.
Here's another go.

It's got simpler due to a suggestion by Markus to take the output
from qmp's qom-get.  While we're here, rework hmp's qom-set to be
a wrapper around the qmp equivalent, which simplifies it a bit.

In one post people didn't particularly like the use of JSON,
but in the intervening 4 years no one has implemented anything to
avoid it, and the output is trivially readable for non-structures
and still pretty readable for (the very rare) structures.

Dave

Dr. David Alan Gilbert (2):
  hmp: Implement qom-get HMP command
  hmp: Simplify qom_set

 hmp-commands.hx        | 14 ++++++++++++++
 include/monitor/hmp.h  |  1 +
 qom/qom-hmp-cmds.c     | 34 +++++++++++++++++++++++-----------
 tests/qtest/test-hmp.c |  1 +
 4 files changed, 39 insertions(+), 11 deletions(-)

-- 
2.26.2


