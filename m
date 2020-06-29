Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1C6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B72206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iv3wTIQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B72206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzZQ-0002ij-21
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jpzY8-0001WD-F0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 15:34:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41763
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jpzY6-0003GJ-KA
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 15:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593459277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B3yZwV4n/uIZvRqyNPD4IDCcs6cpedmKe0rRjeeh/Jw=;
 b=Iv3wTIQM5hr/k0jcYOU3LScrG5ibRAX05E6dMLagYh5VhP2+S1ByjCwhXGHrtKn39mITpG
 vZ5BjNFQNbnCjtDC2Sj+GoCN3ntj1NkyCE50kWjQQ5b3+8fKISqoBgkQ6zxB168FrCkOmf
 LpnjbCaTvE5H5tenPiTPe98qTBg/m6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-J0M966NUMQaqv6HrxhDHUQ-1; Mon, 29 Jun 2020 15:34:33 -0400
X-MC-Unique: J0M966NUMQaqv6HrxhDHUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC9071800D42;
 Mon, 29 Jun 2020 19:34:32 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C5D85C220;
 Mon, 29 Jun 2020 19:34:28 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
Subject: [PATCH v5 0/3] Avoid abort on QMP attempt to add an object with
 duplicate id
Date: Mon, 29 Jun 2020 21:34:21 +0200
Message-Id: <20200629193424.30280-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 15:34:37
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Attempting to add an object through QMP with an id that is
already used leads to a qemu abort. This is a regression since
d2623129a7de ("qom: Drop parameter @errp of object_property_add()
& friends").

The first patch fixes the issue and the second patch adds a test
to check the error is gracefully returned to the QMP client.

The last patch can be considered independently. It merges all the
object-add tests into a single test function and cover new failure
cases.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/qom-graceful-v5

History:

- v4 -> v5:
  - Use 1MB instead of 4GB as size in the hope it removes
    the patchew error

- v3 -> v4:
  - addressed style comment from Markus
  - added patch 3

- v2 -> v3:
  - don't take the object reference on failure in
    object_property_try_add_child
  - add g_assert_nonnull(resp) in 2/2 while keeping
    Thomas A-b

- v1 -> v2:
  - use the try terminology.
  - turn object_property_try_add() into a non-static function
  - add the test


Eric Auger (3):
  qom: Introduce object_property_try_add_child()
  tests/qmp-cmd-test: Add qmp/object-add-duplicate-id
  tests/qmp-cmd-test: Add qmp/object-add-failure-modes

 include/qom/object.h       |  26 ++++++++-
 qom/object.c               |  21 +++++--
 qom/object_interfaces.c    |   7 ++-
 tests/qtest/qmp-cmd-test.c | 109 +++++++++++++++++++++++++++++++++++--
 4 files changed, 149 insertions(+), 14 deletions(-)

-- 
2.20.1


