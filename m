Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E21FC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174DD2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3RhuzSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174DD2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56Tl-0002OB-AB
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j56RN-0006Yr-Fb
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j56RL-0001xV-Ua
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57615
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j56RL-0001xF-QO
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582284351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbfJzGZfZyPY7f+Bc25X6hdR3DBj5uJbiEJ8wpa/tTQ=;
 b=U3RhuzSJG9Br5ee4qfWkKtqdbfeDaXb1HziL6eXfBGqFKsz/lWDqk0Q42adwerMQm10jPl
 pe4VeBNZRohIDXw6Y/dCf9EICv3wJa4mGhmWuTrRXP3eOswuonzN7VnSwrxe2RxygcGykf
 zknlr+0lKHgA0qAjIRBhOOv2hBsx1fE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-ipVJy9vpODGRo9RNWtOVqA-1; Fri, 21 Feb 2020 06:25:46 -0500
X-MC-Unique: ipVJy9vpODGRo9RNWtOVqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 907C48017CC;
 Fri, 21 Feb 2020 11:25:45 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77F655D9C5;
 Fri, 21 Feb 2020 11:25:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/4] iotests: add 282 luks qemu-img measure test
Date: Fri, 21 Feb 2020 11:25:22 +0000
Message-Id: <20200221112522.1497712-5-stefanha@redhat.com>
In-Reply-To: <20200221112522.1497712-1-stefanha@redhat.com>
References: <20200221112522.1497712-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhh
dC5jb20+Ci0tLQogdGVzdHMvcWVtdS1pb3Rlc3RzLzI4MiAgICAgfCA5MyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogdGVzdHMvcWVtdS1pb3Rlc3RzLzI4Mi5vdXQgfCAz
MCArKysrKysrKysrKysKIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgIHwgIDEgKwogMyBmaWxl
cyBjaGFuZ2VkLCAxMjQgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL3Fl
bXUtaW90ZXN0cy8yODIKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjgy
Lm91dAoKZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yODIgYi90ZXN0cy9xZW11LWlv
dGVzdHMvMjgyCm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAwMDAuLjZjNjIwNjVh
ZWYKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjgyCkBAIC0wLDAgKzEs
OTMgQEAKKyMhL3Vzci9iaW4vZW52IGJhc2gKKyMKKyMgcWVtdS1pbWcgbWVhc3VyZSB0ZXN0cyBm
b3IgTFVLUyBpbWFnZXMKKyMKKyMgQ29weXJpZ2h0IChDKSAyMDIwIFJlZCBIYXQsIEluYy4KKyMK
KyMgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0
IGFuZC9vciBtb2RpZnkKKyMgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyMgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyMgKGF0IHlvdXIgb3B0
aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyMKKyMgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVk
IGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisjIGJ1dCBXSVRIT1VUIEFOWSBX
QVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisjIE1FUkNIQU5U
QUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyMg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyMKKyMgWW91IHNo
b3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UKKyMgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW0uICBJZiBub3QsIHNlZSA8aHR0cDovL3d3dy5n
bnUub3JnL2xpY2Vuc2VzLz4uCisjCisKKyMgY3JlYXRvcgorb3duZXI9c3RlZmFuaGFAcmVkaGF0
LmNvbQorCitzZXE9YGJhc2VuYW1lICQwYAorZWNobyAiUUEgb3V0cHV0IGNyZWF0ZWQgYnkgJHNl
cSIKKworc3RhdHVzPTEgICAgIyBmYWlsdXJlIGlzIHRoZSBkZWZhdWx0IQorCitfY2xlYW51cCgp
Cit7CisgICAgX2NsZWFudXBfdGVzdF9pbWcKKyAgICBybSAtZiAiJFRFU1RfSU1HLmNvbnZlcnRl
ZCIKK30KK3RyYXAgIl9jbGVhbnVwOyBleGl0IFwkc3RhdHVzIiAwIDEgMiAzIDE1CisKKyMgZ2V0
IHN0YW5kYXJkIGVudmlyb25tZW50LCBmaWx0ZXJzIGFuZCBjaGVja3MKKy4gLi9jb21tb24ucmMK
Ky4gLi9jb21tb24uZmlsdGVyCisuIC4vY29tbW9uLnBhdHRlcm4KKworX3N1cHBvcnRlZF9mbXQg
bHVrcworX3N1cHBvcnRlZF9wcm90byBmaWxlCitfc3VwcG9ydGVkX29zIExpbnV4CisKK1NFQ1JF
VD1zZWNyZXQsaWQ9c2VjMCxkYXRhPXBhc3NwaHJhc2UKKworZWNobyAiPT0gbWVhc3VyZSAxRyBp
bWFnZSBmaWxlID09IgorZWNobworCiskUUVNVV9JTUcgbWVhc3VyZSAtLW9iamVjdCAiJFNFQ1JF
VCIgXAorCSAgICAgICAgICAtTyAiJElNR0ZNVCIgXAorCQkgIC1vIGtleS1zZWNyZXQ9c2VjMCxp
dGVyLXRpbWU9MTAgXAorCQkgIC0tc2l6ZSAxRworCitlY2hvCitlY2hvICI9PSBjcmVhdGUgMUcg
aW1hZ2UgZmlsZSAoc2l6ZSBzaG91bGQgYmUgbm8gZ3JlYXRlciB0aGFuIG1lYXN1cmVkKSA9PSIK
K2VjaG8KKworX21ha2VfdGVzdF9pbWcgMUcKK3N0YXQgLWMgImltYWdlIGZpbGUgc2l6ZSBpbiBi
eXRlczogJXMiICIkVEVTVF9JTUdfRklMRSIKKworZWNobworZWNobyAiPT0gbW9kaWZpZWQgMUcg
aW1hZ2UgZmlsZSAoc2l6ZSBzaG91bGQgYmUgbm8gZ3JlYXRlciB0aGFuIG1lYXN1cmVkKSA9PSIK
K2VjaG8KKworJFFFTVVfSU8gLS1vYmplY3QgIiRTRUNSRVQiIC0taW1hZ2Utb3B0cyAiJFRFU1Rf
SU1HIiAtYyAid3JpdGUgLVAgMHg1MSAweDEwMDAwIDB4NDAwIiB8IF9maWx0ZXJfcWVtdV9pbyB8
IF9maWx0ZXJfdGVzdGRpcgorc3RhdCAtYyAiaW1hZ2UgZmlsZSBzaXplIGluIGJ5dGVzOiAlcyIg
IiRURVNUX0lNR19GSUxFIgorCitlY2hvCitlY2hvICI9PSBtZWFzdXJlIHByZWFsbG9jYXRpb249
ZmFsbG9jIDFHIGltYWdlIGZpbGUgPT0iCitlY2hvCisKKyRRRU1VX0lNRyBtZWFzdXJlIC0tb2Jq
ZWN0ICIkU0VDUkVUIiBcCisJICAgICAgICAgIC1PICIkSU1HRk1UIiBcCisJCSAgLW8ga2V5LXNl
Y3JldD1zZWMwLGl0ZXItdGltZT0xMCxwcmVhbGxvY2F0aW9uPWZhbGxvYyBcCisJCSAgLS1zaXpl
IDFHCisKK2VjaG8KK2VjaG8gIj09IG1lYXN1cmUgd2l0aCBpbnB1dCBpbWFnZSBmaWxlID09Igor
ZWNobworCitJTUdGTVQ9cmF3IElNR0tFWVNFQ1JFVD0gSU1HT1BUUz0gX21ha2VfdGVzdF9pbWcg
MUcgfCBfZmlsdGVyX2ltZ2ZtdAorUUVNVV9JT19PUFRJT05TPSBJTUdPUFRTU1lOVEFYPSAkUUVN
VV9JTyAtZiByYXcgLWMgIndyaXRlIC1QIDB4NTEgMHgxMDAwMCAweDQwMCIgIiRURVNUX0lNR19G
SUxFIiB8IF9maWx0ZXJfcWVtdV9pbyB8IF9maWx0ZXJfdGVzdGRpcgorJFFFTVVfSU1HIG1lYXN1
cmUgLS1vYmplY3QgIiRTRUNSRVQiIFwKKwkgICAgICAgICAgLU8gIiRJTUdGTVQiIFwKKwkJICAt
byBrZXktc2VjcmV0PXNlYzAsaXRlci10aW1lPTEwIFwKKwkJICAtZiByYXcgXAorCQkgICIkVEVT
VF9JTUdfRklMRSIKKworIyBzdWNjZXNzLCBhbGwgZG9uZQorZWNobyAiKioqIGRvbmUiCitybSAt
ZiAkc2VxLmZ1bGwKK3N0YXR1cz0wCmRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMjgy
Lm91dCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yODIub3V0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAwMDAuLjk5NmNjNDRhNjcKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0cy9xZW11
LWlvdGVzdHMvMjgyLm91dApAQCAtMCwwICsxLDMwIEBACitRQSBvdXRwdXQgY3JlYXRlZCBieSAy
ODIKKz09IG1lYXN1cmUgMUcgaW1hZ2UgZmlsZSA9PQorCityZXF1aXJlZCBzaXplOiAxMDc1ODEw
MzA0CitmdWxseSBhbGxvY2F0ZWQgc2l6ZTogMTA3NTgxMDMwNAorCis9PSBjcmVhdGUgMUcgaW1h
Z2UgZmlsZSAoc2l6ZSBzaG91bGQgYmUgbm8gZ3JlYXRlciB0aGFuIG1lYXN1cmVkKSA9PQorCitG
b3JtYXR0aW5nICdURVNUX0RJUi90LklNR0ZNVCcsIGZtdD1JTUdGTVQgc2l6ZT0xMDczNzQxODI0
CitpbWFnZSBmaWxlIHNpemUgaW4gYnl0ZXM6IDEwNzU4MTAzMDQKKworPT0gbW9kaWZpZWQgMUcg
aW1hZ2UgZmlsZSAoc2l6ZSBzaG91bGQgYmUgbm8gZ3JlYXRlciB0aGFuIG1lYXN1cmVkKSA9PQor
Cit3cm90ZSAxMDI0LzEwMjQgYnl0ZXMgYXQgb2Zmc2V0IDY1NTM2CisxIEtpQiwgWCBvcHM7IFhY
OlhYOlhYLlggKFhYWCBZWVkvc2VjIGFuZCBYWFggb3BzL3NlYykKK2ltYWdlIGZpbGUgc2l6ZSBp
biBieXRlczogMTA3NTgxMDMwNAorCis9PSBtZWFzdXJlIHByZWFsbG9jYXRpb249ZmFsbG9jIDFH
IGltYWdlIGZpbGUgPT0KKworcmVxdWlyZWQgc2l6ZTogMTA3NTgxMDMwNAorZnVsbHkgYWxsb2Nh
dGVkIHNpemU6IDEwNzU4MTAzMDQKKworPT0gbWVhc3VyZSB3aXRoIGlucHV0IGltYWdlIGZpbGUg
PT0KKworRm9ybWF0dGluZyAnVEVTVF9ESVIvdC5JTUdGTVQnLCBmbXQ9SU1HRk1UIHNpemU9MTA3
Mzc0MTgyNAord3JvdGUgMTAyNC8xMDI0IGJ5dGVzIGF0IG9mZnNldCA2NTUzNgorMSBLaUIsIFgg
b3BzOyBYWDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpCityZXF1aXJlZCBz
aXplOiAxMDc1ODEwMzA0CitmdWxseSBhbGxvY2F0ZWQgc2l6ZTogMTA3NTgxMDMwNAorKioqIGRv
bmUKZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCBiL3Rlc3RzL3FlbXUtaW90
ZXN0cy9ncm91cAppbmRleCAxOTA0MjIzMDIwLi42YTI1ZWZlYTRkIDEwMDY0NAotLS0gYS90ZXN0
cy9xZW11LWlvdGVzdHMvZ3JvdXAKKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwCkBAIC0y
ODksNCArMjg5LDUgQEAKIDI3OSBydyBiYWNraW5nIHF1aWNrCiAyODAgcncgbWlncmF0aW9uIHF1
aWNrCiAyODEgcncgcXVpY2sKKzI4MiBxdWljawogMjgzIGF1dG8gcXVpY2sKLS0gCjIuMjQuMQoK


