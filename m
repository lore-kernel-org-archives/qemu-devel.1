Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0435DC4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7F7206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYuOtlqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7F7206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGShT-0004hD-SY
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 15:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jGSgU-0003hN-Qv
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jGSgT-0001cK-RB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:24:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56298)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jGSgT-0001c9-O4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584991465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4s9LGGuC/cUwoE8l6+Ov3NKbGn1km2smFBRw5GZuuZA=;
 b=ZYuOtlqKugFOUXNQRlntTNpwcRB9c5iXteVbgwNo3aoOLvOMnWK/WLU/+ZO+S8z8aSZGqo
 GSsM3B9SkBvM/sKEOEE1eYTa9w0Hi3DlKrLF0/JPo75pY6nPjpOda8jbDHAZyfV+HykEv7
 oivUuH5uxY3/V+7RRkCvGSGSaY0Qovc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-2gLJLbhmNAqJA6lBpao4pg-1; Mon, 23 Mar 2020 15:24:23 -0400
X-MC-Unique: 2gLJLbhmNAqJA6lBpao4pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E77D800D4E;
 Mon, 23 Mar 2020 19:24:22 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C87249B937;
 Mon, 23 Mar 2020 19:24:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 1/1] aio-posix: fix io_uring with external events
Date: Mon, 23 Mar 2020 19:24:11 +0000
Message-Id: <20200323192411.325247-2-stefanha@redhat.com>
In-Reply-To: <20200323192411.325247-1-stefanha@redhat.com>
References: <20200323192411.325247-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2hlbiBleHRlcm5hbCBldmVudCBzb3VyY2VzIGFyZSBkaXNhYmxlZCBmZG1vbi1pb191cmluZyBm
YWxscyBiYWNrIHRvCmZkbW9uLXBvbGwuICBUaGUgLT5uZWVkX3dhaXQoKSBjYWxsYmFjayBuZWVk
cyB0byB3YXRjaCBmb3IgdGhpcyBzbyBpdApjYW4gcmV0dXJuIHRydWUgd2hlbiBleHRlcm5hbCBl
dmVudCBzb3VyY2VzIGFyZSBkaXNhYmxlZC4KCkl0IGlzIGFsc28gbmVjZXNzYXJ5IHRvIGNhbGwg
LT53YWl0KCkgd2hlbiBBaW9IYW5kbGVycyBoYXZlIGNoYW5nZWQKYmVjYXVzZSBpb191cmluZyBp
cyBhc3luY2hyb25vdXMgYW5kIHdlIG11c3Qgc3VibWl0IG5ldyBzcWVzLgoKQm90aCBvZiB0aGVz
ZSBjaGFuZ2VzIHRvIC0+bmVlZF93YWl0KCkgdG9nZXRoZXIgZml4IHRlc3RzL3Rlc3QtYWlvIC1w
Ci9haW8vZXh0ZXJuYWwtY2xpZW50LCB3aGljaCBmYWlsZWQgd2l0aDoKCiAgdGVzdC1haW86IHRl
c3RzL3Rlc3QtYWlvLmM6NDA0OiB0ZXN0X2Fpb19leHRlcm5hbF9jbGllbnQ6IEFzc2VydGlvbiBg
YWlvX3BvbGwoY3R4LCBmYWxzZSknIGZhaWxlZC4KClJlcG9ydGVkLWJ5OiBKdWxpYSBTdXZvcm92
YSA8anVzdWFsQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3Rl
ZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnph
cmVAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDAzMTkxNjM1NTkuMTE3OTAzLTEtc3RlZmFu
aGFAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJl
ZGhhdC5jb20+Ci0tLQogdXRpbC9mZG1vbi1pb191cmluZy5jIHwgMTMgKysrKysrKysrKysrLQog
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS91dGlsL2ZkbW9uLWlvX3VyaW5nLmMgYi91dGlsL2ZkbW9uLWlvX3VyaW5nLmMKaW5kZXgg
ODkzYjc5YjYyMi4uN2UxNDNlZjUxNSAxMDA2NDQKLS0tIGEvdXRpbC9mZG1vbi1pb191cmluZy5j
CisrKyBiL3V0aWwvZmRtb24taW9fdXJpbmcuYwpAQCAtMjkwLDcgKzI5MCwxOCBAQCBzdGF0aWMg
aW50IGZkbW9uX2lvX3VyaW5nX3dhaXQoQWlvQ29udGV4dCAqY3R4LCBBaW9IYW5kbGVyTGlzdCAq
cmVhZHlfbGlzdCwKIAogc3RhdGljIGJvb2wgZmRtb25faW9fdXJpbmdfbmVlZF93YWl0KEFpb0Nv
bnRleHQgKmN0eCkKIHsKLSAgICByZXR1cm4gaW9fdXJpbmdfY3FfcmVhZHkoJmN0eC0+ZmRtb25f
aW9fdXJpbmcpOworICAgIC8qIEhhdmUgaW9fdXJpbmcgZXZlbnRzIGNvbXBsZXRlZD8gKi8KKyAg
ICBpZiAoaW9fdXJpbmdfY3FfcmVhZHkoJmN0eC0+ZmRtb25faW9fdXJpbmcpKSB7CisgICAgICAg
IHJldHVybiB0cnVlOworICAgIH0KKworICAgIC8qIERvIHdlIG5lZWQgdG8gc3VibWl0IG5ldyBp
b191cmluZyBzcWVzPyAqLworICAgIGlmICghUVNMSVNUX0VNUFRZX1JDVSgmY3R4LT5zdWJtaXRf
bGlzdCkpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorCisgICAgLyogQXJlIHdlIGZh
bGxpbmcgYmFjayB0byBmZG1vbi1wb2xsPyAqLworICAgIHJldHVybiBhdG9taWNfcmVhZCgmY3R4
LT5leHRlcm5hbF9kaXNhYmxlX2NudCk7CiB9CiAKIHN0YXRpYyBjb25zdCBGRE1vbk9wcyBmZG1v
bl9pb191cmluZ19vcHMgPSB7Ci0tIAoyLjI0LjEKCg==


