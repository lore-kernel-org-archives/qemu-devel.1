Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48BBC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BF3206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgjSI/xN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BF3206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9iP-00064Z-Su
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kI9gZ-0004nv-2M
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:03:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kI9gX-0006iG-DO
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600171424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZpHqPK3CK146Mal6bKd6DMflnGlmiJ5y/KzwNBn/QvM=;
 b=FgjSI/xNzjwfKddqQMvJ432n/EAE6KrcB7La5QVOm7yqdchKwkgF56B/lCF+T6g5Js7FxC
 FV3GBZo8HO2CB17dgMTjixKQ/kxwHZcjpGxVsjV3ssdNRG4SaRM7tQyzvi8h2CVF0x0ITi
 ROaFQo3WCqNPhhk0hT11VPf4nglvmsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-THQKxIPiM0uv1l1yVqnnwg-1; Tue, 15 Sep 2020 08:03:42 -0400
X-MC-Unique: THQKxIPiM0uv1l1yVqnnwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 149E21074653;
 Tue, 15 Sep 2020 12:03:41 +0000 (UTC)
Received: from localhost (ovpn-112-192.ams2.redhat.com [10.36.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94CF55F704;
 Tue, 15 Sep 2020 12:03:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] fdmon-poll: reset npfd when upgrading to fdmon-epoll
Date: Tue, 15 Sep 2020 13:03:37 +0100
Message-Id: <20200915120339.702938-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djI6CiAqIFJlYmFzZWQgb250byBxZW11LmdpdC9tYXN0ZXIgZm9yIG1lc29uCgpGaXggYW4gYXNz
ZXJ0aW9uIGZhaWx1cmUgd2hlbiBhaW9fcG9sbCgpIGlzIGNhbGxlZCBpbiBhIGFpb19kaXNhYmxl
X2V4dGVybmFsKCkKcmVnaW9uLiBUaGUgZmFpbHVyZSBoYXBwZW5zIHdoZW4gZmRtb24tcG9sbCBp
cyBmaXJzdCB1cGdyYWRlZCB0byBmZG1vbi1lcG9sbAphbmQgdGhlbiBkb3duZ3JhZGVkIGFnYWlu
IGR1ZSB0byBhaW9fZGlzYWJsZV9leHRlcm5hbCgpLgoKU3RlZmFuIEhham5vY3ppICgyKToKICBm
ZG1vbi1wb2xsOiByZXNldCBucGZkIHdoZW4gdXBncmFkaW5nIHRvIGZkbW9uLWVwb2xsCiAgdGVz
dHM6IGFkZCB0ZXN0LWZkbW9uLWVwb2xsCgogTUFJTlRBSU5FUlMgICAgICAgICAgICAgIHwgIDEg
KwogdGVzdHMvdGVzdC1mZG1vbi1lcG9sbC5jIHwgNzMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogdXRpbC9mZG1vbi1wb2xsLmMgICAgICAgIHwgIDEgKwogdGVzdHMv
bWVzb24uYnVpbGQgICAgICAgIHwgIDMgKysKIDQgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0aW9u
cygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Rlc3QtZmRtb24tZXBvbGwuYwoKLS0gCjIu
MjYuMgoK


