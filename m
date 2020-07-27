Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07911C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C964A2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnGOghG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C964A2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08Pr-0004GX-2c
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k08Oa-00032l-5L
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:02:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k08OY-0007Iu-Nc
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595876561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEigPhAsJlaMyex/Vvtyzdslzb9kdarksDey735m440=;
 b=OnGOghG+ZPyH+hnnKa8rH8J9drfCf6THWX8Ib/DNJZZVWx/OJ7ywhICGOYIHBAkEnK/mkC
 CggsYadXKDrWcTvn/3KaEggp0LmahmMtFBkrFPWnHs8hxKYpkcAEOQYjNjs6iSCHaqjiwG
 IcWvxnuMaw/i/5v49nGtRkv2TF5IJL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-E7xks-oBNfugWaQyRCfJPg-1; Mon, 27 Jul 2020 15:02:39 -0400
X-MC-Unique: E7xks-oBNfugWaQyRCfJPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9123059
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 19:02:38 +0000 (UTC)
Received: from localhost (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F831712D7;
 Mon, 27 Jul 2020 19:02:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] virtiofsd: drop CAP_DAC_READ_SEARCH
Date: Mon, 27 Jul 2020 20:02:21 +0100
Message-Id: <20200727190223.422280-2-stefanha@redhat.com>
In-Reply-To: <20200727190223.422280-1-stefanha@redhat.com>
References: <20200727190223.422280-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: vromanso@redhat.com, Daniel Walsh <dwalsh@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, rmohr@redhat.com,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, mpatel@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dmlydGlvZnNkIGRvZXMgbm90IG5lZWQgQ0FQX0RBQ19SRUFEX1NFQVJDSCBiZWNhdXNlIGl0IGFs
cmVhZHkgaGFzCnRoZSBtb3JlIHBvd2VyZnVsIENBUF9EQUNfT1ZFUlJJREUuIERyb3AgaXQgZnJv
bSB0aGUgbGlzdCBvZgpjYXBhYmlsaXRpZXMuCgpUaGlzIGlzIGltcG9ydGFudCBiZWNhdXNlIGNv
bnRhaW5lciBydW50aW1lcyBtYXkgbm90IGluY2x1ZGUKQ0FQX0RBQ19SRUFEX1NFQVJDSCBieSBk
ZWZhdWx0LiBUaGlzIHBhdGNoIGFsbG93cyB2aXJ0aW9mc2QgdG8gcmVkdWNlCml0cyBjYXBhYmls
aXRpZXMgd2hlbiBydW5uaW5nIGluc2lkZSBhIERvY2tlciBjb250YWluZXIuCgpOb3RlIHRoYXQg
Q0FQX0RBQ19SRUFEX1NFQVJDSCBtYXkgYmUgbmVjZXNzYXJ5IGFnYWluIGluIHRoZSBmdXR1cmUg
aWYKdmlydGlvZnNkIHN0YXJ0cyB1c2luZyBvcGVuX2J5X2hhbmRsZV9hdCgyKS4KClNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6
IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgPGRnaWxiZXJ0QHJlZGhhdC5jb20+Ci0tLQogdG9vbHMv
dmlydGlvZnNkL3Bhc3N0aHJvdWdoX2xsLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdG9vbHMvdmlydGlvZnNkL3Bhc3N0aHJvdWdoX2xsLmMgYi90
b29scy92aXJ0aW9mc2QvcGFzc3Rocm91Z2hfbGwuYwppbmRleCA5NGUwZGUyZDJiLi41MGExNjRh
NTk5IDEwMDY0NAotLS0gYS90b29scy92aXJ0aW9mc2QvcGFzc3Rocm91Z2hfbGwuYworKysgYi90
b29scy92aXJ0aW9mc2QvcGFzc3Rocm91Z2hfbGwuYwpAQCAtMjU5Niw3ICsyNTk2LDYgQEAgc3Rh
dGljIHZvaWQgc2V0dXBfY2FwYWJpbGl0aWVzKGNoYXIgKm1vZGNhcHNfaW4pCiAgICAgaWYgKGNh
cG5nX3VwZGF0ZXYoQ0FQTkdfQURELCBDQVBOR19QRVJNSVRURUQgfCBDQVBOR19FRkZFQ1RJVkUs
CiAgICAgICAgICAgICBDQVBfQ0hPV04sCiAgICAgICAgICAgICBDQVBfREFDX09WRVJSSURFLAot
ICAgICAgICAgICAgQ0FQX0RBQ19SRUFEX1NFQVJDSCwKICAgICAgICAgICAgIENBUF9GT1dORVIs
CiAgICAgICAgICAgICBDQVBfRlNFVElELAogICAgICAgICAgICAgQ0FQX1NFVEdJRCwKLS0gCjIu
MjYuMgoK


