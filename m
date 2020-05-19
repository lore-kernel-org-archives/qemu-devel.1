Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21044C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3B420829
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/E7ixHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3B420829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxKs-0007oh-5K
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxCa-0005NA-HC
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:02:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxCZ-0001fO-Ik
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589875334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bcHYPqsq6MA39QLNH+1X3Y7lyoM7eyT2Vqm5pRGwqM=;
 b=Q/E7ixHB3cOgkNPCJYhKFpMzNMARX71uy8nprPbpuE/X3YCLPermqQPlD3daLLy0z4gi5m
 u/vZX4YQL8dk51MOAWC2I+Xl3ccnW3TDbmMvFEZCc/ZTaf6azouHmKFa1CkzeQMxWKl3In
 z/tgfxLVr6Rw/hj3PNuBtyi4BKRKceA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-rr1VLbUWO6mixA8Ouk8JVA-1; Tue, 19 May 2020 04:02:08 -0400
X-MC-Unique: rr1VLbUWO6mixA8Ouk8JVA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F8EE835B41;
 Tue, 19 May 2020 08:02:07 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE07B5D9DD;
 Tue, 19 May 2020 08:01:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] aio-posix: disable fdmon-io_uring when GSource is used
Date: Tue, 19 May 2020 09:00:54 +0100
Message-Id: <20200519080054.146495-9-stefanha@redhat.com>
In-Reply-To: <20200519080054.146495-1-stefanha@redhat.com>
References: <20200519080054.146495-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Oleksandr Natalenko <oleksandr@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGdsaWIgZXZlbnQgbG9vcCBkb2VzIG5vdCBjYWxsIGZkbW9uX2lvX3VyaW5nX3dhaXQoKSBz
byBmZCBoYW5kbGVycwp3YWl0aW5nIHRvIGJlIHN1Ym1pdHRlZCBidWlsZCB1cCBpbiB0aGUgbGlz
dC4gVGhlcmUgaXMgbm8gYmVuZWZpdCBpcwp1c2luZyBpb191cmluZyB3aGVuIHRoZSBnbGliIEdT
b3VyY2UgaXMgYmVpbmcgdXNlZCwgc28gZGlzYWJsZSBpdAppbnN0ZWFkIG9mIGltcGxlbWVudGlu
ZyBhIG1vcmUgY29tcGxleCBmaXguCgpUaGlzIGZpeGVzIGEgbWVtb3J5IGxlYWsgd2hlcmUgQWlv
SGFuZGxlcnMgd291bGQgYnVpbGQgdXAgYW5kIGluY3JlYXNpbmcKYW1vdW50cyBvZiBDUFUgdGlt
ZSB3ZXJlIHNwZW50IGl0ZXJhdGluZyB0aGVtIGluIGFpb19wZW5kaW5nKCkuIFRoZQpzeW1wdG9t
IGlzIHRoYXQgZ3Vlc3RzIGJlY29tZSBzbG93IHdoZW4gUUVNVSBpcyBidWlsdCB3aXRoIGlvX3Vy
aW5nCnN1cHBvcnQuCgpCdWdsaW5rOiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC9xZW11Lyti
dWcvMTg3NzcxNgpGaXhlczogNzNmZDI4MmU3YjZkZDRlNGVhMWMzYmJiM2QzMDJjOGRiNTFlNGNj
ZiAoImFpby1wb3NpeDogYWRkIGlvX3VyaW5nIGZkIG1vbml0b3JpbmcgaW1wbGVtZW50YXRpb24i
KQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClRl
c3RlZC1ieTogT2xla3NhbmRyIE5hdGFsZW5rbyA8b2xla3NhbmRyQHJlZGhhdC5jb20+Ck1lc3Nh
Z2UtaWQ6IDIwMjAwNTExMTgzNjMwLjI3OTc1MC0zLXN0ZWZhbmhhQHJlZGhhdC5jb20KU2lnbmVk
LW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGluY2x1
ZGUvYmxvY2svYWlvLmggfCAgMyArKysKIHV0aWwvYWlvLXBvc2l4LmMgICAgfCAxMiArKysrKysr
KysrKysKIHV0aWwvYWlvLXdpbjMyLmMgICAgfCAgNCArKysrCiB1dGlsL2FzeW5jLmMgICAgICAg
IHwgIDEgKwogNCBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9ibG9jay9haW8uaCBiL2luY2x1ZGUvYmxvY2svYWlvLmgKaW5kZXggNjJlZDk1NDM0
NC4uYjJmNzAzZmEzZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ibG9jay9haW8uaAorKysgYi9pbmNs
dWRlL2Jsb2NrL2Fpby5oCkBAIC03MDEsNiArNzAxLDkgQEAgdm9pZCBhaW9fY29udGV4dF9zZXR1
cChBaW9Db250ZXh0ICpjdHgpOwogICovCiB2b2lkIGFpb19jb250ZXh0X2Rlc3Ryb3koQWlvQ29u
dGV4dCAqY3R4KTsKIAorLyogVXNlZCBpbnRlcm5hbGx5LCBkbyBub3QgY2FsbCBvdXRzaWRlIEFp
b0NvbnRleHQgY29kZSAqLwordm9pZCBhaW9fY29udGV4dF91c2VfZ19zb3VyY2UoQWlvQ29udGV4
dCAqY3R4KTsKKwogLyoqCiAgKiBhaW9fY29udGV4dF9zZXRfcG9sbF9wYXJhbXM6CiAgKiBAY3R4
OiB0aGUgYWlvIGNvbnRleHQKZGlmZiAtLWdpdCBhL3V0aWwvYWlvLXBvc2l4LmMgYi91dGlsL2Fp
by1wb3NpeC5jCmluZGV4IDhhZjMzNGFiMTkuLjFiMmEzYWY2NWIgMTAwNjQ0Ci0tLSBhL3V0aWwv
YWlvLXBvc2l4LmMKKysrIGIvdXRpbC9haW8tcG9zaXguYwpAQCAtNjgyLDYgKzY4MiwxOCBAQCB2
b2lkIGFpb19jb250ZXh0X2Rlc3Ryb3koQWlvQ29udGV4dCAqY3R4KQogICAgIGFpb19mcmVlX2Rl
bGV0ZWRfaGFuZGxlcnMoY3R4KTsKIH0KIAordm9pZCBhaW9fY29udGV4dF91c2VfZ19zb3VyY2Uo
QWlvQ29udGV4dCAqY3R4KQoreworICAgIC8qCisgICAgICogRGlzYWJsZSBpb191cmluZyB3aGVu
IHRoZSBnbGliIG1haW4gbG9vcCBpcyB1c2VkIGJlY2F1c2UgaXQgZG9lc24ndAorICAgICAqIHN1
cHBvcnQgbWl4ZWQgZ2xpYi9haW9fcG9sbCgpIHVzYWdlLiBJdCByZWxpZXMgb24gYWlvX3BvbGwo
KSBiZWluZworICAgICAqIGNhbGxlZCByZWd1bGFybHkgc28gdGhhdCBjaGFuZ2VzIHRvIHRoZSBt
b25pdG9yZWQgZmlsZSBkZXNjcmlwdG9ycyBhcmUKKyAgICAgKiBzdWJtaXR0ZWQsIG90aGVyd2lz
ZSBhIGxpc3Qgb2YgcGVuZGluZyBmZCBoYW5kbGVycyBidWlsZHMgdXAuCisgICAgICovCisgICAg
ZmRtb25faW9fdXJpbmdfZGVzdHJveShjdHgpOworICAgIGFpb19mcmVlX2RlbGV0ZWRfaGFuZGxl
cnMoY3R4KTsKK30KKwogdm9pZCBhaW9fY29udGV4dF9zZXRfcG9sbF9wYXJhbXMoQWlvQ29udGV4
dCAqY3R4LCBpbnQ2NF90IG1heF9ucywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGludDY0X3QgZ3JvdywgaW50NjRfdCBzaHJpbmssIEVycm9yICoqZXJycCkKIHsKZGlmZiAtLWdp
dCBhL3V0aWwvYWlvLXdpbjMyLmMgYi91dGlsL2Fpby13aW4zMi5jCmluZGV4IDcyOWQ1MzNmYWYu
Ljk1M2M1NmFiNDggMTAwNjQ0Ci0tLSBhL3V0aWwvYWlvLXdpbjMyLmMKKysrIGIvdXRpbC9haW8t
d2luMzIuYwpAQCAtNDE0LDYgKzQxNCwxMCBAQCB2b2lkIGFpb19jb250ZXh0X2Rlc3Ryb3koQWlv
Q29udGV4dCAqY3R4KQogewogfQogCit2b2lkIGFpb19jb250ZXh0X3VzZV9nX3NvdXJjZShBaW9D
b250ZXh0ICpjdHgpCit7Cit9CisKIHZvaWQgYWlvX2NvbnRleHRfc2V0X3BvbGxfcGFyYW1zKEFp
b0NvbnRleHQgKmN0eCwgaW50NjRfdCBtYXhfbnMsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQ2NF90IGdyb3csIGludDY0X3Qgc2hyaW5rLCBFcnJvciAqKmVycnApCiB7CmRp
ZmYgLS1naXQgYS91dGlsL2FzeW5jLmMgYi91dGlsL2FzeW5jLmMKaW5kZXggMzE2NWEyOGYyZi4u
MTMxOWVlZTNiYyAxMDA2NDQKLS0tIGEvdXRpbC9hc3luYy5jCisrKyBiL3V0aWwvYXN5bmMuYwpA
QCAtMzYyLDYgKzM2Miw3IEBAIHN0YXRpYyBHU291cmNlRnVuY3MgYWlvX3NvdXJjZV9mdW5jcyA9
IHsKIAogR1NvdXJjZSAqYWlvX2dldF9nX3NvdXJjZShBaW9Db250ZXh0ICpjdHgpCiB7CisgICAg
YWlvX2NvbnRleHRfdXNlX2dfc291cmNlKGN0eCk7CiAgICAgZ19zb3VyY2VfcmVmKCZjdHgtPnNv
dXJjZSk7CiAgICAgcmV0dXJuICZjdHgtPnNvdXJjZTsKIH0KLS0gCjIuMjUuMwoK


