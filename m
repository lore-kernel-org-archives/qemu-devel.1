Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45764C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAAC204EF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVP3xeCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAAC204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBLf-00019H-2K
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jcBJG-0005K4-HS
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:18:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jcBJF-0000fY-Q6
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590167892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6OUjV9d42OaeNTy7tX62TdWiw4w1pIbo02ovt56hIfY=;
 b=CVP3xeChnK6Erd8jv6xC+nwwesLsg558j2NF0vhj7Y9vCS6wKnvkYEdB5T1ZQ7zmrvzhXO
 k34zSfD1n67YCJi5tPwyhQnHfIO8h3O8isSFqt4erg2nrQYUI96A32O4YlFxQEU5UfSYUx
 8u3VgkYOD0RXwBIgnWvfkhsWYMUeZco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-PeRgRvSAPt--n5YcwV-Kgw-1; Fri, 22 May 2020 13:18:11 -0400
X-MC-Unique: PeRgRvSAPt--n5YcwV-Kgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EECF780B700;
 Fri, 22 May 2020 17:18:09 +0000 (UTC)
Received: from localhost (ovpn-112-243.ams2.redhat.com [10.36.112.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D41535798D;
 Fri, 22 May 2020 17:17:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] vhost-user-blk: add VIRTIO_F_RING_PACKED feature bit
Date: Fri, 22 May 2020 18:17:24 +0100
Message-Id: <20200522171726.648279-4-stefanha@redhat.com>
In-Reply-To: <20200522171726.648279-1-stefanha@redhat.com>
References: <20200522171726.648279-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:12:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Vmhvc3QgZGV2aWNlcyBoYXZlIGEgbGlzdCBvZiBmZWF0dXJlIGJpdHMgdGhhdCB0aGUgZGV2aWNl
IGJhY2tlbmQgaXMKYWxsb3dlZCB0byBjb250cm9sLiBUaGUgVklSVElPX0ZfUklOR19QQUNLRUQg
ZmVhdHVyZSBpcyBhIGZlYXR1cmUgdGhhdAptdXN0IGJlIG5lZ290aWF0ZWQgdGhyb3VnaCBhbGwg
dGhlIHdheSB0byB0aGUgZGV2aWNlIGJhY2tlbmQuIEFkZCBpdCBzbwp0aGUgZGV2aWNlIGJhY2tl
bmQgY2FuIGRlY2xhcmUgd2hldGhlciBvciBub3QgaXQgc3VwcG9ydHMgdGhlIHBhY2tlZApyaW5n
IGxheW91dC4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KLS0tCiBody9ibG9jay92aG9zdC11c2VyLWJsay5jIHwgMSArCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9ody9ibG9jay92aG9zdC11c2VyLWJsay5j
IGIvaHcvYmxvY2svdmhvc3QtdXNlci1ibGsuYwppbmRleCA5ZDhjMGIzOTA5Li4xMGUxMTRhMTlh
IDEwMDY0NAotLS0gYS9ody9ibG9jay92aG9zdC11c2VyLWJsay5jCisrKyBiL2h3L2Jsb2NrL3Zo
b3N0LXVzZXItYmxrLmMKQEAgLTQ0LDYgKzQ0LDcgQEAgc3RhdGljIGNvbnN0IGludCB1c2VyX2Zl
YXR1cmVfYml0c1tdID0gewogICAgIFZJUlRJT19CTEtfRl9ESVNDQVJELAogICAgIFZJUlRJT19C
TEtfRl9XUklURV9aRVJPRVMsCiAgICAgVklSVElPX0ZfVkVSU0lPTl8xLAorICAgIFZJUlRJT19G
X1JJTkdfUEFDS0VELAogICAgIFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQywKICAgICBWSVJU
SU9fUklOR19GX0VWRU5UX0lEWCwKICAgICBWSVJUSU9fRl9OT1RJRllfT05fRU1QVFksCi0tIAoy
LjI1LjMKCg==


