Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ABBC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4278D2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjE42pTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4278D2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZKR-00042L-5h
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZ7j-0003o8-8E
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZ7h-000652-4D
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:14:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601460848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVToW14prikmTBTqtQW06DlnWPzOorHLiU0ihmtRaSU=;
 b=KjE42pTpCHZwy84xN4gnMZTldnwD/0M/XufApACyBG3Glo8RBRIELKumoBbpjmFcqbswma
 j25KV+ob/pgaT6kZTvSQxCsjnIh3fbB1qeCUY81HcvCbHL9FG7cohEMzV2UFVvi8NOc7nx
 Ah1/wFnJbEn/nLNEfuwPX0nAu0DC52I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-5sydBZK5OEywozdMlogq9g-1; Wed, 30 Sep 2020 06:14:06 -0400
X-MC-Unique: 5sydBZK5OEywozdMlogq9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C159C109106B;
 Wed, 30 Sep 2020 10:14:04 +0000 (UTC)
Received: from localhost (ovpn-114-33.ams2.redhat.com [10.36.114.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6487D78833;
 Wed, 30 Sep 2020 10:14:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 13/17] block/io: refactor save/load vmstate
Date: Wed, 30 Sep 2020 11:13:01 +0100
Message-Id: <20200930101305.305302-14-stefanha@redhat.com>
In-Reply-To: <20200930101305.305302-1-stefanha@redhat.com>
References: <20200930101305.305302-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPgoKTGlrZSBmb3IgcmVhZC93cml0ZSBpbiBhIHByZXZpb3VzIGNvbW1pdCwgZHJvcCBleHRy
YSBpbmRpcmVjdGlvbiBsYXllciwKZ2VuZXJhdGUgZGlyZWN0bHkgYmRydl9yZWFkdl92bXN0YXRl
KCkgYW5kIGJkcnZfd3JpdGV2X3Ztc3RhdGUoKS4KClNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4KU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogRXJp
YyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDIwMDkyNDE4NTQxNC4yODY0Mi04
LXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4KLS0tCiBibG9jay9jb3JvdXRpbmVzLmggICAgfCAx
MCArKystLS0tCiBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmggfCAgNiArKy0tCiBibG9jay9pby5jICAg
ICAgICAgICAgfCA3MCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAzIGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDQyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2Jsb2NrL2Nvcm91dGluZXMuaCBiL2Jsb2NrL2Nvcm91dGluZXMuaAppbmRleCA2
YzYzYTgxOWM5Li5mNjkxNzlmNWVmIDEwMDY0NAotLS0gYS9ibG9jay9jb3JvdXRpbmVzLmgKKysr
IGIvYmxvY2svY29yb3V0aW5lcy5oCkBAIC01NywxMSArNTcsOSBAQCBiZHJ2X2NvbW1vbl9ibG9j
a19zdGF0dXNfYWJvdmUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW50NjRfdCAqbWFwLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEJsb2NrRHJpdmVyU3RhdGUgKipmaWxlKTsKIAotaW50IGNvcm91dGluZV9mbgotYmRydl9jb19y
d192bXN0YXRlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBRRU1VSU9WZWN0b3IgKnFpb3YsIGludDY0
X3QgcG9zLAotICAgICAgICAgICAgICAgICAgIGJvb2wgaXNfcmVhZCk7Ci1pbnQgZ2VuZXJhdGVk
X2NvX3dyYXBwZXIKLWJkcnZfcndfdm1zdGF0ZShCbG9ja0RyaXZlclN0YXRlICpicywgUUVNVUlP
VmVjdG9yICpxaW92LCBpbnQ2NF90IHBvcywKLSAgICAgICAgICAgICAgICBib29sIGlzX3JlYWQp
OworaW50IGNvcm91dGluZV9mbiBiZHJ2X2NvX3JlYWR2X3Ztc3RhdGUoQmxvY2tEcml2ZXJTdGF0
ZSAqYnMsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRRU1VSU9WZWN0
b3IgKnFpb3YsIGludDY0X3QgcG9zKTsKK2ludCBjb3JvdXRpbmVfZm4gYmRydl9jb193cml0ZXZf
dm1zdGF0ZShCbG9ja0RyaXZlclN0YXRlICpicywKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBRRU1VSU9WZWN0b3IgKnFpb3YsIGludDY0X3QgcG9zKTsKIAogI2VuZGlm
IC8qIEJMT0NLX0NPUk9VVElORVNfSU5UX0ggKi8KZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2sv
YmxvY2suaCBiL2luY2x1ZGUvYmxvY2svYmxvY2suaAppbmRleCBlZWY0Y2NlYWYwLi44Yjg3ZGY2
OWExIDEwMDY0NAotLS0gYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmgKKysrIGIvaW5jbHVkZS9ibG9j
ay9ibG9jay5oCkBAIC01NzIsOCArNTcyLDEwIEBAIGludCBwYXRoX2hhc19wcm90b2NvbChjb25z
dCBjaGFyICpwYXRoKTsKIGludCBwYXRoX2lzX2Fic29sdXRlKGNvbnN0IGNoYXIgKnBhdGgpOwog
Y2hhciAqcGF0aF9jb21iaW5lKGNvbnN0IGNoYXIgKmJhc2VfcGF0aCwgY29uc3QgY2hhciAqZmls
ZW5hbWUpOwogCi1pbnQgYmRydl9yZWFkdl92bXN0YXRlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBR
RU1VSU9WZWN0b3IgKnFpb3YsIGludDY0X3QgcG9zKTsKLWludCBiZHJ2X3dyaXRldl92bXN0YXRl
KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBRRU1VSU9WZWN0b3IgKnFpb3YsIGludDY0X3QgcG9zKTsK
K2ludCBnZW5lcmF0ZWRfY29fd3JhcHBlcgorYmRydl9yZWFkdl92bXN0YXRlKEJsb2NrRHJpdmVy
U3RhdGUgKmJzLCBRRU1VSU9WZWN0b3IgKnFpb3YsIGludDY0X3QgcG9zKTsKK2ludCBnZW5lcmF0
ZWRfY29fd3JhcHBlcgorYmRydl93cml0ZXZfdm1zdGF0ZShCbG9ja0RyaXZlclN0YXRlICpicywg
UUVNVUlPVmVjdG9yICpxaW92LCBpbnQ2NF90IHBvcyk7CiBpbnQgYmRydl9zYXZlX3Ztc3RhdGUo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGNvbnN0IHVpbnQ4X3QgKmJ1ZiwKICAgICAgICAgICAgICAg
ICAgICAgICBpbnQ2NF90IHBvcywgaW50IHNpemUpOwogCmRpZmYgLS1naXQgYS9ibG9jay9pby5j
IGIvYmxvY2svaW8uYwppbmRleCBjM2RjMWRiMDM2Li41NGYwOTY4YWVlIDEwMDY0NAotLS0gYS9i
bG9jay9pby5jCisrKyBiL2Jsb2NrL2lvLmMKQEAgLTI0NzUsMjggKzI0NzUsNTAgQEAgaW50IGJk
cnZfaXNfYWxsb2NhdGVkX2Fib3ZlKEJsb2NrRHJpdmVyU3RhdGUgKnRvcCwKIH0KIAogaW50IGNv
cm91dGluZV9mbgotYmRydl9jb19yd192bXN0YXRlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBRRU1V
SU9WZWN0b3IgKnFpb3YsIGludDY0X3QgcG9zLAotICAgICAgICAgICAgICAgICAgIGJvb2wgaXNf
cmVhZCkKK2JkcnZfY29fcmVhZHZfdm1zdGF0ZShCbG9ja0RyaXZlclN0YXRlICpicywgUUVNVUlP
VmVjdG9yICpxaW92LCBpbnQ2NF90IHBvcykKIHsKICAgICBCbG9ja0RyaXZlciAqZHJ2ID0gYnMt
PmRydjsKICAgICBCbG9ja0RyaXZlclN0YXRlICpjaGlsZF9icyA9IGJkcnZfcHJpbWFyeV9icyhi
cyk7CiAgICAgaW50IHJldCA9IC1FTk9UU1VQOwogCisgICAgaWYgKCFkcnYpIHsKKyAgICAgICAg
cmV0dXJuIC1FTk9NRURJVU07CisgICAgfQorCiAgICAgYmRydl9pbmNfaW5fZmxpZ2h0KGJzKTsK
IAorICAgIGlmIChkcnYtPmJkcnZfbG9hZF92bXN0YXRlKSB7CisgICAgICAgIHJldCA9IGRydi0+
YmRydl9sb2FkX3Ztc3RhdGUoYnMsIHFpb3YsIHBvcyk7CisgICAgfSBlbHNlIGlmIChjaGlsZF9i
cykgeworICAgICAgICByZXQgPSBiZHJ2X2NvX3JlYWR2X3Ztc3RhdGUoY2hpbGRfYnMsIHFpb3Ys
IHBvcyk7CisgICAgfQorCisgICAgYmRydl9kZWNfaW5fZmxpZ2h0KGJzKTsKKworICAgIHJldHVy
biByZXQ7Cit9CisKK2ludCBjb3JvdXRpbmVfZm4KK2JkcnZfY29fd3JpdGV2X3Ztc3RhdGUoQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsIFFFTVVJT1ZlY3RvciAqcWlvdiwgaW50NjRfdCBwb3MpCit7Cisg
ICAgQmxvY2tEcml2ZXIgKmRydiA9IGJzLT5kcnY7CisgICAgQmxvY2tEcml2ZXJTdGF0ZSAqY2hp
bGRfYnMgPSBiZHJ2X3ByaW1hcnlfYnMoYnMpOworICAgIGludCByZXQgPSAtRU5PVFNVUDsKKwog
ICAgIGlmICghZHJ2KSB7Ci0gICAgICAgIHJldCA9IC1FTk9NRURJVU07Ci0gICAgfSBlbHNlIGlm
IChkcnYtPmJkcnZfbG9hZF92bXN0YXRlKSB7Ci0gICAgICAgIGlmIChpc19yZWFkKSB7Ci0gICAg
ICAgICAgICByZXQgPSBkcnYtPmJkcnZfbG9hZF92bXN0YXRlKGJzLCBxaW92LCBwb3MpOwotICAg
ICAgICB9IGVsc2UgewotICAgICAgICAgICAgcmV0ID0gZHJ2LT5iZHJ2X3NhdmVfdm1zdGF0ZShi
cywgcWlvdiwgcG9zKTsKLSAgICAgICAgfQorICAgICAgICByZXR1cm4gLUVOT01FRElVTTsKKyAg
ICB9CisKKyAgICBiZHJ2X2luY19pbl9mbGlnaHQoYnMpOworCisgICAgaWYgKGRydi0+YmRydl9z
YXZlX3Ztc3RhdGUpIHsKKyAgICAgICAgcmV0ID0gZHJ2LT5iZHJ2X3NhdmVfdm1zdGF0ZShicywg
cWlvdiwgcG9zKTsKICAgICB9IGVsc2UgaWYgKGNoaWxkX2JzKSB7Ci0gICAgICAgIHJldCA9IGJk
cnZfY29fcndfdm1zdGF0ZShjaGlsZF9icywgcWlvdiwgcG9zLCBpc19yZWFkKTsKKyAgICAgICAg
cmV0ID0gYmRydl9jb193cml0ZXZfdm1zdGF0ZShjaGlsZF9icywgcWlvdiwgcG9zKTsKICAgICB9
CiAKICAgICBiZHJ2X2RlY19pbl9mbGlnaHQoYnMpOworCiAgICAgcmV0dXJuIHJldDsKIH0KIApA
QCAtMjUwNCwzOCArMjUyNiwxOCBAQCBpbnQgYmRydl9zYXZlX3Ztc3RhdGUoQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsIGNvbnN0IHVpbnQ4X3QgKmJ1ZiwKICAgICAgICAgICAgICAgICAgICAgICBpbnQ2
NF90IHBvcywgaW50IHNpemUpCiB7CiAgICAgUUVNVUlPVmVjdG9yIHFpb3YgPSBRRU1VX0lPVkVD
X0lOSVRfQlVGKHFpb3YsIGJ1Ziwgc2l6ZSk7Ci0gICAgaW50IHJldDsKKyAgICBpbnQgcmV0ID0g
YmRydl93cml0ZXZfdm1zdGF0ZShicywgJnFpb3YsIHBvcyk7CiAKLSAgICByZXQgPSBiZHJ2X3dy
aXRldl92bXN0YXRlKGJzLCAmcWlvdiwgcG9zKTsKLSAgICBpZiAocmV0IDwgMCkgewotICAgICAg
ICByZXR1cm4gcmV0OwotICAgIH0KLQotICAgIHJldHVybiBzaXplOwotfQotCi1pbnQgYmRydl93
cml0ZXZfdm1zdGF0ZShCbG9ja0RyaXZlclN0YXRlICpicywgUUVNVUlPVmVjdG9yICpxaW92LCBp
bnQ2NF90IHBvcykKLXsKLSAgICByZXR1cm4gYmRydl9yd192bXN0YXRlKGJzLCBxaW92LCBwb3Ms
IGZhbHNlKTsKKyAgICByZXR1cm4gcmV0IDwgMCA/IHJldCA6IHNpemU7CiB9CiAKIGludCBiZHJ2
X2xvYWRfdm1zdGF0ZShCbG9ja0RyaXZlclN0YXRlICpicywgdWludDhfdCAqYnVmLAogICAgICAg
ICAgICAgICAgICAgICAgIGludDY0X3QgcG9zLCBpbnQgc2l6ZSkKIHsKICAgICBRRU1VSU9WZWN0
b3IgcWlvdiA9IFFFTVVfSU9WRUNfSU5JVF9CVUYocWlvdiwgYnVmLCBzaXplKTsKLSAgICBpbnQg
cmV0OworICAgIGludCByZXQgPSBiZHJ2X3JlYWR2X3Ztc3RhdGUoYnMsICZxaW92LCBwb3MpOwog
Ci0gICAgcmV0ID0gYmRydl9yZWFkdl92bXN0YXRlKGJzLCAmcWlvdiwgcG9zKTsKLSAgICBpZiAo
cmV0IDwgMCkgewotICAgICAgICByZXR1cm4gcmV0OwotICAgIH0KLQotICAgIHJldHVybiBzaXpl
OwotfQotCi1pbnQgYmRydl9yZWFkdl92bXN0YXRlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBRRU1V
SU9WZWN0b3IgKnFpb3YsIGludDY0X3QgcG9zKQotewotICAgIHJldHVybiBiZHJ2X3J3X3Ztc3Rh
dGUoYnMsIHFpb3YsIHBvcywgdHJ1ZSk7CisgICAgcmV0dXJuIHJldCA8IDAgPyByZXQgOiBzaXpl
OwogfQogCiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKiovCi0tIAoyLjI2LjIKCg==


