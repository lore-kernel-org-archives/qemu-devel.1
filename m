Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68524C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D0920702
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFrZbl1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D0920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2Hb-0006VS-EO
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2Es-0001YZ-VQ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:02:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2Er-0003a4-1W
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592992960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vInTGCffotXESgrOE+sQ/HjsitRb+VUYibAP46TUiF4=;
 b=IFrZbl1awfJ1qmAM4azsnxS/0+nFspT2BBezxKhuwZ2yM1X0fgeJwve8cf5uMzNxv4f4MF
 7LmXLgiFEsy2fV8iX75uwRnojbLtpZi2J/YmTDPR8rwkef3KSaRwi+DGsUdhv1ZnHjXpMr
 S3Qej1/BwslLFHR/5GRvgw1H/iU6N7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-_TkRBPyZNpOpvnJchgsTNQ-1; Wed, 24 Jun 2020 06:02:38 -0400
X-MC-Unique: _TkRBPyZNpOpvnJchgsTNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB3D7107ACCD;
 Wed, 24 Jun 2020 10:02:36 +0000 (UTC)
Received: from localhost (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91C385D9D3;
 Wed, 24 Jun 2020 10:02:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/12] configure: add flags to support SafeStack
Date: Wed, 24 Jun 2020 11:02:02 +0100
Message-Id: <20200624100210.59975-5-stefanha@redhat.com>
In-Reply-To: <20200624100210.59975-1-stefanha@redhat.com>
References: <20200624100210.59975-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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

RnJvbTogRGFuaWVsZSBCdW9ubyA8ZGJ1b25vQGxpbnV4LnZuZXQuaWJtLmNvbT4KClRoaXMgcGF0
Y2ggYWRkcyBhIGZsYWcgdG8gZW5hYmxlL2Rpc2FibGUgdGhlIFNhZmVTdGFjayBpbnN0cnVtZW50
YXRpb24KcHJvdmlkZWQgYnkgTExWTS4KCk9uIGVuYWJsZSwgbWFrZSBzdXJlIHRoYXQgdGhlIGNv
bXBpbGVyIHN1cHBvcnRzIHRoZSBmbGFncywgYW5kIHRoYXQgd2UKYXJlIHVzaW5nIHRoZSBwcm9w
ZXIgY29yb3V0aW5lIGltcGxlbWVudGF0aW9uIChjb3JvdXRpbmUtdWNvbnRleHQpLgpPbiBkaXNh
YmxlLCBleHBsaWNpdGx5IGRpc2FibGUgdGhlIG9wdGlvbiBpZiBpdCB3YXMgZW5hYmxlZCBieSBk
ZWZhdWx0LgoKV2hpbGUgU2FmZVN0YWNrIGlzIHN1cHBvcnRlZCBvbmx5IG9uIExpbnV4LCBOZXRC
U0QsIEZyZWVCU0QgYW5kIG1hY09TLAp3ZSBhcmUgbm90IGNoZWNraW5nIGZvciB0aGUgTy5TLiBz
aW5jZSB0aGlzIGlzIGFscmVhZHkgZG9uZSBieSBMTFZNLgoKU2lnbmVkLW9mZi1ieTogRGFuaWVs
ZSBCdW9ubyA8ZGJ1b25vQGxpbnV4LnZuZXQuaWJtLmNvbT4KTWVzc2FnZS1pZDogMjAyMDA1Mjky
MDUxMjIuNzE0LTQtZGJ1b25vQGxpbnV4LnZuZXQuaWJtLmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogY29uZmlndXJlIHwgNzMgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9jb25maWd1cmUgYi9j
b25maWd1cmUKaW5kZXggYmE4OGZkMTgyNC4uYWU4NzM3ZDVhMiAxMDA3NTUKLS0tIGEvY29uZmln
dXJlCisrKyBiL2NvbmZpZ3VyZQpAQCAtMzA3LDYgKzMwNyw3IEBAIGF1ZGlvX3dpbl9pbnQ9IiIK
IGxpYnNfcWdhPSIiCiBkZWJ1Z19pbmZvPSJ5ZXMiCiBzdGFja19wcm90ZWN0b3I9IiIKK3NhZmVf
c3RhY2s9IiIKIHVzZV9jb250YWluZXJzPSJ5ZXMiCiBnZGJfYmluPSQoY29tbWFuZCAtdiAiZ2Ri
LW11bHRpYXJjaCIgfHwgY29tbWFuZCAtdiAiZ2RiIikKIApAQCAtMTI4Nyw2ICsxMjg4LDEwIEBA
IGZvciBvcHQgZG8KICAgOzsKICAgLS1kaXNhYmxlLXN0YWNrLXByb3RlY3Rvcikgc3RhY2tfcHJv
dGVjdG9yPSJubyIKICAgOzsKKyAgLS1lbmFibGUtc2FmZS1zdGFjaykgc2FmZV9zdGFjaz0ieWVz
IgorICA7OworICAtLWRpc2FibGUtc2FmZS1zdGFjaykgc2FmZV9zdGFjaz0ibm8iCisgIDs7CiAg
IC0tZGlzYWJsZS1jdXJzZXMpIGN1cnNlcz0ibm8iCiAgIDs7CiAgIC0tZW5hYmxlLWN1cnNlcykg
Y3Vyc2VzPSJ5ZXMiCkBAIC0xODI5LDYgKzE4MzQsOCBAQCBkaXNhYmxlZCB3aXRoIC0tZGlzYWJs
ZS1GRUFUVVJFLCBkZWZhdWx0IGlzIGVuYWJsZWQgaWYgYXZhaWxhYmxlOgogICBkZWJ1Zy10Y2cg
ICAgICAgVENHIGRlYnVnZ2luZyAoZGVmYXVsdCBpcyBkaXNhYmxlZCkKICAgZGVidWctaW5mbyAg
ICAgIGRlYnVnZ2luZyBpbmZvcm1hdGlvbgogICBzcGFyc2UgICAgICAgICAgc3BhcnNlIGNoZWNr
ZXIKKyAgc2FmZS1zdGFjayAgICAgIFNhZmVTdGFjayBTdGFjayBTbWFzaCBQcm90ZWN0aW9uLiBE
ZXBlbmRzIG9uCisgICAgICAgICAgICAgICAgICBjbGFuZy9sbHZtID49IDMuNyBhbmQgcmVxdWly
ZXMgY29yb3V0aW5lIGJhY2tlbmQgdWNvbnRleHQuCiAKICAgZ251dGxzICAgICAgICAgIEdOVVRM
UyBjcnlwdG9ncmFwaHkgc3VwcG9ydAogICBuZXR0bGUgICAgICAgICAgbmV0dGxlIGNyeXB0b2dy
YXBoeSBzdXBwb3J0CkBAIC01NTczLDYgKzU1ODAsNjcgQEAgaWYgdGVzdCAiJGRlYnVnX3N0YWNr
X3VzYWdlIiA9ICJ5ZXMiOyB0aGVuCiAgIGZpCiBmaQogCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIworIyBTYWZlU3RhY2sKKworCitpZiB0ZXN0ICIk
c2FmZV9zdGFjayIgPSAieWVzIjsgdGhlbgorY2F0ID4gJFRNUEMgPDwgRU9GCitpbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQoreworI2lmICEgX19oYXNfZmVhdHVyZShzYWZlX3N0YWNr
KQorI2Vycm9yIFNhZmVTdGFjayBEaXNhYmxlZAorI2VuZGlmCisgICAgcmV0dXJuIDA7Cit9CitF
T0YKKyAgZmxhZz0iLWZzYW5pdGl6ZT1zYWZlLXN0YWNrIgorICAjIENoZWNrIHRoYXQgc2FmZS1z
dGFjayBpcyBzdXBwb3J0ZWQgYW5kIGVuYWJsZWQuCisgIGlmIGNvbXBpbGVfcHJvZyAiLVdlcnJv
ciAkZmxhZyIgIiRmbGFnIjsgdGhlbgorICAgICMgRmxhZyBuZWVkZWQgYm90aCBhdCBjb21waWxh
dGlvbiBhbmQgYXQgbGlua2luZworICAgIFFFTVVfQ0ZMQUdTPSIkUUVNVV9DRkxBR1MgJGZsYWci
CisgICAgUUVNVV9MREZMQUdTPSIkUUVNVV9MREZMQUdTICRmbGFnIgorICBlbHNlCisgICAgZXJy
b3JfZXhpdCAiU2FmZVN0YWNrIG5vdCBzdXBwb3J0ZWQgYnkgeW91ciBjb21waWxlciIKKyAgZmkK
KyAgaWYgdGVzdCAiJGNvcm91dGluZSIgIT0gInVjb250ZXh0IjsgdGhlbgorICAgIGVycm9yX2V4
aXQgIlNhZmVTdGFjayBpcyBvbmx5IHN1cHBvcnRlZCBieSB0aGUgY29yb3V0aW5lIGJhY2tlbmQg
dWNvbnRleHQiCisgIGZpCitlbHNlCitjYXQgPiAkVE1QQyA8PCBFT0YKK2ludCBtYWluKGludCBh
cmdjLCBjaGFyICphcmd2W10pCit7CisjaWYgZGVmaW5lZChfX2hhc19mZWF0dXJlKQorI2lmIF9f
aGFzX2ZlYXR1cmUoc2FmZV9zdGFjaykKKyNlcnJvciBTYWZlU3RhY2sgRW5hYmxlZAorI2VuZGlm
CisjZW5kaWYKKyAgICByZXR1cm4gMDsKK30KK0VPRgoraWYgdGVzdCAiJHNhZmVfc3RhY2siID0g
Im5vIjsgdGhlbgorICAjIE1ha2Ugc3VyZSB0aGF0IHNhZmUtc3RhY2sgaXMgZGlzYWJsZWQKKyAg
aWYgISBjb21waWxlX3Byb2cgIi1XZXJyb3IiICIiOyB0aGVuCisgICAgIyBTYWZlU3RhY2sgd2Fz
IGFscmVhZHkgZW5hYmxlZCwgdHJ5IHRvIGV4cGxpY2l0bHkgcmVtb3ZlIHRoZSBmZWF0dXJlCisg
ICAgZmxhZz0iLWZuby1zYW5pdGl6ZT1zYWZlLXN0YWNrIgorICAgIGlmICEgY29tcGlsZV9wcm9n
ICItV2Vycm9yICRmbGFnIiAiJGZsYWciOyB0aGVuCisgICAgICBlcnJvcl9leGl0ICJDb25maWd1
cmUgY2Fubm90IGRpc2FibGUgU2FmZVN0YWNrIgorICAgIGZpCisgICAgUUVNVV9DRkxBR1M9IiRR
RU1VX0NGTEFHUyAkZmxhZyIKKyAgICBRRU1VX0xERkxBR1M9IiRRRU1VX0xERkxBR1MgJGZsYWci
CisgIGZpCitlbHNlICMgIiRzYWZlX3N0YWNrIiA9ICIiCisgICMgU2V0IHNhZmVfc3RhY2sgdG8g
eWVzIG9yIG5vIGJhc2VkIG9uIHByZS1leGlzdGluZyBmbGFncworICBpZiBjb21waWxlX3Byb2cg
Ii1XZXJyb3IiICIiOyB0aGVuCisgICAgc2FmZV9zdGFjaz0ibm8iCisgIGVsc2UKKyAgICBzYWZl
X3N0YWNrPSJ5ZXMiCisgICAgaWYgdGVzdCAiJGNvcm91dGluZSIgIT0gInVjb250ZXh0IjsgdGhl
bgorICAgICAgZXJyb3JfZXhpdCAiU2FmZVN0YWNrIGlzIG9ubHkgc3VwcG9ydGVkIGJ5IHRoZSBj
b3JvdXRpbmUgYmFja2VuZCB1Y29udGV4dCIKKyAgICBmaQorICBmaQorZmkKK2ZpCiAKICMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwogIyBjaGVjayBpZiB3ZSBoYXZl
IG9wZW5fYnlfaGFuZGxlX2F0CkBAIC02NzY1LDYgKzY4MzMsNyBAQCBlY2hvICJzcGFyc2UgZW5h
YmxlZCAgICAkc3BhcnNlIgogZWNobyAic3RyaXAgYmluYXJpZXMgICAgJHN0cmlwX29wdCIKIGVj
aG8gInByb2ZpbGVyICAgICAgICAgICRwcm9maWxlciIKIGVjaG8gInN0YXRpYyBidWlsZCAgICAg
ICRzdGF0aWMiCitlY2hvICJzYWZlIHN0YWNrICAgICAgICAkc2FmZV9zdGFjayIKIGlmIHRlc3Qg
IiRkYXJ3aW4iID0gInllcyIgOyB0aGVuCiAgICAgZWNobyAiQ29jb2Egc3VwcG9ydCAgICAgJGNv
Y29hIgogZmkKQEAgLTgzNzAsNiArODQzOSwxMCBAQCBpZiB0ZXN0ICIkY2NhY2hlX2NwcDIiID0g
InllcyI7IHRoZW4KICAgZWNobyAiZXhwb3J0IENDQUNIRV9DUFAyPXkiID4+ICRjb25maWdfaG9z
dF9tYWsKIGZpCiAKK2lmIHRlc3QgIiRzYWZlX3N0YWNrIiA9ICJ5ZXMiOyB0aGVuCisgIGVjaG8g
IkNPTkZJR19TQUZFU1RBQ0s9eSIgPj4gJGNvbmZpZ19ob3N0X21haworZmkKKwogIyBJZiB3ZSdy
ZSB1c2luZyBhIHNlcGFyYXRlIGJ1aWxkIHRyZWUsIHNldCBpdCB1cCBub3cuCiAjIERJUlMgYXJl
IGRpcmVjdG9yaWVzIHdoaWNoIHdlIHNpbXBseSBta2RpciBpbiB0aGUgYnVpbGQgdHJlZTsKICMg
TElOS1MgYXJlIHRoaW5ncyB0byBzeW1saW5rIGJhY2sgaW50byB0aGUgc291cmNlIHRyZWUKLS0g
CjIuMjYuMgoK


