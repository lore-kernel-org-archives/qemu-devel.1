Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3B3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829662074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPSF/Xvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829662074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKcr-0001f4-Il
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKYi-0004VK-GN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:18:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKYg-0007qA-OJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G0IJggGzUw2GPdTll1DH6CRZ2qMV3yjaBdQfe9tm6qw=;
 b=gPSF/XvtfCIQ8B4NXm/VScF1EzK22nfpK0+AR1vfk7O2jX+5tQA/LWfqpRF8h3olszBw0D
 6YembEmf+Y/nx/rf6rGgbOtfBH7RxvJtiZNlGWpbomU0HlE+cmNQfxb48X+yDWPT0wvcXO
 HKMkwx7ynro1PcjQ8POVRoHY1mELl9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-jY2_geqPPsmyTdX4PI8Uvw-1; Wed, 04 Nov 2020 10:18:44 -0500
X-MC-Unique: jY2_geqPPsmyTdX4PI8Uvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 925E81087D71;
 Wed,  4 Nov 2020 15:18:42 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEFFE1007517;
 Wed,  4 Nov 2020 15:18:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/33] softmmu/memory: fix memory_region_ioeventfd_equal()
Date: Wed,  4 Nov 2020 15:17:57 +0000
Message-Id: <20201104151828.405824-3-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Afanasova <eafanasova@gmail.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogRWxlbmEgQWZhbmFzb3ZhIDxlYWZhbmFzb3ZhQGdtYWlsLmNvbT4KCkV2ZW50ZmQgY2Fu
IGJlIHJlZ2lzdGVyZWQgd2l0aCBhIHplcm8gbGVuZ3RoIHdoZW4gZmFzdF9tbWlvIGlzIHRydWUu
CkhhbmRsZSB0aGlzIGNhc2UgcHJvcGVybHkgd2hlbiBkaXNwYXRjaGluZyB0aHJvdWdoIFFFTVUu
CgpTaWduZWQtb2ZmLWJ5OiBFbGVuYSBBZmFuYXNvdmEgPGVhZmFuYXNvdmFAZ21haWwuY29tPgpN
ZXNzYWdlLWlkOiBjZjcxYTYyZWIwNGU2MTkzMmZmOGZmZGQwMmUwYjJhYWI0ZjQ5NWEwLmNhbWVs
QGdtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+Ci0tLQogc29mdG1tdS9tZW1vcnkuYyB8IDExICsrKysrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvZnRt
bXUvbWVtb3J5LmMgYi9zb2Z0bW11L21lbW9yeS5jCmluZGV4IDIxZDUzM2Q4ZWQuLjhhYmE0MTE0
Y2YgMTAwNjQ0Ci0tLSBhL3NvZnRtbXUvbWVtb3J5LmMKKysrIGIvc29mdG1tdS9tZW1vcnkuYwpA
QCAtMjA1LDggKzIwNSwxNSBAQCBzdGF0aWMgYm9vbCBtZW1vcnlfcmVnaW9uX2lvZXZlbnRmZF9i
ZWZvcmUoTWVtb3J5UmVnaW9uSW9ldmVudGZkICphLAogc3RhdGljIGJvb2wgbWVtb3J5X3JlZ2lv
bl9pb2V2ZW50ZmRfZXF1YWwoTWVtb3J5UmVnaW9uSW9ldmVudGZkICphLAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWVtb3J5UmVnaW9uSW9ldmVudGZkICpiKQog
ewotICAgIHJldHVybiAhbWVtb3J5X3JlZ2lvbl9pb2V2ZW50ZmRfYmVmb3JlKGEsIGIpCi0gICAg
ICAgICYmICFtZW1vcnlfcmVnaW9uX2lvZXZlbnRmZF9iZWZvcmUoYiwgYSk7CisgICAgaWYgKGlu
dDEyOF9lcShhLT5hZGRyLnN0YXJ0LCBiLT5hZGRyLnN0YXJ0KSAmJgorICAgICAgICAoIWludDEy
OF9ueihhLT5hZGRyLnNpemUpIHx8ICFpbnQxMjhfbnooYi0+YWRkci5zaXplKSB8fAorICAgICAg
ICAgKGludDEyOF9lcShhLT5hZGRyLnNpemUsIGItPmFkZHIuc2l6ZSkgJiYKKyAgICAgICAgICAo
YS0+bWF0Y2hfZGF0YSA9PSBiLT5tYXRjaF9kYXRhKSAmJgorICAgICAgICAgICgoYS0+bWF0Y2hf
ZGF0YSAmJiAoYS0+ZGF0YSA9PSBiLT5kYXRhKSkgfHwgIWEtPm1hdGNoX2RhdGEpICYmCisgICAg
ICAgICAgKGEtPmUgPT0gYi0+ZSkpKSkKKyAgICAgICAgcmV0dXJuIHRydWU7CisKKyAgICByZXR1
cm4gZmFsc2U7CiB9CiAKIC8qIFJhbmdlIG9mIG1lbW9yeSBpbiB0aGUgZ2xvYmFsIG1hcC4gIEFk
ZHJlc3NlcyBhcmUgYWJzb2x1dGUuICovCi0tIAoyLjI4LjAKCg==


