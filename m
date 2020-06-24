Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF40BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE20120B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VObzIVpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE20120B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2Hm-0006gX-VI
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2Ej-0001Cp-Th
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:02:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2Eg-0003Vr-Mx
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592992949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VX3xaEhQbYneUxyvAAyvSsdi9n8zcvzyBvibby1ATqM=;
 b=VObzIVpDFmuuuTA9t+qVTfdSYLt/db98AJrYlCbouBn1be8APSLlijiSChplmi3eWBpwOi
 TCAnxO5kYYg2EXwqq/FNeJuaKad1vt05wO7KwBO4Dtu4/4B7ZQ5Ush1DXtZsM1+LpC8Yat
 j1rjUYj786YtrrCwCHSTr47v3PX6uQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-j7dofYqFOKSz7qNfvMLy2g-1; Wed, 24 Jun 2020 06:02:27 -0400
X-MC-Unique: j7dofYqFOKSz7qNfvMLy2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D5CC10059A3;
 Wed, 24 Jun 2020 10:02:26 +0000 (UTC)
Received: from localhost (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5151D84FA;
 Wed, 24 Jun 2020 10:02:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/12] coroutine: support SafeStack in ucontext backend
Date: Wed, 24 Jun 2020 11:02:00 +0100
Message-Id: <20200624100210.59975-3-stefanha@redhat.com>
In-Reply-To: <20200624100210.59975-1-stefanha@redhat.com>
References: <20200624100210.59975-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogRGFuaWVsZSBCdW9ubyA8ZGJ1b25vQGxpbnV4LnZuZXQuaWJtLmNvbT4KCkxMVk0ncyBT
YWZlU3RhY2sgaW5zdHJ1bWVudGF0aW9uIGRvZXMgbm90IHlldCBzdXBwb3J0IHByb2dyYW1zIHRo
YXQgbWFrZQp1c2Ugb2YgdGhlIEFQSXMgaW4gdWNvbnRleHQuaApXaXRoIHRoZSBjdXJyZW50IGlt
cGxlbWVudGF0aW9uIG9mIGNvcm91dGluZS11Y29udGV4dCwgdGhlIHJlc3VsdGluZwpiaW5hcnkg
aXMgaW5jb3JyZWN0LCB3aXRoIGRpZmZlcmVudCBjb3JvdXRpbmVzIHNoYXJpbmcgdGhlIHNhbWUg
dW5zYWZlCnN0YWNrIGFuZCBwcm9kdWNpbmcgdW5kZWZpbmVkIGJlaGF2aW9yIGF0IHJ1bnRpbWUu
ClRoaXMgZml4IGFsbG9jYXRlcyBhbiBhZGRpdGlvbmFsIHVuc2FmZSBzdGFjayBhcmVhIGZvciBl
YWNoIGNvcm91dGluZSwKYW5kIHNldHMgdGhlIG5ldyB1bnNhZmUgc3RhY2sgcG9pbnRlciBiZWZv
cmUgY2FsbGluZyBzd2FwY29udGV4dCgpIGluCnFlbXVfY29yb3V0aW5lX25ldy4KVGhpcyBpcyB0
aGUgb25seSBwbGFjZSB3aGVyZSB0aGUgcG9pbnRlciBuZWVkcyB0byBiZSBtYW51YWxseSB1cGRh
dGVkLApzaW5jZSBzaWdzZXRqbXAvc2lnbG9uZ2ptcCBhcmUgYWxyZWFkeSBpbnN0cnVtZW50ZWQg
YnkgTExWTSB0byBwcm9wZXJseQpzdXBwb3J0IFNhZmVTdGFjay4KVGhlIGFkZGl0aW9uYWwgc3Rh
Y2sgaXMgdGhlbiBmcmVlZCBpbiBxZW11X2Nvcm91dGluZV9kZWxldGUuCgpTaWduZWQtb2ZmLWJ5
OiBEYW5pZWxlIEJ1b25vIDxkYnVvbm9AbGludXgudm5ldC5pYm0uY29tPgpNZXNzYWdlLWlkOiAy
MDIwMDUyOTIwNTEyMi43MTQtMi1kYnVvbm9AbGludXgudm5ldC5pYm0uY29tClNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBpbmNsdWRlL3Fl
bXUvY29yb3V0aW5lX2ludC5oIHwgIDUgKysrKysKIHV0aWwvY29yb3V0aW5lLXVjb250ZXh0LmMg
ICAgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDMz
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvY29yb3V0aW5lX2ludC5o
IGIvaW5jbHVkZS9xZW11L2Nvcm91dGluZV9pbnQuaAppbmRleCBiZDZiMDQ2OGUxLi4xZGExNDg1
NTJmIDEwMDY0NAotLS0gYS9pbmNsdWRlL3FlbXUvY29yb3V0aW5lX2ludC5oCisrKyBiL2luY2x1
ZGUvcWVtdS9jb3JvdXRpbmVfaW50LmgKQEAgLTI4LDYgKzI4LDExIEBACiAjaW5jbHVkZSAicWVt
dS9xdWV1ZS5oIgogI2luY2x1ZGUgInFlbXUvY29yb3V0aW5lLmgiCiAKKyNpZmRlZiBDT05GSUdf
U0FGRVNUQUNLCisvKiBQb2ludGVyIHRvIHRoZSB1bnNhZmUgc3RhY2ssIGRlZmluZWQgYnkgdGhl
IGNvbXBpbGVyICovCitleHRlcm4gX190aHJlYWQgdm9pZCAqX19zYWZlc3RhY2tfdW5zYWZlX3N0
YWNrX3B0cjsKKyNlbmRpZgorCiAjZGVmaW5lIENPUk9VVElORV9TVEFDS19TSVpFICgxIDw8IDIw
KQogCiB0eXBlZGVmIGVudW0gewpkaWZmIC0tZ2l0IGEvdXRpbC9jb3JvdXRpbmUtdWNvbnRleHQu
YyBiL3V0aWwvY29yb3V0aW5lLXVjb250ZXh0LmMKaW5kZXggNjEzZjRjMTE4ZS4uZjBiNjYzMjBl
MSAxMDA2NDQKLS0tIGEvdXRpbC9jb3JvdXRpbmUtdWNvbnRleHQuYworKysgYi91dGlsL2Nvcm91
dGluZS11Y29udGV4dC5jCkBAIC00NSw2ICs0NSwxMSBAQCB0eXBlZGVmIHN0cnVjdCB7CiAgICAg
Q29yb3V0aW5lIGJhc2U7CiAgICAgdm9pZCAqc3RhY2s7CiAgICAgc2l6ZV90IHN0YWNrX3NpemU7
CisjaWZkZWYgQ09ORklHX1NBRkVTVEFDSworICAgIC8qIE5lZWQgYW4gdW5zYWZlIHN0YWNrIGZv
ciBlYWNoIGNvcm91dGluZSAqLworICAgIHZvaWQgKnVuc2FmZV9zdGFjazsKKyAgICBzaXplX3Qg
dW5zYWZlX3N0YWNrX3NpemU7CisjZW5kaWYKICAgICBzaWdqbXBfYnVmIGVudjsKIAogICAgIHZv
aWQgKnRzYW5fY29fZmliZXI7CkBAIC0xNzksNiArMTg0LDEwIEBAIENvcm91dGluZSAqcWVtdV9j
b3JvdXRpbmVfbmV3KHZvaWQpCiAgICAgY28gPSBnX21hbGxvYzAoc2l6ZW9mKCpjbykpOwogICAg
IGNvLT5zdGFja19zaXplID0gQ09ST1VUSU5FX1NUQUNLX1NJWkU7CiAgICAgY28tPnN0YWNrID0g
cWVtdV9hbGxvY19zdGFjaygmY28tPnN0YWNrX3NpemUpOworI2lmZGVmIENPTkZJR19TQUZFU1RB
Q0sKKyAgICBjby0+dW5zYWZlX3N0YWNrX3NpemUgPSBDT1JPVVRJTkVfU1RBQ0tfU0laRTsKKyAg
ICBjby0+dW5zYWZlX3N0YWNrID0gcWVtdV9hbGxvY19zdGFjaygmY28tPnVuc2FmZV9zdGFja19z
aXplKTsKKyNlbmRpZgogICAgIGNvLT5iYXNlLmVudHJ5X2FyZyA9ICZvbGRfZW52OyAvKiBzdGFz
aCBhd2F5IG91ciBqbXBfYnVmICovCiAKICAgICB1Yy51Y19saW5rID0gJm9sZF91YzsKQEAgLTIw
Myw2ICsyMTIsMjIgQEAgQ29yb3V0aW5lICpxZW11X2Nvcm91dGluZV9uZXcodm9pZCkKICAgICAg
ICAgICAgIENPUk9VVElORV9ZSUVMRCwKICAgICAgICAgICAgICZmYWtlX3N0YWNrX3NhdmUsCiAg
ICAgICAgICAgICBjby0+c3RhY2ssIGNvLT5zdGFja19zaXplLCBjby0+dHNhbl9jb19maWJlcik7
CisKKyNpZmRlZiBDT05GSUdfU0FGRVNUQUNLCisgICAgICAgIC8qCisgICAgICAgICAqIEJlZm9y
ZSB3ZSBzd2FwIHRoZSBjb250ZXh0LCBzZXQgdGhlIG5ldyB1bnNhZmUgc3RhY2sKKyAgICAgICAg
ICogVGhlIHVuc2FmZSBzdGFjayBncm93cyBqdXN0IGxpa2UgdGhlIG5vcm1hbCBzdGFjaywgc28g
c3RhcnQgZnJvbQorICAgICAgICAgKiB0aGUgbGFzdCB1c2FibGUgbG9jYXRpb24gb2YgdGhlIG1l
bW9yeSBhcmVhLgorICAgICAgICAgKiBOT1RFOiB3ZSBkb24ndCBoYXZlIHRvIHJlLXNldCB0aGUg
dXNwIGFmdGVyd2FyZHMgYmVjYXVzZSB3ZSBhcmUKKyAgICAgICAgICogY29taW5nIGJhY2sgdG8g
dGhpcyBjb250ZXh0IHRocm91Z2ggYSBzaWdsb25nam1wLgorICAgICAgICAgKiBUaGUgY29tcGls
ZXIgYWxyZWFkeSB3cmFwcGVkIHRoZSBjb3JyZXNwb25kaW5nIHNpZ3NldGptcCBjYWxsIHdpdGgK
KyAgICAgICAgICogY29kZSB0aGF0IHNhdmVzIHRoZSB1c3Agb24gdGhlIChzYWZlKSBzdGFjayBi
ZWZvcmUgdGhlIGNhbGwsIGFuZAorICAgICAgICAgKiByZXN0b3JlcyBpdCByaWdodCBhZnRlciAo
d2hpY2ggaXMgd2hlcmUgd2UgcmV0dXJuIHdpdGggc2lnbG9uZ2ptcCkuCisgICAgICAgICAqLwor
ICAgICAgICB2b2lkICp1c3AgPSBjby0+dW5zYWZlX3N0YWNrICsgY28tPnVuc2FmZV9zdGFja19z
aXplOworICAgICAgICBfX3NhZmVzdGFja191bnNhZmVfc3RhY2tfcHRyID0gdXNwOworI2VuZGlm
CisKICAgICAgICAgc3dhcGNvbnRleHQoJm9sZF91YywgJnVjKTsKICAgICB9CiAKQEAgLTIzNSw2
ICsyNjAsOSBAQCB2b2lkIHFlbXVfY29yb3V0aW5lX2RlbGV0ZShDb3JvdXRpbmUgKmNvXykKICNl
bmRpZgogCiAgICAgcWVtdV9mcmVlX3N0YWNrKGNvLT5zdGFjaywgY28tPnN0YWNrX3NpemUpOwor
I2lmZGVmIENPTkZJR19TQUZFU1RBQ0sKKyAgICBxZW11X2ZyZWVfc3RhY2soY28tPnVuc2FmZV9z
dGFjaywgY28tPnVuc2FmZV9zdGFja19zaXplKTsKKyNlbmRpZgogICAgIGdfZnJlZShjbyk7CiB9
CiAKLS0gCjIuMjYuMgoK


