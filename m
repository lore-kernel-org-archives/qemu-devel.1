Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D68C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD0022281
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQEfMYVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD0022281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyMN-0006NU-Gt
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyC2-0001Gg-LF
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyC0-0002xf-8B
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRwvzbChMIx79e5OYT4Xsph86jhkA0QIGzyIvJFq8dI=;
 b=WQEfMYVgnLEdGNTOP8Z4AdcpqdaqOk7Xh6tUkCoaDTakx5WuK+IGYn/rfFSWhxo718y0s9
 cnqv/l0jPL0Zs6hIRvgZWfN7KUOI4vMm/xTpZlYzwgT0Fb6MXGeG7w8h3rtUVrBWcSTwgp
 cIwgC/uR1zFi9jTllsKi1R0qZSq25Kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-FvrjsjjxO2uvoD4gZdgzEw-1; Fri, 09 Oct 2020 15:36:36 -0400
X-MC-Unique: FvrjsjjxO2uvoD4gZdgzEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CF03186DD38;
 Fri,  9 Oct 2020 19:36:34 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F1926266E;
 Fri,  9 Oct 2020 19:36:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 10/30] util/vhost-user-server: drop unnecessary QOM cast
Date: Fri,  9 Oct 2020 20:35:09 +0100
Message-Id: <20201009193529.322822-11-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
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


