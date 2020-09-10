Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90CEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3809C20731
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZacNbd5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3809C20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGHhL-0003s0-12
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 04:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGHgS-0002bP-Ul
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 04:11:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGHgR-0002xg-Cj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 04:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599725514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Me4RFj/JVSZpwCThTMm0Kv88fJLMSdD2S6cQrEZLU68=;
 b=ZacNbd5jvbhXVkTnXcKxa3xiLADtEQ9WPdRrLYekZHkh20TaDQAhwSdGp5ZCXxKa3zH/cc
 enJ8/T8pfZxfRW5lO9hw0B/W7ydvJ7gJ7ge2CfYqM4ycpOlEQdZJjCd2o2Gu4lXYUw9UgY
 trwdo+ymSMFvaKvV+UwdUw5sjVhSUew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-nL1yHqsMNVWKoZxqZpKlsA-1; Thu, 10 Sep 2020 04:11:52 -0400
X-MC-Unique: nL1yHqsMNVWKoZxqZpKlsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 831EF18B9ED1;
 Thu, 10 Sep 2020 08:11:51 +0000 (UTC)
Received: from localhost (ovpn-112-28.ams2.redhat.com [10.36.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FDF15D9EF;
 Thu, 10 Sep 2020 08:11:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 5/8] scripts/cleanup-trace-events: Fix for vcpu property
Date: Thu, 10 Sep 2020 09:10:46 +0100
Message-Id: <20200910081049.38393-6-stefanha@redhat.com>
In-Reply-To: <20200910081049.38393-1-stefanha@redhat.com>
References: <20200910081049.38393-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:44:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPgoKQ29tbWl0IGE0NGNm
NTI0ZjggInNjcmlwdHMvY2xlYW51cC10cmFjZS1ldmVudHM6IFVwZGF0ZSBmb3IgY3VycmVudApw
cmFjdGljZSIgbGltaXRlZCBzZWFyY2ggdG8gdGhlIGlucHV0IGZpbGUncyBkaXJlY3RvcnkuICBU
aGF0J3Mgd3JvbmcKZm9yIGV2ZW50cyB3aXRoIHRoZSB2Y3B1IHByb3BlcnR5LCBiZWNhdXNlIHRo
ZXNlIGNhbiBvbmx5IGJlIGRlZmluZWQKaW4gcm9vdCBkaXJlY3RvcnkuCgpTaWduZWQtb2ZmLWJ5
OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAw
ODA2MTQxMzM0LjM2NDYzMDItMi1hcm1icnVAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogc2NyaXB0cy9jbGVhbnVwLXRy
YWNlLWV2ZW50cy5wbCB8IDEwICsrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9jbGVhbnVwLXRyYWNl
LWV2ZW50cy5wbCBiL3NjcmlwdHMvY2xlYW51cC10cmFjZS1ldmVudHMucGwKaW5kZXggZDRmMGU0
Y2FiNS4uNmMzNzY3YmQ2YSAxMDA3NTUKLS0tIGEvc2NyaXB0cy9jbGVhbnVwLXRyYWNlLWV2ZW50
cy5wbAorKysgYi9zY3JpcHRzL2NsZWFudXAtdHJhY2UtZXZlbnRzLnBsCkBAIC0zMSwxMCArMzEs
MTIgQEAgb3BlbihJTiwgJGluKSBvciBkaWUgIm9wZW4gJGluOiAkISI7CiBjaGRpcigkZGlyKSBv
ciBkaWUgImNoZGlyICRkaXI6ICQhIjsKIAogd2hpbGUgKDxJTj4pIHsKLSAgICBpZiAoL14oZGlz
YWJsZSB8KHRjZykgfHZjcHUgKSooW2Etel8wLTldKylcKC9pKSB7Ci0gICAgICAgIG15ICRwYXQg
PSAidHJhY2VfJDMiOwotICAgICAgICAkcGF0IC49ICdfdGNnJyBpZiAoZGVmaW5lZCAkMik7Ci0g
ICAgICAgIG9wZW4gR1JFUCwgJy18JywgJ2dpdCcsICdncmVwJywgJy1sdycsICctLW1heC1kZXB0
aCcsICcxJywgJHBhdAorICAgIGlmICgvXihkaXNhYmxlIHwodGNnKSB8KHZjcHUpICkqKFthLXpf
MC05XSspXCgvaSkgeworICAgICAgICBteSAkcGF0ID0gInRyYWNlXyQ0IjsKKyAgICAgICAgJHBh
dCAuPSAnX3RjZycgaWYgZGVmaW5lZCAkMjsKKyAgICAgICAgb3BlbiBHUkVQLCAnLXwnLCAnZ2l0
JywgJ2dyZXAnLCAnLWx3JywKKwkgICAgZGVmaW5lZCAkMyA/ICgpIDogKCctLW1heC1kZXB0aCcs
ICcxJyksCisJICAgICRwYXQKICAgICAgICAgICAgIG9yIGRpZSAicnVuIGdpdCBncmVwOiAkISI7
CiAgICAgICAgIHdoaWxlIChteSAkZm5hbWUgPSA8R1JFUD4pIHsKICAgICAgICAgICAgIGNob21w
ICRmbmFtZTsKLS0gCjIuMjYuMgoK


