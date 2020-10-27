Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C07DC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DE2208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiBm+g5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DE2208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSyl-0003WI-4f
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStb-00069B-IQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXSta-0003Kx-0A
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DiLuO0TjKUvf21RnIV+pV7Tqv0JQb+G7k9o/EC8PMGg=;
 b=KiBm+g5pNeShzZJi0GuJbimp8IBQj006R9rfmDfnIJJAsnOvWEq+loIEIX9IH51ZSr0zVo
 cHliX2BLZT5l00+ALadglam4HabyA8qHHFVMw5Zm3c2ETljxJ7WxBuEqKs9t38JgI90vf+
 kweqwNHQ4jy2TnowNyWMYGQUn7c7//c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-XYNKy08BPlO9DzhqWm1_Vg-1; Tue, 27 Oct 2020 13:36:21 -0400
X-MC-Unique: XYNKy08BPlO9DzhqWm1_Vg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC0CE192AB6F;
 Tue, 27 Oct 2020 17:36:17 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CF6B60C07;
 Tue, 27 Oct 2020 17:36:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/12] block/export: fix vhost-user-blk get_config()
 information leak
Date: Tue, 27 Oct 2020 17:35:20 +0000
Message-Id: <20201027173528.213464-5-stefanha@redhat.com>
In-Reply-To: <20201027173528.213464-1-stefanha@redhat.com>
References: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UmVmdXNlIGdldF9jb25maWcoKSByZXF1ZXN0cyBpbiBleGNlc3Mgb2Ygc2l6ZW9mKHN0cnVjdCB2
aXJ0aW9fYmxrX2NvbmZpZykuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQogYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5j
IHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9i
bG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMgYi9ibG9jay9leHBvcnQvdmhvc3Qt
dXNlci1ibGstc2VydmVyLmMKaW5kZXggMzNjYzA4MThiOC4uNjI2NzJkMWNiOSAxMDA2NDQKLS0t
IGEvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jCisrKyBiL2Jsb2NrL2V4cG9y
dC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYwpAQCAtMjY2LDYgKzI2Niw5IEBAIHZ1X2Jsa19nZXRf
Y29uZmlnKFZ1RGV2ICp2dV9kZXYsIHVpbnQ4X3QgKmNvbmZpZywgdWludDMyX3QgbGVuKQogewog
ICAgIFZ1U2VydmVyICpzZXJ2ZXIgPSBjb250YWluZXJfb2YodnVfZGV2LCBWdVNlcnZlciwgdnVf
ZGV2KTsKICAgICBWdUJsa0V4cG9ydCAqdmV4cCA9IGNvbnRhaW5lcl9vZihzZXJ2ZXIsIFZ1Qmxr
RXhwb3J0LCB2dV9zZXJ2ZXIpOworCisgICAgZ19yZXR1cm5fdmFsX2lmX2ZhaWwobGVuIDw9IHNp
emVvZihzdHJ1Y3QgdmlydGlvX2Jsa19jb25maWcpLCAtMSk7CisKICAgICBtZW1jcHkoY29uZmln
LCAmdmV4cC0+YmxrY2ZnLCBsZW4pOwogICAgIHJldHVybiAwOwogfQotLSAKMi4yNi4yCgo=


