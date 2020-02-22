Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8313C35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739B820675
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dekr+2Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739B820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5QlB-0001AA-M8
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 04:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QZY-0005RM-A9
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QZX-0003nO-1i
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:55:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26117
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QZW-0003nC-Uc
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fuFc5nxGURRnAwy7cVk+HzF64J562kcnEnKseTiiav8=;
 b=Dekr+2SlUefd/ydkoAC21Xps2dTfoocTEkFnV2LYJOmBxRSFPlrrBF/wP2LU1OT+EwJUwb
 TcRk26yj1zKkbBZC+HR9I8AORglaoMMQnyqSHchgehBk+FXSxTB89V4XR2LD3O3s+k+aI2
 oEmlo19GN8AbPqdhLcJvcKXPmwW0wpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-hl_hLGkCPKOaMOz-KsPlDg-1; Sat, 22 Feb 2020 03:55:34 -0500
X-MC-Unique: hl_hLGkCPKOaMOz-KsPlDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B29AB107ACC5;
 Sat, 22 Feb 2020 08:55:32 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 053BA5D9CD;
 Sat, 22 Feb 2020 08:55:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/31] fuzz: add target/fuzz makefile rules
Date: Sat, 22 Feb 2020 08:50:25 +0000
Message-Id: <20200222085030.1760640-27-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Darren Kenny <darren.kenny@oracle.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4KUmV2aWV3ZWQtYnk6IERhcnJlbiBLZW5u
eSA8ZGFycmVuLmtlbm55QG9yYWNsZS5jb20+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwMjIwMDQxMTE4LjIzMjY0LTE4
LWFseG5kckBidS5lZHUKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBy
ZWRoYXQuY29tPgotLS0KIE1ha2VmaWxlICAgICAgICB8IDE1ICsrKysrKysrKysrKysrLQogTWFr
ZWZpbGUudGFyZ2V0IHwgMTYgKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzMCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtl
ZmlsZQppbmRleCBiNWE3Mzc3Y2IxLi4xOGU4MmNjYTg1IDEwMDY0NAotLS0gYS9NYWtlZmlsZQor
KysgYi9NYWtlZmlsZQpAQCAtNDc3LDcgKzQ3Nyw3IEBAIGNvbmZpZy1ob3N0LmgtdGltZXN0YW1w
OiBjb25maWctaG9zdC5tYWsKIHFlbXUtb3B0aW9ucy5kZWY6ICQoU1JDX1BBVEgpL3FlbXUtb3B0
aW9ucy5oeCAkKFNSQ19QQVRIKS9zY3JpcHRzL2h4dG9vbAogCSQoY2FsbCBxdWlldC1jb21tYW5k
LHNoICQoU1JDX1BBVEgpL3NjcmlwdHMvaHh0b29sIC1oIDwgJDwgPiAkQCwiR0VOIiwiJEAiKQog
Ci1UQVJHRVRfRElSU19SVUxFUyA6PSAkKGZvcmVhY2ggdCwgYWxsIGNsZWFuIGluc3RhbGwsICQo
YWRkc3VmZml4IC8kKHQpLCAkKFRBUkdFVF9ESVJTKSkpCitUQVJHRVRfRElSU19SVUxFUyA6PSAk
KGZvcmVhY2ggdCwgYWxsIGZ1enogY2xlYW4gaW5zdGFsbCwgJChhZGRzdWZmaXggLyQodCksICQo
VEFSR0VUX0RJUlMpKSkKIAogU09GVE1NVV9BTExfUlVMRVM9JChmaWx0ZXIgJS1zb2Z0bW11L2Fs
bCwgJChUQVJHRVRfRElSU19SVUxFUykpCiAkKFNPRlRNTVVfQUxMX1JVTEVTKTogJChhdXRoei1v
YmoteSkKQEAgLTQ5MCw2ICs0OTAsMTUgQEAgaWZkZWYgREVDT01QUkVTU19FREsyX0JMT0JTCiAk
KFNPRlRNTVVfQUxMX1JVTEVTKTogJChlZGsyLWRlY29tcHJlc3NlZCkKIGVuZGlmCiAKK1NPRlRN
TVVfRlVaWl9SVUxFUz0kKGZpbHRlciAlLXNvZnRtbXUvZnV6eiwgJChUQVJHRVRfRElSU19SVUxF
UykpCiskKFNPRlRNTVVfRlVaWl9SVUxFUyk6ICQoYXV0aHotb2JqLXkpCiskKFNPRlRNTVVfRlVa
Wl9SVUxFUyk6ICQoYmxvY2stb2JqLXkpCiskKFNPRlRNTVVfRlVaWl9SVUxFUyk6ICQoY2hhcmRl
di1vYmoteSkKKyQoU09GVE1NVV9GVVpaX1JVTEVTKTogJChjcnlwdG8tb2JqLXkpCiskKFNPRlRN
TVVfRlVaWl9SVUxFUyk6ICQoaW8tb2JqLXkpCiskKFNPRlRNTVVfRlVaWl9SVUxFUyk6IGNvbmZp
Zy1hbGwtZGV2aWNlcy5tYWsKKyQoU09GVE1NVV9GVVpaX1JVTEVTKTogJChlZGsyLWRlY29tcHJl
c3NlZCkKKwogLlBIT05ZOiAkKFRBUkdFVF9ESVJTX1JVTEVTKQogIyBUaGUgJChUQVJHRVRfRElS
U19SVUxFUykgYXJlIG9mIHRoZSBmb3JtIFNVQkRJUi9HT0FMLCBzbyB0aGF0CiAjICQoZGlyICRA
KSB5aWVsZHMgdGhlIHN1Yi1kaXJlY3RvcnksIGFuZCAkKG5vdGRpciAkQCkgeWllbGRzIHRoZSBz
dWItZ29hbApAQCAtNTQwLDYgKzU0OSw5IEBAIHN1YmRpci1zbGlycDogc2xpcnAvYWxsCiAkKGZp
bHRlciAlL2FsbCwgJChUQVJHRVRfRElSU19SVUxFUykpOiBsaWJxZW11dXRpbC5hICQoY29tbW9u
LW9iai15KSBcCiAJJChxb20tb2JqLXkpCiAKKyQoZmlsdGVyICUvZnV6eiwgJChUQVJHRVRfRElS
U19SVUxFUykpOiBsaWJxZW11dXRpbC5hICQoY29tbW9uLW9iai15KSBcCisJJChxb20tb2JqLXkp
ICQoY3J5cHRvLXVzZXItb2JqLSQoQ09ORklHX1VTRVJfT05MWSkpCisKIFJPTV9ESVJTID0gJChh
ZGRwcmVmaXggcGMtYmlvcy8sICQoUk9NUykpCiBST01fRElSU19SVUxFUz0kKGZvcmVhY2ggdCwg
YWxsIGNsZWFuLCAkKGFkZHN1ZmZpeCAvJCh0KSwgJChST01fRElSUykpKQogIyBPbmx5IGtlZXAg
LU8gYW5kIC1nIGNmbGFncwpAQCAtNTQ5LDYgKzU2MSw3IEBAICQoUk9NX0RJUlNfUlVMRVMpOgog
CiAuUEhPTlk6IHJlY3Vyc2UtYWxsIHJlY3Vyc2UtY2xlYW4gcmVjdXJzZS1pbnN0YWxsCiByZWN1
cnNlLWFsbDogJChhZGRzdWZmaXggL2FsbCwgJChUQVJHRVRfRElSUykgJChST01fRElSUykpCity
ZWN1cnNlLWZ1eno6ICQoYWRkc3VmZml4IC9mdXp6LCAkKFRBUkdFVF9ESVJTKSAkKFJPTV9ESVJT
KSkKIHJlY3Vyc2UtY2xlYW46ICQoYWRkc3VmZml4IC9jbGVhbiwgJChUQVJHRVRfRElSUykgJChS
T01fRElSUykpCiByZWN1cnNlLWluc3RhbGw6ICQoYWRkc3VmZml4IC9pbnN0YWxsLCAkKFRBUkdF
VF9ESVJTKSkKICQoYWRkc3VmZml4IC9pbnN0YWxsLCAkKFRBUkdFVF9ESVJTKSk6IGFsbApkaWZm
IC0tZ2l0IGEvTWFrZWZpbGUudGFyZ2V0IGIvTWFrZWZpbGUudGFyZ2V0CmluZGV4IDZmNGRkNzIw
MjIuLjJkNDNkYzU4NmEgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlLnRhcmdldAorKysgYi9NYWtlZmls
ZS50YXJnZXQKQEAgLTIyOCw2ICsyMjgsMjIgQEAgaWZkZWYgQ09ORklHX1RSQUNFX1NZU1RFTVRB
UAogCXJtIC1mICouc3RwCiBlbmRpZgogCitpZmRlZiBDT05GSUdfRlVaWgoraW5jbHVkZSAkKFNS
Q19QQVRIKS90ZXN0cy9xdGVzdC9mdXp6L01ha2VmaWxlLmluY2x1ZGUKK2luY2x1ZGUgJChTUkNf
UEFUSCkvdGVzdHMvcXRlc3QvTWFrZWZpbGUuaW5jbHVkZQorCitmdXp6OiBmdXp6LXZhcnMKK2Z1
enotdmFyczogUUVNVV9DRkxBR1MgOj0gJChGVVpaX0NGTEFHUykgJChRRU1VX0NGTEFHUykKK2Z1
enotdmFyczogUUVNVV9MREZMQUdTIDo9ICQoRlVaWl9MREZMQUdTKSAkKFFFTVVfTERGTEFHUykK
K2Z1enotdmFyczogJChRRU1VX1BST0dfRlVaWikKK2R1bW15IDo9ICQoY2FsbCB1bm5lc3QtdmFy
cywsIGZ1enotb2JqLXkpCisKKworJChRRU1VX1BST0dfRlVaWik6IGNvbmZpZy1kZXZpY2VzLm1h
ayAkKGFsbC1vYmoteSkgJChDT01NT05fTERBRERTKSAkKGZ1enotb2JqLXkpCisJJChjYWxsIExJ
TkssICQoZmlsdGVyLW91dCAlLm1haywgJF4pKQorCitlbmRpZgorCiBpbnN0YWxsOiBhbGwKIGlm
bmVxICgkKFBST0dTKSwpCiAJJChjYWxsIGluc3RhbGwtcHJvZywkKFBST0dTKSwkKERFU1RESVIp
JChiaW5kaXIpKQotLSAKMi4yNC4xCgo=


