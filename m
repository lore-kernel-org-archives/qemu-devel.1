Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ACDC43467
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA2422284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S16wIJCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA2422284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyf3-0007Q3-Kc
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 16:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCw-0002eK-QR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCn-000341-V3
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3kT4EVbxOPisQaAmJ8R24cdqMcdL/oYx2iBOYpP+G8=;
 b=S16wIJCaXEgE7FJpgjloI4eGghaUoxo1aulu1LHk0kAya9wtFP0zxwK5ZoOKGfuId1R5KI
 fqLVnds+1DZCWOW5WZpyWsF7+EWibocoOQLSy/rAzIFEi5JnvFkD+bJ62av+Fpe8ujUXOz
 QSbmk94PqXHF/1a6rwP720U/oBrhjcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-AgRFLwtBNjOmhUDnwnphOg-1; Fri, 09 Oct 2020 15:37:24 -0400
X-MC-Unique: AgRFLwtBNjOmhUDnwnphOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C953875060;
 Fri,  9 Oct 2020 19:37:23 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE2E160BFA;
 Fri,  9 Oct 2020 19:37:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 22/30] block: move block exports to libblockdev
Date: Fri,  9 Oct 2020 20:35:21 +0100
Message-Id: <20201009193529.322822-23-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QmxvY2sgZXhwb3J0cyBhcmUgdXNlZCBieSBzb2Z0bW11LCBxZW11LXN0b3JhZ2UtZGFlbW9uLCBh
bmQgcWVtdS1uYmQuClRoZXkgYXJlIG5vdCB1c2VkIGJ5IG90aGVyIHByb2dyYW1zIGFuZCBhcmUg
bm90IG90aGVyd2lzZSBuZWVkZWQgaW4KbGliYmxvY2suCgpVbmRvIHRoZSByZWNlbnQgbW92ZSBv
ZiBibG9ja2Rldi1uYmQuYyBmcm9tIGJsb2NrZGV2X3NzIGludG8gYmxvY2tfc3MuClNpbmNlIGJk
cnZfY2xvc2VfYWxsKCkgKGxpYmJsb2NrKSBjYWxscyBibGtfZXhwX2Nsb3NlX2FsbCgpCihsaWJi
bG9ja2RldikgYSBzdHViIGZ1bmN0aW9uIGlzIHJlcXVpcmVkLi4KCk1ha2UgcWVtdS1uYmQuYyB1
c2Ugc2lnbmFsIGhhbmRsaW5nIHV0aWxpdHkgZnVuY3Rpb25zIGluc3RlYWQgb2YKZHVwbGljYXRp
bmcgdGhlIGNvZGUuIFRoaXMgaGVscHMgYmVjYXVzZSBvcy1wb3NpeC5jIGlzIGluIGxpYmJsb2Nr
ZGV2CmFuZCBpdCBkZXBlbmRzIG9uIGEgcWVtdV9zeXN0ZW1fa2lsbGVkKCkgc3ltYm9sIHRoYXQg
cWVtdS1uYmQuYyBsYWNrcy4KT25jZSB3ZSB1c2UgdGhlIHNpZ25hbCBoYW5kbGluZyB1dGlsaXR5
IGZ1bmN0aW9ucyB3ZSBhbHNvIGVuZCB1cApwcm92aWRpbmcgdGhlIG5lY2Vzc2FyeSBzeW1ib2wu
CgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJl
dmlld2VkLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpSZXZpZXdlZC1i
eTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwOTI5MTI1
NTE2LjE4NjcxNS00LXN0ZWZhbmhhQHJlZGhhdC5jb20KW0ZpeGVkIHMvbmRiL25iZC8gdHlwbyBp
biBjb21taXQgZGVzY3JpcHRpb24gYXMgc3VnZ2VzdGVkIGJ5IEVyaWMgQmxha2UKLS1TdGVmYW5d
ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0t
CiBxZW11LW5iZC5jICAgICAgICAgICAgICAgIHwgMjEgKysrKysrKysrLS0tLS0tLS0tLS0tCiBz
dHVicy9ibGstZXhwLWNsb3NlLWFsbC5jIHwgIDcgKysrKysrKwogYmxvY2svZXhwb3J0L21lc29u
LmJ1aWxkICB8ICA0ICsrLS0KIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgfCAgNCArKy0tCiBu
YmQvbWVzb24uYnVpbGQgICAgICAgICAgIHwgIDIgKysKIHN0dWJzL21lc29uLmJ1aWxkICAgICAg
ICAgfCAgMSArCiA2IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9u
cygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHN0dWJzL2Jsay1leHAtY2xvc2UtYWxsLmMKCmRpZmYg
LS1naXQgYS9xZW11LW5iZC5jIGIvcWVtdS1uYmQuYwppbmRleCBiYWNiNjliMDg5Li41M2U0NjFk
ODRjIDEwMDY0NAotLS0gYS9xZW11LW5iZC5jCisrKyBiL3FlbXUtbmJkLmMKQEAgLTI1LDYgKzI1
LDcgQEAKICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiCiAjaW5jbHVkZSAicWVtdS9jdXRpbHMuaCIK
ICNpbmNsdWRlICJzeXNlbXUvYmxvY2stYmFja2VuZC5oIgorI2luY2x1ZGUgInN5c2VtdS9ydW5z
dGF0ZS5oIiAvKiBmb3IgcWVtdV9zeXN0ZW1fa2lsbGVkKCkgcHJvdG90eXBlICovCiAjaW5jbHVk
ZSAiYmxvY2svYmxvY2tfaW50LmgiCiAjaW5jbHVkZSAiYmxvY2svbmJkLmgiCiAjaW5jbHVkZSAi
cWVtdS9tYWluLWxvb3AuaCIKQEAgLTE1NSw3ICsxNTYsMTEgQEAgUUVNVV9DT1BZUklHSFQgIlxu
IgogfQogCiAjaWYgSEFWRV9OQkRfREVWSUNFCi1zdGF0aWMgdm9pZCB0ZXJtc2lnX2hhbmRsZXIo
aW50IHNpZ251bSkKKy8qCisgKiBUaGUgY2xpZW50IHRocmVhZCB1c2VzIFNJR1RFUk0gdG8gaW50
ZXJydXB0IHRoZSBzZXJ2ZXIuICBBIHNpZ25hbAorICogaGFuZGxlciBlbnN1cmVzIHRoYXQgInFl
bXUtbmJkIC12IC1jIiBleGl0cyB3aXRoIGEgbmljZSBzdGF0dXMgY29kZS4KKyAqLwordm9pZCBx
ZW11X3N5c3RlbV9raWxsZWQoaW50IHNpZ251bSwgcGlkX3QgcGlkKQogewogICAgIHFhdG9taWNf
Y21weGNoZygmc3RhdGUsIFJVTk5JTkcsIFRFUk1JTkFURSk7CiAgICAgcWVtdV9ub3RpZnlfZXZl
bnQoKTsKQEAgLTU4MSwyMCArNTg2LDEyIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikKICAgICBjb25zdCBjaGFyICpwaWRfZmlsZV9uYW1lID0gTlVMTDsKICAgICBCbG9ja0V4cG9y
dE9wdGlvbnMgKmV4cG9ydF9vcHRzOwogCisgICAgb3Nfc2V0dXBfZWFybHlfc2lnbmFsX2hhbmRs
aW5nKCk7CisKICNpZiBIQVZFX05CRF9ERVZJQ0UKLSAgICAvKiBUaGUgY2xpZW50IHRocmVhZCB1
c2VzIFNJR1RFUk0gdG8gaW50ZXJydXB0IHRoZSBzZXJ2ZXIuICBBIHNpZ25hbAotICAgICAqIGhh
bmRsZXIgZW5zdXJlcyB0aGF0ICJxZW11LW5iZCAtdiAtYyIgZXhpdHMgd2l0aCBhIG5pY2Ugc3Rh
dHVzIGNvZGUuCi0gICAgICovCi0gICAgc3RydWN0IHNpZ2FjdGlvbiBzYV9zaWd0ZXJtOwotICAg
IG1lbXNldCgmc2Ffc2lndGVybSwgMCwgc2l6ZW9mKHNhX3NpZ3Rlcm0pKTsKLSAgICBzYV9zaWd0
ZXJtLnNhX2hhbmRsZXIgPSB0ZXJtc2lnX2hhbmRsZXI7Ci0gICAgc2lnYWN0aW9uKFNJR1RFUk0s
ICZzYV9zaWd0ZXJtLCBOVUxMKTsKKyAgICBvc19zZXR1cF9zaWduYWxfaGFuZGxpbmcoKTsKICNl
bmRpZiAvKiBIQVZFX05CRF9ERVZJQ0UgKi8KIAotI2lmZGVmIENPTkZJR19QT1NJWAotICAgIHNp
Z25hbChTSUdQSVBFLCBTSUdfSUdOKTsKLSNlbmRpZgotCiAgICAgc29ja2V0X2luaXQoKTsKICAg
ICBlcnJvcl9pbml0KGFyZ3ZbMF0pOwogICAgIG1vZHVsZV9jYWxsX2luaXQoTU9EVUxFX0lOSVRf
VFJBQ0UpOwpkaWZmIC0tZ2l0IGEvc3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwuYyBiL3N0dWJzL2Js
ay1leHAtY2xvc2UtYWxsLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4u
MWM3MTMxNjc2MwotLS0gL2Rldi9udWxsCisrKyBiL3N0dWJzL2Jsay1leHAtY2xvc2UtYWxsLmMK
QEAgLTAsMCArMSw3IEBACisjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgImJsb2Nr
L2V4cG9ydC5oIgorCisvKiBPbmx5IHVzZWQgaW4gcHJvZ3JhbXMgdGhhdCBzdXBwb3J0IGJsb2Nr
IGV4cG9ydHMgKGxpYmJsb2NrZGV2LmZhKSAqLwordm9pZCBibGtfZXhwX2Nsb3NlX2FsbCh2b2lk
KQoreworfQpkaWZmIC0tZ2l0IGEvYmxvY2svZXhwb3J0L21lc29uLmJ1aWxkIGIvYmxvY2svZXhw
b3J0L21lc29uLmJ1aWxkCmluZGV4IDQ2OWE3YWEwZjUuLmEyNzcyYTBkY2UgMTAwNjQ0Ci0tLSBh
L2Jsb2NrL2V4cG9ydC9tZXNvbi5idWlsZAorKysgYi9ibG9jay9leHBvcnQvbWVzb24uYnVpbGQK
QEAgLTEsMiArMSwyIEBACi1ibG9ja19zcy5hZGQoZmlsZXMoJ2V4cG9ydC5jJykpCi1ibG9ja19z
cy5hZGQod2hlbjogJ0NPTkZJR19WSE9TVF9VU0VSJywgaWZfdHJ1ZTogZmlsZXMoJ3Zob3N0LXVz
ZXItYmxrLXNlcnZlci5jJykpCitibG9ja2Rldl9zcy5hZGQoZmlsZXMoJ2V4cG9ydC5jJykpCiti
bG9ja2Rldl9zcy5hZGQod2hlbjogJ0NPTkZJR19WSE9TVF9VU0VSJywgaWZfdHJ1ZTogZmlsZXMo
J3Zob3N0LXVzZXItYmxrLXNlcnZlci5jJykpCmRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21l
c29uLmJ1aWxkCmluZGV4IDJmYjBiYjdjYjQuLjk5NjRlZDQzYTEgMTAwNjQ0Ci0tLSBhL21lc29u
LmJ1aWxkCisrKyBiL21lc29uLmJ1aWxkCkBAIC0xMzQ0LDcgKzEzNDQsNiBAQCBzdWJkaXIoJ2R1
bXAnKQogCiBibG9ja19zcy5hZGQoZmlsZXMoCiAgICdibG9jay5jJywKLSAgJ2Jsb2NrZGV2LW5i
ZC5jJywKICAgJ2Jsb2Nram9iLmMnLAogICAnam9iLmMnLAogICAncWVtdS1pby1jbWRzLmMnLApA
QCAtMTM1Nyw2ICsxMzU2LDcgQEAgc3ViZGlyKCdibG9jaycpCiAKIGJsb2NrZGV2X3NzLmFkZChm
aWxlcygKICAgJ2Jsb2NrZGV2LmMnLAorICAnYmxvY2tkZXYtbmJkLmMnLAogICAnaW90aHJlYWQu
YycsCiAgICdqb2ItcW1wLmMnLAogKSkKQEAgLTE2ODIsNyArMTY4Miw3IEBAIGlmIGhhdmVfdG9v
bHMKICAgcWVtdV9pbyA9IGV4ZWN1dGFibGUoJ3FlbXUtaW8nLCBmaWxlcygncWVtdS1pby5jJyks
CiAgICAgICAgICAgICAgZGVwZW5kZW5jaWVzOiBbYmxvY2ssIHFlbXV1dGlsXSwgaW5zdGFsbDog
dHJ1ZSkKICAgcWVtdV9uYmQgPSBleGVjdXRhYmxlKCdxZW11LW5iZCcsIGZpbGVzKCdxZW11LW5i
ZC5jJyksCi0gICAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6IFtibG9jaywgcWVtdXV0aWxdLCBp
bnN0YWxsOiB0cnVlKQorICAgICAgICAgICAgICAgZGVwZW5kZW5jaWVzOiBbYmxvY2tkZXYsIHFl
bXV1dGlsXSwgaW5zdGFsbDogdHJ1ZSkKIAogICBzdWJkaXIoJ3N0b3JhZ2UtZGFlbW9uJykKICAg
c3ViZGlyKCdjb250cmliL3JkbWFjbS1tdXgnKQpkaWZmIC0tZ2l0IGEvbmJkL21lc29uLmJ1aWxk
IGIvbmJkL21lc29uLmJ1aWxkCmluZGV4IDBjMDBhNzc2ZDMuLjJiYWFhMzY5NDggMTAwNjQ0Ci0t
LSBhL25iZC9tZXNvbi5idWlsZAorKysgYi9uYmQvbWVzb24uYnVpbGQKQEAgLTEsNSArMSw3IEBA
CiBibG9ja19zcy5hZGQoZmlsZXMoCiAgICdjbGllbnQuYycsCiAgICdjb21tb24uYycsCispKQor
YmxvY2tkZXZfc3MuYWRkKGZpbGVzKAogICAnc2VydmVyLmMnLAogKSkKZGlmZiAtLWdpdCBhL3N0
dWJzL21lc29uLmJ1aWxkIGIvc3R1YnMvbWVzb24uYnVpbGQKaW5kZXggNjdmMmE4YzA2OS4uN2I3
MzNmYWRiNyAxMDA2NDQKLS0tIGEvc3R1YnMvbWVzb24uYnVpbGQKKysrIGIvc3R1YnMvbWVzb24u
YnVpbGQKQEAgLTEsNiArMSw3IEBACiBzdHViX3NzLmFkZChmaWxlcygnYXJjaF90eXBlLmMnKSkK
IHN0dWJfc3MuYWRkKGZpbGVzKCdiZHJ2LW5leHQtbW9uaXRvci1vd25lZC5jJykpCiBzdHViX3Nz
LmFkZChmaWxlcygnYmxrLWNvbW1pdC1hbGwuYycpKQorc3R1Yl9zcy5hZGQoZmlsZXMoJ2Jsay1l
eHAtY2xvc2UtYWxsLmMnKSkKIHN0dWJfc3MuYWRkKGZpbGVzKCdibG9ja2Rldi1jbG9zZS1hbGwt
YmRydi1zdGF0ZXMuYycpKQogc3R1Yl9zcy5hZGQoZmlsZXMoJ2NoYW5nZS1zdGF0ZS1oYW5kbGVy
LmMnKSkKIHN0dWJfc3MuYWRkKGZpbGVzKCdjbW9zLmMnKSkKLS0gCjIuMjYuMgoK


