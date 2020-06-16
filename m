Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C822080D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScsD1o5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C822080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBVZ-00078Q-Hm
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlBTc-00063G-EJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:18:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34350
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlBTZ-0004hJ-ER
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592313483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aSh1165xYnYBCb7haMzKeCNTGU6RZbOmzQDZbigbvbQ=;
 b=ScsD1o5f8RAvH7GTKc9MeFlopwXxdyiCStl9Wmrh1ZLHoho257J2J+gu6toNqYh4LSDBIc
 Ul5oUSCN0XPWwcKU8tAGk8ZVF1T+egc23S10ZV0N4AD5ddTZDrOzicsJaTGm4L+KrwheRl
 9C2zzg7ls3dUkaN6VWKi3ROSuPfE9cE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-Az9mQmZOPa2PYv20YjXGpg-1; Tue, 16 Jun 2020 09:17:59 -0400
X-MC-Unique: Az9mQmZOPa2PYv20YjXGpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8F63873431;
 Tue, 16 Jun 2020 13:17:58 +0000 (UTC)
Received: from localhost (ovpn-112-244.ams2.redhat.com [10.36.112.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B3FA5C1C3;
 Tue, 16 Jun 2020 13:17:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/2] iotests: Make _filter_img_create more active
Date: Tue, 16 Jun 2020 15:17:54 +0200
Message-Id: <20200616131756.1073438-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi,

Applying Maxim’s series for LUKS encryption slot management through
qemu-img amend / blockdev-amend has brought a – on the first glance –
rather minor problem: It changes the order of qcow2’s creation options,
which results in some reference output changes (patch 5:
https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00335.html
).  This affects some tests that can also run with other image formats,
such as qcow, whose order does not change.  So this patch breaks those
tests (I’ve seen it for 134 and 158) when run with a different format
than qcow2 (e.g. qcow).

Now we could just create a difference reference output for qcow2, as is
done e.g. for test 150.  But that would not only be boring, but also not
really sustainable: The actual problem is that the order of creation
options simply does not have to be the same between different image
formats, and so we should not just dump qemu-img create’s output to a
reference output, drop some format-specific options and expect it to
work independent of the format for which the test is run.

So patch 1 in this series makes _filter_img_create sort the creation
options as they appear in the “Formatting” line, so it’s always the same
order between formats.  (And I took this opportunity to also reverse the
filtering implementation from denylisting to allowlisting.)

Patch 2 is taken from Maxim’s series and modified to fit the new
implementation.

I propose putting this series underneath Maxim’s series (in my block
branch) so the latter won’t break 134 and 158 for qcow.  (Doing so will
require dropping some hunks from the patch linked above, but that should
be fine.)


Max Reitz (1):
  iotests: Make _filter_img_create more active

Maxim Levitsky (1):
  iotests: filter few more luks specific create options

 tests/qemu-iotests/087.out       |  6 +-
 tests/qemu-iotests/112.out       |  2 +-
 tests/qemu-iotests/134.out       |  2 +-
 tests/qemu-iotests/153           |  9 ++-
 tests/qemu-iotests/158.out       |  4 +-
 tests/qemu-iotests/188.out       |  2 +-
 tests/qemu-iotests/189.out       |  4 +-
 tests/qemu-iotests/198.out       |  4 +-
 tests/qemu-iotests/263.out       |  4 +-
 tests/qemu-iotests/284.out       |  6 +-
 tests/qemu-iotests/common.filter | 97 ++++++++++++++++++++++++--------
 11 files changed, 94 insertions(+), 46 deletions(-)

-- 
2.26.2


