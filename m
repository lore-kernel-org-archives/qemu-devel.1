Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B4BC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30744215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PjfkA0Ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30744215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEy2v-00022f-T8
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iExtM-00025A-5N
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iExtC-0005ia-SQ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:47:09 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:40190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iExtB-0005Xr-7Q
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1569858414;
 bh=NWvdhfIMuQVKkYna2RswJx4UdS0vPCQdWU2W4dQE0Vw=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=PjfkA0OvxftV095lcDP1J8rJG8cwMFraBeEKEagdAloO4mwuRsNO/ChCQi1swLSYJ
 q+RzctYS4/O7Pbo6lQ0sdPx4S6wwe2PdIoID+393DjOdYnqk2JPT3KdmhRXRrFYSoG
 mhhghIIboFDX48qH3QmT5TgyXn01kpayce8T9PUE=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 114.254.179.216
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1569858412t436917
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: gdbstub and gbd segfaults on different instructions in user space
 emulation
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Mon, 30 Sep 2019 23:46:52 +0800
X-Priority: 3
Message-ID: <tencent_363C13D92BFF319155906E6B@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Mon, 30 Sep 2019 23:46:53 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 52.59.177.22
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgYWxsLAoKSSBhbSBlbmNvdW50ZXJpbmcgc2VnbWVudGF0aW9uIGZhdWx0IHdoaWxlIHBv
cnRpbmcgbXkgY3VzdG9tIElTQSB0byBRRU1VLiBNeSBjdXN0b20gSVNBIGlzIFZFUlkgVkVS
WSBzaW1wbGUsIGl0IG9ubHkgY2hhbmdlcyB0aGUgWzMxOjI2XSBvcGNvZGUgZmllbGQgb2Yg
TFcgYW5kIFNXIGluc3RydWN0aW9ucy4gVGhlIGxpbmsgaGFzIG15IHZlcnkgc2ltcGxlIGlt
cGxlbWVudGF0aW9uOiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUt
ZGV2ZWwvMjAxOS0wOS9tc2cwNjk3Ni5odG1sCgpCZWxvdyBpcyB0aGUgb2JqZHVtcCBvZiB0
aGUgbWFpbiBwYXJ0IG9mIG15IHNpbXBsZSBFTEYuIFRoZSBkb3RzIGFyZSB0aGUgYXV0b21h
dGljYWxseSBnZW5lcmF0ZWQgbm9wJ3MgYnkgdGhlIGNvbXBpbGVyLgowMDQwMDA5MCA8bWFp
bj46CiAgNDAwMDkwOgkyM2JkZmZlMCAgICBhZGRpICAgIHIyOSxyMjksLTMyCiAgNDAwMDk0
Ogk3ZmJlMDAxYyAgICBzdyAgICByMzAsMjgocjI5LgoJLi4uCiAgNDAwMGEwOgkwM2EwZjAy
MSAgICBhZGR1ICAgIHIzMCxyMjkscjAKICA0MDAwYTQ6CTIwMDIwMDAxICAgIGxpICAgIHIy
LDEgICAgIyBpbnQgYSA9IDE7CiAgNDAwMGE4Ogk3ZmMyMDAxMCAgICBzdyAgICByMiwxNihy
MzApCgkuLi4KICA0MDAwYjQ6CTIwMDIwMDAyICAgIGxpICAgIHIyLDIgICAgIyBpbnQgYiA9
IDI7CiAgNDAwMGI4Ogk3ZmMyMDAwYyAgICBzdyAgICByMiwxMihyMzApCgkuLi4KICA0MDAw
YzQ6CTVmYzMwMDEwICAgIGx3ICAgIHIzLDE2KHIzMCkKICA0MDAwYzg6CTAwMDAwMDAwICAg
IG5vcAogIDQwMDBjYzoJNWZjMjAwMGMgICAgbHcgICAgcjIsMTIocjMwKQoJLi4uCiAgNDAw
MGQ4OgkwMDYyMTAyMCAgICBhZGQgICAgcjIscjMscjIgICAgIyBpbnQgYyA9IGEgKyBiOwog
IDQwMDBkYzoJN2ZjMjAwMDggICAgc3cgICAgcjIsOChyMzApCgkuLi4KICA0MDAwZTg6CTAw
MDAxMDIxICAgIGFkZHUgICAgcjIscjAscjAKICA0MDAwZWM6CTAzYzBlODIxICAgIGFkZHUg
ICAgcjI5LHIzMCxyMAogIDQwMDBmMDoJNWZiZTAwMWMgICAgbHcgICAgcjMwLDI4KHIyOSkK
ICA0MDAwZjQ6CTIzYmQwMDIwICAgIGFkZGkgICAgcjI5LHIyOSwzMgogIDQwMDBmODoJMDNl
MDAwMDggICAganIgICAgcjMxCiAgNDAwMGZjOgkwMDAwMDAwMCAgICBub3AKCS4uLgoKVGhl
IGNvZGUgYmVsb3cgZ2l2ZXMgbWUgc2VnZmF1bHQ6CiQgLi9xZW11LW1pcHNlbCAtY3B1IG15
Y3B1IHRlc3Rwcm9ncmFtCgpJIGhhdmUgdHJpZWQgMiB3YXlzIG9mIGRlYnVnZ2luZyBpdC4K
Rmlyc3RseSwgSSBjb25uZWN0ZWQgZ2RiLW11bHRpYXJjaCB0byBnZGJzdHViLCBhbmQgSSBz
aW5nbGUtc3RlcHBlZCB0aGUgaW5zdHJ1Y3Rpb25zIGluIG15IEVMRi4gSW1tZWRpYXRlbHkg
YWZ0ZXIgdGhlIExXIGluc3RydWN0aW9uLCB0aGUgc2VnZmF1bHQgd2FzIHRocm93bi4gSSBv
YnNlcnZlZCB0aGUgbWVtb3J5IGxvY2F0aW9uIHVzaW5nICd4JyBjb21tYW5kIGFuZCBmb3Vu
ZCB0aGF0IGF0IGxlYXN0IG15IFNXIGluc3RydWN0aW9uIHdhcyBpbXBsZW1lbnRlZCBjb3Jy
ZWN0bHkuClNlY29uZGx5LCBJIHVzZWQgZ2RiIHRvIGRpcmVjdGx5IGRlYnVnIFFFTVUuIEkg
c2V0IHRoZSBicmVha3BvaW50IGF0IGZ1bmN0aW9uIGluIHRyYW5zbGF0ZS5jOmRlY29kZV9v
cGMuIFByZXNzaW5nICdjJyBzaG91bGQgaGF2ZSB0aGUgc2FtZSBlZmZlY3QgYXMgc2luZ2xl
LXN0ZXBwaW5nIGluc3RydWN0aW9uIGluIGdkYnN0dWIuIEhvd2V2ZXIsIHRoZSBzZWdtZW50
YXRpb24gZmF1bHQgd2Fzbid0IHRocm93biBhZnRlciBMVy4gSXQgd2FzIGluc3RlYWQgdGhy
b3duIGFmdGVyIHRoZSAnbm9wJyBhZnRlciAnanIgcjMxJyBpbiB0aGUgb2JqZHVtcC4KCkF0
IHRoaXMgcG9pbnQsIEkgYW0gcmVhbGx5IHN0dWNrLiBJIGhhdmUgc3BlbnQgYSBsb25nIHRp
bWUgb24gdGhpcywgYnV0IEkganVzdCBjYW4ndCBmaWd1cmUgb3V0IHdoYXQgaXMgZ29pbmcg
d3JvbmcgaGVyZS4gSWYgYW55b25lIGNhbiBoZWxwIG1lIG91dCBJIHdvdWxkIHJlYWxseSBh
cHByZWNpYXRlIGl0LgoKQ2hlZXJzLApMaWJvIFpob3U=




