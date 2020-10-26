Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FE3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EF0206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVzBT1/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EF0206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5xW-00011o-Mu
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX5vl-00086P-OB
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX5vj-0006M7-VY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603731910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FvMELAILzGyPkWXC4HzHOkB0hWn1HdLAo1eBfXSHWoU=;
 b=XVzBT1/d+8akrLyXVHI6O2L+E3R6COLFOe+WXF2qXD6Z87IVDFOV4xyHw7ExVjtWKR+Mlv
 GvDu7rPccctj8tibh6KZzOtASxc7M6Ap+KLWTZL/hOrrD25fK5FqYZ2xFrFGhvlVX+gGht
 xfn2T1mhaNIX2avTBlNzr3HUG4MLSXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-strHu5sCPgW6wSlFqs-AWA-1; Mon, 26 Oct 2020 13:05:05 -0400
X-MC-Unique: strHu5sCPgW6wSlFqs-AWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60E6F1020900;
 Mon, 26 Oct 2020 17:05:04 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0656B5577D;
 Mon, 26 Oct 2020 17:05:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 v2 0/2] Tracing patches
Date: Mon, 26 Oct 2020 17:05:00 +0000
Message-Id: <20201026170502.65786-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBhNDZlNzI3MTA1NjZlZWEwZjkwZjlj
NjczYTBmMDJkYTAwNjRhY2NlOg0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvY29odWNrL3RhZ3MvczM5MHgtMjAyMDEwMjYnIGludG8gc3RhZ2luZyAoMjAyMC0xMC0y
NiAxNDo1MDowMyArMDAwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkg
YXQ6DQoNCiAgaHR0cHM6Ly9naXRsYWIuY29tL3N0ZWZhbmhhL3FlbXUuZ2l0IHRhZ3MvdHJhY2lu
Zy1wdWxsLXJlcXVlc3QNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGVlODA0MTAx
M2E1NzRiNGY4OGUwNTQ3MmYzMjFlNTBlMWY0YmU3MzM6DQoNCiAgQWRkIGV4ZWN1dGUgYml0IGJh
Y2sgdG8gc2NyaXB0cy90cmFjZXRvb2wucHkgKDIwMjAtMTAtMjYgMTc6MDM6MjYgKzAwMDApDQoN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NClB1bGwgcmVxdWVzdA0KDQp2MjoNCiAqIEZpeCBBbnRob255IFBlcmFyZCdzIGVt
YWlsIGFkZHJlc3MgW1BoaWxpcHBlXQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkFudGhvbnkgUEVSQVJEICgxKToN
CiAgQWRkIGV4ZWN1dGUgYml0IGJhY2sgdG8gc2NyaXB0cy90cmFjZXRvb2wucHkNCg0KSm9zaCBE
dUJvaXMgKDEpOg0KICB0cmFjZS9zaW1wbGU6IEVuYWJsZSB0cmFjaW5nIG9uIHN0YXJ0dXAgb25s
eSBpZiB0aGUgdXNlciBzcGVjaWZpZXMgYQ0KICAgIHRyYWNlIG9wdGlvbg0KDQogdHJhY2UvY29u
dHJvbC5jICAgICAgfCA2ICsrKysrLQ0KIHNjcmlwdHMvdHJhY2V0b29sLnB5IHwgMA0KIDIgZmls
ZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQogbW9kZSBjaGFuZ2Ug
MTAwNjQ0ID0+IDEwMDc1NSBzY3JpcHRzL3RyYWNldG9vbC5weQ0KDQotLSANCjIuMjYuMg0KDQo=


