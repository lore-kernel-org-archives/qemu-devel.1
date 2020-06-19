Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3862DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0058A2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bw7Fvz55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0058A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmE13-0005Fw-8a
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmDzz-0003wg-8k
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:11:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28697
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmDzx-0004BS-KU
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592561508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9au4Bo0lrPIuddH5h6MeuUxlanlAkfnwONHYJw6PTQ=;
 b=bw7Fvz55DvGzFqABXCh65i7T+oI11mzcqU1GTgaG3iSgreXfVIIDQ7hbN+Dtx3wOL2OPOu
 fb5VhH2CrVVZGNf5lILrmSUf0FhKS+dbcu890IetKlnVmjs+628l2UX1NKch6HzMEhjjhe
 qUWrCBylcvHg3lDTPS4+q0FFwsgswIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-bTO-4uQRMWK-oWPpFXYeNw-1; Fri, 19 Jun 2020 06:11:47 -0400
X-MC-Unique: bTO-4uQRMWK-oWPpFXYeNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4705A107ACCD;
 Fri, 19 Jun 2020 10:11:46 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1CD510013C4;
 Fri, 19 Jun 2020 10:11:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qemu-storage-daemon: add missing cleanup calls
Date: Fri, 19 Jun 2020 11:11:32 +0100
Message-Id: <20200619101132.2401756-3-stefanha@redhat.com>
In-Reply-To: <20200619101132.2401756-1-stefanha@redhat.com>
References: <20200619101132.2401756-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2V2ZXJhbCBjb21wb25lbnRzIHVzZWQgYnkgcWVtdS1zdG9yYWdlLWRhZW1vbiBoYXZlIGNsZWFu
dXAgZnVuY3Rpb25zCnRoYXQgYXJlbid0IGNhbGxlZC4gS2VlcCB0aGUgInZhbGdyaW5kIC0tbGVh
ay1jaGVjaz1mdWxsIiBhcyBjbGVhbiBhcwpwb3NzaWJsZSBieSBpbnZva2luZyB0aGUgbmVjZXNz
YXJ5IGNsZWFudXAgZnVuY3Rpb25zLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxz
dGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHFlbXUtc3RvcmFnZS1kYWVtb24uYyB8IDQgKysrKwog
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3FlbXUtc3RvcmFn
ZS1kYWVtb24uYyBiL3FlbXUtc3RvcmFnZS1kYWVtb24uYwppbmRleCBhMDFjYmQ2MzcxLi43ZTli
MGUwZDNmIDEwMDY0NAotLS0gYS9xZW11LXN0b3JhZ2UtZGFlbW9uLmMKKysrIGIvcWVtdS1zdG9y
YWdlLWRhZW1vbi5jCkBAIC0zMzUsNSArMzM1LDkgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkKICAgICAgICAgbWFpbl9sb29wX3dhaXQoZmFsc2UpOwogICAgIH0KIAorICAgIG1v
bml0b3JfY2xlYW51cCgpOworICAgIHFlbXVfY2hyX2NsZWFudXAoKTsKKyAgICB1c2VyX2NyZWF0
YWJsZV9jbGVhbnVwKCk7CisKICAgICByZXR1cm4gRVhJVF9TVUNDRVNTOwogfQotLSAKMi4yNi4y
Cgo=


