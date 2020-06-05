Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C230C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6627D2075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD3KxuzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6627D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh90J-0007Cg-Mi
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8xq-0002GB-JS
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:48:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8xp-0006l0-Cj
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591350516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAclCbkK965kzoir3NvjWZkVoHfN2nNhuLsOqTw6Ncc=;
 b=LD3KxuzLT20/kojC4dePYhfNAGnW3biU4sUOI9jqfDxCHRsAdMETMhFzW6NYbXPfyyc7yX
 tNFMBjCuVmj10oAiedFjjN9Ipx/U2nxdmutrCkv6DId56tSFoJKlYhV6D9F8qxaerT295R
 1TQPGXaFBCPCJJdsa4JfiEQNcx1Kt6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-f6vMfDOrOO2yVomshhH3iA-1; Fri, 05 Jun 2020 05:48:34 -0400
X-MC-Unique: f6vMfDOrOO2yVomshhH3iA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 256FE1940921;
 Fri,  5 Jun 2020 09:48:33 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35B5E5D9D7;
 Fri,  5 Jun 2020 09:48:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 03/11] fuzz: add datadir for oss-fuzz compatability
Date: Fri,  5 Jun 2020 10:47:42 +0100
Message-Id: <20200605094750.149957-4-stefanha@redhat.com>
In-Reply-To: <20200605094750.149957-1-stefanha@redhat.com>
References: <20200605094750.149957-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpUaGlzIGFsbG93cyB1cyB0
byBrZWVwIHBjLWJpb3MgaW4gZXhlY3V0YWJsZV9kaXIvcGMtYmlvcywgcmF0aGVyIHRoYW4KZXhl
Y3V0YWJsZV9kaXIvLi4vcGMtYmlvcywgd2hpY2ggaXMgaW5jb21wYXRpYmxlIHdpdGggb3NzLWZ1
enonIGZpbGUKc3RydWN0dXJlLgoKU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEJ1bGVrb3YgPGFs
eG5kckBidS5lZHU+ClJldmlld2VkLWJ5OiBEYXJyZW4gS2VubnkgPGRhcnJlbi5rZW5ueUBvcmFj
bGUuY29tPgpNZXNzYWdlLWlkOiAyMDIwMDUxMjAzMDEzMy4yOTg5Ni0yLWFseG5kckBidS5lZHUK
U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0K
IGluY2x1ZGUvc3lzZW11L3N5c2VtdS5oIHwgIDIgKysKIHNvZnRtbXUvdmwuYyAgICAgICAgICAg
IHwgIDIgKy0KIHRlc3RzL3F0ZXN0L2Z1enovZnV6ei5jIHwgMTUgKysrKysrKysrKysrKysrCiAz
IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL3N5c2VtdS9zeXNlbXUuaCBiL2luY2x1ZGUvc3lzZW11L3N5c2VtdS5oCmlu
ZGV4IDI2YzBjODAyZDEuLjNlZmNjZGJhN2UgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvc3lzZW11L3N5
c2VtdS5oCisrKyBiL2luY2x1ZGUvc3lzZW11L3N5c2VtdS5oCkBAIC0xNSw2ICsxNSw4IEBAIGV4
dGVybiBjb25zdCBjaGFyICpxZW11X25hbWU7CiBleHRlcm4gUWVtdVVVSUQgcWVtdV91dWlkOwog
ZXh0ZXJuIGJvb2wgcWVtdV91dWlkX3NldDsKIAordm9pZCBxZW11X2FkZF9kYXRhX2Rpcihjb25z
dCBjaGFyICpwYXRoKTsKKwogdm9pZCBxZW11X2FkZF9leGl0X25vdGlmaWVyKE5vdGlmaWVyICpu
b3RpZnkpOwogdm9pZCBxZW11X3JlbW92ZV9leGl0X25vdGlmaWVyKE5vdGlmaWVyICpub3RpZnkp
OwogCmRpZmYgLS1naXQgYS9zb2Z0bW11L3ZsLmMgYi9zb2Z0bW11L3ZsLmMKaW5kZXggYWU1NDUx
YmMyMy4uMDVkMWE0Y2I2YiAxMDA2NDQKLS0tIGEvc29mdG1tdS92bC5jCisrKyBiL3NvZnRtbXUv
dmwuYwpAQCAtMTk5Myw3ICsxOTkzLDcgQEAgY2hhciAqcWVtdV9maW5kX2ZpbGUoaW50IHR5cGUs
IGNvbnN0IGNoYXIgKm5hbWUpCiAgICAgcmV0dXJuIE5VTEw7CiB9CiAKLXN0YXRpYyB2b2lkIHFl
bXVfYWRkX2RhdGFfZGlyKGNvbnN0IGNoYXIgKnBhdGgpCit2b2lkIHFlbXVfYWRkX2RhdGFfZGly
KGNvbnN0IGNoYXIgKnBhdGgpCiB7CiAgICAgaW50IGk7CiAKZGlmZiAtLWdpdCBhL3Rlc3RzL3F0
ZXN0L2Z1enovZnV6ei5jIGIvdGVzdHMvcXRlc3QvZnV6ei9mdXp6LmMKaW5kZXggZjVjOTIzODUy
ZS4uMzMzNjVjMzc4MiAxMDA2NDQKLS0tIGEvdGVzdHMvcXRlc3QvZnV6ei9mdXp6LmMKKysrIGIv
dGVzdHMvcXRlc3QvZnV6ei9mdXp6LmMKQEAgLTEzNyw2ICsxMzcsNyBAQCBpbnQgTExWTUZ1enpl
ckluaXRpYWxpemUoaW50ICphcmdjLCBjaGFyICoqKmFyZ3YsIGNoYXIgKioqZW52cCkKIHsKIAog
ICAgIGNoYXIgKnRhcmdldF9uYW1lOworICAgIGNoYXIgKmRpcjsKIAogICAgIC8qIEluaXRpYWxp
emUgcWdyYXBoIGFuZCBtb2R1bGVzICovCiAgICAgcW9zX2dyYXBoX2luaXQoKTsKQEAgLTE0Nyw2
ICsxNDgsMjAgQEAgaW50IExMVk1GdXp6ZXJJbml0aWFsaXplKGludCAqYXJnYywgY2hhciAqKiph
cmd2LCBjaGFyICoqKmVudnApCiAgICAgdGFyZ2V0X25hbWUgPSBzdHJzdHIoKiphcmd2LCAiLXRh
cmdldC0iKTsKICAgICBpZiAodGFyZ2V0X25hbWUpIHsgICAgICAgIC8qIFRoZSBiaW5hcnkgbmFt
ZSBzcGVjaWZpZXMgdGhlIHRhcmdldCAqLwogICAgICAgICB0YXJnZXRfbmFtZSArPSBzdHJsZW4o
Ii10YXJnZXQtIik7CisgICAgICAgIC8qCisgICAgICAgICAqIFdpdGggb3NzLWZ1enosIHRoZSBl
eGVjdXRhYmxlIGlzIGtlcHQgaW4gdGhlIHJvb3Qgb2YgYSBkaXJlY3RvcnkgKHdlCisgICAgICAg
ICAqIGNhbm5vdCBhc3N1bWUgdGhlIHBhdGgpLiBBbGwgZGF0YSAoaW5jbHVkaW5nIGJpb3MgYmlu
YXJpZXMpIG11c3QgYmUKKyAgICAgICAgICogaW4gdGhlIHNhbWUgZGlyLCBvciBhIHN1YmRpci4g
VGh1cywgd2UgY2Fubm90IHBsYWNlIHRoZSBwYy1iaW9zIHNvCisgICAgICAgICAqIHRoYXQgaXQg
d291bGQgYmUgaW4gZXhlY19kaXIvLi4vcGMtYmlvcy4KKyAgICAgICAgICogQXMgYSB3b3JrYXJv
dW5kLCBvc3MtZnV6eiBhbGxvd3MgdXMgdG8gdXNlIGFyZ3ZbMF0gdG8gZ2V0IHRoZQorICAgICAg
ICAgKiBsb2NhdGlvbiBvZiB0aGUgZXhlY3V0YWJsZS4gVXNpbmcgdGhpcyB3ZSBhZGQgZXhlY19k
aXIvcGMtYmlvcyB0bworICAgICAgICAgKiB0aGUgZGF0YWRpcnMuCisgICAgICAgICAqLworICAg
ICAgICBkaXIgPSBnX2J1aWxkX2ZpbGVuYW1lKGdfcGF0aF9nZXRfZGlybmFtZSgqKmFyZ3YpLCAi
cGMtYmlvcyIsIE5VTEwpOworICAgICAgICBpZiAoZ19maWxlX3Rlc3QoZGlyLCBHX0ZJTEVfVEVT
VF9JU19ESVIpKSB7CisgICAgICAgICAgICBxZW11X2FkZF9kYXRhX2RpcihkaXIpOworICAgICAg
ICB9CisgICAgICAgIGdfZnJlZShkaXIpOwogICAgIH0gZWxzZSBpZiAoKmFyZ2MgPiAxKSB7ICAv
KiBUaGUgdGFyZ2V0IGlzIHNwZWNpZmllZCBhcyBhbiBhcmd1bWVudCAqLwogICAgICAgICB0YXJn
ZXRfbmFtZSA9ICgqYXJndilbMV07CiAgICAgICAgIGlmICghc3Ryc3RyKHRhcmdldF9uYW1lLCAi
LS1mdXp6LXRhcmdldD0iKSkgewotLSAKMi4yNS40Cgo=


