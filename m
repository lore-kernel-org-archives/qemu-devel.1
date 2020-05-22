Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B09FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1058020738
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gT/0CKiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1058020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBJw-0006ae-8Q
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jcBJ5-0004rg-KO
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:18:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36456
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jcBJ2-0000dQ-FU
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590167879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L920wjdi+xW55WmrO3rlVY3adomm8968IC13fk32krM=;
 b=gT/0CKiH4aMxp/ZUzpy7JNANoFO5zgcejYHdkVEkrhxyRVKi7uqklg0bP4Qe/8bJWiaQoF
 xhjqPHI3ooXKP11o1OEUdLr+p5jk48cuq0tGiBt9zi7GcRHCe+6Zil68FMvlgkS4oUiDEK
 2dznc0L74dr5g/bhMb8tKv44DUV8EK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-cQy26KD2PNqC91Srr43hVw-1; Fri, 22 May 2020 13:17:55 -0400
X-MC-Unique: cQy26KD2PNqC91Srr43hVw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00F1E80058A;
 Fri, 22 May 2020 17:17:54 +0000 (UTC)
Received: from localhost (ovpn-112-243.ams2.redhat.com [10.36.112.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C08C5D9CC;
 Fri, 22 May 2020 17:17:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] tests/libqos: mask out VIRTIO_F_RING_PACKED for now
Date: Fri, 22 May 2020 18:17:22 +0100
Message-Id: <20200522171726.648279-2-stefanha@redhat.com>
In-Reply-To: <20200522171726.648279-1-stefanha@redhat.com>
References: <20200522171726.648279-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

VGhlIGxpYnFvcyBWSVJUSU8gY29kZSBkb2VzIG5vdCBpbXBsZW1lbnQgdGhlIHBhY2tlZCB2aXJ0
cXVldWUgbGF5b3V0CnlldC4gTWFzayBvdXQgdGhlIGZlYXR1cmUgYml0IGZvciBub3cgYmVjYXVz
ZSB0ZXN0cyBoYXZlIGEgaGFiaXQgb2YKZW5hYmxpbmcgYWxsIGRldmljZSBmZWF0dXJlIGJpdHMg
YW5kIHdlIGRvbid0IHdhbnQgcGFja2VkIHZpcnRxdWV1ZXMgdG8KYmUgZW5hYmxlZC4KCkxhdGVy
IHBhdGNoZXMgd2lsbCBlbmFibGUgVklSVElPX0ZfUklOR19QQUNLRUQgc28gcHJlcGFyZSBsaWJx
b3Mgbm93LgoKQ2M6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdGVzdHMvcXRlc3Qv
bGlicW9zL3ZpcnRpby5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLmMg
Yi90ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLmMKaW5kZXggOWFhMzYwNjIwYy4uMWMzZjRhMGM4
YiAxMDA2NDQKLS0tIGEvdGVzdHMvcXRlc3QvbGlicW9zL3ZpcnRpby5jCisrKyBiL3Rlc3RzL3F0
ZXN0L2xpYnFvcy92aXJ0aW8uYwpAQCAtOTYsNyArOTYsOCBAQCB1aW50NjRfdCBxdmlydGlvX2Nv
bmZpZ19yZWFkcShRVmlydGlvRGV2aWNlICpkLCB1aW50NjRfdCBhZGRyKQogCiB1aW50NjRfdCBx
dmlydGlvX2dldF9mZWF0dXJlcyhRVmlydGlvRGV2aWNlICpkKQogewotICAgIHJldHVybiBkLT5i
dXMtPmdldF9mZWF0dXJlcyhkKTsKKyAgICAvKiBxdmlydGlvIGRvZXMgbm90IHN1cHBvcnQgcGFj
a2VkIHZpcnRxdWV1ZXMgeWV0ICovCisgICAgcmV0dXJuIGQtPmJ1cy0+Z2V0X2ZlYXR1cmVzKGQp
ICYgfigxdWxsIDw8IFZJUlRJT19GX1JJTkdfUEFDS0VEKTsKIH0KIAogdm9pZCBxdmlydGlvX3Nl
dF9mZWF0dXJlcyhRVmlydGlvRGV2aWNlICpkLCB1aW50NjRfdCBmZWF0dXJlcykKLS0gCjIuMjUu
MwoK


