Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3248CC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3785206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDqrRjJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3785206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDIz-00006B-78
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYDI9-0007Ha-Mz
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:36:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYDI9-0005BK-48
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589222200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fjUGUhphV+KYypr/GlDoUb5PDXuGZj++pV4ZcKF6gDM=;
 b=RDqrRjJ0bXkLaIKMsQluhROK7wmNPOQSEzfNp/SwZwbWGdceabF3oxJnjwjSEywSji1Y4+
 NQLsMCq3152TM63Dii683Fds1NmbB+E7nld9QxXT9fDIvTTh5s3Lk0U472gH+9/TYoqIjI
 4Uqasp+ge6FDokYd/RMw/5VGsPMgjJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-g1vhQhfpPG6QrhG1Fm1xCA-1; Mon, 11 May 2020 14:36:36 -0400
X-MC-Unique: g1vhQhfpPG6QrhG1Fm1xCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3448EC1A3;
 Mon, 11 May 2020 18:36:34 +0000 (UTC)
Received: from localhost (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A8925C1B5;
 Mon, 11 May 2020 18:36:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] aio-posix: fix fdmon-io_uring memory leak
Date: Mon, 11 May 2020 19:36:28 +0100
Message-Id: <20200511183630.279750-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBidWcgd2FzIGludHJvZHVjZWQgaW4gUUVNVSA1LjAgYW5kIGNhdXNlcyBndWVzdHMgdG8g
c2xvdyBkb3duIGJlY2F1c2UNCkFpb0hhbmRsZXJzIGFyZSBub3QgZnJlZWQgd2hlbiB0aGUgZmRt
b24taW9fdXJpbmcgZmlsZSBkZXNjcmlwdG9yIG1vbml0b3JpbmcNCmltcGxlbWVudGF0aW9uIGlz
IHVzZWQgYnkgdGhlIG1haW4gbG9vcCB0aHJlYWQncyBnbGliIGV2ZW50IGxvb3AuIFRoaXMgaXNz
dWUNCmRvZXMgbm90IGFwcGx5IHRvIElPVGhyZWFkIHVzYWdlIG9mIGZkbW9uLWlvX3VyaW5nLg0K
DQpJbiBwcmFjdGljZSBmZXcgZGlzdHJvcyBidWlsZCB3aXRoIGlvX3VyaW5nIHN1cHBvcnQgZW5h
YmxlZCBhdCB0aGUgbW9tZW50LCBzbw0KdGhlIG51bWJlciBvZiBhZmZlY3RlZCB1c2VycyBpcyBs
aWtlbHkgdG8gYmUgc21hbGwuIFRoZSBmaXggaXMgc3RpbGwgc3VpdGFibGUNCmZvciBhIHN0YWJs
ZSByZWxlYXNlIHRob3VnaC4NCg0KaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvcWVtdS8rYnVn
LzE4Nzc3MTYNCmh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L3FlbXUvK2J1Zy8xODczMDMyDQoN
ClN0ZWZhbiBIYWpub2N6aSAoMik6DQogIGFpby1wb3NpeDogZG9uJ3QgZHVwbGljYXRlIGZkIGhh
bmRsZXIgZGVsZXRpb24gaW4NCiAgICBmZG1vbl9pb191cmluZ19kZXN0cm95KCkNCiAgYWlvLXBv
c2l4OiBkaXNhYmxlIGZkbW9uLWlvX3VyaW5nIHdoZW4gR1NvdXJjZSBpcyB1c2VkDQoNCiBpbmNs
dWRlL2Jsb2NrL2Fpby5oICAgfCAgMyArKysNCiB1dGlsL2Fpby1wb3NpeC5jICAgICAgfCAxMyAr
KysrKysrKysrKysrDQogdXRpbC9haW8td2luMzIuYyAgICAgIHwgIDQgKysrKw0KIHV0aWwvYXN5
bmMuYyAgICAgICAgICB8ICAxICsNCiB1dGlsL2ZkbW9uLWlvX3VyaW5nLmMgfCAxMyArKysrKysr
KysrLS0tDQogNSBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KDQotLSANCjIuMjUuMw0KDQo=


