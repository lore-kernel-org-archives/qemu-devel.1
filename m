Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01510C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6998E20780
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6Bohv9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6998E20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVz8X-000054-6b
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVyvQ-0007dy-Pa
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVyvN-0000yD-Ei
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4L06fNv5aJG9QsRTTubOTAeBelEAva87357K9YMFpAU=;
 b=Q6Bohv9lAJgrOwAA75M0G5CBMtyfKo0W1ci+KwdMQBlP0uDiRkmcWAqoAh+dNTiTuDC3E8
 jnbvS6MMr2HLrCyPYb/JVG69pf+U5ThYOme5JS4IDFw4X2JLYKpcwFaaCX2XF3kUSB7Ygy
 Z2I69FV7YSNbdRla+SopTuN/S4js7XU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-VP9L9hQoMkyUnan5neUHgg-1; Fri, 23 Oct 2020 11:24:10 -0400
X-MC-Unique: VP9L9hQoMkyUnan5neUHgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62B4E10766DA;
 Fri, 23 Oct 2020 15:23:43 +0000 (UTC)
Received: from localhost (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0148F5D9CC;
 Fri, 23 Oct 2020 15:23:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 21/28] block: move block exports to libblockdev
Date: Fri, 23 Oct 2020 16:21:40 +0100
Message-Id: <20201023152147.1016281-22-stefanha@redhat.com>
In-Reply-To: <20201023152147.1016281-1-stefanha@redhat.com>
References: <20201023152147.1016281-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
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
CiBxZW11LW5iZC5jICAgICAgICAgICAgICAgIHwgMjEgKysrKysrKystLS0tLS0tLS0tLS0tCiBz
dHVicy9ibGstZXhwLWNsb3NlLWFsbC5jIHwgIDcgKysrKysrKwogYmxvY2svZXhwb3J0L21lc29u
LmJ1aWxkICB8ICA0ICsrLS0KIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgfCAgNCArKy0tCiBu
YmQvbWVzb24uYnVpbGQgICAgICAgICAgIHwgIDIgKysKIHN0dWJzL21lc29uLmJ1aWxkICAgICAg
ICAgfCAgMSArCiA2IGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9u
cygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHN0dWJzL2Jsay1leHAtY2xvc2UtYWxsLmMKCmRpZmYg
LS1naXQgYS9xZW11LW5iZC5jIGIvcWVtdS1uYmQuYwppbmRleCBiYzY0NGEwNjcwLi5hMDcwMWNk
ZjM2IDEwMDY0NAotLS0gYS9xZW11LW5iZC5jCisrKyBiL3FlbXUtbmJkLmMKQEAgLTI1LDYgKzI1
LDcgQEAKICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiCiAjaW5jbHVkZSAicWVtdS9jdXRpbHMuaCIK
ICNpbmNsdWRlICJzeXNlbXUvYmxvY2stYmFja2VuZC5oIgorI2luY2x1ZGUgInN5c2VtdS9ydW5z
dGF0ZS5oIiAvKiBmb3IgcWVtdV9zeXN0ZW1fa2lsbGVkKCkgcHJvdG90eXBlICovCiAjaW5jbHVk
ZSAiYmxvY2svYmxvY2tfaW50LmgiCiAjaW5jbHVkZSAiYmxvY2svbmJkLmgiCiAjaW5jbHVkZSAi
cWVtdS9tYWluLWxvb3AuaCIKQEAgLTE1NSw3ICsxNTYsMTEgQEAgUUVNVV9DT1BZUklHSFQgIlxu
IgogfQogCiAjaWZkZWYgQ09ORklHX1BPU0lYCi1zdGF0aWMgdm9pZCB0ZXJtc2lnX2hhbmRsZXIo
aW50IHNpZ251bSkKKy8qCisgKiBUaGUgY2xpZW50IHRocmVhZCB1c2VzIFNJR1RFUk0gdG8gaW50
ZXJydXB0IHRoZSBzZXJ2ZXIuICBBIHNpZ25hbAorICogaGFuZGxlciBlbnN1cmVzIHRoYXQgInFl
bXUtbmJkIC12IC1jIiBleGl0cyB3aXRoIGEgbmljZSBzdGF0dXMgY29kZS4KKyAqLwordm9pZCBx
ZW11X3N5c3RlbV9raWxsZWQoaW50IHNpZ251bSwgcGlkX3QgcGlkKQogewogICAgIHFhdG9taWNf
Y21weGNoZygmc3RhdGUsIFJVTk5JTkcsIFRFUk1JTkFURSk7CiAgICAgcWVtdV9ub3RpZnlfZXZl
bnQoKTsKQEAgLTU4MiwxOCArNTg3LDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2
KQogICAgIEJsb2NrRXhwb3J0T3B0aW9ucyAqZXhwb3J0X29wdHM7CiAKICNpZmRlZiBDT05GSUdf
UE9TSVgKLSAgICAvKgotICAgICAqIEV4aXQgZ3JhY2VmdWxseSBvbiB2YXJpb3VzIHNpZ25hbHMs
IHdoaWNoIGluY2x1ZGVzIFNJR1RFUk0gdXNlZAotICAgICAqIGJ5ICdxZW11LW5iZCAtdiAtYycu
Ci0gICAgICovCi0gICAgc3RydWN0IHNpZ2FjdGlvbiBzYV9zaWd0ZXJtOwotICAgIG1lbXNldCgm
c2Ffc2lndGVybSwgMCwgc2l6ZW9mKHNhX3NpZ3Rlcm0pKTsKLSAgICBzYV9zaWd0ZXJtLnNhX2hh
bmRsZXIgPSB0ZXJtc2lnX2hhbmRsZXI7Ci0gICAgc2lnYWN0aW9uKFNJR1RFUk0sICZzYV9zaWd0
ZXJtLCBOVUxMKTsKLSAgICBzaWdhY3Rpb24oU0lHSU5ULCAmc2Ffc2lndGVybSwgTlVMTCk7Ci0g
ICAgc2lnYWN0aW9uKFNJR0hVUCwgJnNhX3NpZ3Rlcm0sIE5VTEwpOwotCi0gICAgc2lnbmFsKFNJ
R1BJUEUsIFNJR19JR04pOworICAgIG9zX3NldHVwX2Vhcmx5X3NpZ25hbF9oYW5kbGluZygpOwor
ICAgIG9zX3NldHVwX3NpZ25hbF9oYW5kbGluZygpOwogI2VuZGlmCiAKICAgICBzb2NrZXRfaW5p
dCgpOwpkaWZmIC0tZ2l0IGEvc3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwuYyBiL3N0dWJzL2Jsay1l
eHAtY2xvc2UtYWxsLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uMWM3
MTMxNjc2MwotLS0gL2Rldi9udWxsCisrKyBiL3N0dWJzL2Jsay1leHAtY2xvc2UtYWxsLmMKQEAg
LTAsMCArMSw3IEBACisjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgImJsb2NrL2V4
cG9ydC5oIgorCisvKiBPbmx5IHVzZWQgaW4gcHJvZ3JhbXMgdGhhdCBzdXBwb3J0IGJsb2NrIGV4
cG9ydHMgKGxpYmJsb2NrZGV2LmZhKSAqLwordm9pZCBibGtfZXhwX2Nsb3NlX2FsbCh2b2lkKQor
eworfQpkaWZmIC0tZ2l0IGEvYmxvY2svZXhwb3J0L21lc29uLmJ1aWxkIGIvYmxvY2svZXhwb3J0
L21lc29uLmJ1aWxkCmluZGV4IGZmZmU2YjA5ZTguLjlmYjRmYmY4MWQgMTAwNjQ0Ci0tLSBhL2Js
b2NrL2V4cG9ydC9tZXNvbi5idWlsZAorKysgYi9ibG9jay9leHBvcnQvbWVzb24uYnVpbGQKQEAg
LTEsMiArMSwyIEBACi1ibG9ja19zcy5hZGQoZmlsZXMoJ2V4cG9ydC5jJykpCi1ibG9ja19zcy5h
ZGQod2hlbjogWydDT05GSUdfTElOVVgnLCAnQ09ORklHX1ZIT1NUX1VTRVInXSwgaWZfdHJ1ZTog
ZmlsZXMoJ3Zob3N0LXVzZXItYmxrLXNlcnZlci5jJykpCitibG9ja2Rldl9zcy5hZGQoZmlsZXMo
J2V4cG9ydC5jJykpCitibG9ja2Rldl9zcy5hZGQod2hlbjogWydDT05GSUdfTElOVVgnLCAnQ09O
RklHX1ZIT1NUX1VTRVInXSwgaWZfdHJ1ZTogZmlsZXMoJ3Zob3N0LXVzZXItYmxrLXNlcnZlci5j
JykpCmRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkCmluZGV4IDg4MDY4MzQw
N2YuLmIzNDljOWJkYTggMTAwNjQ0Ci0tLSBhL21lc29uLmJ1aWxkCisrKyBiL21lc29uLmJ1aWxk
CkBAIC0xNDQzLDcgKzE0NDMsNiBAQCBzdWJkaXIoJ2R1bXAnKQogCiBibG9ja19zcy5hZGQoZmls
ZXMoCiAgICdibG9jay5jJywKLSAgJ2Jsb2NrZGV2LW5iZC5jJywKICAgJ2Jsb2Nram9iLmMnLAog
ICAnam9iLmMnLAogICAncWVtdS1pby1jbWRzLmMnLApAQCAtMTQ1Niw2ICsxNDU1LDcgQEAgc3Vi
ZGlyKCdibG9jaycpCiAKIGJsb2NrZGV2X3NzLmFkZChmaWxlcygKICAgJ2Jsb2NrZGV2LmMnLAor
ICAnYmxvY2tkZXYtbmJkLmMnLAogICAnaW90aHJlYWQuYycsCiAgICdqb2ItcW1wLmMnLAogKSkK
QEAgLTE4MzIsNyArMTgzMiw3IEBAIGlmIGhhdmVfdG9vbHMKICAgcWVtdV9pbyA9IGV4ZWN1dGFi
bGUoJ3FlbXUtaW8nLCBmaWxlcygncWVtdS1pby5jJyksCiAgICAgICAgICAgICAgZGVwZW5kZW5j
aWVzOiBbYmxvY2ssIHFlbXV1dGlsXSwgaW5zdGFsbDogdHJ1ZSkKICAgcWVtdV9uYmQgPSBleGVj
dXRhYmxlKCdxZW11LW5iZCcsIGZpbGVzKCdxZW11LW5iZC5jJyksCi0gICAgICAgICAgICAgICBk
ZXBlbmRlbmNpZXM6IFtibG9jaywgcWVtdXV0aWxdLCBpbnN0YWxsOiB0cnVlKQorICAgICAgICAg
ICAgICAgZGVwZW5kZW5jaWVzOiBbYmxvY2tkZXYsIHFlbXV1dGlsXSwgaW5zdGFsbDogdHJ1ZSkK
IAogICBzdWJkaXIoJ3N0b3JhZ2UtZGFlbW9uJykKICAgc3ViZGlyKCdjb250cmliL3JkbWFjbS1t
dXgnKQpkaWZmIC0tZ2l0IGEvbmJkL21lc29uLmJ1aWxkIGIvbmJkL21lc29uLmJ1aWxkCmluZGV4
IDBjMDBhNzc2ZDMuLjJiYWFhMzY5NDggMTAwNjQ0Ci0tLSBhL25iZC9tZXNvbi5idWlsZAorKysg
Yi9uYmQvbWVzb24uYnVpbGQKQEAgLTEsNSArMSw3IEBACiBibG9ja19zcy5hZGQoZmlsZXMoCiAg
ICdjbGllbnQuYycsCiAgICdjb21tb24uYycsCispKQorYmxvY2tkZXZfc3MuYWRkKGZpbGVzKAog
ICAnc2VydmVyLmMnLAogKSkKZGlmZiAtLWdpdCBhL3N0dWJzL21lc29uLmJ1aWxkIGIvc3R1YnMv
bWVzb24uYnVpbGQKaW5kZXggNjdmMmE4YzA2OS4uN2I3MzNmYWRiNyAxMDA2NDQKLS0tIGEvc3R1
YnMvbWVzb24uYnVpbGQKKysrIGIvc3R1YnMvbWVzb24uYnVpbGQKQEAgLTEsNiArMSw3IEBACiBz
dHViX3NzLmFkZChmaWxlcygnYXJjaF90eXBlLmMnKSkKIHN0dWJfc3MuYWRkKGZpbGVzKCdiZHJ2
LW5leHQtbW9uaXRvci1vd25lZC5jJykpCiBzdHViX3NzLmFkZChmaWxlcygnYmxrLWNvbW1pdC1h
bGwuYycpKQorc3R1Yl9zcy5hZGQoZmlsZXMoJ2Jsay1leHAtY2xvc2UtYWxsLmMnKSkKIHN0dWJf
c3MuYWRkKGZpbGVzKCdibG9ja2Rldi1jbG9zZS1hbGwtYmRydi1zdGF0ZXMuYycpKQogc3R1Yl9z
cy5hZGQoZmlsZXMoJ2NoYW5nZS1zdGF0ZS1oYW5kbGVyLmMnKSkKIHN0dWJfc3MuYWRkKGZpbGVz
KCdjbW9zLmMnKSkKLS0gCjIuMjYuMgoK


