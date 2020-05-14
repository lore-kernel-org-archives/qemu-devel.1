Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC607C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 02:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF9B205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 02:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXEepoeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF9B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ3a5-0001AN-Ht
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 22:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ3ZE-0008Dx-QT
 for qemu-devel@nongnu.org; Wed, 13 May 2020 22:25:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ3ZD-000309-4R
 for qemu-devel@nongnu.org; Wed, 13 May 2020 22:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589423142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eADQqk9OQzCmSqI8HMFEbm/E/yxJaEUjCjBSbR1W6ro=;
 b=TXEepoeH9JDSfEg5ypXeKm89Qrw43ZFOlfJtPl91dEfpmbBrOdA5a15iaF00Vr+9yvKbOh
 +a7jdeqjyR0Aqp1cfLTzWhx3udhxt4jcseSV7uinqGi3anEWveYB/C0mqB9QoCGmKRNcmZ
 0YMCVc9Yg2KA9bcL/FNVqPUUTtr55fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-qNqj_VlfPLmf-GlB0tY4yA-1; Wed, 13 May 2020 22:25:39 -0400
X-MC-Unique: qNqj_VlfPLmf-GlB0tY4yA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67A0B107ACF6;
 Thu, 14 May 2020 02:25:38 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA66579AD;
 Thu, 14 May 2020 02:25:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] iotests: add JobRunner framework
Date: Wed, 13 May 2020 22:25:33 -0400
Message-Id: <20200514022536.2568-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The basic idea is to make a generic job runtime manager and allow
callers to subclass the manager. Then, instead of adding callback
arguments to the function all the time, we have à la carte customization
of the loop.

To showcase this a little bit, I removed the pre_finalization argument
and made existing callers use a custom JobRunner; and then converted
test 040 to use this style of job runner.

Is it a simplification? No. Is it cool? Maybe. Did it remove the
duplicated job-running code in 040? yes.

As of V4, I'm not sure I really want to pursue this at the moment; it
does feel a bit harder to use than the old interface; though it's more
"complete". I might look into refining the idea and trying to include it
directly in python/qemu; and providing some more 'bespoke' wrappers in
iotests that make using it in the test framework a little less
cumbersome.

Regardless, I am posting it to the list for archiving for now.

v4:
 - Rebased on current master.
 - Converted new usages is test 055.

V3:
 - Rebased on logging series v8
 - Converted 155's new usage of job_run

V2:
 - Rebased on logging series; logging conditionals are pretty now.
 - Inlined callback login in 257
 - No longer based on bitmap-populate job (no test 287)
 - Moved super() call to the beginning of test 040's callback
 - Added docstrings and type annotations

John Snow (3):
  qmp.py: change event_wait to use a dict
  iotests: add JobRunner class
  iotests: modify test 040 to use JobRunner

 python/qemu/machine.py        |  10 +-
 tests/qemu-iotests/040        |  51 +++++----
 tests/qemu-iotests/055        |  17 +--
 tests/qemu-iotests/155        |  11 +-
 tests/qemu-iotests/255        |   9 +-
 tests/qemu-iotests/257        |  54 +++++----
 tests/qemu-iotests/260        |   5 +-
 tests/qemu-iotests/iotests.py | 206 +++++++++++++++++++++++++---------
 tests/qemu-iotests/pylintrc   |  11 ++
 9 files changed, 258 insertions(+), 116 deletions(-)

-- 
2.21.1


