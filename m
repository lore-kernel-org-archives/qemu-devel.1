Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F098C35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFD22071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2Yozynz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFD22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Qi7-0004Lk-Hg
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 04:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QZ7-0004Wq-VG
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QZ6-0003KH-F3
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:55:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QZ6-0003Ip-47
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MSZTLmaYG+qK9vL/bTHVoYFnsI9tYJib4ryVsYq5XL0=;
 b=V2YozynzFGQlvoVH3XBl070ZUdhAMPj5Nz3MUSEI+MhAD3lQhAgP9txwGdz4eY0oFZWtIk
 myrpUjwPaACvH/D//WLUNIjaSh5/KY2MAaC7najYEEXaOgCnhm2iB9R/qt6Ng8p0L5+zGg
 mpdSR4JnwdRK0+7DYjkMWD8oxiSmz3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-uhKdeQRPOa6O2q-yKkZX0g-1; Sat, 22 Feb 2020 03:55:07 -0500
X-MC-Unique: uhKdeQRPOa6O2q-yKkZX0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F2D78017CC;
 Sat, 22 Feb 2020 08:55:06 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 784931001B07;
 Sat, 22 Feb 2020 08:54:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/31] fuzz: support for fork-based fuzzing.
Date: Sat, 22 Feb 2020 08:50:23 +0000
Message-Id: <20200222085030.1760640-25-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+Cgpmb3JrKCkgaXMgYSBzaW1w
bGUgd2F5IHRvIGVuc3VyZSB0aGF0IHN0YXRlIGRvZXMgbm90IGxlYWsgaW4gYmV0d2VlbgpmdXp6
aW5nIHJ1bnMuIFVuZm9ydHVuYXRlbHksIHRoZSBmdXp6ZXIgbXV0YXRpb24gZW5naW5lIHJlbGll
cyBvbgpiaXRtYXBzIHdoaWNoIGNvbnRhaW4gY292ZXJhZ2UgaW5mb3JtYXRpb24gZm9yIGVhY2gg
ZnV6emluZyBydW4sIGFuZAp0aGVzZSBiaXRtYXBzIHNob3VsZCBiZSBjb3BpZWQgZnJvbSB0aGUg
Y2hpbGQgdG8gdGhlIHBhcmVudCh3aGVyZSB0aGUKbXV0YXRpb24gb2NjdXJzKS4gVGhlc2UgYml0
bWFwcyBhcmUgY3JlYXRlZCB0aHJvdWdoIGNvbXBpbGUtdGltZQppbnN0cnVtZW50YXRpb24gYW5k
IHRoZXkgYXJlIG5vdCBzaGFyZWQgd2l0aCBmb3JrKCktZWQgcHJvY2Vzc2VzLCBieQpkZWZhdWx0
LiBUbyBhZGRyZXNzIHRoaXMsIHdlIGNyZWF0ZSBhIHNoYXJlZCBtZW1vcnkgcmVnaW9uLCBhZGp1
c3QgaXRzCnNpemUgYW5kIG1hcCBpdCBfb3Zlcl8gdGhlIGNvdW50ZXIgcmVnaW9uLiBGdXJ0aGVy
bW9yZSwgbGliZnV6emVyCmRvZXNuJ3QgZ2VuZXJhbGx5IGV4cG9zZSB0aGUgZ2xvYmFscyB0aGF0
IHNwZWNpZnkgdGhlIGxvY2F0aW9uIG9mIHRoZQpjb3VudGVycy9jb3ZlcmFnZSBiaXRtYXAuIEFz
IGEgd29ya2Fyb3VuZCwgd2UgcmVseSBvbiBhIGN1c3RvbSBsaW5rZXIKc2NyaXB0IHdoaWNoIGZv
cmNlcyBhbGwgb2YgdGhlIGJpdG1hcHMgd2UgY2FyZSBhYm91dCB0byBiZSBwbGFjZWQgaW4gYQpj
b250aWd1b3VzIHJlZ2lvbiwgd2hpY2ggaXMgZWFzeSB0byBsb2NhdGUgYW5kIG1tYXAgb3Zlci4K
ClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBCdWxla292IDxhbHhuZHJAYnUuZWR1PgpSZXZpZXdl
ZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTog
RGFycmVuIEtlbm55IDxkYXJyZW4ua2VubnlAb3JhY2xlLmNvbT4KTWVzc2FnZS1pZDogMjAyMDAy
MjAwNDExMTguMjMyNjQtMTYtYWx4bmRyQGJ1LmVkdQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdGVzdHMvcXRlc3QvZnV6ei9NYWtlZmls
ZS5pbmNsdWRlIHwgIDUgKysrCiB0ZXN0cy9xdGVzdC9mdXp6L2ZvcmtfZnV6ei5jICAgICAgfCA1
NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy9xdGVzdC9mdXp6L2Zvcmtf
ZnV6ei5oICAgICAgfCAyMyArKysrKysrKysrKysrCiB0ZXN0cy9xdGVzdC9mdXp6L2ZvcmtfZnV6
ei5sZCAgICAgfCAzNyArKysrKysrKysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgMTIw
IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9mdXp6L2Zvcmtf
ZnV6ei5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvZnV6ei9mb3JrX2Z1enouaAog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmxkCgpkaWZmIC0t
Z2l0IGEvdGVzdHMvcXRlc3QvZnV6ei9NYWtlZmlsZS5pbmNsdWRlIGIvdGVzdHMvcXRlc3QvZnV6
ei9NYWtlZmlsZS5pbmNsdWRlCmluZGV4IDg2MzJiYjg5ZjQuLmE5MDkxNWQ1NmQgMTAwNjQ0Ci0t
LSBhL3Rlc3RzL3F0ZXN0L2Z1enovTWFrZWZpbGUuaW5jbHVkZQorKysgYi90ZXN0cy9xdGVzdC9m
dXp6L01ha2VmaWxlLmluY2x1ZGUKQEAgLTIsNSArMiwxMCBAQCBRRU1VX1BST0dfRlVaWj1xZW11
LWZ1enotJChUQVJHRVRfTkFNRSkkKEVYRVNVRikKIAogZnV6ei1vYmoteSArPSB0ZXN0cy9xdGVz
dC9saWJxdGVzdC5vCiBmdXp6LW9iai15ICs9IHRlc3RzL3F0ZXN0L2Z1enovZnV6ei5vICMgRnV6
emVyIHNrZWxldG9uCitmdXp6LW9iai15ICs9IHRlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6Lm8K
IAogRlVaWl9DRkxBR1MgKz0gLUkkKFNSQ19QQVRIKS90ZXN0cyAtSSQoU1JDX1BBVEgpL3Rlc3Rz
L3F0ZXN0CisKKyMgTGlua2VyIFNjcmlwdCB0byBmb3JjZSBjb3ZlcmFnZS1jb3VudGVycyBpbnRv
IGtub3duIHJlZ2lvbnMgd2hpY2ggd2UgY2FuIG1hcmsKKyMgc2hhcmVkCitGVVpaX0xERkxBR1Mg
Kz0gLVhsaW5rZXIgLVQkKFNSQ19QQVRIKS90ZXN0cy9xdGVzdC9mdXp6L2ZvcmtfZnV6ei5sZApk
aWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvZnV6ei9mb3JrX2Z1enouYyBiL3Rlc3RzL3F0ZXN0L2Z1
enovZm9ya19mdXp6LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uMmJk
MDg1MTkwMwotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmMK
QEAgLTAsMCArMSw1NSBAQAorLyoKKyAqIEZvcmstYmFzZWQgZnV6emluZyBoZWxwZXJzCisgKgor
ICogQ29weXJpZ2h0IFJlZCBIYXQgSW5jLiwgMjAxOQorICoKKyAqIEF1dGhvcnM6CisgKiAgQWxl
eGFuZGVyIEJ1bGVrb3YgICA8YWx4bmRyQGJ1LmVkdT4KKyAqCisgKiBUaGlzIHdvcmsgaXMgbGlj
ZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR1BMLCB2ZXJzaW9uIDIgb3IgbGF0ZXIu
CisgKiBTZWUgdGhlIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4KKyAq
CisgKi8KKworI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJmb3JrX2Z1enouaCIK
KworCit2b2lkIGNvdW50ZXJfc2htX2luaXQodm9pZCkKK3sKKyAgICBjaGFyICpzaG1fcGF0aCA9
IGdfc3RyZHVwX3ByaW50ZigiL3FlbXUtZnV6ei1jbnRycy4lZCIsIGdldHBpZCgpKTsKKyAgICBp
bnQgZmQgPSBzaG1fb3BlbihzaG1fcGF0aCwgT19DUkVBVCB8IE9fUkRXUiwgU19JUlVTUiB8IFNf
SVdVU1IpOworICAgIGdfZnJlZShzaG1fcGF0aCk7CisKKyAgICBpZiAoZmQgPT0gLTEpIHsKKyAg
ICAgICAgcGVycm9yKCJFcnJvcjogIik7CisgICAgICAgIGV4aXQoMSk7CisgICAgfQorICAgIGlm
IChmdHJ1bmNhdGUoZmQsICZfX0ZVWlpfQ09VTlRFUlNfRU5EIC0gJl9fRlVaWl9DT1VOVEVSU19T
VEFSVCkgPT0gLTEpIHsKKyAgICAgICAgcGVycm9yKCJFcnJvcjogIik7CisgICAgICAgIGV4aXQo
MSk7CisgICAgfQorICAgIC8qIENvcHkgd2hhdCdzIGluIHRoZSBjb3VudGVyIHJlZ2lvbiB0byB0
aGUgc2htLi4gKi8KKyAgICB2b2lkICpycHRyID0gbW1hcChOVUxMICwKKyAgICAgICAgICAgICZf
X0ZVWlpfQ09VTlRFUlNfRU5EIC0gJl9fRlVaWl9DT1VOVEVSU19TVEFSVCwKKyAgICAgICAgICAg
IFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIE1BUF9TSEFSRUQsIGZkLCAwKTsKKyAgICBtZW1jcHko
cnB0ciwKKyAgICAgICAgICAgJl9fRlVaWl9DT1VOVEVSU19TVEFSVCwKKyAgICAgICAgICAgJl9f
RlVaWl9DT1VOVEVSU19FTkQgLSAmX19GVVpaX0NPVU5URVJTX1NUQVJUKTsKKworICAgIG11bm1h
cChycHRyLCAmX19GVVpaX0NPVU5URVJTX0VORCAtICZfX0ZVWlpfQ09VTlRFUlNfU1RBUlQpOwor
CisgICAgLyogQW5kIG1hcCB0aGUgc2htIG92ZXIgdGhlIGNvdW50ZXIgcmVnaW9uICovCisgICAg
cnB0ciA9IG1tYXAoJl9fRlVaWl9DT1VOVEVSU19TVEFSVCwKKyAgICAgICAgICAgICZfX0ZVWlpf
Q09VTlRFUlNfRU5EIC0gJl9fRlVaWl9DT1VOVEVSU19TVEFSVCwKKyAgICAgICAgICAgIFBST1Rf
UkVBRCB8IFBST1RfV1JJVEUsIE1BUF9TSEFSRUQgfCBNQVBfRklYRUQsIGZkLCAwKTsKKworICAg
IGNsb3NlKGZkKTsKKworICAgIGlmICghcnB0cikgeworICAgICAgICBwZXJyb3IoIkVycm9yOiAi
KTsKKyAgICAgICAgZXhpdCgxKTsKKyAgICB9Cit9CisKKwpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRl
c3QvZnV6ei9mb3JrX2Z1enouaCBiL3Rlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmgKbmV3IGZp
bGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uOWVjYjhiNThlZgotLS0gL2Rldi9udWxs
CisrKyBiL3Rlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmgKQEAgLTAsMCArMSwyMyBAQAorLyoK
KyAqIEZvcmstYmFzZWQgZnV6emluZyBoZWxwZXJzCisgKgorICogQ29weXJpZ2h0IFJlZCBIYXQg
SW5jLiwgMjAxOQorICoKKyAqIEF1dGhvcnM6CisgKiAgQWxleGFuZGVyIEJ1bGVrb3YgICA8YWx4
bmRyQGJ1LmVkdT4KKyAqCisgKiBUaGlzIHdvcmsgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR1BMLCB2ZXJzaW9uIDIgb3IgbGF0ZXIuCisgKiBTZWUgdGhlIENPUFlJTkcg
ZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4KKyAqCisgKi8KKworI2lmbmRlZiBGT1JL
X0ZVWlpfSAorI2RlZmluZSBGT1JLX0ZVWlpfSAorCitleHRlcm4gdWludDhfdCBfX0ZVWlpfQ09V
TlRFUlNfU1RBUlQ7CitleHRlcm4gdWludDhfdCBfX0ZVWlpfQ09VTlRFUlNfRU5EOworCit2b2lk
IGNvdW50ZXJfc2htX2luaXQodm9pZCk7CisKKyNlbmRpZgorCmRpZmYgLS1naXQgYS90ZXN0cy9x
dGVzdC9mdXp6L2ZvcmtfZnV6ei5sZCBiL3Rlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmxkCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAuLmIyM2E1OWYxOTQKLS0tIC9kZXYv
bnVsbAorKysgYi90ZXN0cy9xdGVzdC9mdXp6L2ZvcmtfZnV6ei5sZApAQCAtMCwwICsxLDM3IEBA
CisvKiBXZSBhZGp1c3QgbGlua2VyIHNjcmlwdCBtb2RpZmljYXRpb24gdG8gcGxhY2UgYWxsIG9m
IHRoZSBzdHVmZiB0aGF0IG5lZWRzIHRvCisgKiBwZXJzaXN0IGFjcm9zcyBmdXp6aW5nIHJ1bnMg
aW50byBhIGNvbnRpZ3VvdXMgc2VjaXRvbiBvZiBtZW1vcnkuIFRoZW4sIGl0IGlzCisgKiBlYXN5
IHRvIHJlLW1hcCB0aGUgY291bnRlci1yZWxhdGVkIG1lbW9yeSBhcyBzaGFyZWQuCisqLworCitT
RUNUSU9OUworeworICAuZGF0YS5mdXp6X3N0YXJ0IDogQUxJR04oNEspCisgIHsKKyAgICAgIF9f
RlVaWl9DT1VOVEVSU19TVEFSVCA9IC47CisgICAgICBfX3N0YXJ0X19fc2FuY292X2NudHJzID0g
LjsKKyAgICAgICooXypzYW5jb3ZfY250cnMpOworICAgICAgX19zdG9wX19fc2FuY292X2NudHJz
ID0gLjsKKworICAgICAgLyogTG93ZXN0IHN0YWNrIGNvdW50ZXIgKi8KKyAgICAgICooX19zYW5j
b3ZfbG93ZXN0X3N0YWNrKTsKKyAgfQorICAuZGF0YS5mdXp6X29yZGVyZWQgOgorICB7CisgICAg
ICAvKiBDb3ZlcmFnZSBjb3VudGVycy4gVGhleSdyZSBub3QgbmVjZXNzYXJ5IGZvciBmdXp6aW5n
LCBidXQgYXJlIHVzZWZ1bAorICAgICAgICogZm9yIGFuYWx5emluZyB0aGUgZnV6emluZyBwZXJm
b3JtYW5jZQorICAgICAgICovCisgICAgICBfX3N0YXJ0X19fbGx2bV9wcmZfY250cyA9IC47Cisg
ICAgICAqKCpsbHZtX3ByZl9jbnRzKTsKKyAgICAgIF9fc3RvcF9fX2xsdm1fcHJmX2NudHMgPSAu
OworCisgICAgICAvKiBJbnRlcm5hbCBMaWJmdXp6ZXIgVHJhY2VQQyBvYmplY3Qgd2hpY2ggY29u
dGFpbnMgdGhlIFZhbHVlUHJvZmlsZU1hcCAqLworICAgICAgRnV6emVyVHJhY2VQQyooLmJzcyop
OworICB9CisgIC5kYXRhLmZ1enpfZW5kIDogQUxJR04oNEspCisgIHsKKyAgICAgIF9fRlVaWl9D
T1VOVEVSU19FTkQgPSAuOworICB9Cit9CisvKiBEb250IG92ZXJ3cml0ZSB0aGUgU0VDVElPTlMg
aW4gdGhlIGRlZmF1bHQgbGlua2VyIHNjcmlwdC4gSW5zdGVhZCBpbnNlcnQgdGhlCisgKiBhYm92
ZSBpbnRvIHRoZSBkZWZhdWx0IHNjcmlwdCAqLworSU5TRVJUIEFGVEVSIC5kYXRhOwotLSAKMi4y
NC4xCgo=


