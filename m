Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D31AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09CD2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilY0I74F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09CD2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxCu-0005dY-0W
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxBg-00046T-VA
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxBf-0001Xa-NH
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589875278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N72jo2qy7yIe80Sdmh2qTL3VyO0YOqstTVx8zIjrf2A=;
 b=ilY0I74FiLdZUinjlhrxPrnsMopBOCM+7obf/Ve66UHZQoTI/0LEMdDk/8mFvmcn/fkbJT
 dNIWnejljbPYa1Z/cXFMd8kEfP7vlKgxb8H9vtE+Ge8SrMpHHbaiDbjesm7if9V+OCo671
 MSgpdk2Gpldf07zPilF/DyCV0KES01M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-1SJPmuKbNTyUJTF8aHPnxQ-1; Tue, 19 May 2020 04:01:13 -0400
X-MC-Unique: 1SJPmuKbNTyUJTF8aHPnxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 488A7835B41;
 Tue, 19 May 2020 08:01:12 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 663C95C1BB;
 Tue, 19 May 2020 08:01:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] tests/fuzz/Makefile: Do not link code using unavailable
 devices
Date: Tue, 19 May 2020 09:00:47 +0100
Message-Id: <20200519080054.146495-2-stefanha@redhat.com>
In-Reply-To: <20200519080054.146495-1-stefanha@redhat.com>
References: <20200519080054.146495-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKU29tZSBk
ZXZpY2VzIGF2YWlsYWJpbGl0eSBkZXBlbmRzIG9uIENPTkZJRyBvcHRpb25zLgpVc2UgdGhlc2Ug
b3B0aW9ucyB0byBvbmx5IGxpbmsgdGVzdHMgd2hlbiByZXF1ZXN0ZWQgZGV2aWNlCmlzIGF2YWls
YWJsZS4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVk
aGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA1MTQxNDM0MzMuMTg1NjktMi1waGlsbWRAcmVkaGF0
LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
Ci0tLQogdGVzdHMvcXRlc3QvZnV6ei9NYWtlZmlsZS5pbmNsdWRlIHwgNiArKystLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dGVzdHMvcXRlc3QvZnV6ei9NYWtlZmlsZS5pbmNsdWRlIGIvdGVzdHMvcXRlc3QvZnV6ei9NYWtl
ZmlsZS5pbmNsdWRlCmluZGV4IGNkZTNlOTYzNmMuLmYyNTlkODY2YzkgMTAwNjQ0Ci0tLSBhL3Rl
c3RzL3F0ZXN0L2Z1enovTWFrZWZpbGUuaW5jbHVkZQorKysgYi90ZXN0cy9xdGVzdC9mdXp6L01h
a2VmaWxlLmluY2x1ZGUKQEAgLTcsOSArNyw5IEBAIGZ1enotb2JqLXkgKz0gdGVzdHMvcXRlc3Qv
ZnV6ei9mb3JrX2Z1enoubwogZnV6ei1vYmoteSArPSB0ZXN0cy9xdGVzdC9mdXp6L3Fvc19mdXp6
Lm8KIAogIyBUYXJnZXRzCi1mdXp6LW9iai15ICs9IHRlc3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1
enoubwotZnV6ei1vYmoteSArPSB0ZXN0cy9xdGVzdC9mdXp6L3ZpcnRpb19uZXRfZnV6ei5vCi1m
dXp6LW9iai15ICs9IHRlc3RzL3F0ZXN0L2Z1enovdmlydGlvX3Njc2lfZnV6ei5vCitmdXp6LW9i
ai0kKENPTkZJR19QQ0lfSTQ0MEZYKSArPSB0ZXN0cy9xdGVzdC9mdXp6L2k0NDBmeF9mdXp6Lm8K
K2Z1enotb2JqLSQoQ09ORklHX1ZJUlRJT19ORVQpICs9IHRlc3RzL3F0ZXN0L2Z1enovdmlydGlv
X25ldF9mdXp6Lm8KK2Z1enotb2JqLSQoQ09ORklHX1NDU0kpICs9IHRlc3RzL3F0ZXN0L2Z1enov
dmlydGlvX3Njc2lfZnV6ei5vCiAKIEZVWlpfQ0ZMQUdTICs9IC1JJChTUkNfUEFUSCkvdGVzdHMg
LUkkKFNSQ19QQVRIKS90ZXN0cy9xdGVzdAogCi0tIAoyLjI1LjMKCg==


