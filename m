Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896EDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5777A206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aN3vuX/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5777A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwA7-0002SB-LB
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlw7z-0007i9-Jj
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:06:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20945
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlw7x-0000tk-SM
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592492812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CTDk/C5sy9fdP7q38gb2YbsTx0EqwFQCAR3hRLnF4PU=;
 b=aN3vuX/hButl87RTGdLXHRc2wsbjXwwr1Dkhg4MLzq07gv3qM0X16f8eDi4UAJld3DUwLF
 +a+Tz4o4sE7XDfFIg/Ad7Ds1mIp6NEc0gQcp1Za3OWquwqsL/FwV1+Oh3ZatwJZnpVOESr
 Y6rCIMNlFiZIZSveNb+Bar4d7jDjLx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-zu7z8udsMHKvFsmcCsknPQ-1; Thu, 18 Jun 2020 11:06:36 -0400
X-MC-Unique: zu7z8udsMHKvFsmcCsknPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 206E5EC1A4;
 Thu, 18 Jun 2020 15:06:35 +0000 (UTC)
Received: from localhost (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCD691E2273;
 Thu, 18 Jun 2020 15:06:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 0/2] iotests: Make _filter_img_create more active
Date: Thu, 18 Jun 2020 17:06:26 +0200
Message-Id: <20200618150628.2169239-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00748.html

v2 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00931.html


Hi,

I somehow missed running iotests where qemu-img create fails, like 111.
v2 broke it because in contrast to v1, it returned early when there is
no “, fmt=” in the line instead of filtering the filename.

So v3 keeps the fixes pertaining to Maxim’s comments, but rolls back on
that other one: If there is no “, fmt=”, the function will not bail out
early, but just keep $options empty and continue on (like v1 did).


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/2:[0018] [FC] 'iotests: Make _filter_img_create more active'
002/2:[----] [--] 'iotests: filter few more luks specific create options'


Max Reitz (1):
  iotests: Make _filter_img_create more active

Maxim Levitsky (1):
  iotests: filter few more luks specific create options

 tests/qemu-iotests/087.out       |  6 +--
 tests/qemu-iotests/112.out       |  2 +-
 tests/qemu-iotests/134.out       |  2 +-
 tests/qemu-iotests/141           |  2 +-
 tests/qemu-iotests/153           |  9 ++--
 tests/qemu-iotests/158.out       |  4 +-
 tests/qemu-iotests/188.out       |  2 +-
 tests/qemu-iotests/189.out       |  4 +-
 tests/qemu-iotests/198.out       |  4 +-
 tests/qemu-iotests/263.out       |  4 +-
 tests/qemu-iotests/284.out       |  6 +--
 tests/qemu-iotests/common.filter | 93 +++++++++++++++++++++++---------
 12 files changed, 91 insertions(+), 47 deletions(-)

-- 
2.26.2


