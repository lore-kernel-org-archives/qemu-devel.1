Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2193AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B842920838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1LKMf6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B842920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS2nR-0002K8-Po
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2Zf-0004cM-UH
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2Zd-0004H2-Vh
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602527369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L59NxEYQfDomtwIOdd3o5xLQv9h9cBBdqGswJFYAQjg=;
 b=I1LKMf6OEGoxDG7sbJtjl7uAj0CIBrP5xa2F+NsPDM3121dOQmW3+MNn34nF9BgbgNTI1w
 Jpnb9AiBU+zPQcVEOyOwFlAm/CwQ75pPUSurfspms/I5FIUsQ3loPmPNh11Q1AA/7mVhyz
 YGg0/fJKkaXrCeKOpM7SDj2FQVY4jjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-Q2ia7_kgPRm68arkUkeCXA-1; Mon, 12 Oct 2020 14:29:27 -0400
X-MC-Unique: Q2ia7_kgPRm68arkUkeCXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF0BE427EB;
 Mon, 12 Oct 2020 18:29:25 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A4B155760;
 Mon, 12 Oct 2020 18:29:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 22/30] block: move block exports to libblockdev
Date: Mon, 12 Oct 2020 19:27:52 +0100
Message-Id: <20201012182800.157697-23-stefanha@redhat.com>
In-Reply-To: <20201012182800.157697-1-stefanha@redhat.com>
References: <20201012182800.157697-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
CiBxZW11LW5iZC5jICAgICAgICAgICAgICAgIHwgMjUgKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LQogc3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwuYyB8ICA3ICsrKysrKysKIGJsb2NrL2V4cG9ydC9t
ZXNvbi5idWlsZCAgfCAgNCArKy0tCiBtZXNvbi5idWlsZCAgICAgICAgICAgICAgIHwgIDQgKyst
LQogbmJkL21lc29uLmJ1aWxkICAgICAgICAgICB8ICAyICsrCiBzdHVicy9tZXNvbi5idWlsZCAg
ICAgICAgIHwgIDEgKwogNiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyMCBkZWxl
dGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzdHVicy9ibGstZXhwLWNsb3NlLWFsbC5jCgpk
aWZmIC0tZ2l0IGEvcWVtdS1uYmQuYyBiL3FlbXUtbmJkLmMKaW5kZXggYmM2NDRhMDY3MC4uMzY5
YjAwZTNiOSAxMDA2NDQKLS0tIGEvcWVtdS1uYmQuYworKysgYi9xZW11LW5iZC5jCkBAIC0yNSw2
ICsyNSw3IEBACiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIgogI2luY2x1ZGUgInFlbXUvY3V0aWxz
LmgiCiAjaW5jbHVkZSAic3lzZW11L2Jsb2NrLWJhY2tlbmQuaCIKKyNpbmNsdWRlICJzeXNlbXUv
cnVuc3RhdGUuaCIgLyogZm9yIHFlbXVfc3lzdGVtX2tpbGxlZCgpIHByb3RvdHlwZSAqLwogI2lu
Y2x1ZGUgImJsb2NrL2Jsb2NrX2ludC5oIgogI2luY2x1ZGUgImJsb2NrL25iZC5oIgogI2luY2x1
ZGUgInFlbXUvbWFpbi1sb29wLmgiCkBAIC0xNTQsOCArMTU1LDEyIEBAIFFFTVVfQ09QWVJJR0hU
ICJcbiIKICAgICAsIG5hbWUpOwogfQogCi0jaWZkZWYgQ09ORklHX1BPU0lYCi1zdGF0aWMgdm9p
ZCB0ZXJtc2lnX2hhbmRsZXIoaW50IHNpZ251bSkKKyNpZiBDT05GSUdfUE9TSVgKKy8qCisgKiBU
aGUgY2xpZW50IHRocmVhZCB1c2VzIFNJR1RFUk0gdG8gaW50ZXJydXB0IHRoZSBzZXJ2ZXIuICBB
IHNpZ25hbAorICogaGFuZGxlciBlbnN1cmVzIHRoYXQgInFlbXUtbmJkIC12IC1jIiBleGl0cyB3
aXRoIGEgbmljZSBzdGF0dXMgY29kZS4KKyAqLwordm9pZCBxZW11X3N5c3RlbV9raWxsZWQoaW50
IHNpZ251bSwgcGlkX3QgcGlkKQogewogICAgIHFhdG9taWNfY21weGNoZygmc3RhdGUsIFJVTk5J
TkcsIFRFUk1JTkFURSk7CiAgICAgcWVtdV9ub3RpZnlfZXZlbnQoKTsKQEAgLTU4MSwyMCArNTg2
LDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogICAgIGNvbnN0IGNoYXIgKnBp
ZF9maWxlX25hbWUgPSBOVUxMOwogICAgIEJsb2NrRXhwb3J0T3B0aW9ucyAqZXhwb3J0X29wdHM7
CiAKLSNpZmRlZiBDT05GSUdfUE9TSVgKLSAgICAvKgotICAgICAqIEV4aXQgZ3JhY2VmdWxseSBv
biB2YXJpb3VzIHNpZ25hbHMsIHdoaWNoIGluY2x1ZGVzIFNJR1RFUk0gdXNlZAotICAgICAqIGJ5
ICdxZW11LW5iZCAtdiAtYycuCi0gICAgICovCi0gICAgc3RydWN0IHNpZ2FjdGlvbiBzYV9zaWd0
ZXJtOwotICAgIG1lbXNldCgmc2Ffc2lndGVybSwgMCwgc2l6ZW9mKHNhX3NpZ3Rlcm0pKTsKLSAg
ICBzYV9zaWd0ZXJtLnNhX2hhbmRsZXIgPSB0ZXJtc2lnX2hhbmRsZXI7Ci0gICAgc2lnYWN0aW9u
KFNJR1RFUk0sICZzYV9zaWd0ZXJtLCBOVUxMKTsKLSAgICBzaWdhY3Rpb24oU0lHSU5ULCAmc2Ff
c2lndGVybSwgTlVMTCk7Ci0gICAgc2lnYWN0aW9uKFNJR0hVUCwgJnNhX3NpZ3Rlcm0sIE5VTEwp
OwotCi0gICAgc2lnbmFsKFNJR1BJUEUsIFNJR19JR04pOwotI2VuZGlmCisgICAgb3Nfc2V0dXBf
ZWFybHlfc2lnbmFsX2hhbmRsaW5nKCk7CisgICAgb3Nfc2V0dXBfc2lnbmFsX2hhbmRsaW5nKCk7
CiAKICAgICBzb2NrZXRfaW5pdCgpOwogICAgIGVycm9yX2luaXQoYXJndlswXSk7CmRpZmYgLS1n
aXQgYS9zdHVicy9ibGstZXhwLWNsb3NlLWFsbC5jIGIvc3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwu
YwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwLi4xYzcxMzE2NzYzCi0tLSAv
ZGV2L251bGwKKysrIGIvc3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwuYwpAQCAtMCwwICsxLDcgQEAK
KyNpbmNsdWRlICJxZW11L29zZGVwLmgiCisjaW5jbHVkZSAiYmxvY2svZXhwb3J0LmgiCisKKy8q
IE9ubHkgdXNlZCBpbiBwcm9ncmFtcyB0aGF0IHN1cHBvcnQgYmxvY2sgZXhwb3J0cyAobGliYmxv
Y2tkZXYuZmEpICovCit2b2lkIGJsa19leHBfY2xvc2VfYWxsKHZvaWQpCit7Cit9CmRpZmYgLS1n
aXQgYS9ibG9jay9leHBvcnQvbWVzb24uYnVpbGQgYi9ibG9jay9leHBvcnQvbWVzb24uYnVpbGQK
aW5kZXggNDY5YTdhYTBmNS4uYTI3NzJhMGRjZSAxMDA2NDQKLS0tIGEvYmxvY2svZXhwb3J0L21l
c29uLmJ1aWxkCisrKyBiL2Jsb2NrL2V4cG9ydC9tZXNvbi5idWlsZApAQCAtMSwyICsxLDIgQEAK
LWJsb2NrX3NzLmFkZChmaWxlcygnZXhwb3J0LmMnKSkKLWJsb2NrX3NzLmFkZCh3aGVuOiAnQ09O
RklHX1ZIT1NUX1VTRVInLCBpZl90cnVlOiBmaWxlcygndmhvc3QtdXNlci1ibGstc2VydmVyLmMn
KSkKK2Jsb2NrZGV2X3NzLmFkZChmaWxlcygnZXhwb3J0LmMnKSkKK2Jsb2NrZGV2X3NzLmFkZCh3
aGVuOiAnQ09ORklHX1ZIT1NUX1VTRVInLCBpZl90cnVlOiBmaWxlcygndmhvc3QtdXNlci1ibGst
c2VydmVyLmMnKSkKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVzb24uYnVpbGQKaW5kZXgg
MmZiMGJiN2NiNC4uOTk2NGVkNDNhMSAxMDA2NDQKLS0tIGEvbWVzb24uYnVpbGQKKysrIGIvbWVz
b24uYnVpbGQKQEAgLTEzNDQsNyArMTM0NCw2IEBAIHN1YmRpcignZHVtcCcpCiAKIGJsb2NrX3Nz
LmFkZChmaWxlcygKICAgJ2Jsb2NrLmMnLAotICAnYmxvY2tkZXYtbmJkLmMnLAogICAnYmxvY2tq
b2IuYycsCiAgICdqb2IuYycsCiAgICdxZW11LWlvLWNtZHMuYycsCkBAIC0xMzU3LDYgKzEzNTYs
NyBAQCBzdWJkaXIoJ2Jsb2NrJykKIAogYmxvY2tkZXZfc3MuYWRkKGZpbGVzKAogICAnYmxvY2tk
ZXYuYycsCisgICdibG9ja2Rldi1uYmQuYycsCiAgICdpb3RocmVhZC5jJywKICAgJ2pvYi1xbXAu
YycsCiApKQpAQCAtMTY4Miw3ICsxNjgyLDcgQEAgaWYgaGF2ZV90b29scwogICBxZW11X2lvID0g
ZXhlY3V0YWJsZSgncWVtdS1pbycsIGZpbGVzKCdxZW11LWlvLmMnKSwKICAgICAgICAgICAgICBk
ZXBlbmRlbmNpZXM6IFtibG9jaywgcWVtdXV0aWxdLCBpbnN0YWxsOiB0cnVlKQogICBxZW11X25i
ZCA9IGV4ZWN1dGFibGUoJ3FlbXUtbmJkJywgZmlsZXMoJ3FlbXUtbmJkLmMnKSwKLSAgICAgICAg
ICAgICAgIGRlcGVuZGVuY2llczogW2Jsb2NrLCBxZW11dXRpbF0sIGluc3RhbGw6IHRydWUpCisg
ICAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6IFtibG9ja2RldiwgcWVtdXV0aWxdLCBpbnN0YWxs
OiB0cnVlKQogCiAgIHN1YmRpcignc3RvcmFnZS1kYWVtb24nKQogICBzdWJkaXIoJ2NvbnRyaWIv
cmRtYWNtLW11eCcpCmRpZmYgLS1naXQgYS9uYmQvbWVzb24uYnVpbGQgYi9uYmQvbWVzb24uYnVp
bGQKaW5kZXggMGMwMGE3NzZkMy4uMmJhYWEzNjk0OCAxMDA2NDQKLS0tIGEvbmJkL21lc29uLmJ1
aWxkCisrKyBiL25iZC9tZXNvbi5idWlsZApAQCAtMSw1ICsxLDcgQEAKIGJsb2NrX3NzLmFkZChm
aWxlcygKICAgJ2NsaWVudC5jJywKICAgJ2NvbW1vbi5jJywKKykpCitibG9ja2Rldl9zcy5hZGQo
ZmlsZXMoCiAgICdzZXJ2ZXIuYycsCiApKQpkaWZmIC0tZ2l0IGEvc3R1YnMvbWVzb24uYnVpbGQg
Yi9zdHVicy9tZXNvbi5idWlsZAppbmRleCA2N2YyYThjMDY5Li43YjczM2ZhZGI3IDEwMDY0NAot
LS0gYS9zdHVicy9tZXNvbi5idWlsZAorKysgYi9zdHVicy9tZXNvbi5idWlsZApAQCAtMSw2ICsx
LDcgQEAKIHN0dWJfc3MuYWRkKGZpbGVzKCdhcmNoX3R5cGUuYycpKQogc3R1Yl9zcy5hZGQoZmls
ZXMoJ2JkcnYtbmV4dC1tb25pdG9yLW93bmVkLmMnKSkKIHN0dWJfc3MuYWRkKGZpbGVzKCdibGst
Y29tbWl0LWFsbC5jJykpCitzdHViX3NzLmFkZChmaWxlcygnYmxrLWV4cC1jbG9zZS1hbGwuYycp
KQogc3R1Yl9zcy5hZGQoZmlsZXMoJ2Jsb2NrZGV2LWNsb3NlLWFsbC1iZHJ2LXN0YXRlcy5jJykp
CiBzdHViX3NzLmFkZChmaWxlcygnY2hhbmdlLXN0YXRlLWhhbmRsZXIuYycpKQogc3R1Yl9zcy5h
ZGQoZmlsZXMoJ2Ntb3MuYycpKQotLSAKMi4yNi4yCgo=


