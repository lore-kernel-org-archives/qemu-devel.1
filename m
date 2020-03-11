Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74D8C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4722208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtqXph4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4722208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0go-0000H5-Oj
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC0fs-0006yP-FG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC0fq-0000It-6Z
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC0fq-0000Ih-3c
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583930481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZaawQ9CCgw9+6/uP2kS2YGY8JFyJ+jcvITPBVKrP3F4=;
 b=gtqXph4IwPmRBSjwm8l75JcsYhF22hJa94F8mFJGlwL9uSCDk+9DZ7LP9ihrWIvGGqeGpP
 O6NHNg8/pg6YP1IPUKxsiMwkHtq3O4CngqjKn7ggnhuLR7H/yWVL/K+qDTNzIytUnOFhSE
 E/Gzlb7NNSIcHMMA4ZKkeQKNgKpo+OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-DNLYj92pMkOEAp924vfxXw-1; Wed, 11 Mar 2020 08:41:18 -0400
X-MC-Unique: DNLYj92pMkOEAp924vfxXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E660100550E;
 Wed, 11 Mar 2020 12:41:16 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6A4D10013A1;
 Wed, 11 Mar 2020 12:41:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] aio-posix: simplify FDMonOps->update() prototype
Date: Wed, 11 Mar 2020 12:40:42 +0000
Message-Id: <20200311124045.277969-7-stefanha@redhat.com>
In-Reply-To: <20200311124045.277969-1-stefanha@redhat.com>
References: <20200311124045.277969-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIEFpb0hhbmRsZXIgKm5vZGUsIGJvb2wgaXNfbmV3IGFyZ3VtZW50cyBhcmUgbW9yZSBjb21w
bGljYXRlZCB0bwp0aGluayBhYm91dCB0aGFuIHNpbXBseSBiZWluZyBnaXZlbiBBaW9IYW5kbGVy
ICpvbGRfbm9kZSwgQWlvSGFuZGxlcgoqbmV3X25vZGUuCgpGdXJ0aGVybW9yZSwgdGhlIG5ldyBM
aW51eCBpb191cmluZyBmaWxlIGRlc2NyaXB0b3IgbW9uaXRvcmluZyBtZWNoYW5pc20KYWRkZWQg
YnkgdGhlIG5ldyBwYXRjaCByZXF1aXJlcyBhY2Nlc3MgdG8gYm90aCB0aGUgb2xkIGFuZCB0aGUg
bmV3Cm5vZGVzLiAgTWFrZSB0aGlzIGNoYW5nZSBub3cgaW4gcHJlcGFyYXRpb24uCgpTaWduZWQt
b2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ckxpbms6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMDAzMDUxNzA4MDYuMTMxMzI0NS01LXN0ZWZhbmhhQHJl
ZGhhdC5jb20KTWVzc2FnZS1JZDogPDIwMjAwMzA1MTcwODA2LjEzMTMyNDUtNS1zdGVmYW5oYUBy
ZWRoYXQuY29tPgotLS0KIGluY2x1ZGUvYmxvY2svYWlvLmggfCAxMyArKysrKystLS0tLS0tCiB1
dGlsL2Fpby1wb3NpeC5jICAgIHwgIDcgKy0tLS0tLQogdXRpbC9mZG1vbi1lcG9sbC5jICB8IDIx
ICsrKysrKysrKysrKy0tLS0tLS0tLQogdXRpbC9mZG1vbi1wb2xsLmMgICB8ICA0ICsrKy0KIDQg
ZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ibG9jay9haW8uaCBiL2luY2x1ZGUvYmxvY2svYWlvLmgKaW5kZXggOTBl
MDdkNzUwNy4uYmQ3NmIwOGYxYSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ibG9jay9haW8uaAorKysg
Yi9pbmNsdWRlL2Jsb2NrL2Fpby5oCkBAIC01NywxNyArNTcsMTYgQEAgdHlwZWRlZiBzdHJ1Y3Qg
ewogICAgIC8qCiAgICAgICogdXBkYXRlOgogICAgICAqIEBjdHg6IHRoZSBBaW9Db250ZXh0Ci0g
ICAgICogQG5vZGU6IHRoZSBoYW5kbGVyCi0gICAgICogQGlzX25ldzogaXMgdGhlIGZpbGUgZGVz
Y3JpcHRvciBhbHJlYWR5IGJlaW5nIG1vbml0b3JlZD8KKyAgICAgKiBAb2xkX25vZGU6IHRoZSBl
eGlzdGluZyBoYW5kbGVyIG9yIE5VTEwgaWYgdGhpcyBmaWxlIGRlc2NyaXB0b3IgaXMgYmVpbmcK
KyAgICAgKiAgICAgICAgICAgIG1vbml0b3JlZCBmb3IgdGhlIGZpcnN0IHRpbWUKKyAgICAgKiBA
bmV3X25vZGU6IHRoZSBuZXcgaGFuZGxlciBvciBOVUxMIGlmIHRoaXMgZmlsZSBkZXNjcmlwdG9y
IGlzIGJlaW5nCisgICAgICogICAgICAgICAgICByZW1vdmVkCiAgICAgICoKLSAgICAgKiBBZGQv
cmVtb3ZlL21vZGlmeSBhIG1vbml0b3JlZCBmaWxlIGRlc2NyaXB0b3IuICBUaGVyZSBhcmUgdGhy
ZWUgY2FzZXM6Ci0gICAgICogMS4gbm9kZS0+cGZkLmV2ZW50cyA9PSAwIG1lYW5zIHJlbW92ZSB0
aGUgZmlsZSBkZXNjcmlwdG9yLgotICAgICAqIDIuICFpc19uZXcgbWVhbnMgbW9kaWZ5IGFuIGFs
cmVhZHkgbW9uaXRvcmVkIGZpbGUgZGVzY3JpcHRvci4KLSAgICAgKiAzLiBpc19uZXcgbWVhbnMg
YWRkIGEgbmV3IGZpbGUgZGVzY3JpcHRvci4KKyAgICAgKiBBZGQvcmVtb3ZlL21vZGlmeSBhIG1v
bml0b3JlZCBmaWxlIGRlc2NyaXB0b3IuCiAgICAgICoKICAgICAgKiBDYWxsZWQgd2l0aCBjdHgt
Pmxpc3RfbG9jayBhY3F1aXJlZC4KICAgICAgKi8KLSAgICB2b2lkICgqdXBkYXRlKShBaW9Db250
ZXh0ICpjdHgsIEFpb0hhbmRsZXIgKm5vZGUsIGJvb2wgaXNfbmV3KTsKKyAgICB2b2lkICgqdXBk
YXRlKShBaW9Db250ZXh0ICpjdHgsIEFpb0hhbmRsZXIgKm9sZF9ub2RlLCBBaW9IYW5kbGVyICpu
ZXdfbm9kZSk7CiAKICAgICAvKgogICAgICAqIHdhaXQ6CmRpZmYgLS1naXQgYS91dGlsL2Fpby1w
b3NpeC5jIGIvdXRpbC9haW8tcG9zaXguYwppbmRleCBiYzBiODY1NDdjLi4wMjhiMmFiZGVkIDEw
MDY0NAotLS0gYS91dGlsL2Fpby1wb3NpeC5jCisrKyBiL3V0aWwvYWlvLXBvc2l4LmMKQEAgLTEz
OSwxMiArMTM5LDcgQEAgdm9pZCBhaW9fc2V0X2ZkX2hhbmRsZXIoQWlvQ29udGV4dCAqY3R4LAog
ICAgIGF0b21pY19zZXQoJmN0eC0+cG9sbF9kaXNhYmxlX2NudCwKICAgICAgICAgICAgICAgIGF0
b21pY19yZWFkKCZjdHgtPnBvbGxfZGlzYWJsZV9jbnQpICsgcG9sbF9kaXNhYmxlX2NoYW5nZSk7
CiAKLSAgICBpZiAobmV3X25vZGUpIHsKLSAgICAgICAgY3R4LT5mZG1vbl9vcHMtPnVwZGF0ZShj
dHgsIG5ld19ub2RlLCBpc19uZXcpOwotICAgIH0gZWxzZSBpZiAobm9kZSkgewotICAgICAgICAv
KiBVbnJlZ2lzdGVyIGRlbGV0ZWQgZmRfaGFuZGxlciAqLwotICAgICAgICBjdHgtPmZkbW9uX29w
cy0+dXBkYXRlKGN0eCwgbm9kZSwgZmFsc2UpOwotICAgIH0KKyAgICBjdHgtPmZkbW9uX29wcy0+
dXBkYXRlKGN0eCwgbm9kZSwgbmV3X25vZGUpOwogICAgIHFlbXVfbG9ja2NudF91bmxvY2soJmN0
eC0+bGlzdF9sb2NrKTsKICAgICBhaW9fbm90aWZ5KGN0eCk7CiAKZGlmZiAtLWdpdCBhL3V0aWwv
ZmRtb24tZXBvbGwuYyBiL3V0aWwvZmRtb24tZXBvbGwuYwppbmRleCAyOWMxNDU0NDY5Li5kNTZi
Njk0NjhiIDEwMDY0NAotLS0gYS91dGlsL2ZkbW9uLWVwb2xsLmMKKysrIGIvdXRpbC9mZG1vbi1l
cG9sbC5jCkBAIC0zMCwyMSArMzAsMjQgQEAgc3RhdGljIGlubGluZSBpbnQgZXBvbGxfZXZlbnRz
X2Zyb21fcGZkKGludCBwZmRfZXZlbnRzKQogICAgICAgICAgICAocGZkX2V2ZW50cyAmIEdfSU9f
RVJSID8gRVBPTExFUlIgOiAwKTsKIH0KIAotc3RhdGljIHZvaWQgZmRtb25fZXBvbGxfdXBkYXRl
KEFpb0NvbnRleHQgKmN0eCwgQWlvSGFuZGxlciAqbm9kZSwgYm9vbCBpc19uZXcpCitzdGF0aWMg
dm9pZCBmZG1vbl9lcG9sbF91cGRhdGUoQWlvQ29udGV4dCAqY3R4LAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEFpb0hhbmRsZXIgKm9sZF9ub2RlLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEFpb0hhbmRsZXIgKm5ld19ub2RlKQogewotICAgIHN0cnVjdCBlcG9sbF9l
dmVudCBldmVudDsKKyAgICBzdHJ1Y3QgZXBvbGxfZXZlbnQgZXZlbnQgPSB7CisgICAgICAgIC5k
YXRhLnB0ciA9IG5ld19ub2RlLAorICAgICAgICAuZXZlbnRzID0gbmV3X25vZGUgPyBlcG9sbF9l
dmVudHNfZnJvbV9wZmQobmV3X25vZGUtPnBmZC5ldmVudHMpIDogMCwKKyAgICB9OwogICAgIGlu
dCByOwotICAgIGludCBjdGw7CiAKLSAgICBpZiAoIW5vZGUtPnBmZC5ldmVudHMpIHsKLSAgICAg
ICAgY3RsID0gRVBPTExfQ1RMX0RFTDsKKyAgICBpZiAoIW5ld19ub2RlKSB7CisgICAgICAgIHIg
PSBlcG9sbF9jdGwoY3R4LT5lcG9sbGZkLCBFUE9MTF9DVExfREVMLCBvbGRfbm9kZS0+cGZkLmZk
LCAmZXZlbnQpOworICAgIH0gZWxzZSBpZiAoIW9sZF9ub2RlKSB7CisgICAgICAgIHIgPSBlcG9s
bF9jdGwoY3R4LT5lcG9sbGZkLCBFUE9MTF9DVExfQURELCBuZXdfbm9kZS0+cGZkLmZkLCAmZXZl
bnQpOwogICAgIH0gZWxzZSB7Ci0gICAgICAgIGV2ZW50LmRhdGEucHRyID0gbm9kZTsKLSAgICAg
ICAgZXZlbnQuZXZlbnRzID0gZXBvbGxfZXZlbnRzX2Zyb21fcGZkKG5vZGUtPnBmZC5ldmVudHMp
OwotICAgICAgICBjdGwgPSBpc19uZXcgPyBFUE9MTF9DVExfQUREIDogRVBPTExfQ1RMX01PRDsK
KyAgICAgICAgciA9IGVwb2xsX2N0bChjdHgtPmVwb2xsZmQsIEVQT0xMX0NUTF9NT0QsIG5ld19u
b2RlLT5wZmQuZmQsICZldmVudCk7CiAgICAgfQogCi0gICAgciA9IGVwb2xsX2N0bChjdHgtPmVw
b2xsZmQsIGN0bCwgbm9kZS0+cGZkLmZkLCAmZXZlbnQpOwogICAgIGlmIChyKSB7CiAgICAgICAg
IGZkbW9uX2Vwb2xsX2Rpc2FibGUoY3R4KTsKICAgICB9CmRpZmYgLS1naXQgYS91dGlsL2ZkbW9u
LXBvbGwuYyBiL3V0aWwvZmRtb24tcG9sbC5jCmluZGV4IDY3OTkyMTE2YjguLjI4MTE0YTBmMzkg
MTAwNjQ0Ci0tLSBhL3V0aWwvZmRtb24tcG9sbC5jCisrKyBiL3V0aWwvZmRtb24tcG9sbC5jCkBA
IC05Myw3ICs5Myw5IEBAIHN0YXRpYyBpbnQgZmRtb25fcG9sbF93YWl0KEFpb0NvbnRleHQgKmN0
eCwgQWlvSGFuZGxlckxpc3QgKnJlYWR5X2xpc3QsCiAgICAgcmV0dXJuIHJldDsKIH0KIAotc3Rh
dGljIHZvaWQgZmRtb25fcG9sbF91cGRhdGUoQWlvQ29udGV4dCAqY3R4LCBBaW9IYW5kbGVyICpu
b2RlLCBib29sIGlzX25ldykKK3N0YXRpYyB2b2lkIGZkbW9uX3BvbGxfdXBkYXRlKEFpb0NvbnRl
eHQgKmN0eCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFpb0hhbmRsZXIgKm9sZF9u
b2RlLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQWlvSGFuZGxlciAqbmV3X25vZGUp
CiB7CiAgICAgLyogRG8gbm90aGluZywgQWlvSGFuZGxlciBhbHJlYWR5IGNvbnRhaW5zIHRoZSBz
dGF0ZSB3ZSdsbCBuZWVkICovCiB9Ci0tIAoyLjI0LjEKCg==


