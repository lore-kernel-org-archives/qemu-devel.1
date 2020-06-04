Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6799C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88436206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co5JcFWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88436206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgvwB-0001iF-RI
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 15:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgvv9-0000SX-VM
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:52:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgvv8-0008Py-DE
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591300377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k9n1IxDzBOAQDCzfF7eKLKnk5SORGBd7/iEXj4AvHVE=;
 b=Co5JcFWj+CAeyu4yBDpX/1cIbZQ2U84Cx5Qn86sSR6Vt70DiwHylJTxcTAmemKmRMeL8AH
 uwXeGHzeH/zHQFcAiVK0NPgisjGNgk3scmwez2xNfAdxr8ka5lSZHiB6q06XdkEgFKB0wu
 XuauAIXHcnUitnR2vHvnp5Lql75t4J4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-58HXD3GYOHuhWBV14lpi-A-1; Thu, 04 Jun 2020 15:52:55 -0400
X-MC-Unique: 58HXD3GYOHuhWBV14lpi-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29934801503
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 19:52:54 +0000 (UTC)
Received: from probe.redhat.com (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 512A36ACF6;
 Thu,  4 Jun 2020 19:52:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] python/machine.py: refactor shutdown
Date: Thu,  4 Jun 2020 15:52:49 -0400
Message-Id: <20200604195252.20739-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, philmd@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:
 - Split _post_shutdown refactor into own patch (now 1/3)
 - Re-add sigkill warning squelch (now 3/3)

NOTE: I re-added the squelch in its own patch for review purposes, but
for the purposes of avoiding temporary breakage, a maintainer may wish
to squash patches 2 and 3 if they are accepted.

v2: Philippe took patches 1, 3 and 4.

This is a re-write of what was:
[PATCH RFC 03/32] python//machine.py: remove bare except
[PATCH 2/4] python/machine.py: remove bare except

It's a bit heavier handed, but it should address some of kwolf's
feedback from the RFC version.

Applies straight to origin/master, ought to pass pylint and flake8:

> cd ~/src/qemu/python/qemu
> pylint *.py
> flake8 *.py

John Snow (3):
  python/machine.py: consolidate _post_shutdown()
  python/machine.py: refactor shutdown
  python/machine.py: re-add sigkill warning suppression

 python/qemu/machine.py | 100 +++++++++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 29 deletions(-)

-- 
2.21.3


