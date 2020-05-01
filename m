Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13959C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 08:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35F8206D9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 08:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cr4XGxce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35F8206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUR8q-0001sO-0b
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 04:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUR38-0001Co-1r
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUR2s-0004zf-Av
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:29:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60343
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jUR2r-0004tR-Mh
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588321756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1KqxwuQINsvghZKvSRECqg3J3rn5MeI41Ww7TEYuMA=;
 b=cr4XGxceZP9AATUNC4QDUojeRiQSsi6QHAra/w3JaBWufI0N7fhMcE9Z8KdqCoVPO74LzU
 qTAcOLhGf7ImA04bOz3pxfLRSM1S+AuJWWHEab+mGMld+PtqDX0HfVk6oAxC+8y647anAM
 G+prZpiIyMlyoAiIBgg9Sl3kjh/zJyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-H6KfKyzPNOeR2F_rmS3zeg-1; Fri, 01 May 2020 04:29:15 -0400
X-MC-Unique: H6KfKyzPNOeR2F_rmS3zeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F65B80183C;
 Fri,  1 May 2020 08:29:13 +0000 (UTC)
Received: from localhost (ovpn-112-199.ams2.redhat.com [10.36.112.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B67732B4BC;
 Fri,  1 May 2020 08:29:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] lockable: Replace locks with lock guard macros
Date: Fri,  1 May 2020 09:28:06 +0100
Message-Id: <20200501082806.205696-5-stefanha@redhat.com>
In-Reply-To: <20200501082806.205696-1-stefanha@redhat.com>
References: <20200501082806.205696-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 04:28:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Bandan Das <bsd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Lieven <pl@kamp.de>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Simran Singhal <singhalsimran0@gmail.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogU2ltcmFuIFNpbmdoYWwgPHNpbmdoYWxzaW1yYW4wQGdtYWlsLmNvbT4KClJlcGxhY2Ug
bWFudWFsIGxvY2soKS91bmxvY2soKSBjYWxscyB3aXRoIGxvY2sgZ3VhcmQgbWFjcm9zCihRRU1V
X0xPQ0tfR1VBUkQvV0lUSF9RRU1VX0xPQ0tfR1VBUkQpLgoKU2lnbmVkLW9mZi1ieTogU2ltcmFu
IFNpbmdoYWwgPHNpbmdoYWxzaW1yYW4wQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFl1dmFsIFNo
YWlhIDx5dXZhbC5zaGFpYS5tbEBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBNYXJjZWwgQXBmZWxi
YXVtPG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPgpUZXN0ZWQtYnk6IFl1dmFsIFNoYWlhIDx5
dXZhbC5zaGFpYS5tbEBnbWFpbC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwNDAyMDY1MDM1LkdBMTU0
NzdAc2ltcmFuLUluc3Bpcm9uLTU1NTgKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxz
dGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGh3L2h5cGVydi9oeXBlcnYuYyAgICAgfCAxNSArKysr
KystLS0tLS0tCiBody9yZG1hL3JkbWFfYmFja2VuZC5jIHwgNTAgKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBody9yZG1hL3JkbWFfcm0uYyAgICAgIHwgIDMgKy0t
CiAzIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2h3L2h5cGVydi9oeXBlcnYuYyBiL2h3L2h5cGVydi9oeXBlcnYuYwppbmRleCA4
Y2EzNzA2ZjViLi40ZGRhZmUxZGUxIDEwMDY0NAotLS0gYS9ody9oeXBlcnYvaHlwZXJ2LmMKKysr
IGIvaHcvaHlwZXJ2L2h5cGVydi5jCkBAIC0xNSw2ICsxNSw3IEBACiAjaW5jbHVkZSAic3lzZW11
L2t2bS5oIgogI2luY2x1ZGUgInFlbXUvYml0b3BzLmgiCiAjaW5jbHVkZSAicWVtdS9lcnJvci1y
ZXBvcnQuaCIKKyNpbmNsdWRlICJxZW11L2xvY2thYmxlLmgiCiAjaW5jbHVkZSAicWVtdS9xdWV1
ZS5oIgogI2luY2x1ZGUgInFlbXUvcmN1LmgiCiAjaW5jbHVkZSAicWVtdS9yY3VfcXVldWUuaCIK
QEAgLTQ5MSw3ICs0OTIsNyBAQCBpbnQgaHlwZXJ2X3NldF9tc2dfaGFuZGxlcih1aW50MzJfdCBj
b25uX2lkLCBIdk1zZ0hhbmRsZXIgaGFuZGxlciwgdm9pZCAqZGF0YSkKICAgICBpbnQgcmV0Owog
ICAgIE1zZ0hhbmRsZXIgKm1oOwogCi0gICAgcWVtdV9tdXRleF9sb2NrKCZoYW5kbGVyc19tdXRl
eCk7CisgICAgUUVNVV9MT0NLX0dVQVJEKCZoYW5kbGVyc19tdXRleCk7CiAgICAgUUxJU1RfRk9S
RUFDSChtaCwgJm1zZ19oYW5kbGVycywgbGluaykgewogICAgICAgICBpZiAobWgtPmNvbm5faWQg
PT0gY29ubl9pZCkgewogICAgICAgICAgICAgaWYgKGhhbmRsZXIpIHsKQEAgLTUwMSw3ICs1MDIs
NyBAQCBpbnQgaHlwZXJ2X3NldF9tc2dfaGFuZGxlcih1aW50MzJfdCBjb25uX2lkLCBIdk1zZ0hh
bmRsZXIgaGFuZGxlciwgdm9pZCAqZGF0YSkKICAgICAgICAgICAgICAgICBnX2ZyZWVfcmN1KG1o
LCByY3UpOwogICAgICAgICAgICAgICAgIHJldCA9IDA7CiAgICAgICAgICAgICB9Ci0gICAgICAg
ICAgICBnb3RvIHVubG9jazsKKyAgICAgICAgICAgIHJldHVybiByZXQ7CiAgICAgICAgIH0KICAg
ICB9CiAKQEAgLTUxNSw4ICs1MTYsNyBAQCBpbnQgaHlwZXJ2X3NldF9tc2dfaGFuZGxlcih1aW50
MzJfdCBjb25uX2lkLCBIdk1zZ0hhbmRsZXIgaGFuZGxlciwgdm9pZCAqZGF0YSkKICAgICB9IGVs
c2UgewogICAgICAgICByZXQgPSAtRU5PRU5UOwogICAgIH0KLXVubG9jazoKLSAgICBxZW11X211
dGV4X3VubG9jaygmaGFuZGxlcnNfbXV0ZXgpOworCiAgICAgcmV0dXJuIHJldDsKIH0KIApAQCAt
NTY1LDcgKzU2NSw3IEBAIHN0YXRpYyBpbnQgc2V0X2V2ZW50X2ZsYWdfaGFuZGxlcih1aW50MzJf
dCBjb25uX2lkLCBFdmVudE5vdGlmaWVyICpub3RpZmllcikKICAgICBpbnQgcmV0OwogICAgIEV2
ZW50RmxhZ0hhbmRsZXIgKmhhbmRsZXI7CiAKLSAgICBxZW11X211dGV4X2xvY2soJmhhbmRsZXJz
X211dGV4KTsKKyAgICBRRU1VX0xPQ0tfR1VBUkQoJmhhbmRsZXJzX211dGV4KTsKICAgICBRTElT
VF9GT1JFQUNIKGhhbmRsZXIsICZldmVudF9mbGFnX2hhbmRsZXJzLCBsaW5rKSB7CiAgICAgICAg
IGlmIChoYW5kbGVyLT5jb25uX2lkID09IGNvbm5faWQpIHsKICAgICAgICAgICAgIGlmIChub3Rp
ZmllcikgewpAQCAtNTc1LDcgKzU3NSw3IEBAIHN0YXRpYyBpbnQgc2V0X2V2ZW50X2ZsYWdfaGFu
ZGxlcih1aW50MzJfdCBjb25uX2lkLCBFdmVudE5vdGlmaWVyICpub3RpZmllcikKICAgICAgICAg
ICAgICAgICBnX2ZyZWVfcmN1KGhhbmRsZXIsIHJjdSk7CiAgICAgICAgICAgICAgICAgcmV0ID0g
MDsKICAgICAgICAgICAgIH0KLSAgICAgICAgICAgIGdvdG8gdW5sb2NrOworICAgICAgICAgICAg
cmV0dXJuIHJldDsKICAgICAgICAgfQogICAgIH0KIApAQCAtNTg4LDggKzU4OCw3IEBAIHN0YXRp
YyBpbnQgc2V0X2V2ZW50X2ZsYWdfaGFuZGxlcih1aW50MzJfdCBjb25uX2lkLCBFdmVudE5vdGlm
aWVyICpub3RpZmllcikKICAgICB9IGVsc2UgewogICAgICAgICByZXQgPSAtRU5PRU5UOwogICAg
IH0KLXVubG9jazoKLSAgICBxZW11X211dGV4X3VubG9jaygmaGFuZGxlcnNfbXV0ZXgpOworCiAg
ICAgcmV0dXJuIHJldDsKIH0KIApkaWZmIC0tZ2l0IGEvaHcvcmRtYS9yZG1hX2JhY2tlbmQuYyBi
L2h3L3JkbWEvcmRtYV9iYWNrZW5kLmMKaW5kZXggM2RkMzlmZTFhNy4uZGI3ZTVjOGJlNSAxMDA2
NDQKLS0tIGEvaHcvcmRtYS9yZG1hX2JhY2tlbmQuYworKysgYi9ody9yZG1hL3JkbWFfYmFja2Vu
ZC5jCkBAIC05NSwzNiArOTUsMzYgQEAgc3RhdGljIGludCByZG1hX3BvbGxfY3EoUmRtYURldmlj
ZVJlc291cmNlcyAqcmRtYV9kZXZfcmVzLCBzdHJ1Y3QgaWJ2X2NxICppYmNxKQogICAgIHN0cnVj
dCBpYnZfd2Mgd2NbMl07CiAgICAgUmRtYVByb3RlY3RlZEdTTGlzdCAqY3FlX2N0eF9saXN0Owog
Ci0gICAgcWVtdV9tdXRleF9sb2NrKCZyZG1hX2Rldl9yZXMtPmxvY2spOwotICAgIGRvIHsKLSAg
ICAgICAgbmUgPSBpYnZfcG9sbF9jcShpYmNxLCBBUlJBWV9TSVpFKHdjKSwgd2MpOworICAgIFdJ
VEhfUUVNVV9MT0NLX0dVQVJEKCZyZG1hX2Rldl9yZXMtPmxvY2spIHsKKyAgICAgICAgZG8gewor
ICAgICAgICAgICAgbmUgPSBpYnZfcG9sbF9jcShpYmNxLCBBUlJBWV9TSVpFKHdjKSwgd2MpOwog
Ci0gICAgICAgIHRyYWNlX3JkbWFfcG9sbF9jcShuZSwgaWJjcSk7CisgICAgICAgICAgICB0cmFj
ZV9yZG1hX3BvbGxfY3EobmUsIGliY3EpOwogCi0gICAgICAgIGZvciAoaSA9IDA7IGkgPCBuZTsg
aSsrKSB7Ci0gICAgICAgICAgICBiY3R4ID0gcmRtYV9ybV9nZXRfY3FlX2N0eChyZG1hX2Rldl9y
ZXMsIHdjW2ldLndyX2lkKTsKLSAgICAgICAgICAgIGlmICh1bmxpa2VseSghYmN0eCkpIHsKLSAg
ICAgICAgICAgICAgICByZG1hX2Vycm9yX3JlcG9ydCgiTm8gbWF0Y2hpbmcgY3R4IGZvciByZXEg
JSJQUklkNjQsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd2NbaV0ud3JfaWQp
OwotICAgICAgICAgICAgICAgIGNvbnRpbnVlOwotICAgICAgICAgICAgfQorICAgICAgICAgICAg
Zm9yIChpID0gMDsgaSA8IG5lOyBpKyspIHsKKyAgICAgICAgICAgICAgICBiY3R4ID0gcmRtYV9y
bV9nZXRfY3FlX2N0eChyZG1hX2Rldl9yZXMsIHdjW2ldLndyX2lkKTsKKyAgICAgICAgICAgICAg
ICBpZiAodW5saWtlbHkoIWJjdHgpKSB7CisgICAgICAgICAgICAgICAgICAgIHJkbWFfZXJyb3Jf
cmVwb3J0KCJObyBtYXRjaGluZyBjdHggZm9yIHJlcSAlIlBSSWQ2NCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgd2NbaV0ud3JfaWQpOworICAgICAgICAgICAgICAgICAg
ICBjb250aW51ZTsKKyAgICAgICAgICAgICAgICB9CiAKLSAgICAgICAgICAgIGNvbXBfaGFuZGxl
cihiY3R4LT51cF9jdHgsICZ3Y1tpXSk7CisgICAgICAgICAgICAgICAgY29tcF9oYW5kbGVyKGJj
dHgtPnVwX2N0eCwgJndjW2ldKTsKIAotICAgICAgICAgICAgaWYgKGJjdHgtPmJhY2tlbmRfcXAp
IHsKLSAgICAgICAgICAgICAgICBjcWVfY3R4X2xpc3QgPSAmYmN0eC0+YmFja2VuZF9xcC0+Y3Fl
X2N0eF9saXN0OwotICAgICAgICAgICAgfSBlbHNlIHsKLSAgICAgICAgICAgICAgICBjcWVfY3R4
X2xpc3QgPSAmYmN0eC0+YmFja2VuZF9zcnEtPmNxZV9jdHhfbGlzdDsKLSAgICAgICAgICAgIH0K
KyAgICAgICAgICAgICAgICBpZiAoYmN0eC0+YmFja2VuZF9xcCkgeworICAgICAgICAgICAgICAg
ICAgICBjcWVfY3R4X2xpc3QgPSAmYmN0eC0+YmFja2VuZF9xcC0+Y3FlX2N0eF9saXN0OworICAg
ICAgICAgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAgICAgICAgICAgIGNxZV9jdHhfbGlzdCA9
ICZiY3R4LT5iYWNrZW5kX3NycS0+Y3FlX2N0eF9saXN0OworICAgICAgICAgICAgICAgIH0KIAot
ICAgICAgICAgICAgcmRtYV9wcm90ZWN0ZWRfZ3NsaXN0X3JlbW92ZV9pbnQzMihjcWVfY3R4X2xp
c3QsIHdjW2ldLndyX2lkKTsKLSAgICAgICAgICAgIHJkbWFfcm1fZGVhbGxvY19jcWVfY3R4KHJk
bWFfZGV2X3Jlcywgd2NbaV0ud3JfaWQpOwotICAgICAgICAgICAgZ19mcmVlKGJjdHgpOwotICAg
ICAgICB9Ci0gICAgICAgIHRvdGFsX25lICs9IG5lOwotICAgIH0gd2hpbGUgKG5lID4gMCk7Ci0g
ICAgYXRvbWljX3N1YigmcmRtYV9kZXZfcmVzLT5zdGF0cy5taXNzaW5nX2NxZSwgdG90YWxfbmUp
OwotICAgIHFlbXVfbXV0ZXhfdW5sb2NrKCZyZG1hX2Rldl9yZXMtPmxvY2spOworICAgICAgICAg
ICAgICAgIHJkbWFfcHJvdGVjdGVkX2dzbGlzdF9yZW1vdmVfaW50MzIoY3FlX2N0eF9saXN0LCB3
Y1tpXS53cl9pZCk7CisgICAgICAgICAgICAgICAgcmRtYV9ybV9kZWFsbG9jX2NxZV9jdHgocmRt
YV9kZXZfcmVzLCB3Y1tpXS53cl9pZCk7CisgICAgICAgICAgICAgICAgZ19mcmVlKGJjdHgpOwor
ICAgICAgICAgICAgfQorICAgICAgICAgICAgdG90YWxfbmUgKz0gbmU7CisgICAgICAgIH0gd2hp
bGUgKG5lID4gMCk7CisgICAgICAgIGF0b21pY19zdWIoJnJkbWFfZGV2X3Jlcy0+c3RhdHMubWlz
c2luZ19jcWUsIHRvdGFsX25lKTsKKyAgICB9CiAKICAgICBpZiAobmUgPCAwKSB7CiAgICAgICAg
IHJkbWFfZXJyb3JfcmVwb3J0KCJpYnZfcG9sbF9jcSBmYWlsLCByYz0lZCwgZXJybm89JWQiLCBu
ZSwgZXJybm8pOwpkaWZmIC0tZ2l0IGEvaHcvcmRtYS9yZG1hX3JtLmMgYi9ody9yZG1hL3JkbWFf
cm0uYwppbmRleCA3ZTllYTI4M2M5Li42MDk1N2Y4OGRiIDEwMDY0NAotLS0gYS9ody9yZG1hL3Jk
bWFfcm0uYworKysgYi9ody9yZG1hL3JkbWFfcm0uYwpAQCAtMTQ3LDE0ICsxNDcsMTMgQEAgc3Rh
dGljIGlubGluZSB2b2lkIHJkbWFfcmVzX3RibF9kZWFsbG9jKFJkbWFSbVJlc1RibCAqdGJsLCB1
aW50MzJfdCBoYW5kbGUpCiB7CiAgICAgdHJhY2VfcmRtYV9yZXNfdGJsX2RlYWxsb2ModGJsLT5u
YW1lLCBoYW5kbGUpOwogCi0gICAgcWVtdV9tdXRleF9sb2NrKCZ0YmwtPmxvY2spOworICAgIFFF
TVVfTE9DS19HVUFSRCgmdGJsLT5sb2NrKTsKIAogICAgIGlmIChoYW5kbGUgPCB0YmwtPnRibF9z
eikgewogICAgICAgICBjbGVhcl9iaXQoaGFuZGxlLCB0YmwtPmJpdG1hcCk7CiAgICAgICAgIHRi
bC0+dXNlZC0tOwogICAgIH0KIAotICAgIHFlbXVfbXV0ZXhfdW5sb2NrKCZ0YmwtPmxvY2spOwog
fQogCiBpbnQgcmRtYV9ybV9hbGxvY19wZChSZG1hRGV2aWNlUmVzb3VyY2VzICpkZXZfcmVzLCBS
ZG1hQmFja2VuZERldiAqYmFja2VuZF9kZXYsCi0tIAoyLjI1LjMKCg==


