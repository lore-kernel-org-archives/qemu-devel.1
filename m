Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06956C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C673D2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERNQKaO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C673D2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP7iu-0008CH-Sf
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 12:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jP7hg-0006g1-PI
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jP7hf-0000IN-MW
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:49:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jP7hf-0000Ee-J5
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587055765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZbd1wkLddIQWvgwrrzUlnRVaKwv8Al0ckS8kzN+P3s=;
 b=ERNQKaO8GdCybNTIzLiBWBniegHwRJcXBIprTI0Eu7OOdGMlhd9HUDSphr1YX+95INZ8m0
 V+MSuYjJjLKglHPpgNvrGJX2ExmN+MjyJQKG/irzNa0gokxWmbeJLIF2iDq14msooVLS7U
 SpCzHqEuS5PzkXg1Jpl3ewVOKA4XIZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-QD5d7MkdNyeKHbZO96_yzA-1; Thu, 16 Apr 2020 12:49:23 -0400
X-MC-Unique: QD5d7MkdNyeKHbZO96_yzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D38B108839B
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 16:49:22 +0000 (UTC)
Received: from localhost (ovpn-114-223.ams2.redhat.com [10.36.114.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 930CC5D9E2;
 Thu, 16 Apr 2020 16:49:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] virtiofsd: only retain file system capabilities
Date: Thu, 16 Apr 2020 17:49:06 +0100
Message-Id: <20200416164907.244868-2-stefanha@redhat.com>
In-Reply-To: <20200416164907.244868-1-stefanha@redhat.com>
References: <20200416164907.244868-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dmlydGlvZnNkIHJ1bnMgYXMgcm9vdCBidXQgb25seSBuZWVkcyBhIHN1YnNldCBvZiByb290J3Mg
TGludXgKY2FwYWJpbGl0aWVzKDcpLiAgQXMgYSBmaWxlIHNlcnZlciBpdHMgcHVycG9zZSBpcyB0
byBjcmVhdGUgYW5kIGFjY2VzcwpmaWxlcyBvbiBiZWhhbGYgb2YgYSBjbGllbnQuICBJdCBuZWVk
cyB0byBiZSBhYmxlIHRvIGFjY2VzcyBmaWxlcyB3aXRoCmFyYml0cmFyeSB1aWQvZ2lkIG93bmVy
cy4gIEl0IGFsc28gbmVlZHMgdG8gYmUgY3JlYXRlIGRldmljZSBub2Rlcy4KCkludHJvZHVjZSBh
IExpbnV4IGNhcGFiaWxpdGllcyg3KSB3aGl0ZWxpc3QgYW5kIGRyb3AgYWxsIGNhcGFiaWxpdGll
cwp0aGF0IHdlIGRvbid0IG5lZWQsIG1ha2luZyB0aGUgdmlydGlvZnNkIHByb2Nlc3MgbGVzcyBw
b3dlcmZ1bCB0aGFuIGEKcmVndWxhciB1aWQgcm9vdCBwcm9jZXNzLgoKICAjIGNhdCAvcHJvYy9Q
SUQvc3RhdHVzCiAgLi4uCiAgICAgICAgICBCZWZvcmUgICAgICAgICAgIEFmdGVyCiAgQ2FwSW5o
OiAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAKICBDYXBQcm06IDAwMDAwMDNmZmZm
ZmZmZmYgMDAwMDAwMDA4ODAwMDBkZgogIENhcEVmZjogMDAwMDAwM2ZmZmZmZmZmZiAwMDAwMDAw
MDg4MDAwMGRmCiAgQ2FwQm5kOiAwMDAwMDAzZmZmZmZmZmZmIDAwMDAwMDAwMDAwMDAwMDAKICBD
YXBBbWI6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMAoKTm90ZSB0aGF0IGZpbGUg
Y2FwYWJpbGl0aWVzIGNhbm5vdCBiZSB1c2VkIHRvIGFjaGlldmUgdGhlIHNhbWUgZWZmZWN0IG9u
CnRoZSB2aXJ0aW9mc2QgZXhlY3V0YWJsZSBiZWNhdXNlIG1vdW50IGlzIHVzZWQgZHVyaW5nIHNh
bmRib3ggc2V0dXAuClRoZXJlZm9yZSB3ZSBkcm9wIGNhcGFiaWxpdGllcyBwcm9ncmFtbWF0aWNh
bGx5IGF0IHRoZSByaWdodCBwb2ludApkdXJpbmcgc3RhcnR1cC4KClRoaXMgcGF0Y2ggb25seSBh
ZmZlY3RzIHRoZSBzYW5kYm94ZWQgY2hpbGQgcHJvY2Vzcy4gIFRoZSBwYXJlbnQgcHJvY2Vzcwp0
aGF0IHNpdHMgaW4gd2FpdHBpZCgyKSBzdGlsbCBoYXMgZnVsbCByb290IGNhcGFiaWxpdGllcyBh
bmQgd2lsbCBiZQphZGRyZXNzZWQgaW4gdGhlIG5leHQgcGF0Y2guCgpTaWduZWQtb2ZmLWJ5OiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdG9vbHMvdmlydGlvZnNk
L3Bhc3N0aHJvdWdoX2xsLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90b29scy92aXJ0
aW9mc2QvcGFzc3Rocm91Z2hfbGwuYyBiL3Rvb2xzL3ZpcnRpb2ZzZC9wYXNzdGhyb3VnaF9sbC5j
CmluZGV4IDRjMzVjOTViMjUuLmFmOTdiYTFjNDEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3ZpcnRpb2Zz
ZC9wYXNzdGhyb3VnaF9sbC5jCisrKyBiL3Rvb2xzL3ZpcnRpb2ZzZC9wYXNzdGhyb3VnaF9sbC5j
CkBAIC0yNjk1LDYgKzI2OTUsNDMgQEAgc3RhdGljIHZvaWQgc2V0dXBfbW91bnRzKGNvbnN0IGNo
YXIgKnNvdXJjZSkKICAgICBjbG9zZShvbGRyb290KTsKIH0KIAorLyoKKyAqIE9ubHkga2VlcCB3
aGl0ZWxpc3RlZCBjYXBhYmlsaXRpZXMgdGhhdCBhcmUgbmVlZGVkIGZvciBmaWxlIHN5c3RlbSBv
cGVyYXRpb24KKyAqLworc3RhdGljIHZvaWQgc2V0dXBfY2FwYWJpbGl0aWVzKHZvaWQpCit7Cisg
ICAgcHRocmVhZF9tdXRleF9sb2NrKCZjYXAubXV0ZXgpOworICAgIGNhcG5nX3Jlc3RvcmVfc3Rh
dGUoJmNhcC5zYXZlZCk7CisKKyAgICAvKgorICAgICAqIFdoaXRlbGlzdCBmaWxlIHN5c3RlbS1y
ZWxhdGVkIGNhcGFiaWxpdGllcyB0aGF0IGFyZSBuZWVkZWQgZm9yIGEgZmlsZQorICAgICAqIHNl
cnZlciB0byBhY3QgbGlrZSByb290LiAgRHJvcCBldmVyeXRoaW5nIGVsc2UgbGlrZSBuZXR3b3Jr
aW5nIGFuZAorICAgICAqIHN5c2FkbWluIGNhcGFiaWxpdGllcy4KKyAgICAgKgorICAgICAqIEV4
Y2x1c2lvbnM6CisgICAgICogMS4gQ0FQX0xJTlVYX0lNTVVUQUJMRSBpcyBub3QgaW5jbHVkZWQg
YmVjYXVzZSBpdCdzIG9ubHkgdXNlZCB2aWEgaW9jdGwKKyAgICAgKiAgICBhbmQgd2UgZG9uJ3Qg
c3VwcG9ydCB0aGF0LgorICAgICAqIDIuIENBUF9NQUNfT1ZFUlJJREUgaXMgbm90IGluY2x1ZGVk
IGJlY2F1c2UgaXQgb25seSBzZWVtcyB0byBiZQorICAgICAqICAgIHVzZWQgYnkgdGhlIFNtYWNr
IExTTS4gIE9taXQgaXQgdW50aWwgdGhlcmUgaXMgZGVtYW5kIGZvciBpdC4KKyAgICAgKi8KKyAg
ICBjYXBuZ19zZXRwaWQoc3lzY2FsbChTWVNfZ2V0dGlkKSk7CisgICAgY2FwbmdfY2xlYXIoQ0FQ
TkdfU0VMRUNUX0JPVEgpOworICAgIGNhcG5nX3VwZGF0ZXYoQ0FQTkdfQURELCBDQVBOR19QRVJN
SVRURUQgfCBDQVBOR19FRkZFQ1RJVkUsCisgICAgICAgICAgICBDQVBfQ0hPV04sCisgICAgICAg
ICAgICBDQVBfREFDX09WRVJSSURFLAorICAgICAgICAgICAgQ0FQX0RBQ19SRUFEX1NFQVJDSCwK
KyAgICAgICAgICAgIENBUF9GT1dORVIsCisgICAgICAgICAgICBDQVBfRlNFVElELAorICAgICAg
ICAgICAgQ0FQX1NFVEdJRCwKKyAgICAgICAgICAgIENBUF9TRVRVSUQsCisgICAgICAgICAgICBD
QVBfTUtOT0QsCisgICAgICAgICAgICBDQVBfU0VURkNBUCk7CisgICAgY2FwbmdfYXBwbHkoQ0FQ
TkdfU0VMRUNUX0JPVEgpOworCisgICAgY2FwLnNhdmVkID0gY2Fwbmdfc2F2ZV9zdGF0ZSgpOwor
ICAgIHB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZjYXAubXV0ZXgpOworfQorCiAvKgogICogTG9jayBk
b3duIHRoaXMgcHJvY2VzcyB0byBwcmV2ZW50IGFjY2VzcyB0byBvdGhlciBwcm9jZXNzZXMgb3Ig
ZmlsZXMgb3V0c2lkZQogICogc291cmNlIGRpcmVjdG9yeS4gIFRoaXMgcmVkdWNlcyB0aGUgaW1w
YWN0IG9mIGFyYml0cmFyeSBjb2RlIGV4ZWN1dGlvbiBidWdzLgpAQCAtMjcwNSw2ICsyNzQyLDcg
QEAgc3RhdGljIHZvaWQgc2V0dXBfc2FuZGJveChzdHJ1Y3QgbG9fZGF0YSAqbG8sIHN0cnVjdCBm
dXNlX3Nlc3Npb24gKnNlLAogICAgIHNldHVwX25hbWVzcGFjZXMobG8sIHNlKTsKICAgICBzZXR1
cF9tb3VudHMobG8tPnNvdXJjZSk7CiAgICAgc2V0dXBfc2VjY29tcChlbmFibGVfc3lzbG9nKTsK
KyAgICBzZXR1cF9jYXBhYmlsaXRpZXMoKTsKIH0KIAogLyogUmFpc2UgdGhlIG1heGltdW0gbnVt
YmVyIG9mIG9wZW4gZmlsZSBkZXNjcmlwdG9ycyAqLwotLSAKMi4yNS4xCgo=


