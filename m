Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D984C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8175620738
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOLmjqA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8175620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlR0-00035E-8G
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKkmN-0002wO-4H
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKkm8-0005NB-4N
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600790655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AueNZhdLhYocaLCRBb3j6nP0goFi/pKPAVv9RYVyxmg=;
 b=cOLmjqA5l88RIcr0KxIJj6ktgEXfuhlt+PLw6a+nBfQWXtsjdSUCsAgrcvHoLrY/UmU0kE
 0cdNXPcyO3co/RbMPzzE30A1VV5pzO1mRxfaIA7s2l1wxyQ8PAorqAXFjgASuP9iRLx6zb
 glY5wfcqYTSQJ9Ivo4R5MsUGzfNBatI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-5ocR_u6eMKaA1JSTSzY_ew-1; Tue, 22 Sep 2020 12:04:11 -0400
X-MC-Unique: 5ocR_u6eMKaA1JSTSzY_ew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FE1B1007466;
 Tue, 22 Sep 2020 16:04:10 +0000 (UTC)
Received: from localhost (ovpn-115-55.ams2.redhat.com [10.36.115.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 009F960C04;
 Tue, 22 Sep 2020 16:04:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/11] block/export: shorten serial string to fit
Date: Tue, 22 Sep 2020 17:03:51 +0100
Message-Id: <20200922160401.294055-2-stefanha@redhat.com>
In-Reply-To: <20200922160401.294055-1-stefanha@redhat.com>
References: <20200922160401.294055-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHNlcmlhbCBmaWVsZCBpcyBvbmx5IDIwIGJ5dGVzIGxvbmcuIFNob3J0ZW4gdGhlIHN0cmlu
ZyBzbyBpdCBmaXRzLgoKVGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIGNvbXBpbGVyIHdhcm5pbmc6
CgogIC4uL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYzoxNzg6NTA6IGVycm9y
OiDigJglc+KAmSBkaXJlY3RpdmUgb3V0cHV0IHRydW5jYXRlZCB3cml0aW5nIDIxIGJ5dGVzIGlu
dG8gYSByZWdpb24gb2Ygc2l6ZSAyMCBbLVdlcnJvcj1mb3JtYXQtdHJ1bmNhdGlvbj1dCiAgMTc4
IHwgICAgICAgICBzbnByaW50ZihlbGVtLT5pbl9zZ1swXS5pb3ZfYmFzZSwgc2l6ZSwgIiVzIiwg
InZob3N0X3VzZXJfYmxrX3NlcnZlciIpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBefiAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpT
aWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQog
YmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svZXhw
b3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jIGIvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxr
LXNlcnZlci5jCmluZGV4IGVjNzgxMzBmMDkuLmZiNzc2NGE3MzAgMTAwNjQ0Ci0tLSBhL2Jsb2Nr
L2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYworKysgYi9ibG9jay9leHBvcnQvdmhvc3Qt
dXNlci1ibGstc2VydmVyLmMKQEAgLTE3NSw3ICsxNzUsNyBAQCBzdGF0aWMgdm9pZCBjb3JvdXRp
bmVfZm4gdnVfYmxvY2tfdmlydGlvX3Byb2Nlc3NfcmVxKHZvaWQgKm9wYXF1ZSkKICAgICBjYXNl
IFZJUlRJT19CTEtfVF9HRVRfSUQ6IHsKICAgICAgICAgc2l6ZV90IHNpemUgPSBNSU4oaW92X3Np
emUoJmVsZW0tPmluX3NnWzBdLCBpbl9udW0pLAogICAgICAgICAgICAgICAgICAgICAgICAgICBW
SVJUSU9fQkxLX0lEX0JZVEVTKTsKLSAgICAgICAgc25wcmludGYoZWxlbS0+aW5fc2dbMF0uaW92
X2Jhc2UsIHNpemUsICIlcyIsICJ2aG9zdF91c2VyX2Jsa19zZXJ2ZXIiKTsKKyAgICAgICAgc25w
cmludGYoZWxlbS0+aW5fc2dbMF0uaW92X2Jhc2UsIHNpemUsICIlcyIsICJ2aG9zdF91c2VyX2Js
ayIpOwogICAgICAgICByZXEtPmluLT5zdGF0dXMgPSBWSVJUSU9fQkxLX1NfT0s7CiAgICAgICAg
IHJlcS0+c2l6ZSA9IGVsZW0tPmluX3NnWzBdLmlvdl9sZW47CiAgICAgICAgIGJyZWFrOwotLSAK
Mi4yNi4yCgo=


