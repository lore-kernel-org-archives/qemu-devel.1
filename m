Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F14BC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD0020663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbgS4uHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD0020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEIO-0008T1-VZ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jEDzV-0005Rh-CN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jEDzU-0008R6-02
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:18:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49647)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jEDzT-0008P1-Sh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584458326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ws8HDmVwvDV5AY92fxD3+WmuLSy/5BMimrFpbSm5Wjc=;
 b=WbgS4uHYIHaCH6jhoNBXum0IuagetjfBioHAMhu8USM2VEIbcNWAZ3H3l7HuPc8CEg3E9u
 7ypH3Y1orzrQC18/te/pmCMTCdTdYqw6AWZWLqL3JX8KjI9GuYMN3winIq1D3ve1oRmy/v
 ZwjwSzeepXZh4O6FkDGIw7lvhqRrLc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-f_MuiGN0OduPi4lGZ0i4Yg-1; Tue, 17 Mar 2020 11:18:41 -0400
X-MC-Unique: f_MuiGN0OduPi4lGZ0i4Yg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B7DF8017DF;
 Tue, 17 Mar 2020 15:18:40 +0000 (UTC)
Received: from localhost (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23E4810840CD;
 Tue, 17 Mar 2020 15:18:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] block/io: fix bdrv_co_do_copy_on_readv
Date: Tue, 17 Mar 2020 15:18:31 +0000
Message-Id: <20200317151831.531965-2-stefanha@redhat.com>
In-Reply-To: <20200317151831.531965-1-stefanha@redhat.com>
References: <20200317151831.531965-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPgoKUHJpb3IgdG8gMTE0M2VjNWViZjQgaXQgd2FzIE9LIHRvIHFlbXVfaW92ZWNfZnJvbV9i
dWYoKSBmcm9tIGFsaWduZWQtdXAKYnVmZmVyIHRvIG9yaWdpbmFsIHFpb3YsIGFzIHFlbXVfaW92
ZWNfZnJvbV9idWYoKSB3aWxsIHN0b3AgYXQgcWlvdiBlbmQKYW55d2F5LgoKQnV0IGFmdGVyIDEx
NDNlYzVlYmY0IHdlIGFzc3VtZSB0aGF0IGJkcnZfY29fZG9fY29weV9vbl9yZWFkdiB3b3JrcyBv
bgpwYXJ0IG9mIG9yaWdpbmFsIHFpb3YsIGRlZmluZWQgYnkgcWlvdl9vZmZzZXQgYW5kIGJ5dGVz
LiBTbyB3ZSBtdXN0IG5vdAp0b3VjaCBxaW92IGJlaGluZCBxaW92X29mZnNldCtieXRlcyBib3Vu
ZC4gRml4IGl0LgoKQ2M6IHFlbXUtc3RhYmxlQG5vbmdudS5vcmcgIyB2NC4yCkZpeGVzOiAxMTQz
ZWM1ZWJmNApTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+ClJldmlld2VkLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhh
dC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwMzEyMDgxOTQ5LjUzNTAtMS12c2VtZW50c292QHZpcnR1
b3p6by5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQu
Y29tPgotLS0KIGJsb2NrL2lvLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9ibG9jay9pby5jIGIvYmxvY2svaW8uYwpp
bmRleCA3ZTRjYjc0Y2Y0Li5hYmE2N2Y2NmI5IDEwMDY0NAotLS0gYS9ibG9jay9pby5jCisrKyBi
L2Jsb2NrL2lvLmMKQEAgLTEzOTksNyArMTM5OSw3IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2Zu
IGJkcnZfY29fZG9fY29weV9vbl9yZWFkdihCZHJ2Q2hpbGQgKmNoaWxkLAogICAgICAgICAgICAg
aWYgKCEoZmxhZ3MgJiBCRFJWX1JFUV9QUkVGRVRDSCkpIHsKICAgICAgICAgICAgICAgICBxZW11
X2lvdmVjX2Zyb21fYnVmKHFpb3YsIHFpb3Zfb2Zmc2V0ICsgcHJvZ3Jlc3MsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBib3VuY2VfYnVmZmVyICsgc2tpcF9ieXRlcywKLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBudW0gLSBza2lwX2J5dGVzKTsKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1JTihwbnVtIC0gc2tpcF9ieXRlcywg
Ynl0ZXMgLSBwcm9ncmVzcykpOwogICAgICAgICAgICAgfQogICAgICAgICB9IGVsc2UgaWYgKCEo
ZmxhZ3MgJiBCRFJWX1JFUV9QUkVGRVRDSCkpIHsKICAgICAgICAgICAgIC8qIFJlYWQgZGlyZWN0
bHkgaW50byB0aGUgZGVzdGluYXRpb24gKi8KLS0gCjIuMjQuMQoK


