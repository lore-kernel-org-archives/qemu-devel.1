Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBEBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0FE22404
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGNvagA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0FE22404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX50M-00062J-F6
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4xA-0002zN-K1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4x8-0005ra-JV
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603728153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEuLy70bO9rGKypxbnX7ZHoOi/nKsVsUSyciGbs1XDI=;
 b=VGNvagA7sfEwjcSEhTDBatNPr1ATJlHb5+Z7hs7AYG1rrkZ0MemxcHNXWsay8E4+V6eNMu
 A68dqKdj9jaPR64wsE4Kyn+YRrDb1kSvOE6CqO5IIccK6XYkTIf4LzB1hVv/iK6fvGiAfA
 NLphWYRVGnOed6PZjL6wB7a+IaizHQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-6F21LJZROjSmqDZEzbvP-Q-1; Mon, 26 Oct 2020 12:02:29 -0400
X-MC-Unique: 6F21LJZROjSmqDZEzbvP-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 703921060B73;
 Mon, 26 Oct 2020 16:02:27 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04D8E5C1BB;
 Mon, 26 Oct 2020 16:02:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 1/2] trace/simple: Enable tracing on startup only if the
 user specifies a trace option
Date: Mon, 26 Oct 2020 16:02:20 +0000
Message-Id: <20201026160221.62704-2-stefanha@redhat.com>
In-Reply-To: <20201026160221.62704-1-stefanha@redhat.com>
References: <20201026160221.62704-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Josh DuBois <josh@joshdubois.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogSm9zaCBEdUJvaXMgPGpvc2hAam9zaGR1Ym9pcy5jb20+CgpUcmFjaW5nIGNhbiBiZSBl
bmFibGVkIGF0IHRoZSBjb21tYW5kIGxpbmUgb3IgdmlhIHRoZQptb25pdG9yLiBDb21tYW5kLWxp
bmUgdHJhY2Ugb3B0aW9ucyBhcmUgcmVjb3JkZWQgZHVyaW5nCnRyYWNlX29wdF9wYXJzZSgpLCBi
dXQgdHJhY2luZyBpcyBub3QgZW5hYmxlZCB1bnRpbCB0aGUgdmFyaW91cwpmcm9udC1lbmRzIGxh
dGVyIGNhbGwgdHJhY2VfaW5pdF9maWxlKCkuIElmIHRoZSB1c2VyIHBhc3NlcyBhIHRyYWNlCm9w
dGlvbiBvbiB0aGUgY29tbWFuZC1saW5lLCByZW1lbWJlciB0aGF0IGFuZCBlbmFibGUgdHJhY2lu
ZyBkdXJpbmcKdHJhY2VfaW5pdF9maWxlKCkuICBPdGhlcndpc2UsIHRyYWNlX2luaXRfZmlsZSgp
IHNob3VsZCByZWNvcmQgdGhlCnRyYWNlIGZpbGUgc3BlY2lmaWVkIGJ5IHRoZSBmcm9udGVuZCBh
bmQgYXZvaWQgZW5hYmxpbmcgdHJhY2VzCnVudGlsIHRoZSB1c2VyIHJlcXVlc3RzIHRoZW0gdmlh
IHRoZSBtb25pdG9yLgoKVGhpcyBmaXhlcyAxYjcxNTdiZTNhOGM0MzAwZmM4MDQ0ZDQwZjRiMmU2
NGExNTJhMWI0IGFuZCBhbHNvCmRiMjVkNTZjMDE0YWExYTk2MzE5YzY2M2UwYTYwMzQ2YTIyM2Iz
MWUsIGJ5IGFsbG93aW5nIHRoZSB1c2VyCnRvIGVuYWJsZSB0cmFjZXMgb24gdGhlIGNvbW1hbmQg
bGluZSBhbmQgYWxzbyBhdm9pZGluZwp1bndhbnRlZCB0cmFjZS08cGlkPiBmaWxlcyB3aGVuIHRo
ZSB1c2VyIGhhcyBub3QgYXNrZWQgZm9yIHRoZW0uCgpGaXhlczogMWI3MTU3YmUzYThjNDMwMGZj
ODA0NGQ0MGY0YjJlNjRhMTUyYTFiNApTaWduZWQtb2ZmLWJ5OiBKb3NoIER1Qm9pcyA8am9zaEBq
b3NoZHVib2lzLmNvbT4KTWVzc2FnZS1pZDogMjAyMDA4MTYxNzQ2MTAuMjAyNTMtMS1qb3NoQGpv
c2hkdWJvaXMuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVk
aGF0LmNvbT4KLS0tCiB0cmFjZS9jb250cm9sLmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RyYWNlL2NvbnRy
b2wuYyBiL3RyYWNlL2NvbnRyb2wuYwppbmRleCBiMzVlNTEyZGNlLi41NjY5ZGI3ZWVhIDEwMDY0
NAotLS0gYS90cmFjZS9jb250cm9sLmMKKysrIGIvdHJhY2UvY29udHJvbC5jCkBAIC0zOSw2ICsz
OSw3IEBAIHN0YXRpYyBUcmFjZUV2ZW50R3JvdXAgKmV2ZW50X2dyb3VwczsKIHN0YXRpYyBzaXpl
X3QgbmV2ZW50X2dyb3VwczsKIHN0YXRpYyB1aW50MzJfdCBuZXh0X2lkOwogc3RhdGljIHVpbnQz
Ml90IG5leHRfdmNwdV9pZDsKK3N0YXRpYyBib29sIGluaXRfdHJhY2Vfb25fc3RhcnR1cDsKIAog
UWVtdU9wdHNMaXN0IHFlbXVfdHJhY2Vfb3B0cyA9IHsKICAgICAubmFtZSA9ICJ0cmFjZSIsCkBA
IC0yMjUsNyArMjI2LDkgQEAgdm9pZCB0cmFjZV9pbml0X2ZpbGUoY29uc3QgY2hhciAqZmlsZSkK
IHsKICNpZmRlZiBDT05GSUdfVFJBQ0VfU0lNUExFCiAgICAgc3Rfc2V0X3RyYWNlX2ZpbGUoZmls
ZSk7Ci0gICAgc3Rfc2V0X3RyYWNlX2ZpbGVfZW5hYmxlZCh0cnVlKTsKKyAgICBpZiAoaW5pdF90
cmFjZV9vbl9zdGFydHVwKSB7CisgICAgICAgIHN0X3NldF90cmFjZV9maWxlX2VuYWJsZWQodHJ1
ZSk7CisgICAgfQogI2VsaWYgZGVmaW5lZCBDT05GSUdfVFJBQ0VfTE9HCiAgICAgLyoKICAgICAg
KiBJZiBib3RoIHRoZSBzaW1wbGUgYW5kIHRoZSBsb2cgYmFja2VuZHMgYXJlIGVuYWJsZWQsICIt
LXRyYWNlIGZpbGUiCkBAIC0yOTksNiArMzAyLDcgQEAgY2hhciAqdHJhY2Vfb3B0X3BhcnNlKGNv
bnN0IGNoYXIgKm9wdGFyZykKICAgICB9CiAgICAgdHJhY2VfaW5pdF9ldmVudHMocWVtdV9vcHRf
Z2V0KG9wdHMsICJldmVudHMiKSk7CiAgICAgdHJhY2VfZmlsZSA9IGdfc3RyZHVwKHFlbXVfb3B0
X2dldChvcHRzLCAiZmlsZSIpKTsKKyAgICBpbml0X3RyYWNlX29uX3N0YXJ0dXAgPSB0cnVlOwog
ICAgIHFlbXVfb3B0c19kZWwob3B0cyk7CiAKICAgICByZXR1cm4gdHJhY2VfZmlsZTsKLS0gCjIu
MjYuMgoK


