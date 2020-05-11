Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D14C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724D4206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeTk1bbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724D4206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDJF-0000lA-Kq
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYDII-0007Vn-Lo
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:36:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYDII-0005CP-0D
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589222209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=detrTPCuCfAG/mIePNerc0GXWkj/VuOpI3Y0eXMjOvA=;
 b=GeTk1bbLLwMm3OhOOh71xdswElfuy8DDOJsn4ocNBeBUzebitb69vtaa68Gyc7w91aAawk
 l2LOh2EWx37ZfnwzXGbMt7EOQL4xts0vvZiyDh6H+UGckccvm6lk89FMEge6mEVNUdYfF7
 sFu5cZMBah8XWec/VWqxxPT9ItmOl5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-J8MuR9SyM8ua4DJT9-IjbA-1; Mon, 11 May 2020 14:36:45 -0400
X-MC-Unique: J8MuR9SyM8ua4DJT9-IjbA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37640107ACCA;
 Mon, 11 May 2020 18:36:44 +0000 (UTC)
Received: from localhost (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 344CB1002382;
 Mon, 11 May 2020 18:36:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] aio-posix: don't duplicate fd handler deletion in
 fdmon_io_uring_destroy()
Date: Mon, 11 May 2020 19:36:29 +0100
Message-Id: <20200511183630.279750-2-stefanha@redhat.com>
In-Reply-To: <20200511183630.279750-1-stefanha@redhat.com>
References: <20200511183630.279750-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGlvX3VyaW5nIGZpbGUgZGVzY3JpcHRvciBtb25pdG9yaW5nIGltcGxlbWVudGF0aW9uIGhh
cyBhbiBpbnRlcm5hbApsaXN0IG9mIGZkIGhhbmRsZXJzIHRoYXQgYXJlIHBlbmRpbmcgc3VibWlz
c2lvbiB0byBpb191cmluZy4KZmRtb25faW9fdXJpbmdfZGVzdHJveSgpIGRlbGV0ZXMgYWxsIGZk
IGhhbmRsZXJzIG9uIHRoZSBsaXN0LgoKRG9uJ3QgZGVsZXRlIGZkIGhhbmRsZXJzIGRpcmVjdGx5
IGluIGZkbW9uX2lvX3VyaW5nX2Rlc3Ryb3koKSBmb3IgdHdvCnJlYXNvbnM6CjEuIFRoaXMgZHVw
bGljYXRlcyB0aGUgYWlvLXBvc2l4LmMgQWlvSGFuZGxlciBkZWxldGlvbiBjb2RlIGFuZCBjb3Vs
ZAogICBiZWNvbWUgb3V0ZGF0ZWQgaWYgdGhlIHN0cnVjdCBjaGFuZ2VzLgoyLiBPbmx5IGhhbmRs
ZXJzIHdpdGggdGhlIEZETU9OX0lPX1VSSU5HX1JFTU9WRSBmbGFnIHNldCBhcmUgc2FmZSB0bwog
ICByZW1vdmUuIElmIHRoZSBmbGFnIGlzIG5vdCBzZXQgdGhlbiBzb21ldGhpbmcgc3RpbGwgaGFz
IGEgcG9pbnRlciB0bwogICB0aGUgZmQgaGFuZGxlci4gTGV0IGFpby1wb3NpeC5jIGFuZCBpdHMg
dXNlciB3b3JyeSBhYm91dCB0aGF0LiBJbgogICBwcmFjdGljZSB0aGlzIGlzbid0IGFuIGlzc3Vl
IGJlY2F1c2UgZmRtb25faW9fdXJpbmdfZGVzdHJveSgpIGlzIG9ubHkKICAgY2FsbGVkIHdoZW4g
c2h1dHRpbmcgZG93biBzbyBhbGwgdXNlcnMgaGF2ZSByZW1vdmVkIHRoZWlyIGZkCiAgIGhhbmRs
ZXJzLCBidXQgdGhlIG5leHQgcGF0Y2ggd2lsbCBuZWVkIHRoaXMhCgpTaWduZWQtb2ZmLWJ5OiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdXRpbC9haW8tcG9zaXgu
YyAgICAgIHwgIDEgKwogdXRpbC9mZG1vbi1pb191cmluZy5jIHwgMTMgKysrKysrKysrKy0tLQog
MiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3V0aWwvYWlvLXBvc2l4LmMgYi91dGlsL2Fpby1wb3NpeC5jCmluZGV4IGMzNjEzZDI5
OWUuLjhhZjMzNGFiMTkgMTAwNjQ0Ci0tLSBhL3V0aWwvYWlvLXBvc2l4LmMKKysrIGIvdXRpbC9h
aW8tcG9zaXguYwpAQCAtNjc5LDYgKzY3OSw3IEBAIHZvaWQgYWlvX2NvbnRleHRfZGVzdHJveShB
aW9Db250ZXh0ICpjdHgpCiB7CiAgICAgZmRtb25faW9fdXJpbmdfZGVzdHJveShjdHgpOwogICAg
IGZkbW9uX2Vwb2xsX2Rpc2FibGUoY3R4KTsKKyAgICBhaW9fZnJlZV9kZWxldGVkX2hhbmRsZXJz
KGN0eCk7CiB9CiAKIHZvaWQgYWlvX2NvbnRleHRfc2V0X3BvbGxfcGFyYW1zKEFpb0NvbnRleHQg
KmN0eCwgaW50NjRfdCBtYXhfbnMsCmRpZmYgLS1naXQgYS91dGlsL2ZkbW9uLWlvX3VyaW5nLmMg
Yi91dGlsL2ZkbW9uLWlvX3VyaW5nLmMKaW5kZXggZDVhODBlZDZmYi4uMWQxNDE3N2RmMCAxMDA2
NDQKLS0tIGEvdXRpbC9mZG1vbi1pb191cmluZy5jCisrKyBiL3V0aWwvZmRtb24taW9fdXJpbmcu
YwpAQCAtMzQyLDExICszNDIsMTggQEAgdm9pZCBmZG1vbl9pb191cmluZ19kZXN0cm95KEFpb0Nv
bnRleHQgKmN0eCkKIAogICAgICAgICBpb191cmluZ19xdWV1ZV9leGl0KCZjdHgtPmZkbW9uX2lv
X3VyaW5nKTsKIAotICAgICAgICAvKiBObyBuZWVkIHRvIHN1Ym1pdCB0aGVzZSBhbnltb3JlLCBq
dXN0IGZyZWUgdGhlbS4gKi8KKyAgICAgICAgLyogTW92ZSBoYW5kbGVycyBkdWUgdG8gYmUgcmVt
b3ZlZCBvbnRvIHRoZSBkZWxldGVkIGxpc3QgKi8KICAgICAgICAgd2hpbGUgKChub2RlID0gUVNM
SVNUX0ZJUlNUX1JDVSgmY3R4LT5zdWJtaXRfbGlzdCkpKSB7CisgICAgICAgICAgICB1bnNpZ25l
ZCBmbGFncyA9IGF0b21pY19mZXRjaF9hbmQoJm5vZGUtPmZsYWdzLAorICAgICAgICAgICAgICAg
ICAgICB+KEZETU9OX0lPX1VSSU5HX1BFTkRJTkcgfAorICAgICAgICAgICAgICAgICAgICAgIEZE
TU9OX0lPX1VSSU5HX0FERCB8CisgICAgICAgICAgICAgICAgICAgICAgRkRNT05fSU9fVVJJTkdf
UkVNT1ZFKSk7CisKKyAgICAgICAgICAgIGlmIChmbGFncyAmIEZETU9OX0lPX1VSSU5HX1JFTU9W
RSkgeworICAgICAgICAgICAgICAgIFFMSVNUX0lOU0VSVF9IRUFEX1JDVSgmY3R4LT5kZWxldGVk
X2Fpb19oYW5kbGVycywgbm9kZSwgbm9kZV9kZWxldGVkKTsKKyAgICAgICAgICAgIH0KKwogICAg
ICAgICAgICAgUVNMSVNUX1JFTU9WRV9IRUFEX1JDVSgmY3R4LT5zdWJtaXRfbGlzdCwgbm9kZV9z
dWJtaXR0ZWQpOwotICAgICAgICAgICAgUUxJU1RfUkVNT1ZFKG5vZGUsIG5vZGUpOwotICAgICAg
ICAgICAgZ19mcmVlKG5vZGUpOwogICAgICAgICB9CiAKICAgICAgICAgY3R4LT5mZG1vbl9vcHMg
PSAmZmRtb25fcG9sbF9vcHM7Ci0tIAoyLjI1LjMKCg==


