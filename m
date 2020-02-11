Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F1C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB1C2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtIe9PF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB1C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Y3R-0004DN-IT
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j1Y0l-0008QU-AO
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j1Y0j-0005S2-Sq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47735
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j1Y0j-0005Qe-NJ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581437021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cepXeL6J/V993gFxgQax79jSoOuQ7Uj4dfUDVwJ31cA=;
 b=XtIe9PF/Z9P99Vkf5UyhqlBGgOCMATdW2TOVfYjON/NED0eOv3B0dtvHUClbxEFN7s9r8u
 8CGqxeyAz06Wm7SRNWtNnh1du4+j2alL6hKRpCkwIVoY804dvH/H6GS65smAAtQsKWzgDD
 iU4cBg05jkSbZYAkECF/pZmtG8TR4i8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-HebugjuXPwefBHc2Pw65Qg-1; Tue, 11 Feb 2020 11:03:38 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2A378017CC;
 Tue, 11 Feb 2020 16:03:37 +0000 (UTC)
Received: from localhost (unknown [10.36.118.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 885095C109;
 Tue, 11 Feb 2020 16:03:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] iotests: add 282 luks qemu-img measure test
Date: Tue, 11 Feb 2020 16:03:18 +0000
Message-Id: <20200211160318.453650-5-stefanha@redhat.com>
In-Reply-To: <20200211160318.453650-1-stefanha@redhat.com>
References: <20200211160318.453650-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: HebugjuXPwefBHc2Pw65Qg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyB0ZXN0IGV4ZXJjaXNlcyB0aGUgYmxvY2svY3J5cHRvLmMgImx1a3MiIGJsb2NrIGRyaXZl
cgouYmRydl9tZWFzdXJlKCkgY29kZS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8
c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB0ZXN0cy9xZW11LWlvdGVzdHMvMjgyICAgICB8IDkz
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy9xZW11LWlvdGVz
dHMvMjgyLm91dCB8IDMwICsrKysrKysrKysrKwogdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwICAg
fCAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDEyNCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAx
MDA3NTUgdGVzdHMvcWVtdS1pb3Rlc3RzLzI4MgogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Fl
bXUtaW90ZXN0cy8yODIub3V0CgpkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI4MiBi
L3Rlc3RzL3FlbXUtaW90ZXN0cy8yODIKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5kZXggMDAwMDAw
MDAwMC4uNmM2MjA2NWFlZgotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8y
ODIKQEAgLTAsMCArMSw5MyBAQAorIyEvdXNyL2Jpbi9lbnYgYmFzaAorIworIyBxZW11LWltZyBt
ZWFzdXJlIHRlc3RzIGZvciBMVUtTIGltYWdlcworIworIyBDb3B5cmlnaHQgKEMpIDIwMjAgUmVk
IEhhdCwgSW5jLgorIworIyBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
ZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorIyBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorIyB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgor
IyAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorIworIyBUaGlzIHByb2dyYW0g
aXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyMgYnV0
IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkg
b2YKKyMgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NF
LiAgU2VlIHRoZQorIyBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxz
LgorIworIyBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZQorIyBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbS4gIElmIG5vdCwgc2Vl
IDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KKyMKKworIyBjcmVhdG9yCitvd25lcj1z
dGVmYW5oYUByZWRoYXQuY29tCisKK3NlcT1gYmFzZW5hbWUgJDBgCitlY2hvICJRQSBvdXRwdXQg
Y3JlYXRlZCBieSAkc2VxIgorCitzdGF0dXM9MSAgICAjIGZhaWx1cmUgaXMgdGhlIGRlZmF1bHQh
CisKK19jbGVhbnVwKCkKK3sKKyAgICBfY2xlYW51cF90ZXN0X2ltZworICAgIHJtIC1mICIkVEVT
VF9JTUcuY29udmVydGVkIgorfQordHJhcCAiX2NsZWFudXA7IGV4aXQgXCRzdGF0dXMiIDAgMSAy
IDMgMTUKKworIyBnZXQgc3RhbmRhcmQgZW52aXJvbm1lbnQsIGZpbHRlcnMgYW5kIGNoZWNrcwor
LiAuL2NvbW1vbi5yYworLiAuL2NvbW1vbi5maWx0ZXIKKy4gLi9jb21tb24ucGF0dGVybgorCitf
c3VwcG9ydGVkX2ZtdCBsdWtzCitfc3VwcG9ydGVkX3Byb3RvIGZpbGUKK19zdXBwb3J0ZWRfb3Mg
TGludXgKKworU0VDUkVUPXNlY3JldCxpZD1zZWMwLGRhdGE9cGFzc3BocmFzZQorCitlY2hvICI9
PSBtZWFzdXJlIDFHIGltYWdlIGZpbGUgPT0iCitlY2hvCisKKyRRRU1VX0lNRyBtZWFzdXJlIC0t
b2JqZWN0ICIkU0VDUkVUIiBcCisJICAgICAgICAgIC1PICIkSU1HRk1UIiBcCisJCSAgLW8ga2V5
LXNlY3JldD1zZWMwLGl0ZXItdGltZT0xMCBcCisJCSAgLS1zaXplIDFHCisKK2VjaG8KK2VjaG8g
Ij09IGNyZWF0ZSAxRyBpbWFnZSBmaWxlIChzaXplIHNob3VsZCBiZSBubyBncmVhdGVyIHRoYW4g
bWVhc3VyZWQpID09IgorZWNobworCitfbWFrZV90ZXN0X2ltZyAxRworc3RhdCAtYyAiaW1hZ2Ug
ZmlsZSBzaXplIGluIGJ5dGVzOiAlcyIgIiRURVNUX0lNR19GSUxFIgorCitlY2hvCitlY2hvICI9
PSBtb2RpZmllZCAxRyBpbWFnZSBmaWxlIChzaXplIHNob3VsZCBiZSBubyBncmVhdGVyIHRoYW4g
bWVhc3VyZWQpID09IgorZWNobworCiskUUVNVV9JTyAtLW9iamVjdCAiJFNFQ1JFVCIgLS1pbWFn
ZS1vcHRzICIkVEVTVF9JTUciIC1jICJ3cml0ZSAtUCAweDUxIDB4MTAwMDAgMHg0MDAiIHwgX2Zp
bHRlcl9xZW11X2lvIHwgX2ZpbHRlcl90ZXN0ZGlyCitzdGF0IC1jICJpbWFnZSBmaWxlIHNpemUg
aW4gYnl0ZXM6ICVzIiAiJFRFU1RfSU1HX0ZJTEUiCisKK2VjaG8KK2VjaG8gIj09IG1lYXN1cmUg
cHJlYWxsb2NhdGlvbj1mYWxsb2MgMUcgaW1hZ2UgZmlsZSA9PSIKK2VjaG8KKworJFFFTVVfSU1H
IG1lYXN1cmUgLS1vYmplY3QgIiRTRUNSRVQiIFwKKwkgICAgICAgICAgLU8gIiRJTUdGTVQiIFwK
KwkJICAtbyBrZXktc2VjcmV0PXNlYzAsaXRlci10aW1lPTEwLHByZWFsbG9jYXRpb249ZmFsbG9j
IFwKKwkJICAtLXNpemUgMUcKKworZWNobworZWNobyAiPT0gbWVhc3VyZSB3aXRoIGlucHV0IGlt
YWdlIGZpbGUgPT0iCitlY2hvCisKK0lNR0ZNVD1yYXcgSU1HS0VZU0VDUkVUPSBJTUdPUFRTPSBf
bWFrZV90ZXN0X2ltZyAxRyB8IF9maWx0ZXJfaW1nZm10CitRRU1VX0lPX09QVElPTlM9IElNR09Q
VFNTWU5UQVg9ICRRRU1VX0lPIC1mIHJhdyAtYyAid3JpdGUgLVAgMHg1MSAweDEwMDAwIDB4NDAw
IiAiJFRFU1RfSU1HX0ZJTEUiIHwgX2ZpbHRlcl9xZW11X2lvIHwgX2ZpbHRlcl90ZXN0ZGlyCisk
UUVNVV9JTUcgbWVhc3VyZSAtLW9iamVjdCAiJFNFQ1JFVCIgXAorCSAgICAgICAgICAtTyAiJElN
R0ZNVCIgXAorCQkgIC1vIGtleS1zZWNyZXQ9c2VjMCxpdGVyLXRpbWU9MTAgXAorCQkgIC1mIHJh
dyBcCisJCSAgIiRURVNUX0lNR19GSUxFIgorCisjIHN1Y2Nlc3MsIGFsbCBkb25lCitlY2hvICIq
KiogZG9uZSIKK3JtIC1mICRzZXEuZnVsbAorc3RhdHVzPTAKZGlmZiAtLWdpdCBhL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8yODIub3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI4Mi5vdXQKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uOTk2Y2M0NGE2NwotLS0gL2Rldi9udWxsCisr
KyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yODIub3V0CkBAIC0wLDAgKzEsMzAgQEAKK1FBIG91dHB1
dCBjcmVhdGVkIGJ5IDI4MgorPT0gbWVhc3VyZSAxRyBpbWFnZSBmaWxlID09CisKK3JlcXVpcmVk
IHNpemU6IDEwNzU4MTAzMDQKK2Z1bGx5IGFsbG9jYXRlZCBzaXplOiAxMDc1ODEwMzA0CisKKz09
IGNyZWF0ZSAxRyBpbWFnZSBmaWxlIChzaXplIHNob3VsZCBiZSBubyBncmVhdGVyIHRoYW4gbWVh
c3VyZWQpID09CisKK0Zvcm1hdHRpbmcgJ1RFU1RfRElSL3QuSU1HRk1UJywgZm10PUlNR0ZNVCBz
aXplPTEwNzM3NDE4MjQKK2ltYWdlIGZpbGUgc2l6ZSBpbiBieXRlczogMTA3NTgxMDMwNAorCis9
PSBtb2RpZmllZCAxRyBpbWFnZSBmaWxlIChzaXplIHNob3VsZCBiZSBubyBncmVhdGVyIHRoYW4g
bWVhc3VyZWQpID09CisKK3dyb3RlIDEwMjQvMTAyNCBieXRlcyBhdCBvZmZzZXQgNjU1MzYKKzEg
S2lCLCBYIG9wczsgWFg6WFg6WFguWCAoWFhYIFlZWS9zZWMgYW5kIFhYWCBvcHMvc2VjKQoraW1h
Z2UgZmlsZSBzaXplIGluIGJ5dGVzOiAxMDc1ODEwMzA0CisKKz09IG1lYXN1cmUgcHJlYWxsb2Nh
dGlvbj1mYWxsb2MgMUcgaW1hZ2UgZmlsZSA9PQorCityZXF1aXJlZCBzaXplOiAxMDc1ODEwMzA0
CitmdWxseSBhbGxvY2F0ZWQgc2l6ZTogMTA3NTgxMDMwNAorCis9PSBtZWFzdXJlIHdpdGggaW5w
dXQgaW1hZ2UgZmlsZSA9PQorCitGb3JtYXR0aW5nICdURVNUX0RJUi90LklNR0ZNVCcsIGZtdD1J
TUdGTVQgc2l6ZT0xMDczNzQxODI0Cit3cm90ZSAxMDI0LzEwMjQgYnl0ZXMgYXQgb2Zmc2V0IDY1
NTM2CisxIEtpQiwgWCBvcHM7IFhYOlhYOlhYLlggKFhYWCBZWVkvc2VjIGFuZCBYWFggb3BzL3Nl
YykKK3JlcXVpcmVkIHNpemU6IDEwNzU4MTAzMDQKK2Z1bGx5IGFsbG9jYXRlZCBzaXplOiAxMDc1
ODEwMzA0CisqKiogZG9uZQpkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwIGIv
dGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwCmluZGV4IDE5MDQyMjMwMjAuLjZhMjVlZmVhNGQgMTAw
NjQ0Ci0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy9ncm91cAorKysgYi90ZXN0cy9xZW11LWlvdGVz
dHMvZ3JvdXAKQEAgLTI4OSw0ICsyODksNSBAQAogMjc5IHJ3IGJhY2tpbmcgcXVpY2sKIDI4MCBy
dyBtaWdyYXRpb24gcXVpY2sKIDI4MSBydyBxdWljaworMjgyIHF1aWNrCiAyODMgYXV0byBxdWlj
awotLSAKMi4yNC4xCgo=


