Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2066C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4406420663
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayNp1c1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4406420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPT3K-0005EJ-8F
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSfQ-0006CL-53
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSfM-0008LQ-F4
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601912679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iw7X2p7YYXMxl+sUC13M4JpxwUWm2sy3GOYYoD4ZpLQ=;
 b=ayNp1c1BNzR8GsZo8M77hurgpTZUOsa51ilbNZX1j9XguTV+qpczyOjVjnLU8OHLFKNQEq
 et96fTApLngkWGjHlJ+DqG+lnpu74T37sEFF4azzJN6Vp2Rerywwkbls+AHU769ltx+ZMT
 ywLnUnR4z2DdxaOloA7Oez2vLFHRfJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-UuPzhlkHMOi6ey5D_mx5Cw-1; Mon, 05 Oct 2020 11:44:34 -0400
X-MC-Unique: UuPzhlkHMOi6ey5D_mx5Cw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E652B801AB5;
 Mon,  5 Oct 2020 15:44:32 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D7775C1BD;
 Mon,  5 Oct 2020 15:44:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 16/17] util/vfio-helpers: Collect IOVA reserved regions
Date: Mon,  5 Oct 2020 16:43:22 +0100
Message-Id: <20201005154323.31347-17-stefanha@redhat.com>
In-Reply-To: <20201005154323.31347-1-stefanha@redhat.com>
References: <20201005154323.31347-1-stefanha@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgoKVGhlIElPVkEgYWxsb2Nh
dG9yIGN1cnJlbnRseSBpZ25vcmVzIGhvc3QgcmVzZXJ2ZWQgcmVnaW9ucy4KQXMgYSByZXN1bHQg
c29tZSBjaG9zZW4gSU9WQXMgbWF5IGNvbGxpZGUgd2l0aCBzb21lIG9mIHRoZW0sCnJlc3VsdGlu
ZyBpbiBWRklPIE1BUF9ETUEgZXJyb3JzIGxhdGVyIG9uLiBUaGlzIGhhcHBlbnMgb24gQVJNCndo
ZXJlIHRoZSBNU0kgcmVzZXJ2ZWQgd2luZG93IHF1aWNrbHkgaXMgZW5jb3VudGVyZWQ6ClsweDgw
MDAwMDAsIDB4ODEwMDAwMF0uIHNpbmNlIDUuNCBrZXJuZWwsIFZGSU8gcmV0dXJucyB0aGUgdXNh
YmxlCklPVkEgcmVnaW9ucy4gU28gbGV0J3MgZW51bWVyYXRlIHRoZW0gaW4gdGhlIHByb3NwZWN0
IHRvIGF2b2lkCnRoZW0sIGxhdGVyIG9uLgoKU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMDkyOTA4NTU1MC4zMDkyNi0yLWVy
aWMuYXVnZXJAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQogdXRpbC92ZmlvLWhlbHBlcnMuYyB8IDcyICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDcwIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC92ZmlvLWhlbHBl
cnMuYyBiL3V0aWwvdmZpby1oZWxwZXJzLmMKaW5kZXggOWFjMzA3ZTNkNC4uZmU5Y2E5Y2UzOCAx
MDA2NDQKLS0tIGEvdXRpbC92ZmlvLWhlbHBlcnMuYworKysgYi91dGlsL3ZmaW8taGVscGVycy5j
CkBAIC00MCw2ICs0MCwxMSBAQCB0eXBlZGVmIHN0cnVjdCB7CiAgICAgdWludDY0X3QgaW92YTsK
IH0gSU9WQU1hcHBpbmc7CiAKK3N0cnVjdCBJT1ZBUmFuZ2UgeworICAgIHVpbnQ2NF90IHN0YXJ0
OworICAgIHVpbnQ2NF90IGVuZDsKK307CisKIHN0cnVjdCBRRU1VVkZJT1N0YXRlIHsKICAgICBR
ZW11TXV0ZXggbG9jazsKIApAQCAtNDksNiArNTQsOCBAQCBzdHJ1Y3QgUUVNVVZGSU9TdGF0ZSB7
CiAgICAgaW50IGRldmljZTsKICAgICBSQU1CbG9ja05vdGlmaWVyIHJhbV9ub3RpZmllcjsKICAg
ICBzdHJ1Y3QgdmZpb19yZWdpb25faW5mbyBjb25maWdfcmVnaW9uX2luZm8sIGJhcl9yZWdpb25f
aW5mb1s2XTsKKyAgICBzdHJ1Y3QgSU9WQVJhbmdlICp1c2FibGVfaW92YV9yYW5nZXM7CisgICAg
dWludDhfdCBuYl9pb3ZhX3JhbmdlczsKIAogICAgIC8qIFRoZXNlIGZpZWxkcyBhcmUgcHJvdGVj
dGVkIGJ5IEBsb2NrICovCiAgICAgLyogVkZJTydzIElPIHZpcnR1YWwgYWRkcmVzcyBzcGFjZSBp
cyBtYW5hZ2VkIGJ5IHNwbGl0dGluZyBpbnRvIGEgZmV3CkBAIC0yMzYsNiArMjQzLDM1IEBAIHN0
YXRpYyBpbnQgcWVtdV92ZmlvX3BjaV93cml0ZV9jb25maWcoUUVNVVZGSU9TdGF0ZSAqcywgdm9p
ZCAqYnVmLCBpbnQgc2l6ZSwgaW50CiAgICAgcmV0dXJuIHJldCA9PSBzaXplID8gMCA6IC1lcnJu
bzsKIH0KIAorc3RhdGljIHZvaWQgY29sbGVjdF91c2FibGVfaW92YV9yYW5nZXMoUUVNVVZGSU9T
dGF0ZSAqcywgdm9pZCAqYnVmKQoreworICAgIHN0cnVjdCB2ZmlvX2lvbW11X3R5cGUxX2luZm8g
KmluZm8gPSAoc3RydWN0IHZmaW9faW9tbXVfdHlwZTFfaW5mbyAqKWJ1ZjsKKyAgICBzdHJ1Y3Qg
dmZpb19pbmZvX2NhcF9oZWFkZXIgKmNhcCA9ICh2b2lkICopYnVmICsgaW5mby0+Y2FwX29mZnNl
dDsKKyAgICBzdHJ1Y3QgdmZpb19pb21tdV90eXBlMV9pbmZvX2NhcF9pb3ZhX3JhbmdlICpjYXBf
aW92YV9yYW5nZTsKKyAgICBpbnQgaTsKKworICAgIHdoaWxlIChjYXAtPmlkICE9IFZGSU9fSU9N
TVVfVFlQRTFfSU5GT19DQVBfSU9WQV9SQU5HRSkgeworICAgICAgICBpZiAoIWNhcC0+bmV4dCkg
eworICAgICAgICAgICAgcmV0dXJuOworICAgICAgICB9CisgICAgICAgIGNhcCA9IChzdHJ1Y3Qg
dmZpb19pbmZvX2NhcF9oZWFkZXIgKikoYnVmICsgY2FwLT5uZXh0KTsKKyAgICB9CisKKyAgICBj
YXBfaW92YV9yYW5nZSA9IChzdHJ1Y3QgdmZpb19pb21tdV90eXBlMV9pbmZvX2NhcF9pb3ZhX3Jh
bmdlICopY2FwOworCisgICAgcy0+bmJfaW92YV9yYW5nZXMgPSBjYXBfaW92YV9yYW5nZS0+bnJf
aW92YXM7CisgICAgaWYgKHMtPm5iX2lvdmFfcmFuZ2VzID4gMSkgeworICAgICAgICBzLT51c2Fi
bGVfaW92YV9yYW5nZXMgPQorICAgICAgICAgICAgZ19yZWFsbG9jKHMtPnVzYWJsZV9pb3ZhX3Jh
bmdlcywKKyAgICAgICAgICAgICAgICAgICAgICBzLT5uYl9pb3ZhX3JhbmdlcyAqIHNpemVvZihz
dHJ1Y3QgSU9WQVJhbmdlKSk7CisgICAgfQorCisgICAgZm9yIChpID0gMDsgaSA8IHMtPm5iX2lv
dmFfcmFuZ2VzOyBpKyspIHsKKyAgICAgICAgcy0+dXNhYmxlX2lvdmFfcmFuZ2VzW2ldLnN0YXJ0
ID0gY2FwX2lvdmFfcmFuZ2UtPmlvdmFfcmFuZ2VzW2ldLnN0YXJ0OworICAgICAgICBzLT51c2Fi
bGVfaW92YV9yYW5nZXNbaV0uZW5kID0gY2FwX2lvdmFfcmFuZ2UtPmlvdmFfcmFuZ2VzW2ldLmVu
ZDsKKyAgICB9Cit9CisKIHN0YXRpYyBpbnQgcWVtdV92ZmlvX2luaXRfcGNpKFFFTVVWRklPU3Rh
dGUgKnMsIGNvbnN0IGNoYXIgKmRldmljZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEVycm9yICoqZXJycCkKIHsKQEAgLTI0MywxMCArMjc5LDEzIEBAIHN0YXRpYyBpbnQgcWVtdV92
ZmlvX2luaXRfcGNpKFFFTVVWRklPU3RhdGUgKnMsIGNvbnN0IGNoYXIgKmRldmljZSwKICAgICBp
bnQgaTsKICAgICB1aW50MTZfdCBwY2lfY21kOwogICAgIHN0cnVjdCB2ZmlvX2dyb3VwX3N0YXR1
cyBncm91cF9zdGF0dXMgPSB7IC5hcmdzeiA9IHNpemVvZihncm91cF9zdGF0dXMpIH07Ci0gICAg
c3RydWN0IHZmaW9faW9tbXVfdHlwZTFfaW5mbyBpb21tdV9pbmZvID0geyAuYXJnc3ogPSBzaXpl
b2YoaW9tbXVfaW5mbykgfTsKKyAgICBzdHJ1Y3QgdmZpb19pb21tdV90eXBlMV9pbmZvICppb21t
dV9pbmZvID0gTlVMTDsKKyAgICBzaXplX3QgaW9tbXVfaW5mb19zaXplID0gc2l6ZW9mKCppb21t
dV9pbmZvKTsKICAgICBzdHJ1Y3QgdmZpb19kZXZpY2VfaW5mbyBkZXZpY2VfaW5mbyA9IHsgLmFy
Z3N6ID0gc2l6ZW9mKGRldmljZV9pbmZvKSB9OwogICAgIGNoYXIgKmdyb3VwX2ZpbGUgPSBOVUxM
OwogCisgICAgcy0+dXNhYmxlX2lvdmFfcmFuZ2VzID0gTlVMTDsKKwogICAgIC8qIENyZWF0ZSBh
IG5ldyBjb250YWluZXIgKi8KICAgICBzLT5jb250YWluZXIgPSBvcGVuKCIvZGV2L3ZmaW8vdmZp
byIsIE9fUkRXUik7CiAKQEAgLTMxMCwxMyArMzQ5LDM1IEBAIHN0YXRpYyBpbnQgcWVtdV92Zmlv
X2luaXRfcGNpKFFFTVVWRklPU3RhdGUgKnMsIGNvbnN0IGNoYXIgKmRldmljZSwKICAgICAgICAg
Z290byBmYWlsOwogICAgIH0KIAorICAgIGlvbW11X2luZm8gPSBnX21hbGxvYzAoaW9tbXVfaW5m
b19zaXplKTsKKyAgICBpb21tdV9pbmZvLT5hcmdzeiA9IGlvbW11X2luZm9fc2l6ZTsKKwogICAg
IC8qIEdldCBhZGRpdGlvbmFsIElPTU1VIGluZm8gKi8KLSAgICBpZiAoaW9jdGwocy0+Y29udGFp
bmVyLCBWRklPX0lPTU1VX0dFVF9JTkZPLCAmaW9tbXVfaW5mbykpIHsKKyAgICBpZiAoaW9jdGwo
cy0+Y29udGFpbmVyLCBWRklPX0lPTU1VX0dFVF9JTkZPLCBpb21tdV9pbmZvKSkgewogICAgICAg
ICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLCAiRmFpbGVkIHRvIGdldCBJT01NVSBpbmZv
Iik7CiAgICAgICAgIHJldCA9IC1lcnJubzsKICAgICAgICAgZ290byBmYWlsOwogICAgIH0KIAor
ICAgIC8qCisgICAgICogaWYgdGhlIGtlcm5lbCBkb2VzIG5vdCByZXBvcnQgdXNhYmxlIElPVkEg
cmVnaW9ucywgY2hvb3NlCisgICAgICogdGhlIGxlZ2FjeSBbUUVNVV9WRklPX0lPVkFfTUlOLCBR
RU1VX1ZGSU9fSU9WQV9NQVggLTFdIHJlZ2lvbgorICAgICAqLworICAgIHMtPm5iX2lvdmFfcmFu
Z2VzID0gMTsKKyAgICBzLT51c2FibGVfaW92YV9yYW5nZXMgPSBnX25ldzAoc3RydWN0IElPVkFS
YW5nZSwgMSk7CisgICAgcy0+dXNhYmxlX2lvdmFfcmFuZ2VzWzBdLnN0YXJ0ID0gUUVNVV9WRklP
X0lPVkFfTUlOOworICAgIHMtPnVzYWJsZV9pb3ZhX3Jhbmdlc1swXS5lbmQgPSBRRU1VX1ZGSU9f
SU9WQV9NQVggLSAxOworCisgICAgaWYgKGlvbW11X2luZm8tPmFyZ3N6ID4gaW9tbXVfaW5mb19z
aXplKSB7CisgICAgICAgIGlvbW11X2luZm9fc2l6ZSA9IGlvbW11X2luZm8tPmFyZ3N6OworICAg
ICAgICBpb21tdV9pbmZvID0gZ19yZWFsbG9jKGlvbW11X2luZm8sIGlvbW11X2luZm9fc2l6ZSk7
CisgICAgICAgIGlmIChpb2N0bChzLT5jb250YWluZXIsIFZGSU9fSU9NTVVfR0VUX0lORk8sIGlv
bW11X2luZm8pKSB7CisgICAgICAgICAgICByZXQgPSAtZXJybm87CisgICAgICAgICAgICBnb3Rv
IGZhaWw7CisgICAgICAgIH0KKyAgICAgICAgY29sbGVjdF91c2FibGVfaW92YV9yYW5nZXMocywg
aW9tbXVfaW5mbyk7CisgICAgfQorCiAgICAgcy0+ZGV2aWNlID0gaW9jdGwocy0+Z3JvdXAsIFZG
SU9fR1JPVVBfR0VUX0RFVklDRV9GRCwgZGV2aWNlKTsKIAogICAgIGlmIChzLT5kZXZpY2UgPCAw
KSB7CkBAIC0zNjUsOCArNDI2LDEzIEBAIHN0YXRpYyBpbnQgcWVtdV92ZmlvX2luaXRfcGNpKFFF
TVVWRklPU3RhdGUgKnMsIGNvbnN0IGNoYXIgKmRldmljZSwKICAgICBpZiAocmV0KSB7CiAgICAg
ICAgIGdvdG8gZmFpbDsKICAgICB9CisgICAgZ19mcmVlKGlvbW11X2luZm8pOwogICAgIHJldHVy
biAwOwogZmFpbDoKKyAgICBnX2ZyZWUocy0+dXNhYmxlX2lvdmFfcmFuZ2VzKTsKKyAgICBzLT51
c2FibGVfaW92YV9yYW5nZXMgPSBOVUxMOworICAgIHMtPm5iX2lvdmFfcmFuZ2VzID0gMDsKKyAg
ICBnX2ZyZWUoaW9tbXVfaW5mbyk7CiAgICAgY2xvc2Uocy0+Z3JvdXApOwogZmFpbF9jb250YWlu
ZXI6CiAgICAgY2xvc2Uocy0+Y29udGFpbmVyKTsKQEAgLTcxNiw2ICs3ODIsOCBAQCB2b2lkIHFl
bXVfdmZpb19jbG9zZShRRU1VVkZJT1N0YXRlICpzKQogICAgICAgICBxZW11X3ZmaW9fdW5kb19t
YXBwaW5nKHMsICZzLT5tYXBwaW5nc1tpXSwgTlVMTCk7CiAgICAgfQogICAgIHJhbV9ibG9ja19u
b3RpZmllcl9yZW1vdmUoJnMtPnJhbV9ub3RpZmllcik7CisgICAgZ19mcmVlKHMtPnVzYWJsZV9p
b3ZhX3Jhbmdlcyk7CisgICAgcy0+bmJfaW92YV9yYW5nZXMgPSAwOwogICAgIHFlbXVfdmZpb19y
ZXNldChzKTsKICAgICBjbG9zZShzLT5kZXZpY2UpOwogICAgIGNsb3NlKHMtPmdyb3VwKTsKLS0g
CjIuMjYuMgoK


