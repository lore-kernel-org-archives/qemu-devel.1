Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58446C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 05:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496E12067D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 05:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4Uj8AjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496E12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2pZo-0000W3-ER
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 01:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2pVt-0006dy-3j
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 01:29:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2pVr-0004mO-Gq
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 01:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596518962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFKhdiku8sGCyHV+5oEu1Ba9zo9tsc85ZfOtQNKJumQ=;
 b=W4Uj8AjDw1Sjjy3UJYnioSWUiNp4TKZDOVAwq+9W3EtKmGaFoGzTwmD0vzO8NTts3RO/YY
 53zR8VLKc5XHbkiVDeCSLM61ZIs3DnN0KS94nqS3+Xkln9dexsjJRKik0FO5mzp2y6dfPP
 0uPfqlx4dvaSulB9gp8M534ib3dimrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-zZFkjMyvN5GD-FDZoZTzwA-1; Tue, 04 Aug 2020 01:28:17 -0400
X-MC-Unique: zZFkjMyvN5GD-FDZoZTzwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 040261005510;
 Tue,  4 Aug 2020 05:28:16 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 756258A181;
 Tue,  4 Aug 2020 05:28:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] async: always set ctx->notified in aio_notify()
Date: Tue,  4 Aug 2020 06:28:03 +0100
Message-Id: <20200804052804.1165291-3-stefanha@redhat.com>
In-Reply-To: <20200804052804.1165291-1-stefanha@redhat.com>
References: <20200804052804.1165291-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

YWlvX25vdGlmeSgpIGRvZXMgbm90IHNldCBjdHgtPm5vdGlmaWVkIHdoZW4gY2FsbGVkIHdpdGgK
Y3R4LT5haW9fbm90aWZ5X21lIGRpc2FibGVkLiBJbiBvcmRlciB0byBwb2xsIGN0eC0+bm90aWZp
ZWQgaXQgaXMKdGhlcmVmb3JlIG5lY2Vzc2FyeSB0byBlbmFibGUgY3R4LT5haW9fbm90aWZ5X21l
LgoKVGhpcyBpcyBzdWJvcHRpbWFsIHNpbmNlIGV4cGVuc2l2ZSBldmVudF9ub3RpZmllcl9zZXQo
JmN0eC0+bm90aWZpZXIpCmFuZCBldmVudF9ub3RpZmllcl90ZXN0X2FuZF9jbGVhcigmY3R4LT5u
b3RpZmllcikgY2FsbHMgcmVxdWlyZWQgd2hlbgpjdHgtPmFpb19ub3RpZnlfbWUgaXMgZW5hYmxl
ZC4KCkNoYW5nZSBhaW9fbm90aWZ5KCkgbWUgc28gdGhhdCBhaW8tPm5vdGlmaWVkIGlzIGFsd2F5
cyBzZXQsIHJlZ2FyZGxlc3MKb2YgY3R4LT5haW9fbm90aWZ5X21lLiBUaGlzIHdpbGwgYWxsb3cg
cG9sbGluZyB0byB3b3JrIGNoZWFwbHkgd2l0aApjdHgtPmFpb19ub3RpZnlfbWUgZGlzYWJsZWQu
IE1vdmUgdGhlIGV2ZW50X25vdGlmaWVyX3Rlc3RfYW5kX2NsZWFyKCkgdG8KdGhlIGZkIGhhbmRs
ZXIgZnVuY3Rpb24gKHdoaWNoIGlzIG5vdyBubyBsb25nZXIgYW4gZW1wdHkgZnVuY3Rpb24gc28K
ImR1bW15IiBoYXMgYmVlbiBkcm9wcGVkIGZyb20gaXRzIG5hbWUpLgoKVGhlIG5leHQgcGF0Y2gg
dGFrZXMgYWR2YW50YWdlIG9mIHRoaXMgYnkgb3B0aW1pemluZyBwb2xsaW5nIGluCnV0aWwvYWlv
LXBvc2l4LmMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+Ci0tLQogdXRpbC9hc3luYy5jIHwgMTggKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS91
dGlsL2FzeW5jLmMgYi91dGlsL2FzeW5jLmMKaW5kZXggZDlmOTg3ZTEzMy4uM2U2OGI1Yjc1NyAx
MDA2NDQKLS0tIGEvdXRpbC9hc3luYy5jCisrKyBiL3V0aWwvYXN5bmMuYwpAQCAtNDI1LDE5ICs0
MjUsMTQgQEAgdm9pZCBhaW9fbm90aWZ5KEFpb0NvbnRleHQgKmN0eCkKICAgICBzbXBfbWIoKTsK
ICAgICBpZiAoYXRvbWljX3JlYWQoJmN0eC0+bm90aWZ5X21lKSkgewogICAgICAgICBldmVudF9u
b3RpZmllcl9zZXQoJmN0eC0+bm90aWZpZXIpOwotICAgICAgICBhdG9taWNfbWJfc2V0KCZjdHgt
Pm5vdGlmaWVkLCB0cnVlKTsKICAgICB9CisKKyAgICBhdG9taWNfbWJfc2V0KCZjdHgtPm5vdGlm
aWVkLCB0cnVlKTsKIH0KIAogdm9pZCBhaW9fbm90aWZ5X2FjY2VwdChBaW9Db250ZXh0ICpjdHgp
CiB7Ci0gICAgaWYgKGF0b21pY194Y2hnKCZjdHgtPm5vdGlmaWVkLCBmYWxzZSkKLSNpZmRlZiBX
SU4zMgotICAgICAgICB8fCB0cnVlCi0jZW5kaWYKLSAgICApIHsKLSAgICAgICAgZXZlbnRfbm90
aWZpZXJfdGVzdF9hbmRfY2xlYXIoJmN0eC0+bm90aWZpZXIpOwotICAgIH0KKyAgICBhdG9taWNf
bWJfc2V0KCZjdHgtPm5vdGlmaWVkLCBmYWxzZSk7CiB9CiAKIHN0YXRpYyB2b2lkIGFpb190aW1l
cmxpc3Rfbm90aWZ5KHZvaWQgKm9wYXF1ZSwgUUVNVUNsb2NrVHlwZSB0eXBlKQpAQCAtNDQ1LDgg
KzQ0MCwxMSBAQCBzdGF0aWMgdm9pZCBhaW9fdGltZXJsaXN0X25vdGlmeSh2b2lkICpvcGFxdWUs
IFFFTVVDbG9ja1R5cGUgdHlwZSkKICAgICBhaW9fbm90aWZ5KG9wYXF1ZSk7CiB9CiAKLXN0YXRp
YyB2b2lkIGFpb19jb250ZXh0X25vdGlmaWVyX2R1bW15X2NiKEV2ZW50Tm90aWZpZXIgKmUpCitz
dGF0aWMgdm9pZCBhaW9fY29udGV4dF9ub3RpZmllcl9jYihFdmVudE5vdGlmaWVyICplKQogewor
ICAgIEFpb0NvbnRleHQgKmN0eCA9IGNvbnRhaW5lcl9vZihlLCBBaW9Db250ZXh0LCBub3RpZmll
cik7CisKKyAgICBldmVudF9ub3RpZmllcl90ZXN0X2FuZF9jbGVhcigmY3R4LT5ub3RpZmllcik7
CiB9CiAKIC8qIFJldHVybnMgdHJ1ZSBpZiBhaW9fbm90aWZ5KCkgd2FzIGNhbGxlZCAoZS5nLiBh
IEJIIHdhcyBzY2hlZHVsZWQpICovCkBAIC01MDgsNyArNTA2LDcgQEAgQWlvQ29udGV4dCAqYWlv
X2NvbnRleHRfbmV3KEVycm9yICoqZXJycCkKIAogICAgIGFpb19zZXRfZXZlbnRfbm90aWZpZXIo
Y3R4LCAmY3R4LT5ub3RpZmllciwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZhbHNlLAot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYWlvX2NvbnRleHRfbm90aWZpZXJfZHVtbXlfY2Is
CisgICAgICAgICAgICAgICAgICAgICAgICAgICBhaW9fY29udGV4dF9ub3RpZmllcl9jYiwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGFpb19jb250ZXh0X25vdGlmaWVyX3BvbGwpOwogI2lm
ZGVmIENPTkZJR19MSU5VWF9BSU8KICAgICBjdHgtPmxpbnV4X2FpbyA9IE5VTEw7Ci0tIAoyLjI2
LjIKCg==


