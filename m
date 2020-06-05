Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AF0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58BB2075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJuJkK9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58BB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh91f-00023r-2N
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8yO-0003XH-J4
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:49:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8yN-0006pY-Na
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591350551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obSFu5gu523AqVMnoUB8q9xLwd8TgW9ZodC9N3uuImc=;
 b=WJuJkK9aZPxEVlT4quUAX1kxNr/3XmVhwcocppqlsuBiJ8kk2Z685T/xaeqhZuk7Jul8Vc
 VqQUwU3wBWkm1j/+VUgyMboTIMrj6q9vNEo3zYDHtVnlwajVErObJiyJ3zS/K1Rl1JTw4C
 MXuRgytb/htJTNfIqeH2YUmRYWm3m7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-n3PVCGaDP4GHs0PS5B-Ypw-1; Fri, 05 Jun 2020 05:49:09 -0400
X-MC-Unique: n3PVCGaDP4GHs0PS5B-Ypw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50EFC1940932;
 Fri,  5 Jun 2020 09:49:07 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 811607CCEF;
 Fri,  5 Jun 2020 09:48:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 06/11] fuzz: run the main-loop in fork-server process
Date: Fri,  5 Jun 2020 10:47:45 +0100
Message-Id: <20200605094750.149957-7-stefanha@redhat.com>
In-Reply-To: <20200605094750.149957-1-stefanha@redhat.com>
References: <20200605094750.149957-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpXaXRob3V0IHRoaXMsIHRo
ZSB0aW1lIHNpbmNlIHRoZSBsYXN0IG1haW4tbG9vcCBrZWVwcyBpbmNyZWFzaW5nLCBhcyB0aGUK
ZnV6emVyIHJ1bnMuIFRoZSBmb3JrZWQgY2hpbGRyZW4gbmVlZCB0byBoYW5kbGUgYWxsIHRoZSAi
cGFzdC1kdWUiCnRpbWVycywgc2xvd2luZyB0aGVtIGRvd24sIG92ZXIgdGltZS4gV2l0aCB0aGlz
IGNoYW5nZSwgdGhlCnBhcmVudC9mb3JrLXNlcnZlciBwcm9jZXNzIHJ1bnMgdGhlIG1haW4tbG9v
cCwgd2hpbGUgd2FpdGluZyBvbiB0aGUKY2hpbGQsIGVuc3VyaW5nIHRoYXQgdGhlIHRpbWVyIGV2
ZW50cyBkbyBub3QgcGlsZSB1cCwgb3ZlciB0aW1lLgoKU2lnbmVkLW9mZi1ieTogQWxleGFuZGVy
IEJ1bGVrb3YgPGFseG5kckBidS5lZHU+ClJldmlld2VkLWJ5OiBEYXJyZW4gS2VubnkgPGRhcnJl
bi5rZW5ueUBvcmFjbGUuY29tPgpNZXNzYWdlLWlkOiAyMDIwMDUxMjAzMDEzMy4yOTg5Ni01LWFs
eG5kckBidS5lZHUKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgotLS0KIHRlc3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1enouYyAgICAgIHwgMSArCiB0
ZXN0cy9xdGVzdC9mdXp6L3ZpcnRpb19uZXRfZnV6ei5jICB8IDIgKysKIHRlc3RzL3F0ZXN0L2Z1
enovdmlydGlvX3Njc2lfZnV6ei5jIHwgMiArKwogMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9mdXp6L2k0NDBmeF9mdXp6LmMgYi90ZXN0
cy9xdGVzdC9mdXp6L2k0NDBmeF9mdXp6LmMKaW5kZXggNzc1YjMwNDFiYS4uZTJmMzFlNTZmOSAx
MDA2NDQKLS0tIGEvdGVzdHMvcXRlc3QvZnV6ei9pNDQwZnhfZnV6ei5jCisrKyBiL3Rlc3RzL3F0
ZXN0L2Z1enovaTQ0MGZ4X2Z1enouYwpAQCAtMTUxLDYgKzE1MSw3IEBAIHN0YXRpYyB2b2lkIGk0
NDBmeF9mdXp6X3Fvc19mb3JrKFFUZXN0U3RhdGUgKnMsCiAgICAgICAgIGk0NDBmeF9mdXp6X3Fv
cyhzLCBEYXRhLCBTaXplKTsKICAgICAgICAgX0V4aXQoMCk7CiAgICAgfSBlbHNlIHsKKyAgICAg
ICAgZmx1c2hfZXZlbnRzKHMpOwogICAgICAgICB3YWl0KE5VTEwpOwogICAgIH0KIH0KZGlmZiAt
LWdpdCBhL3Rlc3RzL3F0ZXN0L2Z1enovdmlydGlvX25ldF9mdXp6LmMgYi90ZXN0cy9xdGVzdC9m
dXp6L3ZpcnRpb19uZXRfZnV6ei5jCmluZGV4IGQwOGE0N2UyNzguLmEzM2JkNzMwNjcgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3F0ZXN0L2Z1enovdmlydGlvX25ldF9mdXp6LmMKKysrIGIvdGVzdHMvcXRl
c3QvZnV6ei92aXJ0aW9fbmV0X2Z1enouYwpAQCAtMTIyLDYgKzEyMiw3IEBAIHN0YXRpYyB2b2lk
IHZpcnRpb19uZXRfZm9ya19mdXp6KFFUZXN0U3RhdGUgKnMsCiAgICAgICAgIGZsdXNoX2V2ZW50
cyhzKTsKICAgICAgICAgX0V4aXQoMCk7CiAgICAgfSBlbHNlIHsKKyAgICAgICAgZmx1c2hfZXZl
bnRzKHMpOwogICAgICAgICB3YWl0KE5VTEwpOwogICAgIH0KIH0KQEAgLTEzNCw2ICsxMzUsNyBA
QCBzdGF0aWMgdm9pZCB2aXJ0aW9fbmV0X2ZvcmtfZnV6el9jaGVja191c2VkKFFUZXN0U3RhdGUg
KnMsCiAgICAgICAgIGZsdXNoX2V2ZW50cyhzKTsKICAgICAgICAgX0V4aXQoMCk7CiAgICAgfSBl
bHNlIHsKKyAgICAgICAgZmx1c2hfZXZlbnRzKHMpOwogICAgICAgICB3YWl0KE5VTEwpOwogICAg
IH0KIH0KZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2Z1enovdmlydGlvX3Njc2lfZnV6ei5jIGIv
dGVzdHMvcXRlc3QvZnV6ei92aXJ0aW9fc2NzaV9mdXp6LmMKaW5kZXggM2I5NTI0N2YxMi4uNTFk
Y2U0OTFhYiAxMDA2NDQKLS0tIGEvdGVzdHMvcXRlc3QvZnV6ei92aXJ0aW9fc2NzaV9mdXp6LmMK
KysrIGIvdGVzdHMvcXRlc3QvZnV6ei92aXJ0aW9fc2NzaV9mdXp6LmMKQEAgLTE0NSw2ICsxNDUs
NyBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fc2NzaV9mb3JrX2Z1enooUVRlc3RTdGF0ZSAqcywKICAg
ICAgICAgZmx1c2hfZXZlbnRzKHMpOwogICAgICAgICBfRXhpdCgwKTsKICAgICB9IGVsc2Ugewor
ICAgICAgICBmbHVzaF9ldmVudHMocyk7CiAgICAgICAgIHdhaXQoTlVMTCk7CiAgICAgfQogfQpA
QCAtMTY0LDYgKzE2NSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19zY3NpX3dpdGhfZmxhZ19mdXp6
KFFUZXN0U3RhdGUgKnMsCiAgICAgICAgIH0KICAgICAgICAgX0V4aXQoMCk7CiAgICAgfSBlbHNl
IHsKKyAgICAgICAgZmx1c2hfZXZlbnRzKHMpOwogICAgICAgICB3YWl0KE5VTEwpOwogICAgIH0K
IH0KLS0gCjIuMjUuNAoK


