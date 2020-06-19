Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9920EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C332073E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUq2wsuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C332073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmE1M-0005m3-Hl
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmDzp-0003iY-EB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:11:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32595
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmDzn-00049X-QG
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592561499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hEpjPz/ltPTLbOah6saY3MbC4v9utwseCP9UFJ1WO0I=;
 b=EUq2wsuZQ0ILq8Py46Rlol0D/k7mnVFskwDXwimLvrNojICbOW9QnzdZkBkfDOR3iCbdxp
 W7QqpjpGbv9ziIGHrQaY8dDQTMXVwc3aR73Cf5nG3AkfzOGQV+lzD8/yXQso8Jo0FiqR+V
 iWexi0EmwrlN9+FSmhTKpxRhBrk0prg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-5L3DGDnGMs6Z6VVBpuTzXw-1; Fri, 19 Jun 2020 06:11:37 -0400
X-MC-Unique: 5L3DGDnGMs6Z6VVBpuTzXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A596B872FE1;
 Fri, 19 Jun 2020 10:11:36 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B14419C79;
 Fri, 19 Jun 2020 10:11:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] qemu-storage-daemon: memory leak and --object opts fixes
Date: Fri, 19 Jun 2020 11:11:30 +0100
Message-Id: <20200619101132.2401756-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U21hbGwgZml4ZXMgZm9yIHFlbXUtc3RvcmFnZS1kYWVtb24uDQoNClN0ZWZhbiBIYWpub2N6aSAo
Mik6DQogIHFlbXUtc3RvcmFnZS1kYWVtb246IHJlbWVtYmVyIHRvIGFkZCBxZW11X29iamVjdF9v
cHRzDQogIHFlbXUtc3RvcmFnZS1kYWVtb246IGFkZCBtaXNzaW5nIGNsZWFudXAgY2FsbHMNCg0K
IHFlbXUtc3RvcmFnZS1kYWVtb24uYyB8IDUgKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspDQoNCi0tIA0KMi4yNi4yDQoNCg==


