Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B7EC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD0520EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtVRLzXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD0520EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKCK-0006Hh-W3
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKK5x-0000JA-NR
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKK5v-0001Jj-Sz
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600688095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dmk58Gzs/ellAaqhm8wYnKQ4lg8lRQmB9s1pLeHYQ4=;
 b=CtVRLzXY7yQyFoFFbb4FlsLVfj5xH5Oz0o1wSWj8O9r6QCvKMSyAAxhSh3ZJnd6enmXGE7
 pIhzcnFoBjN56xsVCVknd1zxFfuIdMQWwvkYLDQ7vCuJWChe6NSMGKy71wOLgQ7uoeIo7f
 LLp0+GsW3oYZ+2smznOoGKTRusd4Y8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-3kX45oceOJu3kkVvF7Triw-1; Mon, 21 Sep 2020 07:34:53 -0400
X-MC-Unique: 3kX45oceOJu3kkVvF7Triw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72D05801FD4
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 11:34:52 +0000 (UTC)
Received: from localhost (ovpn-112-39.ams2.redhat.com [10.36.112.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CC885DA30;
 Mon, 21 Sep 2020 11:34:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] libvhost-user: return on error in vu_log_queue_fill()
Date: Mon, 21 Sep 2020 12:34:20 +0100
Message-Id: <20200921113420.154378-3-stefanha@redhat.com>
In-Reply-To: <20200921113420.154378-1-stefanha@redhat.com>
References: <20200921113420.154378-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dnVfcGFuaWMoKSBpcyBub3QgZ3VhcmFudGVlZCB0byBleGl0IHRoZSBwcm9ncmFtLiBSZXR1cm4g
ZWFybHkgd2hlbgplcnJvcnMgYXJlIGVuY291bnRlcmVkLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGNvbnRyaWIvbGlidmhvc3QtdXNl
ci9saWJ2aG9zdC11c2VyLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoK
ZGlmZiAtLWdpdCBhL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMgYi9jb250
cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5jCmluZGV4IDI3NjI2ZTYyOWEuLjFmYzJj
YjEyY2UgMTAwNjQ0Ci0tLSBhL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMK
KysrIGIvY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYwpAQCAtMjcyMiw2ICsy
NzIyLDcgQEAgdnVfbG9nX3F1ZXVlX2ZpbGwoVnVEZXYgKmRldiwgVnVWaXJ0cSAqdnEsCiAgICAg
aWYgKGRlc2NbaV0uZmxhZ3MgJiBWUklOR19ERVNDX0ZfSU5ESVJFQ1QpIHsKICAgICAgICAgaWYg
KGRlc2NbaV0ubGVuICUgc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjKSkgewogICAgICAgICAgICAg
dnVfcGFuaWMoZGV2LCAiSW52YWxpZCBzaXplIGZvciBpbmRpcmVjdCBidWZmZXIgdGFibGUiKTsK
KyAgICAgICAgICAgIHJldHVybjsKICAgICAgICAgfQogCiAgICAgICAgIC8qIGxvb3Agb3ZlciB0
aGUgaW5kaXJlY3QgZGVzY3JpcHRvciB0YWJsZSAqLwotLSAKMi4yNi4yCgo=


