Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D3C43467
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40A52053B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2qNswJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40A52053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyg5-0008Hu-KK
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 16:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyD7-000347-Kd
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyD5-000361-Oi
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtvnK0f/LNuPJKfiDksYrxzItoNrs0JmX/tUwY70GkA=;
 b=F2qNswJStGuod0km3bi3oG+3UA99rGWhyPscI9yFeas3QgHIu9NeQ3sRnJvOFlbpWs4sQV
 HO4t4B6gocDYOxQrFx7kGZ0zZJ0+x7qi/aF+L3FAOS34RNhm50rTRubSDHkRI8n77naiC4
 6Pfk7RX7EHefviGDuYRblT6nSt0bsys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-yWaxbCZlPR-znIC53Y1xzg-1; Fri, 09 Oct 2020 15:37:43 -0400
X-MC-Unique: yWaxbCZlPR-znIC53Y1xzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42B72879519;
 Fri,  9 Oct 2020 19:37:41 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B58F96266E;
 Fri,  9 Oct 2020 19:37:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 26/30] block/io: fix bdrv_co_block_status_above
Date: Fri,  9 Oct 2020 20:35:25 +0100
Message-Id: <20201009193529.322822-27-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPgoKYmRydl9jb19ibG9ja19zdGF0dXNfYWJvdmUgaGFzIHNldmVyYWwgZGVzaWduIHByb2Js
ZW1zIHdpdGggaGFuZGxpbmcKc2hvcnQgYmFja2luZyBmaWxlczoKCjEuIFdpdGggd2FudF96ZXJv
cz10cnVlLCBpdCBtYXkgcmV0dXJuIHJldCB3aXRoIEJEUlZfQkxPQ0tfWkVSTyBidXQKd2l0aG91
dCBCRFJWX0JMT0NLX0FMTE9DQVRFRCBmbGFnLCB3aGVuIGFjdHVhbGx5IHNob3J0IGJhY2tpbmcg
ZmlsZQp3aGljaCBwcm9kdWNlcyB0aGVzZSBhZnRlci1FT0YgemVyb3MgaXMgaW5zaWRlIHJlcXVl
c3RlZCBiYWNraW5nCnNlcXVlbmNlLgoKMi4gV2l0aCB3YW50X3plcm89ZmFsc2UsIGl0IG1heSBy
ZXR1cm4gcG51bT0wIHByaW9yIHRvIGFjdHVhbCBFT0YsCmJlY2F1c2Ugb2YgRU9GIG9mIHNob3J0
IGJhY2tpbmcgZmlsZS4KCkZpeCB0aGVzZSB0aGluZ3MsIG1ha2luZyBsb2dpYyBhYm91dCBzaG9y
dCBiYWNraW5nIGZpbGVzIGNsZWFyZXIuCgpXaXRoIGZpeGVkIGJkcnZfYmxvY2tfc3RhdHVzX2Fi
b3ZlIHdlIGFsc28gaGF2ZSB0byBpbXByb3ZlIGlzX3plcm8gaW4KcWNvdzIgY29kZSwgb3RoZXJ3
aXNlIGlvdGVzdCAxNTQgd2lsbCBmYWlsLCBiZWNhdXNlIHdpdGggdGhpcyBwYXRjaCB3ZQpzdG9w
IHRvIG1lcmdlIHplcm9zIG9mIGRpZmZlcmVudCB0eXBlcyAocHJvZHVjZWQgYnkgZnVsbHkgdW5h
bGxvY2F0ZWQKaW4gdGhlIHdob2xlIGJhY2tpbmcgY2hhaW4gcmVnaW9ucyB2cyBwcm9kdWNlZCBi
eSBzaG9ydCBiYWNraW5nIGZpbGVzKS4KCk5vdGUgYWxzbywgdGhhdCB0aGlzIHBhdGNoIGxlYXZl
cyBmb3IgYW5vdGhlciBkYXkgdGhlIGdlbmVyYWwgcHJvYmxlbQphcm91bmQgYmxvY2stc3RhdHVz
OiBtaXN1c2Ugb2YgQkRSVl9CTE9DS19BTExPQ0FURUQgYXMgaXMtZnMtYWxsb2NhdGVkCnZzIGdv
LXRvLWJhY2tpbmcuCgpTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+ClJldmlld2VkLWJ5OiBBbGJlcnRvIEdhcmNpYSA8
YmVydG9AaWdhbGlhLmNvbT4KUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQu
Y29tPgpNZXNzYWdlLWlkOiAyMDIwMDkyNDE5NDAwMy4yMjA4MC0yLXZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbQpbRml4IHMvY29tZXMvY29tZS8gYXMgc3VnZ2VzdGVkIGJ5IEVyaWMgQmxha2UKLS1T
dGVmYW5dClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4KLS0tCiBibG9jay9pby5jICAgIHwgNjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tCiBibG9jay9xY293Mi5jIHwgMTYgKysrKysrKysrKy0tCiAy
IGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2Jsb2NrL2lvLmMgYi9ibG9jay9pby5jCmluZGV4IDU0ZjA5NjhhZWUuLmE3MThkNTBj
YTIgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2lvLmMKKysrIGIvYmxvY2svaW8uYwpAQCAtMjM1MCwzNCAr
MjM1MCw3NCBAQCBiZHJ2X2NvX2NvbW1vbl9ibG9ja19zdGF0dXNfYWJvdmUoQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCAqbWFw
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKipm
aWxlKQogeworICAgIGludCByZXQ7CiAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqcDsKLSAgICBpbnQg
cmV0ID0gMDsKLSAgICBib29sIGZpcnN0ID0gdHJ1ZTsKKyAgICBpbnQ2NF90IGVvZiA9IDA7CiAK
ICAgICBhc3NlcnQoYnMgIT0gYmFzZSk7Ci0gICAgZm9yIChwID0gYnM7IHAgIT0gYmFzZTsgcCA9
IGJkcnZfZmlsdGVyX29yX2Nvd19icyhwKSkgeworCisgICAgcmV0ID0gYmRydl9jb19ibG9ja19z
dGF0dXMoYnMsIHdhbnRfemVybywgb2Zmc2V0LCBieXRlcywgcG51bSwgbWFwLCBmaWxlKTsKKyAg
ICBpZiAocmV0IDwgMCB8fCAqcG51bSA9PSAwIHx8IHJldCAmIEJEUlZfQkxPQ0tfQUxMT0NBVEVE
KSB7CisgICAgICAgIHJldHVybiByZXQ7CisgICAgfQorCisgICAgaWYgKHJldCAmIEJEUlZfQkxP
Q0tfRU9GKSB7CisgICAgICAgIGVvZiA9IG9mZnNldCArICpwbnVtOworICAgIH0KKworICAgIGFz
c2VydCgqcG51bSA8PSBieXRlcyk7CisgICAgYnl0ZXMgPSAqcG51bTsKKworICAgIGZvciAocCA9
IGJkcnZfZmlsdGVyX29yX2Nvd19icyhicyk7IHAgIT0gYmFzZTsKKyAgICAgICAgIHAgPSBiZHJ2
X2ZpbHRlcl9vcl9jb3dfYnMocCkpCisgICAgewogICAgICAgICByZXQgPSBiZHJ2X2NvX2Jsb2Nr
X3N0YXR1cyhwLCB3YW50X3plcm8sIG9mZnNldCwgYnl0ZXMsIHBudW0sIG1hcCwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsZSk7CiAgICAgICAgIGlmIChyZXQgPCAwKSB7
Ci0gICAgICAgICAgICBicmVhazsKKyAgICAgICAgICAgIHJldHVybiByZXQ7CiAgICAgICAgIH0K
LSAgICAgICAgaWYgKHJldCAmIEJEUlZfQkxPQ0tfWkVSTyAmJiByZXQgJiBCRFJWX0JMT0NLX0VP
RiAmJiAhZmlyc3QpIHsKKyAgICAgICAgaWYgKCpwbnVtID09IDApIHsKICAgICAgICAgICAgIC8q
Ci0gICAgICAgICAgICAgKiBSZWFkaW5nIGJleW9uZCB0aGUgZW5kIG9mIHRoZSBmaWxlIGNvbnRp
bnVlcyB0byByZWFkCi0gICAgICAgICAgICAgKiB6ZXJvZXMsIGJ1dCB3ZSBjYW4gb25seSB3aWRl
biB0aGUgcmVzdWx0IHRvIHRoZQotICAgICAgICAgICAgICogdW5hbGxvY2F0ZWQgbGVuZ3RoIHdl
IGxlYXJuZWQgZnJvbSBhbiBlYXJsaWVyCi0gICAgICAgICAgICAgKiBpdGVyYXRpb24uCisgICAg
ICAgICAgICAgKiBUaGUgdG9wIGxheWVyIGRlZmVycmVkIHRvIHRoaXMgbGF5ZXIsIGFuZCBiZWNh
dXNlIHRoaXMgbGF5ZXIgaXMKKyAgICAgICAgICAgICAqIHNob3J0LCBhbnkgemVyb2VzIHRoYXQg
d2Ugc3ludGhlc2l6ZSBiZXlvbmQgRU9GIGJlaGF2ZSBhcyBpZiB0aGV5CisgICAgICAgICAgICAg
KiB3ZXJlIGFsbG9jYXRlZCBhdCB0aGlzIGxheWVyLgorICAgICAgICAgICAgICoKKyAgICAgICAg
ICAgICAqIFdlIGRvbid0IGluY2x1ZGUgQkRSVl9CTE9DS19FT0YgaW50byByZXQsIGFzIHVwcGVy
IGxheWVyIG1heSBiZQorICAgICAgICAgICAgICogbGFyZ2VyLiBXZSdsbCBhZGQgQkRSVl9CTE9D
S19FT0YgaWYgbmVlZGVkIGF0IGZ1bmN0aW9uIGVuZCwgc2VlCisgICAgICAgICAgICAgKiBiZWxv
dy4KICAgICAgICAgICAgICAqLworICAgICAgICAgICAgYXNzZXJ0KHJldCAmIEJEUlZfQkxPQ0tf
RU9GKTsKICAgICAgICAgICAgICpwbnVtID0gYnl0ZXM7CisgICAgICAgICAgICBpZiAoZmlsZSkg
eworICAgICAgICAgICAgICAgICpmaWxlID0gcDsKKyAgICAgICAgICAgIH0KKyAgICAgICAgICAg
IHJldCA9IEJEUlZfQkxPQ0tfWkVSTyB8IEJEUlZfQkxPQ0tfQUxMT0NBVEVEOworICAgICAgICAg
ICAgYnJlYWs7CiAgICAgICAgIH0KLSAgICAgICAgaWYgKHJldCAmIChCRFJWX0JMT0NLX1pFUk8g
fCBCRFJWX0JMT0NLX0RBVEEpKSB7CisgICAgICAgIGlmIChyZXQgJiBCRFJWX0JMT0NLX0FMTE9D
QVRFRCkgeworICAgICAgICAgICAgLyoKKyAgICAgICAgICAgICAqIFdlJ3ZlIGZvdW5kIHRoZSBu
b2RlIGFuZCB0aGUgc3RhdHVzLCB3ZSBtdXN0IGJyZWFrLgorICAgICAgICAgICAgICoKKyAgICAg
ICAgICAgICAqIERyb3AgQkRSVl9CTE9DS19FT0YsIGFzIGl0J3Mgbm90IGZvciB1cHBlciBsYXll
ciwgd2hpY2ggbWF5IGJlCisgICAgICAgICAgICAgKiBsYXJnZXIuIFdlJ2xsIGFkZCBCRFJWX0JM
T0NLX0VPRiBpZiBuZWVkZWQgYXQgZnVuY3Rpb24gZW5kLCBzZWUKKyAgICAgICAgICAgICAqIGJl
bG93LgorICAgICAgICAgICAgICovCisgICAgICAgICAgICByZXQgJj0gfkJEUlZfQkxPQ0tfRU9G
OwogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIH0KLSAgICAgICAgLyogW29mZnNldCwgcG51
bV0gdW5hbGxvY2F0ZWQgb24gdGhpcyBsYXllciwgd2hpY2ggY291bGQgYmUgb25seQotICAgICAg
ICAgKiB0aGUgZmlyc3QgcGFydCBvZiBbb2Zmc2V0LCBieXRlc10uICAqLwotICAgICAgICBieXRl
cyA9IE1JTihieXRlcywgKnBudW0pOwotICAgICAgICBmaXJzdCA9IGZhbHNlOworCisgICAgICAg
IC8qCisgICAgICAgICAqIE9LLCBbb2Zmc2V0LCBvZmZzZXQgKyAqcG51bSkgcmVnaW9uIGlzIHVu
YWxsb2NhdGVkIG9uIHRoaXMgbGF5ZXIsCisgICAgICAgICAqIGxldCdzIGNvbnRpbnVlIHRoZSBk
aXZpbmcuCisgICAgICAgICAqLworICAgICAgICBhc3NlcnQoKnBudW0gPD0gYnl0ZXMpOworICAg
ICAgICBieXRlcyA9ICpwbnVtOworICAgIH0KKworICAgIGlmIChvZmZzZXQgKyAqcG51bSA9PSBl
b2YpIHsKKyAgICAgICAgcmV0IHw9IEJEUlZfQkxPQ0tfRU9GOwogICAgIH0KKwogICAgIHJldHVy
biByZXQ7CiB9CiAKZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLmMgYi9ibG9jay9xY293Mi5jCmlu
ZGV4IGIwNTUxMjcxOGMuLmI2Y2I0ZGI4YmIgMTAwNjQ0Ci0tLSBhL2Jsb2NrL3Fjb3cyLmMKKysr
IGIvYmxvY2svcWNvdzIuYwpAQCAtMzg2MCw4ICszODYwLDIwIEBAIHN0YXRpYyBib29sIGlzX3pl
cm8oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGludDY0X3Qgb2Zmc2V0LCBpbnQ2NF90IGJ5dGVzKQog
ICAgIGlmICghYnl0ZXMpIHsKICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgfQotICAgIHJlcyA9
IGJkcnZfYmxvY2tfc3RhdHVzX2Fib3ZlKGJzLCBOVUxMLCBvZmZzZXQsIGJ5dGVzLCAmbnIsIE5V
TEwsIE5VTEwpOwotICAgIHJldHVybiByZXMgPj0gMCAmJiAocmVzICYgQkRSVl9CTE9DS19aRVJP
KSAmJiBuciA9PSBieXRlczsKKworICAgIC8qCisgICAgICogYmRydl9ibG9ja19zdGF0dXNfYWJv
dmUgZG9lc24ndCBtZXJnZSBkaWZmZXJlbnQgdHlwZXMgb2YgemVyb3MsIGZvcgorICAgICAqIGV4
YW1wbGUsIHplcm9zIHdoaWNoIGNvbWUgZnJvbSB0aGUgcmVnaW9uIHdoaWNoIGlzIHVuYWxsb2Nh
dGVkIGluCisgICAgICogdGhlIHdob2xlIGJhY2tpbmcgY2hhaW4sIGFuZCB6ZXJvcyB3aGljaCBj
b21lIGJlY2F1c2Ugb2YgYSBzaG9ydAorICAgICAqIGJhY2tpbmcgZmlsZS4gU28sIHdlIG5lZWQg
YSBsb29wLgorICAgICAqLworICAgIGRvIHsKKyAgICAgICAgcmVzID0gYmRydl9ibG9ja19zdGF0
dXNfYWJvdmUoYnMsIE5VTEwsIG9mZnNldCwgYnl0ZXMsICZuciwgTlVMTCwgTlVMTCk7CisgICAg
ICAgIG9mZnNldCArPSBucjsKKyAgICAgICAgYnl0ZXMgLT0gbnI7CisgICAgfSB3aGlsZSAocmVz
ID49IDAgJiYgKHJlcyAmIEJEUlZfQkxPQ0tfWkVSTykgJiYgbnIgJiYgYnl0ZXMpOworCisgICAg
cmV0dXJuIHJlcyA+PSAwICYmIChyZXMgJiBCRFJWX0JMT0NLX1pFUk8pICYmIGJ5dGVzID09IDA7
CiB9CiAKIHN0YXRpYyBjb3JvdXRpbmVfZm4gaW50IHFjb3cyX2NvX3B3cml0ZV96ZXJvZXMoQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsCi0tIAoyLjI2LjIKCg==


