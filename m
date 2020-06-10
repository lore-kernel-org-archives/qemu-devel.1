Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1140AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF03206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5loXeJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF03206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj3kP-0007uq-2e
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 12:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj3jY-0006VO-EO
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:37:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24880
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj3jX-0007NK-Oo
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591807067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J6AfX+ggEQ2HL6W79adcL+pToHj0MVsrqJoGzODj1RA=;
 b=Z5loXeJj3f6KOd93NJ5QrZoyUlYJTA1k0GaJTDNGXBzmXZUORQ2MnDHU+LOklZcG55BABj
 07RR+Ot3b6uII55N16cUe+DfMGRHQrGaY/zjYJ9Txegsu15Tt8e8fhb0HgxCapj+GVOw8l
 auAGJYVtuQLVkHooBexMl8RhAHs0hOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-q0PS2VmwPZCIK-YKYd1XcA-1; Wed, 10 Jun 2020 12:37:43 -0400
X-MC-Unique: q0PS2VmwPZCIK-YKYd1XcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24054872FF7;
 Wed, 10 Jun 2020 16:37:42 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 966E710027AA;
 Wed, 10 Jun 2020 16:37:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Fix NBD CVE-2020-10761
Date: Wed, 10 Jun 2020 11:37:39 -0500
Message-Id: <20200610163741.3745251-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: xuwei@redhat.com, vsementsov@virtuozzo.com, qemu-stable@nongnu.org,
 qemu-block@nongnu.org, ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In qemu 4.2, I accidentally introduced the ability for an NBD client
obeying the specification to kill qemu as NBD server with an assertion
failure when the client requests an unusually long export name, as a
regression from the intended graceful server error message back to the
client.

In v2:
- use strnlen instead of strlen
- malloc a sane string rather than using a static buffer [Vladimir]
- enhance commit message
- tweak iotest to use different abbreviation than qemu-nbd
- add R-b on patch 2

Once this is reviewed, I'll then spin v2 of my NBD pull request.

Eric Blake (2):
  nbd/server: Avoid long error message assertions CVE-2020-10761
  block: Call attention to truncation of long NBD exports

 block.c                    |  7 +++++--
 block/nbd.c                | 21 +++++++++++++--------
 nbd/server.c               | 23 ++++++++++++++++++++---
 tests/qemu-iotests/143     |  4 ++++
 tests/qemu-iotests/143.out |  2 ++
 5 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.27.0


