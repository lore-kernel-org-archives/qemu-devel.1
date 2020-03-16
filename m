Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF289C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B944D205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z74fXayi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B944D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtcJ-0002Qd-S7
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jDsGp-0004Gr-VC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jDsGo-00010b-Ix
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30011)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jDsGo-0000xH-El
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/usjdqYuVUkky4E7ILH7W1xV57FQXTwQaWgE352H60=;
 b=Z74fXayibjiETiC6mmFjCF6gh+GFmeN1ZC2+MjQjVwJR0dZb/sj8HHB4yBRYLvTyI/I4wa
 tN6T4WB+LFZgrkxBH/MapjhZdYPB7XtZbMKOCl7q9AuMJdgQvgSd+RCfE9sJnw3bq35/FG
 AxRxEuRJ9wfcLoxyOjLhRur8MZR2KAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-P1SWZ1KwMqa-zbcP3GRITQ-1; Mon, 16 Mar 2020 12:07:12 -0400
X-MC-Unique: P1SWZ1KwMqa-zbcP3GRITQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5418D19389DB;
 Mon, 16 Mar 2020 16:07:11 +0000 (UTC)
Received: from localhost (ovpn-117-61.ams2.redhat.com [10.36.117.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C7188FC16;
 Mon, 16 Mar 2020 16:07:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] migration: avoid suspicious strncpy() use
Date: Mon, 16 Mar 2020 16:07:01 +0000
Message-Id: <20200316160702.478964-2-stefanha@redhat.com>
In-Reply-To: <20200316160702.478964-1-stefanha@redhat.com>
References: <20200316160702.478964-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Z2NjIChHQ0MpIDkuMi4xIDIwMTkwODI3IChSZWQgSGF0IDkuMi4xLTEpIHdpdGggc2FuaXRpemVy
cyBlbmFibGVkCnJlcG9ydHMgdGhlIGZvbGxvd2luZyBlcnJvcjoKCiAgICBDQyAgICAgIG1pZ3Jh
dGlvbi9nbG9iYWxfc3RhdGUubwogIEluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNyL2luY2x1ZGUv
c3RyaW5nLmg6NDk1LAogICAgICAgICAgICAgICAgICAgZnJvbSAvaG9tZS9zdGVmYW5oYS9xZW11
L2luY2x1ZGUvcWVtdS9vc2RlcC5oOjEwMSwKICAgICAgICAgICAgICAgICAgIGZyb20gbWlncmF0
aW9uL2dsb2JhbF9zdGF0ZS5jOjEzOgogIEluIGZ1bmN0aW9uIOKAmHN0cm5jcHnigJksCiAgICAg
IGlubGluZWQgZnJvbSDigJhnbG9iYWxfc3RhdGVfc3RvcmVfcnVubmluZ+KAmSBhdCBtaWdyYXRp
b24vZ2xvYmFsX3N0YXRlLmM6NDc6NToKICAvdXNyL2luY2x1ZGUvYml0cy9zdHJpbmdfZm9ydGlm
aWVkLmg6MTA2OjEwOiBlcnJvcjog4oCYX19idWlsdGluX3N0cm5jcHnigJkgc3BlY2lmaWVkIGJv
dW5kIDEwMCBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0
aW9uXQogICAgMTA2IHwgICByZXR1cm4gX19idWlsdGluX19fc3RybmNweV9jaGsgKF9fZGVzdCwg
X19zcmMsIF9fbGVuLCBfX2JvcyAoX19kZXN0KSk7CiAgICAgICAgfCAgICAgICAgICBefn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoK
VXNlIHBzdHJjcHkoKSBpbnN0ZWFkIG9mIHN0cm5jcHkoKS4gIEl0IGlzIGd1YXJhbnRlZWQgdG8g
TlVMLXRlcm1pbmF0ZQpzdHJpbmdzLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxz
dGVmYW5oYUByZWRoYXQuY29tPgotLS0KIG1pZ3JhdGlvbi9nbG9iYWxfc3RhdGUuYyB8IDQgKyst
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9taWdyYXRpb24vZ2xvYmFsX3N0YXRlLmMgYi9taWdyYXRpb24vZ2xvYmFsX3N0YXRl
LmMKaW5kZXggMjUzMTE0NzlhNC4uY2JlMDdmMjFhOCAxMDA2NDQKLS0tIGEvbWlncmF0aW9uL2ds
b2JhbF9zdGF0ZS5jCisrKyBiL21pZ3JhdGlvbi9nbG9iYWxfc3RhdGUuYwpAQCAtNDQsOCArNDQs
OCBAQCB2b2lkIGdsb2JhbF9zdGF0ZV9zdG9yZV9ydW5uaW5nKHZvaWQpCiB7CiAgICAgY29uc3Qg
Y2hhciAqc3RhdGUgPSBSdW5TdGF0ZV9zdHIoUlVOX1NUQVRFX1JVTk5JTkcpOwogICAgIGFzc2Vy
dChzdHJsZW4oc3RhdGUpIDwgc2l6ZW9mKGdsb2JhbF9zdGF0ZS5ydW5zdGF0ZSkpOwotICAgIHN0
cm5jcHkoKGNoYXIgKilnbG9iYWxfc3RhdGUucnVuc3RhdGUsCi0gICAgICAgICAgIHN0YXRlLCBz
aXplb2YoZ2xvYmFsX3N0YXRlLnJ1bnN0YXRlKSk7CisgICAgcHN0cmNweSgoY2hhciAqKWdsb2Jh
bF9zdGF0ZS5ydW5zdGF0ZSwKKyAgICAgICAgICAgIHNpemVvZihnbG9iYWxfc3RhdGUucnVuc3Rh
dGUpLCBzdGF0ZSk7CiB9CiAKIGJvb2wgZ2xvYmFsX3N0YXRlX3JlY2VpdmVkKHZvaWQpCi0tIAoy
LjI0LjEKCg==


