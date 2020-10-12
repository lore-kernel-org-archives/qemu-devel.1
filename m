Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE0820797
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUVd2gI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE0820797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS2h6-0003LV-QW
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2Z6-0003cw-Nv
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2Z0-0004Au-6t
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602527329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRwvzbChMIx79e5OYT4Xsph86jhkA0QIGzyIvJFq8dI=;
 b=YUVd2gI08+EYMgtHs2eLsM+63LpcPjYIivgMkoSe3QxhuorwanmPWLIITd5Cfy6kJ2ftc1
 EeZRKUB3RAK1dKWF1N73LtbUm4iEP0Yifzlt6TEmjNr1Gm2RPwOgGiaAyzZn7XQXQ049Gy
 Xzga1Kr/n00xa06fwbxjY05xe3GBmsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424--Z6F2AecP1CrIvf0-WTAmA-1; Mon, 12 Oct 2020 14:28:45 -0400
X-MC-Unique: -Z6F2AecP1CrIvf0-WTAmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB492802B48;
 Mon, 12 Oct 2020 18:28:43 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8021319C78;
 Mon, 12 Oct 2020 18:28:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 10/30] util/vhost-user-server: drop unnecessary QOM cast
Date: Mon, 12 Oct 2020 19:27:40 +0100
Message-Id: <20201012182800.157697-11-stefanha@redhat.com>
In-Reply-To: <20201012182800.157697-1-stefanha@redhat.com>
References: <20201012182800.157697-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2UgYWxyZWFkeSBoYXZlIGFjY2VzcyB0byB0aGUgdmFsdWUgd2l0aCB0aGUgY29ycmVjdCB0eXBl
IChpb2MgYW5kIHNpb2MKYXJlIHRoZSBzYW1lIFFJT0NoYW5uZWwpLgoKU2lnbmVkLW9mZi1ieTog
U3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMDky
NDE1MTU0OS45MTM3MzctNC1zdGVmYW5oYUByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZh
biBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB1dGlsL3Zob3N0LXVzZXItc2Vy
dmVyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMgYi91dGlsL3Zob3N0LXVz
ZXItc2VydmVyLmMKaW5kZXggMmNkMGNmODI3Ny4uZWJlNDc4ODVmNSAxMDA2NDQKLS0tIGEvdXRp
bC92aG9zdC11c2VyLXNlcnZlci5jCisrKyBiL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYwpAQCAt
MzM3LDcgKzMzNyw3IEBAIHN0YXRpYyB2b2lkIHZ1X2FjY2VwdChRSU9OZXRMaXN0ZW5lciAqbGlz
dGVuZXIsIFFJT0NoYW5uZWxTb2NrZXQgKnNpb2MsCiAgICAgc2VydmVyLT5pb2MgPSBRSU9fQ0hB
Tk5FTChzaW9jKTsKICAgICBvYmplY3RfcmVmKE9CSkVDVChzZXJ2ZXItPmlvYykpOwogICAgIHFp
b19jaGFubmVsX2F0dGFjaF9haW9fY29udGV4dChzZXJ2ZXItPmlvYywgc2VydmVyLT5jdHgpOwot
ICAgIHFpb19jaGFubmVsX3NldF9ibG9ja2luZyhRSU9fQ0hBTk5FTChzZXJ2ZXItPnNpb2MpLCBm
YWxzZSwgTlVMTCk7CisgICAgcWlvX2NoYW5uZWxfc2V0X2Jsb2NraW5nKHNlcnZlci0+aW9jLCBm
YWxzZSwgTlVMTCk7CiAgICAgdnVfY2xpZW50X3N0YXJ0KHNlcnZlcik7CiB9CiAKLS0gCjIuMjYu
MgoK


