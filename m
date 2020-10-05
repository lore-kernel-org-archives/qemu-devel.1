Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E18C4363D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2230920639
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fp7PA2cH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2230920639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSiY-00012a-1m
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSed-0005Ez-Pa
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSea-0008Cz-Py
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601912636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdyvNAejLgu2g67AqYzyT3iXkaQubEmOA428B2xgKNc=;
 b=fp7PA2cHyyV+tzCGeXfHifVxY0zrOzx1gyli/OPWoymzZtRIaB1NoY/QZ6Ei2iIbil4/yJ
 wWeRqYblWztgizShbM9/HFhRgtOLeg6lvQQvkUHVh3MdmyXPRs6RV8ssEslQhA51g8SB+D
 0xJERz3KLKuOokPbuzbFYbnLi5I6qdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-2fixLjYBNBuxBcuhRkaGhw-1; Mon, 05 Oct 2020 11:43:54 -0400
X-MC-Unique: 2fixLjYBNBuxBcuhRkaGhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B74618A8220;
 Mon,  5 Oct 2020 15:43:53 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEA67610AF;
 Mon,  5 Oct 2020 15:43:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 08/17] block/io: refactor coroutine wrappers
Date: Mon,  5 Oct 2020 16:43:14 +0100
Message-Id: <20201005154323.31347-9-stefanha@redhat.com>
In-Reply-To: <20201005154323.31347-1-stefanha@redhat.com>
References: <20201005154323.31347-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPgoKTW9zdCBvZiBvdXIgY29yb3V0aW5lIHdyYXBwZXJzIGFscmVhZHkgZm9sbG93IHRoaXMg
Y29udmVudGlvbjoKCldlIGhhdmUgJ2Nvcm91dGluZV9mbiBiZHJ2X2NvXzxzb21ldGhpbmc+KDxu
b3JtYWwgYXJndW1lbnQgbGlzdD4pJyBhcwp0aGUgY29yZSBmdW5jdGlvbiwgYW5kIGEgd3JhcHBl
ciAnYmRydl88c29tZXRoaW5nPig8c2FtZSBhcmd1bWVudApsaXN0PiknIHdoaWNoIGRvZXMgcGFy
YW1ldGVyIHBhY2tpbmcgYW5kIGNhbGxzIGJkcnZfcnVuX2NvKCkuCgpUaGUgb25seSBvdXRzaWRl
cnMgYXJlIHRoZSBiZHJ2X3Byd3ZfY28gYW5kCmJkcnZfY29tbW9uX2Jsb2NrX3N0YXR1c19hYm92
ZSB3cmFwcGVycy4gTGV0J3MgcmVmYWN0b3IgdGhlbSB0byBiZWhhdmUKYXMgdGhlIG90aGVycywg
aXQgc2ltcGxpZmllcyBmdXJ0aGVyIGNvbnZlcnNpb24gb2YgY29yb3V0aW5lIHdyYXBwZXJzLgoK
VGhpcyBwYXRjaCBhZGRzIGFuIGluZGlyZWN0aW9uIGxheWVyLCBidXQgaXQgd2lsbCBiZSBjb21w
ZW5zYXRlZCBieQphIGZ1cnRoZXIgY29tbWl0LCB3aGljaCB3aWxsIGRyb3AgYmRydl9jb19wcnd2
IHRvZ2V0aGVyIHdpdGggdGhlCmlzX3dyaXRlIGxvZ2ljLCB0byBrZWVwIHRoZSByZWFkIGFuZCB3
cml0ZSBwYXRocyBzZXBhcmF0ZS4KClNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4KU2lnbmVkLW9mZi1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogRXJpYyBCbGFrZSA8
ZWJsYWtlQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhh
QHJlZGhhdC5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDIwMDkyNDE4NTQxNC4yODY0Mi0zLXZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4KLS0tCiBibG9jay9pby5jIHwgNjAgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzIg
aW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svaW8uYyBi
L2Jsb2NrL2lvLmMKaW5kZXggMTFkZjE4ODlmMS4uYjRmNmFiMGFiMSAxMDA2NDQKLS0tIGEvYmxv
Y2svaW8uYworKysgYi9ibG9jay9pby5jCkBAIC05MzMsMjcgKzkzMywzMSBAQCB0eXBlZGVmIHN0
cnVjdCBSd0NvIHsKICAgICBCZHJ2UmVxdWVzdEZsYWdzIGZsYWdzOwogfSBSd0NvOwogCitzdGF0
aWMgaW50IGNvcm91dGluZV9mbiBiZHJ2X2NvX3Byd3YoQmRydkNoaWxkICpjaGlsZCwgaW50NjRf
dCBvZmZzZXQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUUVNVUlPVmVj
dG9yICpxaW92LCBib29sIGlzX3dyaXRlLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEJkcnZSZXF1ZXN0RmxhZ3MgZmxhZ3MpCit7CisgICAgaWYgKGlzX3dyaXRlKSB7Cisg
ICAgICAgIHJldHVybiBiZHJ2X2NvX3B3cml0ZXYoY2hpbGQsIG9mZnNldCwgcWlvdi0+c2l6ZSwg
cWlvdiwgZmxhZ3MpOworICAgIH0gZWxzZSB7CisgICAgICAgIHJldHVybiBiZHJ2X2NvX3ByZWFk
dihjaGlsZCwgb2Zmc2V0LCBxaW92LT5zaXplLCBxaW92LCBmbGFncyk7CisgICAgfQorfQorCiBz
dGF0aWMgaW50IGNvcm91dGluZV9mbiBiZHJ2X3J3X2NvX2VudHJ5KHZvaWQgKm9wYXF1ZSkKIHsK
ICAgICBSd0NvICpyd2NvID0gb3BhcXVlOwogCi0gICAgaWYgKCFyd2NvLT5pc193cml0ZSkgewot
ICAgICAgICByZXR1cm4gYmRydl9jb19wcmVhZHYocndjby0+Y2hpbGQsIHJ3Y28tPm9mZnNldCwK
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJ3Y28tPnFpb3YtPnNpemUsIHJ3Y28tPnFp
b3YsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICByd2NvLT5mbGFncyk7Ci0gICAgfSBl
bHNlIHsKLSAgICAgICAgcmV0dXJuIGJkcnZfY29fcHdyaXRldihyd2NvLT5jaGlsZCwgcndjby0+
b2Zmc2V0LAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJ3Y28tPnFpb3YtPnNpemUs
IHJ3Y28tPnFpb3YsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcndjby0+ZmxhZ3Mp
OwotICAgIH0KKyAgICByZXR1cm4gYmRydl9jb19wcnd2KHJ3Y28tPmNoaWxkLCByd2NvLT5vZmZz
ZXQsIHJ3Y28tPnFpb3YsCisgICAgICAgICAgICAgICAgICAgICAgICByd2NvLT5pc193cml0ZSwg
cndjby0+ZmxhZ3MpOwogfQogCiAvKgogICogUHJvY2VzcyBhIHZlY3RvcmVkIHN5bmNocm9ub3Vz
IHJlcXVlc3QgdXNpbmcgY29yb3V0aW5lcwogICovCi1zdGF0aWMgaW50IGJkcnZfcHJ3dl9jbyhC
ZHJ2Q2hpbGQgKmNoaWxkLCBpbnQ2NF90IG9mZnNldCwKLSAgICAgICAgICAgICAgICAgICAgICAg
IFFFTVVJT1ZlY3RvciAqcWlvdiwgYm9vbCBpc193cml0ZSwKLSAgICAgICAgICAgICAgICAgICAg
ICAgIEJkcnZSZXF1ZXN0RmxhZ3MgZmxhZ3MpCitzdGF0aWMgaW50IGJkcnZfcHJ3dihCZHJ2Q2hp
bGQgKmNoaWxkLCBpbnQ2NF90IG9mZnNldCwKKyAgICAgICAgICAgICAgICAgICAgIFFFTVVJT1Zl
Y3RvciAqcWlvdiwgYm9vbCBpc193cml0ZSwKKyAgICAgICAgICAgICAgICAgICAgIEJkcnZSZXF1
ZXN0RmxhZ3MgZmxhZ3MpCiB7CiAgICAgUndDbyByd2NvID0gewogICAgICAgICAuY2hpbGQgPSBj
aGlsZCwKQEAgLTk3MSw4ICs5NzUsNyBAQCBpbnQgYmRydl9wd3JpdGVfemVyb2VzKEJkcnZDaGls
ZCAqY2hpbGQsIGludDY0X3Qgb2Zmc2V0LAogewogICAgIFFFTVVJT1ZlY3RvciBxaW92ID0gUUVN
VV9JT1ZFQ19JTklUX0JVRihxaW92LCBOVUxMLCBieXRlcyk7CiAKLSAgICByZXR1cm4gYmRydl9w
cnd2X2NvKGNoaWxkLCBvZmZzZXQsICZxaW92LCB0cnVlLAotICAgICAgICAgICAgICAgICAgICAg
ICAgQkRSVl9SRVFfWkVST19XUklURSB8IGZsYWdzKTsKKyAgICByZXR1cm4gYmRydl9wcnd2KGNo
aWxkLCBvZmZzZXQsICZxaW92LCB0cnVlLCBCRFJWX1JFUV9aRVJPX1dSSVRFIHwgZmxhZ3MpOwog
fQogCiAvKgpAQCAtMTAyMSw3ICsxMDI0LDcgQEAgaW50IGJkcnZfcHJlYWR2KEJkcnZDaGlsZCAq
Y2hpbGQsIGludDY0X3Qgb2Zmc2V0LCBRRU1VSU9WZWN0b3IgKnFpb3YpCiB7CiAgICAgaW50IHJl
dDsKIAotICAgIHJldCA9IGJkcnZfcHJ3dl9jbyhjaGlsZCwgb2Zmc2V0LCBxaW92LCBmYWxzZSwg
MCk7CisgICAgcmV0ID0gYmRydl9wcnd2KGNoaWxkLCBvZmZzZXQsIHFpb3YsIGZhbHNlLCAwKTsK
ICAgICBpZiAocmV0IDwgMCkgewogICAgICAgICByZXR1cm4gcmV0OwogICAgIH0KQEAgLTEwNDUs
NyArMTA0OCw3IEBAIGludCBiZHJ2X3B3cml0ZXYoQmRydkNoaWxkICpjaGlsZCwgaW50NjRfdCBv
ZmZzZXQsIFFFTVVJT1ZlY3RvciAqcWlvdikKIHsKICAgICBpbnQgcmV0OwogCi0gICAgcmV0ID0g
YmRydl9wcnd2X2NvKGNoaWxkLCBvZmZzZXQsIHFpb3YsIHRydWUsIDApOworICAgIHJldCA9IGJk
cnZfcHJ3dihjaGlsZCwgb2Zmc2V0LCBxaW92LCB0cnVlLCAwKTsKICAgICBpZiAocmV0IDwgMCkg
ewogICAgICAgICByZXR1cm4gcmV0OwogICAgIH0KQEAgLTI0NDksMTQgKzI0NTIsMTUgQEAgZWFy
bHlfb3V0OgogICAgIHJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJk
cnZfY29fYmxvY2tfc3RhdHVzX2Fib3ZlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLAotICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQmxvY2tEcml2ZXJTdGF0
ZSAqYmFzZSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJvb2wgd2FudF96ZXJvLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50NjRfdCBvZmZzZXQsCi0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IGJ5dGVzLAotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCAqcG51bSwKLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDY0X3QgKm1h
cCwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJs
b2NrRHJpdmVyU3RhdGUgKipmaWxlKQorc3RhdGljIGludCBjb3JvdXRpbmVfZm4KK2JkcnZfY29f
Y29tbW9uX2Jsb2NrX3N0YXR1c19hYm92ZShCbG9ja0RyaXZlclN0YXRlICpicywKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBCbG9ja0RyaXZlclN0YXRlICpiYXNlLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgd2FudF96ZXJvLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGludDY0X3Qgb2Zmc2V0LAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludDY0X3QgYnl0ZXMsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW50NjRfdCAqcG51bSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpbnQ2NF90ICptYXAsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQmxvY2tE
cml2ZXJTdGF0ZSAqKmZpbGUpCiB7CiAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqcDsKICAgICBpbnQg
cmV0ID0gMDsKQEAgLTI0OTQsMTAgKzI0OTgsMTAgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4g
YmRydl9ibG9ja19zdGF0dXNfYWJvdmVfY29fZW50cnkodm9pZCAqb3BhcXVlKQogewogICAgIEJk
cnZDb0Jsb2NrU3RhdHVzRGF0YSAqZGF0YSA9IG9wYXF1ZTsKIAotICAgIHJldHVybiBiZHJ2X2Nv
X2Jsb2NrX3N0YXR1c19hYm92ZShkYXRhLT5icywgZGF0YS0+YmFzZSwKLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZGF0YS0+d2FudF96ZXJvLAotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkYXRhLT5vZmZzZXQsIGRhdGEtPmJ5dGVzLAotICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhLT5wbnVtLCBkYXRhLT5tYXAsIGRh
dGEtPmZpbGUpOworICAgIHJldHVybiBiZHJ2X2NvX2NvbW1vbl9ibG9ja19zdGF0dXNfYWJvdmUo
ZGF0YS0+YnMsIGRhdGEtPmJhc2UsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBkYXRhLT53YW50X3plcm8sCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkYXRhLT5vZmZzZXQsIGRhdGEtPmJ5dGVzLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YS0+cG51bSwgZGF0YS0+bWFwLCBk
YXRhLT5maWxlKTsKIH0KIAogLyoKLS0gCjIuMjYuMgoK


