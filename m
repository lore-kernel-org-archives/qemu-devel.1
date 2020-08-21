Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075AFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C375420656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUNPANEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C375420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9440-0006A5-Sy
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k942h-0004wW-4h
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:13:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k942f-0000HV-K8
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598004780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oSS+t9d7gT0sbwEru9loSWXIvdKIr7lbp+I25yaof+g=;
 b=TUNPANEgmlH0VH+w09WiYJAgA6BB1Iv07hTABThJYKOhUh2nibbE1XaAZ+kEMgUjQrGzJT
 mrF5tfmP6NUDKMry39dec6I06VEqB8WEXaZYv9KNlqpye7KYMK+mlgbqrqOxNSszXdbo+2
 Pagy9GzJdj5khTfcDoixjGfcQpSXzPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-5E5jZt94NxqBm1uSa60SZw-1; Fri, 21 Aug 2020 06:12:58 -0400
X-MC-Unique: 5E5jZt94NxqBm1uSa60SZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA9DD1006709;
 Fri, 21 Aug 2020 10:12:57 +0000 (UTC)
Received: from localhost (ovpn-113-166.ams2.redhat.com [10.36.113.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5811B5C1D0;
 Fri, 21 Aug 2020 10:12:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] fdmon-poll: reset npfd when upgrading to fdmon-epoll
Date: Fri, 21 Aug 2020 11:12:50 +0100
Message-Id: <20200821101252.203056-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

Rml4IGFuIGFzc2VydGlvbiBmYWlsdXJlIHdoZW4gYWlvX3BvbGwoKSBpcyBjYWxsZWQgaW4gYSBh
aW9fZGlzYWJsZV9leHRlcm5hbCgpDQpyZWdpb24uIFRoZSBmYWlsdXJlIGhhcHBlbnMgd2hlbiBm
ZG1vbi1wb2xsIGlzIGZpcnN0IHVwZ3JhZGVkIHRvIGZkbW9uLWVwb2xsDQphbmQgdGhlbiBkb3du
Z3JhZGVkIGFnYWluIGR1ZSB0byBhaW9fZGlzYWJsZV9leHRlcm5hbCgpLg0KDQpTdGVmYW4gSGFq
bm9jemkgKDIpOg0KICBmZG1vbi1wb2xsOiByZXNldCBucGZkIHdoZW4gdXBncmFkaW5nIHRvIGZk
bW9uLWVwb2xsDQogIHRlc3RzOiBhZGQgdGVzdC1mZG1vbi1lcG9sbA0KDQogTUFJTlRBSU5FUlMg
ICAgICAgICAgICAgIHwgIDEgKw0KIHRlc3RzL01ha2VmaWxlLmluY2x1ZGUgICB8ICA0ICsrKw0K
IHRlc3RzL3Rlc3QtZmRtb24tZXBvbGwuYyB8IDczICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCiB1dGlsL2ZkbW9uLXBvbGwuYyAgICAgICAgfCAgMSArDQogNCBmaWxl
cyBjaGFuZ2VkLCA3OSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Rl
c3QtZmRtb24tZXBvbGwuYw0KDQotLSANCjIuMjYuMg0KDQo=


