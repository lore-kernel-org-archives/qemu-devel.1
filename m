Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A626B20715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7BXiIZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A626B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaYFB-0004Gh-Tj
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaYBt-0006Fb-2C
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:19:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58998
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaYBr-0007IV-1K
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589779189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=slnwgKwIJv0fQSqbSeCI0vaZXv9a7OVuNa0sUhwg+rU=;
 b=Y7BXiIZ1TarL0+6jr3fDTK9eWyQeT1mIqWCPbQkYYc4tHZQFeSV/M2kFklQCrCEN3MQ/DE
 bE1NdweQDnbACA57lnxX7e/NzTTd8UB68NUu60ZE8u0F+XNtZ6DAcCdxuqjFkC8HF4N0L5
 bj2NaAZ6uDJknheBBJ5TJItTUa59Z28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-BdV0naTCMweabbHDSpwLJw-1; Mon, 18 May 2020 01:19:47 -0400
X-MC-Unique: BdV0naTCMweabbHDSpwLJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DC481005510
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 05:19:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1A2A82A0B;
 Mon, 18 May 2020 05:19:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B9D911358BC; Mon, 18 May 2020 07:19:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH not-for-merge 0/5] Instrumentation for "Fixes around device
 realization"
Date: Mon, 18 May 2020 07:19:40 +0200
Message-Id: <20200518051945.8621-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the instrumentation mentioned in "[PATCH 00/24] Fixes around
device realization".

PATCH 2/5 might have value on its own.  You tell me.

Shell script to smoke-test all machines:

#!/bin/sh
success=0
fail=0
ulimit -c 0
git-describe --dirty --match v\*
git-log --oneline -1
for i in bld/*-softmmu
do
    t=${i%-softmmu}
    t=${t##*/}
    q=$i/qemu-system-$t
    echo "= $t ="

    for m in `$q -M help | sed -n '/(alias of/d;2,$s/ .*//p'`
    do
	echo "== $m =="
	echo -e 'info qom-tree\ninfo qtree\nq' | $q -S -accel qtest -display none -L smoke-mon-roms -M $m -monitor stdio
	if [ $? -eq 0 ]
	then echo "*** Success: $m ***"; let success++
	else echo "*** Fail: $m"; let fail++
	fi
    done
done
echo $success succeeded, $fail failed


Markus Armbruster (5):
  qom: Instrument to detect missed realize
  qom: Make "info qom-tree" show children sorted
  qdev: Make "info qtree" show child devices sorted by QOM path
  qdev: Instrument to detect missed QOM parenting
  qdev: Instrument to detect bus mismatch

 hw/core/qdev.c     | 17 ++++++++++++++++
 qdev-monitor.c     | 32 ++++++++++++++++++++++++++++-
 qom/qom-hmp-cmds.c | 51 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 98 insertions(+), 2 deletions(-)

-- 
2.21.1


