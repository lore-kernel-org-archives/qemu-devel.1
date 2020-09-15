Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6D0C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0265206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKUhiLK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0265206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9iR-00069j-Ft
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kI9ga-0004o7-I8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kI9gY-0006iq-NH
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600171425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pg/Vj1z9yL1sXyltud1XoFfG1FY87CJvPcrtKpgSpU=;
 b=NKUhiLK/pI9XjUOEYIZ9kmgrt+Df9TOdIQWZXbx+lvuAsFZ+tohiI9EUnWKDpNtHTcBeLt
 4Y+vddXwSC18rbgGj6Loj4UMpLI+iovRohXoCMxEYtZw9pZn/jQ5aPV+wdc4pbxeX8V5xS
 ZmJ8j59gtspoZJUlTzy8/PXFeY2Ea7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-9kSxR3B0MJ-HajGB4i8lyw-1; Tue, 15 Sep 2020 08:03:43 -0400
X-MC-Unique: 9kSxR3B0MJ-HajGB4i8lyw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABEB818BE161;
 Tue, 15 Sep 2020 12:03:42 +0000 (UTC)
Received: from localhost (ovpn-112-192.ams2.redhat.com [10.36.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5066B51574;
 Tue, 15 Sep 2020 12:03:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] fdmon-poll: reset npfd when upgrading to fdmon-epoll
Date: Tue, 15 Sep 2020 13:03:38 +0100
Message-Id: <20200915120339.702938-2-stefanha@redhat.com>
In-Reply-To: <20200915120339.702938-1-stefanha@redhat.com>
References: <20200915120339.702938-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bnBmZCBrZWVwcyB0cmFjayBvZiBob3cgbWFueSBwb2xsZmRzIGFyZSBjdXJyZW50bHkgYmVpbmcg
bW9uaXRvcmVkLiBJdAptdXN0IGJlIHJlc2V0IHRvIDAgd2hlbiBmZG1vbl9wb2xsX3dhaXQoKSBy
ZXR1cm5zLgoKV2hlbiBucGZkIHJlYWNoZXMgYSB0cmVzaG9sZCB3ZSBzd2l0Y2ggdG8gZmRtb24t
ZXBvbGwgYmVjYXVzZSBpdCBzY2FsZXMKYmV0dGVyLgoKVGhpcyBwYXRjaCByZXNldHMgbnBmZCBp
biB0aGUgY2FzZSB3aGVyZSB3ZSBzd2l0Y2ggdG8gZmRtb24tZXBvbGwuCkZvcmdldHRpbmcgdG8g
ZG8gc28gcmVzdWx0cyBpbiB0aGUgZm9sbG93aW5nIGFzc2VydGlvbiBmYWlsdXJlOgoKICB1dGls
L2ZkbW9uLXBvbGwuYzo2NTogZmRtb25fcG9sbF93YWl0OiBBc3NlcnRpb24gYG5wZmQgPT0gMCcg
ZmFpbGVkLgoKQnVnbGluazogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNn
aT9pZD0xODY5OTUyCkZpeGVzOiAxZjA1MGE0NjkwZjYyYTFlN2RhYmM0ZjQ0MTQxZTlmNzYyYzM3
NjlmICgiYWlvLXBvc2l4OiBleHRyYWN0IHBwb2xsKDIpIGFuZCBlcG9sbCg3KSBmZCBtb25pdG9y
aW5nIikKUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0
LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29t
PgotLS0KIHV0aWwvZmRtb24tcG9sbC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKCmRpZmYgLS1naXQgYS91dGlsL2ZkbW9uLXBvbGwuYyBiL3V0aWwvZmRtb24tcG9sbC5j
CmluZGV4IDQ4ODA2N2I2NzkuLjVmZTNiNDc4NjUgMTAwNjQ0Ci0tLSBhL3V0aWwvZmRtb24tcG9s
bC5jCisrKyBiL3V0aWwvZmRtb24tcG9sbC5jCkBAIC03Myw2ICs3Myw3IEBAIHN0YXRpYyBpbnQg
ZmRtb25fcG9sbF93YWl0KEFpb0NvbnRleHQgKmN0eCwgQWlvSGFuZGxlckxpc3QgKnJlYWR5X2xp
c3QsCiAKICAgICAvKiBlcG9sbCg3KSBpcyBmYXN0ZXIgYWJvdmUgYSBjZXJ0YWluIG51bWJlciBv
ZiBmZHMgKi8KICAgICBpZiAoZmRtb25fZXBvbGxfdHJ5X3VwZ3JhZGUoY3R4LCBucGZkKSkgewor
ICAgICAgICBucGZkID0gMDsgLyogd2Ugd29uJ3QgbmVlZCBwb2xsZmRzW10sIHJlc2V0IG5wZmQg
Ki8KICAgICAgICAgcmV0dXJuIGN0eC0+ZmRtb25fb3BzLT53YWl0KGN0eCwgcmVhZHlfbGlzdCwg
dGltZW91dCk7CiAgICAgfQogCi0tIAoyLjI2LjIKCg==


