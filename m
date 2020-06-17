Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C04C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B646720776
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SF/FRwZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B646720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlY4K-0007zH-U2
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlY1Z-0002x8-2W
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:22:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlY1X-0002nu-CT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592400158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TT69A6sn6nxaF8vf9SlSTJ0DEvgXoB2t1fj/EcQTgZg=;
 b=SF/FRwZF23kUuVjJXKlavtG9RxMA1zh9HCfl7LfB9kYukS+HW4rl9LusTgtrsq/1iscuBX
 nEp+imFyTJbrz0rraIKQ4Hqf0h21tUBwJ2fIgGwwA8EwtpQ9XoARXGf3gqC4WBTjpyfhKz
 aKt6bKE3MG8a1tNEsuycxr860DI3/qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-Fx3iNc8BOlu9e-_hXzHnZA-1; Wed, 17 Jun 2020 09:22:35 -0400
X-MC-Unique: Fx3iNc8BOlu9e-_hXzHnZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36DEE8035D2;
 Wed, 17 Jun 2020 13:22:34 +0000 (UTC)
Received: from localhost (ovpn-114-151.ams2.redhat.com [10.36.114.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D2DA1002394;
 Wed, 17 Jun 2020 13:22:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] block/nvme: clarify that free_req_queue is protected
 by q->lock
Date: Wed, 17 Jun 2020 14:21:59 +0100
Message-Id: <20200617132201.1832152-6-stefanha@redhat.com>
In-Reply-To: <20200617132201.1832152-1-stefanha@redhat.com>
References: <20200617132201.1832152-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RXhpc3RpbmcgdXNlcnMgYWNjZXNzIGZyZWVfcmVxX3F1ZXVlIHVuZGVyIHEtPmxvY2suIERvY3Vt
ZW50IHRoaXMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+ClJldmlld2VkLWJ5OiBTZXJnaW8gTG9wZXogPHNscEByZWRoYXQuY29tPgpSZXZpZXdl
ZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgotLS0KIGJs
b2NrL252bWUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL252bWUuYyBiL2Jsb2NrL252bWUuYwppbmRleCA4
ZTYwODgyYWYzLi40MjZjNzdlNWFiIDEwMDY0NAotLS0gYS9ibG9jay9udm1lLmMKKysrIGIvYmxv
Y2svbnZtZS5jCkBAIC01Nyw3ICs1Nyw2IEBAIHR5cGVkZWYgc3RydWN0IHsKIH0gTlZNZVJlcXVl
c3Q7CiAKIHR5cGVkZWYgc3RydWN0IHsKLSAgICBDb1F1ZXVlICAgICBmcmVlX3JlcV9xdWV1ZTsK
ICAgICBRZW11TXV0ZXggICBsb2NrOwogCiAgICAgLyogRmllbGRzIHByb3RlY3RlZCBieSBCUUwg
Ki8KQEAgLTY1LDYgKzY0LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgewogICAgIHVpbnQ4X3QgICAgICpw
cnBfbGlzdF9wYWdlczsKIAogICAgIC8qIEZpZWxkcyBwcm90ZWN0ZWQgYnkgQGxvY2sgKi8KKyAg
ICBDb1F1ZXVlICAgICBmcmVlX3JlcV9xdWV1ZTsKICAgICBOVk1lUXVldWUgICBzcSwgY3E7CiAg
ICAgaW50ICAgICAgICAgY3FfcGhhc2U7CiAgICAgaW50ICAgICAgICAgZnJlZV9yZXFfaGVhZDsK
LS0gCjIuMjYuMgoK


