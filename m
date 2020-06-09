Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C243AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E1720774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu9IIzA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E1720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihyl-00019b-RV
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jihfH-0005Zm-GS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:03:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jihfG-0007fJ-8j
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpBjdPJit81RyLQg32b3Yht5C7v5b4PqLtOChucBn8I=;
 b=Pu9IIzA8du5cabm+yse1D3T5dxM8g6EXRUWwqR4TBwgxJ7zyur4cguB8LqPSRtgi4NxjQ9
 w01C7TSFEKlkxqG5xeZCKql4V3dEG+OToIDFH1QyI1u2ihvivglZxPBItpN/tWBQzUgYUp
 Jzr+ViPT0e6udoKeq4z6j8hoIyvSFUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-MrRZydAbNkKDwnDZECfKbQ-1; Tue, 09 Jun 2020 13:03:49 -0400
X-MC-Unique: MrRZydAbNkKDwnDZECfKbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44D131005512;
 Tue,  9 Jun 2020 17:03:48 +0000 (UTC)
Received: from localhost (ovpn-115-52.ams2.redhat.com [10.36.115.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE6B260C87;
 Tue,  9 Jun 2020 17:03:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] vhost-scsi: add VIRTIO_F_VERSION_1 and
 VIRTIO_F_RING_PACKED
Date: Tue,  9 Jun 2020 18:02:17 +0100
Message-Id: <20200609170218.246468-7-stefanha@redhat.com>
In-Reply-To: <20200609170218.246468-1-stefanha@redhat.com>
References: <20200609170218.246468-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com, cohuck@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TGV0IHZob3N0LXNjc2kgYW5kIHZob3N0LXVzZXItc2NzaSBkZXZpY2UgYmFja2VuZHMgZGV0ZXJt
aW5lIHdoZXRoZXIKVklSVElPIDEuMCBhbmQgcGFja2VkIHZpcnRxdWV1ZXMgYXJlIHN1cHBvcnRl
ZC4gSXQgZG9lc24ndCBtYWtlIHNlbnNlIHRvCmhhbmRsZSB0aGVzZSBmZWF0dXJlIGJpdHMgaW4g
UUVNVSBzaW5jZSB0aGUgZGV2aWNlIGJhY2tlbmQgbmVlZHMgdG8Kc3VwcG9ydCB0aGVtIGlmIHdl
IHdhbnQgdG8gdXNlIHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBSYXBoYWVsIE5vcndpdHogPHJhcGhhZWwubm9y
d2l0ekBudXRhbml4LmNvbT4KLS0tCiBody9zY3NpL3Zob3N0LXNjc2kuYyAgICAgIHwgMiArKwog
aHcvc2NzaS92aG9zdC11c2VyLXNjc2kuYyB8IDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaHcvc2NzaS92aG9zdC1zY3NpLmMgYi9ody9zY3NpL3Zo
b3N0LXNjc2kuYwppbmRleCBjMWIwMTJhZWE0Li5hN2ZiNzg4YWY1IDEwMDY0NAotLS0gYS9ody9z
Y3NpL3Zob3N0LXNjc2kuYworKysgYi9ody9zY3NpL3Zob3N0LXNjc2kuYwpAQCAtMzQsNiArMzQs
OCBAQAogCiAvKiBGZWF0dXJlcyBzdXBwb3J0ZWQgYnkgaG9zdCBrZXJuZWwuICovCiBzdGF0aWMg
Y29uc3QgaW50IGtlcm5lbF9mZWF0dXJlX2JpdHNbXSA9IHsKKyAgICBWSVJUSU9fRl9WRVJTSU9O
XzEsCisgICAgVklSVElPX0ZfUklOR19QQUNLRUQsCiAgICAgVklSVElPX0ZfTk9USUZZX09OX0VN
UFRZLAogICAgIFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQywKICAgICBWSVJUSU9fUklOR19G
X0VWRU5UX0lEWCwKZGlmZiAtLWdpdCBhL2h3L3Njc2kvdmhvc3QtdXNlci1zY3NpLmMgYi9ody9z
Y3NpL3Zob3N0LXVzZXItc2NzaS5jCmluZGV4IGNiYjVkOTc1OTkuLjZhYTBkNWRlZDIgMTAwNjQ0
Ci0tLSBhL2h3L3Njc2kvdmhvc3QtdXNlci1zY3NpLmMKKysrIGIvaHcvc2NzaS92aG9zdC11c2Vy
LXNjc2kuYwpAQCAtMzIsNiArMzIsOCBAQAogCiAvKiBGZWF0dXJlcyBzdXBwb3J0ZWQgYnkgdGhl
IGhvc3QgYXBwbGljYXRpb24gKi8KIHN0YXRpYyBjb25zdCBpbnQgdXNlcl9mZWF0dXJlX2JpdHNb
XSA9IHsKKyAgICBWSVJUSU9fRl9WRVJTSU9OXzEsCisgICAgVklSVElPX0ZfUklOR19QQUNLRUQs
CiAgICAgVklSVElPX0ZfTk9USUZZX09OX0VNUFRZLAogICAgIFZJUlRJT19SSU5HX0ZfSU5ESVJF
Q1RfREVTQywKICAgICBWSVJUSU9fUklOR19GX0VWRU5UX0lEWCwKLS0gCjIuMjYuMgoK


