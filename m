Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2BCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8895820756
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxQO77wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8895820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBKy-0000LG-Ph
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jcBJT-0005tp-EN
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:18:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jcBJR-0000gg-VI
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590167905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfEehpGDUiUAoeGDAnzCD1TZiUEMeKWipRXXUThsAm0=;
 b=NxQO77wieDaaMCXZ/NVcuI219ZxhAMJmlISIGcMOJ3Uwu8tyQiAVmHo5Plcp4XCRUhhwhF
 nmaELpj3SuXnIRW08DXDrQW8t/kcgSDEMzxboHiFdBFfmHjhpoeYSk7VdsA4hjIfv/xqvT
 yH2yMgs3zhI7mP5IpKaN238fDLtjwlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-sohZndYtPcmxSUnI2mXA7g-1; Fri, 22 May 2020 13:18:23 -0400
X-MC-Unique: sohZndYtPcmxSUnI2mXA7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F9C8100CC87;
 Fri, 22 May 2020 17:18:22 +0000 (UTC)
Received: from localhost (ovpn-112-243.ams2.redhat.com [10.36.112.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4D35C1D0;
 Fri, 22 May 2020 17:18:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] vhost-scsi: add VIRTIO_F_VERSION_1 and
 VIRTIO_F_RING_PACKED
Date: Fri, 22 May 2020 18:17:25 +0100
Message-Id: <20200522171726.648279-5-stefanha@redhat.com>
In-Reply-To: <20200522171726.648279-1-stefanha@redhat.com>
References: <20200522171726.648279-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 08:01:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 jasowang@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TGV0IHZob3N0LXNjc2kgYW5kIHZob3N0LXVzZXItc2NzaSBkZXZpY2UgYmFja2VuZHMgZGV0ZXJt
aW5lIHdoZXRoZXIKVklSVElPIDEuMCBhbmQgcGFja2VkIHZpcnRxdWV1ZXMgYXJlIHN1cHBvcnRl
ZC4gSXQgZG9lc24ndCBtYWtlIHNlbnNlIHRvCmhhbmRsZSB0aGVzZSBmZWF0dXJlIGJpdHMgaW4g
UUVNVSBzaW5jZSB0aGUgZGV2aWNlIGJhY2tlbmQgbmVlZHMgdG8Kc3VwcG9ydCB0aGVtIGlmIHdl
IHdhbnQgdG8gdXNlIHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQogaHcvc2NzaS92aG9zdC1zY3NpLmMgICAgICB8IDIgKysKIGh3
L3Njc2kvdmhvc3QtdXNlci1zY3NpLmMgfCAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2h3L3Njc2kvdmhvc3Qtc2NzaS5jIGIvaHcvc2NzaS92aG9z
dC1zY3NpLmMKaW5kZXggYzFiMDEyYWVhNC4uYTdmYjc4OGFmNSAxMDA2NDQKLS0tIGEvaHcvc2Nz
aS92aG9zdC1zY3NpLmMKKysrIGIvaHcvc2NzaS92aG9zdC1zY3NpLmMKQEAgLTM0LDYgKzM0LDgg
QEAKIAogLyogRmVhdHVyZXMgc3VwcG9ydGVkIGJ5IGhvc3Qga2VybmVsLiAqLwogc3RhdGljIGNv
bnN0IGludCBrZXJuZWxfZmVhdHVyZV9iaXRzW10gPSB7CisgICAgVklSVElPX0ZfVkVSU0lPTl8x
LAorICAgIFZJUlRJT19GX1JJTkdfUEFDS0VELAogICAgIFZJUlRJT19GX05PVElGWV9PTl9FTVBU
WSwKICAgICBWSVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MsCiAgICAgVklSVElPX1JJTkdfRl9F
VkVOVF9JRFgsCmRpZmYgLS1naXQgYS9ody9zY3NpL3Zob3N0LXVzZXItc2NzaS5jIGIvaHcvc2Nz
aS92aG9zdC11c2VyLXNjc2kuYwppbmRleCBjYmI1ZDk3NTk5Li42YWEwZDVkZWQyIDEwMDY0NAot
LS0gYS9ody9zY3NpL3Zob3N0LXVzZXItc2NzaS5jCisrKyBiL2h3L3Njc2kvdmhvc3QtdXNlci1z
Y3NpLmMKQEAgLTMyLDYgKzMyLDggQEAKIAogLyogRmVhdHVyZXMgc3VwcG9ydGVkIGJ5IHRoZSBo
b3N0IGFwcGxpY2F0aW9uICovCiBzdGF0aWMgY29uc3QgaW50IHVzZXJfZmVhdHVyZV9iaXRzW10g
PSB7CisgICAgVklSVElPX0ZfVkVSU0lPTl8xLAorICAgIFZJUlRJT19GX1JJTkdfUEFDS0VELAog
ICAgIFZJUlRJT19GX05PVElGWV9PTl9FTVBUWSwKICAgICBWSVJUSU9fUklOR19GX0lORElSRUNU
X0RFU0MsCiAgICAgVklSVElPX1JJTkdfRl9FVkVOVF9JRFgsCi0tIAoyLjI1LjMKCg==


