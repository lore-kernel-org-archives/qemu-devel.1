Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41167C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1A0206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vy8H68yI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1A0206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFlv-0002J9-9B
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFip-0005wv-0g
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46433
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFim-0006fX-MJ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/lfnL4sZXHtl+qlzPzdmzfltq9+rSdml1mjkHgKpYs=;
 b=Vy8H68yIAKQUda2LlAGAQZ8s+wRAGtkc6RYeCi599KbjdWCQ6oFzh0VzQF3RovwurYmqwF
 L0q0a2tHijHootCkLTrVrWw+0SvXWsG4iIs6Bls8zI4dsK9hb5kvRyxmdAlMRlhaIpiMrN
 fbMqFnENKpN4RmrVmg0wsQMiUNofL0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-DoWWaWtcPUW-V4zFzHcp7w-1; Fri, 19 Jun 2020 08:02:09 -0400
X-MC-Unique: DoWWaWtcPUW-V4zFzHcp7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2ADB18FE864;
 Fri, 19 Jun 2020 12:02:08 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7027D7C1EC;
 Fri, 19 Jun 2020 12:02:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 2/6] block-helpers: switch to int64_t block size values
Date: Fri, 19 Jun 2020 13:01:53 +0100
Message-Id: <20200619120157.2422429-2-stefanha@redhat.com>
In-Reply-To: <20200619120157.2422429-1-stefanha@redhat.com>
References: <20200614183907.514282-4-coiby.xu@gmail.com>
 <20200619120157.2422429-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHVpbnQxNl90IHR5cGUgaXMgdG9vIHNtYWxsIGZvciBNQVhfQkxPQ0tfU0laRSAoMiBNaUIp
LiBUaGUgaW50NjRfdAp0eXBlIGlzIHdpZGVseSB1c2VkIGluIFFFTVUgYXMgYSB0eXBlIGZvciBk
aXNrIG9mZnNldHMgYW5kIHNpemVzLCBzbwppdCdzIGFuIGFwcHJvcHJpYXRlIHR5cGUgdG8gdXNl
IGhlcmUuIEl0IHdpbGwgd29yayBmb3IgYWxsIGNhbGxlcnMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdXRpbC9ibG9jay1oZWxwZXJz
LmggfCAyICstCiB1dGlsL2Jsb2NrLWhlbHBlcnMuYyB8IDQgKystLQogMiBmaWxlcyBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC9ibG9j
ay1oZWxwZXJzLmggYi91dGlsL2Jsb2NrLWhlbHBlcnMuaAppbmRleCA0Njk3NWNhN2FmLi5lYzY0
MjE1NjBjIDEwMDY0NAotLS0gYS91dGlsL2Jsb2NrLWhlbHBlcnMuaAorKysgYi91dGlsL2Jsb2Nr
LWhlbHBlcnMuaApAQCAtMTMsNyArMTMsNyBAQAogI2RlZmluZSBNQVhfQkxPQ0tfU0laRSAgICAg
ICAgICAoMiAqIE1pQikKICNkZWZpbmUgTUFYX0JMT0NLX1NJWkVfU1RSICAgICAgIjIgTWlCIgog
Ci12b2lkIGNoZWNrX2xvZ2ljYWxfYmxvY2tfc2l6ZShjb25zdCBjaGFyICppZCwgY29uc3QgY2hh
ciAqbmFtZSwgdWludDE2X3QgdmFsdWUsCit2b2lkIGNoZWNrX2xvZ2ljYWxfYmxvY2tfc2l6ZShj
b25zdCBjaGFyICppZCwgY29uc3QgY2hhciAqbmFtZSwgaW50NjRfdCB2YWx1ZSwKICAgICAgICAg
ICAgICAgICAgICAgIEVycm9yICoqZXJycCk7CiAKICNlbmRpZiAvKiBCTE9DS19IRUxQRVJTX0gg
Ki8KZGlmZiAtLWdpdCBhL3V0aWwvYmxvY2staGVscGVycy5jIGIvdXRpbC9ibG9jay1oZWxwZXJz
LmMKaW5kZXggMDg5ZmUzNDAxZC4uOWU2ODk1NGM0NiAxMDA2NDQKLS0tIGEvdXRpbC9ibG9jay1o
ZWxwZXJzLmMKKysrIGIvdXRpbC9ibG9jay1oZWxwZXJzLmMKQEAgLTIyLDcgKzIyLDcgQEAKICAq
CiAgKiAgTW92ZWQgZnJvbSBody9jb3JlL3FkZXYtcHJvcGVydGllcy5jOnNldF9ibG9ja3NpemUo
KQogICovCi12b2lkIGNoZWNrX2xvZ2ljYWxfYmxvY2tfc2l6ZShjb25zdCBjaGFyICppZCwgY29u
c3QgY2hhciAqbmFtZSwgdWludDE2X3QgdmFsdWUsCit2b2lkIGNoZWNrX2xvZ2ljYWxfYmxvY2tf
c2l6ZShjb25zdCBjaGFyICppZCwgY29uc3QgY2hhciAqbmFtZSwgaW50NjRfdCB2YWx1ZSwKICAg
ICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkKIHsKICAgICAvKiB2YWx1ZSBvZiAwIG1l
YW5zICJ1bnNldCIgKi8KQEAgLTM3LDcgKzM3LDcgQEAgdm9pZCBjaGVja19sb2dpY2FsX2Jsb2Nr
X3NpemUoY29uc3QgY2hhciAqaWQsIGNvbnN0IGNoYXIgKm5hbWUsIHVpbnQxNl90IHZhbHVlLAog
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsCiAgICAgICAgICAgICAgICAgICAgIlByb3BlcnR5ICVz
LiVzIGRvZXNuJ3QgdGFrZSB2YWx1ZSAnJSIgUFJJZDY0CiAgICAgICAgICAgICAgICAgICAgIics
IGl0J3Mgbm90IGEgcG93ZXIgb2YgMiIsCi0gICAgICAgICAgICAgICAgICAgaWQsIG5hbWUsIChp
bnQ2NF90KXZhbHVlKTsKKyAgICAgICAgICAgICAgICAgICBpZCwgbmFtZSwgdmFsdWUpOwogICAg
ICAgICByZXR1cm47CiAgICAgfQogfQotLSAKMi4yNi4yCgo=


