Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D39C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007F020674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPkcbYiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007F020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtqD-0004Gn-4C
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jDsGr-0004IV-Cc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jDsGq-0001DM-Al
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44297)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jDsGq-0001Ae-4K
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTgI/nlz6J7xfzMurOKQXZJuFv1H/GjoGqD7EAU+5Dw=;
 b=QPkcbYiTX15B5KbHTuWJeNz2eJ90xqqnyZIvqzux8wB7ISDK5MhJKWwio9bMuaYi25AHKG
 H1w5nrN6WXFuhKRgNuiuY9CTTzJANNRiAF7orCSWkPdPMlXkbdC2bH6w5w8lLtje64/25Y
 d1Q5NWxjvNw2Q18HWVzccVm3TrZD294=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-ylJWVIKWMhiqWwL0Xr3j3g-1; Mon, 16 Mar 2020 12:07:14 -0400
X-MC-Unique: ylJWVIKWMhiqWwL0Xr3j3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F9D8115EF54;
 Mon, 16 Mar 2020 16:07:13 +0000 (UTC)
Received: from localhost (ovpn-117-61.ams2.redhat.com [10.36.117.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B88A11001B07;
 Mon, 16 Mar 2020 16:07:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/rdma: avoid suspicious strncpy() use
Date: Mon, 16 Mar 2020 16:07:02 +0000
Message-Id: <20200316160702.478964-3-stefanha@redhat.com>
In-Reply-To: <20200316160702.478964-1-stefanha@redhat.com>
References: <20200316160702.478964-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Z2NjIChHQ0MpIDkuMi4xIDIwMTkwODI3IChSZWQgSGF0IDkuMi4xLTEpIHdpdGggc2FuaXRpemVy
cyBlbmFibGVkCnJlcG9ydHMgdGhlIGZvbGxvd2luZyBlcnJvcjoKCiAgQ0MgICAgICB4ODZfNjQt
c29mdG1tdS9ody9yZG1hL3Ztdy9wdnJkbWFfZGV2X3JpbmcubwpJbiBmaWxlIGluY2x1ZGVkIGZy
b20gL3Vzci9pbmNsdWRlL3N0cmluZy5oOjQ5NSwKICAgICAgICAgICAgICAgICBmcm9tIGluY2x1
ZGUvcWVtdS9vc2RlcC5oOjEwMSwKICAgICAgICAgICAgICAgICBmcm9tIGh3L3JkbWEvdm13L3B2
cmRtYV9kZXZfcmluZy5jOjE2OgpJbiBmdW5jdGlvbiDigJhzdHJuY3B54oCZLAogICAgaW5saW5l
ZCBmcm9tIOKAmHB2cmRtYV9yaW5nX2luaXTigJkgYXQgaHcvcmRtYS92bXcvcHZyZG1hX2Rldl9y
aW5nLmM6MzM6NToKL3Vzci9pbmNsdWRlL2JpdHMvc3RyaW5nX2ZvcnRpZmllZC5oOjEwNjoxMDog
ZXJyb3I6IOKAmF9fYnVpbHRpbl9zdHJuY3B54oCZIHNwZWNpZmllZCBib3VuZCAzMiBlcXVhbHMg
ZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQogIDEwNiB8ICAg
cmV0dXJuIF9fYnVpbHRpbl9fX3N0cm5jcHlfY2hrIChfX2Rlc3QsIF9fc3JjLCBfX2xlbiwgX19i
b3MgKF9fZGVzdCkpOwogICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpVc2UgcHN0cmNweSgpIGluc3Rl
YWQgb2Ygc3RybmNweSgpLiAgSXQgaXMgZ3VhcmFudGVlZCB0byBOVUwtdGVybWluYXRlCnN0cmlu
Z3MuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
Ci0tLQogaHcvcmRtYS92bXcvcHZyZG1hX2Rldl9yaW5nLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaHcvcmRt
YS92bXcvcHZyZG1hX2Rldl9yaW5nLmMgYi9ody9yZG1hL3Ztdy9wdnJkbWFfZGV2X3JpbmcuYwpp
bmRleCBkN2JjN2Y1Y2NjLi43NGI4ZmE4MzRjIDEwMDY0NAotLS0gYS9ody9yZG1hL3Ztdy9wdnJk
bWFfZGV2X3JpbmcuYworKysgYi9ody9yZG1hL3Ztdy9wdnJkbWFfZGV2X3JpbmcuYwpAQCAtMTQs
NiArMTQsNyBAQAogICovCiAKICNpbmNsdWRlICJxZW11L29zZGVwLmgiCisjaW5jbHVkZSAicWVt
dS9jdXRpbHMuaCIKICNpbmNsdWRlICJody9wY2kvcGNpLmgiCiAjaW5jbHVkZSAiY3B1LmgiCiAK
QEAgLTMwLDggKzMxLDcgQEAgaW50IHB2cmRtYV9yaW5nX2luaXQoUHZyZG1hUmluZyAqcmluZywg
Y29uc3QgY2hhciAqbmFtZSwgUENJRGV2aWNlICpkZXYsCiAgICAgaW50IGk7CiAgICAgaW50IHJj
ID0gMDsKIAotICAgIHN0cm5jcHkocmluZy0+bmFtZSwgbmFtZSwgTUFYX1JJTkdfTkFNRV9TWik7
Ci0gICAgcmluZy0+bmFtZVtNQVhfUklOR19OQU1FX1NaIC0gMV0gPSAwOworICAgIHBzdHJjcHko
cmluZy0+bmFtZSwgTUFYX1JJTkdfTkFNRV9TWiwgbmFtZSk7CiAgICAgcmluZy0+ZGV2ID0gZGV2
OwogICAgIHJpbmctPnJpbmdfc3RhdGUgPSByaW5nX3N0YXRlOwogICAgIHJpbmctPm1heF9lbGVt
cyA9IG1heF9lbGVtczsKLS0gCjIuMjQuMQoK


