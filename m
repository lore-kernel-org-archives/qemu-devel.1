Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDA6C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB5A2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLI6R7f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB5A2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSwW-00012z-2H
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXSta-00066w-GI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStY-0003JX-UG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsMACuBNQKcMNHAzKoCB6XkxGSeg+sqaGMrJlhUn0WU=;
 b=WLI6R7f2HHJR9Kc4aSHu4wyzwp027fL71vTaTxutN0+Kqbvzy4No5DDR/X8tw3akoaPbCv
 rq6SaXLyze68lpm9X6Cl/Mjh21oftA0Cf9BFfIG1xZaHAX46Q5xyJXdYoF6jhC+ql0zIw2
 D4MLkhoVPuZZ5DHtv2zUjykk0vPOQK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-LkJJXOk8O2CLSJTWWkPe2Q-1; Tue, 27 Oct 2020 13:36:24 -0400
X-MC-Unique: LkJJXOk8O2CLSJTWWkPe2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 734578049EF;
 Tue, 27 Oct 2020 17:36:19 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C24755771;
 Tue, 27 Oct 2020 17:36:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/12] contrib/vhost-user-blk: fix get_config() information
 leak
Date: Tue, 27 Oct 2020 17:35:21 +0000
Message-Id: <20201027173528.213464-6-stefanha@redhat.com>
In-Reply-To: <20201027173528.213464-1-stefanha@redhat.com>
References: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

UmVmdXNlIGdldF9jb25maWcoKSBpbiBleGNlc3Mgb2Ygc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fYmxr
X2NvbmZpZykuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+Ci0tLQogY29udHJpYi92aG9zdC11c2VyLWJsay92aG9zdC11c2VyLWJsay5jIHwgMiAr
KwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2NvbnRyaWIv
dmhvc3QtdXNlci1ibGsvdmhvc3QtdXNlci1ibGsuYyBiL2NvbnRyaWIvdmhvc3QtdXNlci1ibGsv
dmhvc3QtdXNlci1ibGsuYwppbmRleCAyNWVjY2QwMmI1Li5jYWFkODg2MzdlIDEwMDY0NAotLS0g
YS9jb250cmliL3Zob3N0LXVzZXItYmxrL3Zob3N0LXVzZXItYmxrLmMKKysrIGIvY29udHJpYi92
aG9zdC11c2VyLWJsay92aG9zdC11c2VyLWJsay5jCkBAIC00MDQsNiArNDA0LDggQEAgdnViX2dl
dF9jb25maWcoVnVEZXYgKnZ1X2RldiwgdWludDhfdCAqY29uZmlnLCB1aW50MzJfdCBsZW4pCiAg
ICAgVnVnRGV2ICpnZGV2OwogICAgIFZ1YkRldiAqdmRldl9ibGs7CiAKKyAgICBnX3JldHVybl92
YWxfaWZfZmFpbChsZW4gPD0gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZyksIC0xKTsK
KwogICAgIGdkZXYgPSBjb250YWluZXJfb2YodnVfZGV2LCBWdWdEZXYsIHBhcmVudCk7CiAgICAg
dmRldl9ibGsgPSBjb250YWluZXJfb2YoZ2RldiwgVnViRGV2LCBwYXJlbnQpOwogICAgIG1lbWNw
eShjb25maWcsICZ2ZGV2X2Jsay0+YmxrY2ZnLCBsZW4pOwotLSAKMi4yNi4yCgo=


