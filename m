Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B54C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237772075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeU3Af31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237772075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh92P-0003mj-CC
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8yd-00041G-5N
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:49:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8yc-0006wj-56
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591350565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJbmD890MPdc4XuV7RvTabZD6/hV+2KvrQ5ip8Z0CDw=;
 b=aeU3Af31/onyluM2K7YC585CazEkhHHJ4vYwSdT7UtRr1JLi7dlvvlens6uczv+hq19vej
 6V9/P2V+eVYvdfk/qdDLZ/znXISpB4nhQBiT55v/YWE+ayZVWcnZznkp6W528Ilcozs20F
 Oc0X+erkcD8CLfCy7M4kJc7fZq9By2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-AR3y7fC6MPu0JtKegFcJlw-1; Fri, 05 Jun 2020 05:49:21 -0400
X-MC-Unique: AR3y7fC6MPu0JtKegFcJlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F471461;
 Fri,  5 Jun 2020 09:49:19 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 341375C660;
 Fri,  5 Jun 2020 09:49:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 08/11] memory: Extract memory_region_msync() from
 memory_region_writeback()
Date: Fri,  5 Jun 2020 10:47:47 +0100
Message-Id: <20200605094750.149957-9-stefanha@redhat.com>
In-Reply-To: <20200605094750.149957-1-stefanha@redhat.com>
References: <20200605094750.149957-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Julia Suvorova <jusual@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKU3VnZ2Vz
dGVkLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBSaWNo
YXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KQWNrZWQtYnk6IFBh
b2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwNTA4MDYy
NDU2LjIzMzQ0LTMtcGhpbG1kQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCB8IDEz
ICsrKysrKysrKysrKy0KIG1lbW9yeS5jICAgICAgICAgICAgICB8IDEwICsrKysrKysrLS0KIDIg
ZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2V4ZWMvbWVtb3J5LmggYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgKaW5kZXgg
MWI3Y2ZkZDViNi4uM2UwMGNkYmJmYSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5o
CisrKyBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaApAQCAtMTQ3Myw4ICsxNDczLDE5IEBAIHZvaWQg
Km1lbW9yeV9yZWdpb25fZ2V0X3JhbV9wdHIoTWVtb3J5UmVnaW9uICptcik7CiAgKi8KIHZvaWQg
bWVtb3J5X3JlZ2lvbl9yYW1fcmVzaXplKE1lbW9yeVJlZ2lvbiAqbXIsIHJhbV9hZGRyX3QgbmV3
c2l6ZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7CisKIC8q
KgotICogbWVtb3J5X3JlZ2lvbl93cml0ZWJhY2s6IFRyaWdnZXIgY2FjaGUgd3JpdGViYWNrIG9y
IG1zeW5jIGZvcgorICogbWVtb3J5X3JlZ2lvbl9tc3luYzogU3luY2hyb25pemUgc2VsZWN0ZWQg
YWRkcmVzcyByYW5nZSBvZgorICogYSBtZW1vcnkgbWFwcGVkIHJlZ2lvbgorICoKKyAqIEBtcjog
dGhlIG1lbW9yeSByZWdpb24gdG8gYmUgbXN5bmMKKyAqIEBhZGRyOiB0aGUgaW5pdGlhbCBhZGRy
ZXNzIG9mIHRoZSByYW5nZSB0byBiZSBzeW5jCisgKiBAc2l6ZTogdGhlIHNpemUgb2YgdGhlIHJh
bmdlIHRvIGJlIHN5bmMKKyAqLwordm9pZCBtZW1vcnlfcmVnaW9uX21zeW5jKE1lbW9yeVJlZ2lv
biAqbXIsIGh3YWRkciBhZGRyLCBod2FkZHIgc2l6ZSk7CisKKy8qKgorICogbWVtb3J5X3JlZ2lv
bl93cml0ZWJhY2s6IFRyaWdnZXIgY2FjaGUgd3JpdGViYWNrIGZvcgogICogc2VsZWN0ZWQgYWRk
cmVzcyByYW5nZQogICoKICAqIEBtcjogdGhlIG1lbW9yeSByZWdpb24gdG8gYmUgdXBkYXRlZApk
aWZmIC0tZ2l0IGEvbWVtb3J5LmMgYi9tZW1vcnkuYwppbmRleCBiYjg0MzM0ZTFlLi45M2ZlYmU0
NzU5IDEwMDY0NAotLS0gYS9tZW1vcnkuYworKysgYi9tZW1vcnkuYwpAQCAtMjE5Nyw2ICsyMTk3
LDEyIEBAIHZvaWQgbWVtb3J5X3JlZ2lvbl9yYW1fcmVzaXplKE1lbW9yeVJlZ2lvbiAqbXIsIHJh
bV9hZGRyX3QgbmV3c2l6ZSwgRXJyb3IgKiplcnJwCiAgICAgcWVtdV9yYW1fcmVzaXplKG1yLT5y
YW1fYmxvY2ssIG5ld3NpemUsIGVycnApOwogfQogCit2b2lkIG1lbW9yeV9yZWdpb25fbXN5bmMo
TWVtb3J5UmVnaW9uICptciwgaHdhZGRyIGFkZHIsIGh3YWRkciBzaXplKQoreworICAgIGlmICht
ci0+cmFtX2Jsb2NrKSB7CisgICAgICAgIHFlbXVfcmFtX3dyaXRlYmFjayhtci0+cmFtX2Jsb2Nr
LCBhZGRyLCBzaXplKTsKKyAgICB9Cit9CiAKIHZvaWQgbWVtb3J5X3JlZ2lvbl93cml0ZWJhY2so
TWVtb3J5UmVnaW9uICptciwgaHdhZGRyIGFkZHIsIGh3YWRkciBzaXplKQogewpAQCAtMjIwNCw4
ICsyMjEwLDggQEAgdm9pZCBtZW1vcnlfcmVnaW9uX3dyaXRlYmFjayhNZW1vcnlSZWdpb24gKm1y
LCBod2FkZHIgYWRkciwgaHdhZGRyIHNpemUpCiAgICAgICogTWlnaHQgYmUgZXh0ZW5kZWQgY2Fz
ZSBuZWVkZWQgdG8gY292ZXIKICAgICAgKiBkaWZmZXJlbnQgdHlwZXMgb2YgbWVtb3J5IHJlZ2lv
bnMKICAgICAgKi8KLSAgICBpZiAobXItPnJhbV9ibG9jayAmJiBtci0+ZGlydHlfbG9nX21hc2sp
IHsKLSAgICAgICAgcWVtdV9yYW1fd3JpdGViYWNrKG1yLT5yYW1fYmxvY2ssIGFkZHIsIHNpemUp
OworICAgIGlmIChtci0+ZGlydHlfbG9nX21hc2spIHsKKyAgICAgICAgbWVtb3J5X3JlZ2lvbl9t
c3luYyhtciwgYWRkciwgc2l6ZSk7CiAgICAgfQogfQogCi0tIAoyLjI1LjQKCg==


