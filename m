Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD898C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A8720716
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyXBNeAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A8720716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k682k-0006jH-O1
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k67vY-0003KR-32
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k67vU-0002gH-QI
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597304728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFoIFh667YKanwfAVIXCX8H0waB0Q3Vuw1uagVdy/Ig=;
 b=eyXBNeAV5BpnR0LJgQVyU86iZMg9rTPDe9hrqeXc/RlbOWyNflDHGYA1BzCzkfgiQ9F/9/
 5NR5E+YsyAk09fYmm0GMSY0LyPkHVvvlbLtKTthVrtChRVvhXiD0lzcK3jizhMXW7Zwz2q
 uUmsBoumNIcpC99d6R7K+TQADqcsIgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-nNICfkRSMLCaW7ssWp0lSg-1; Thu, 13 Aug 2020 03:45:23 -0400
X-MC-Unique: nNICfkRSMLCaW7ssWp0lSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 665768064C0;
 Thu, 13 Aug 2020 07:45:21 +0000 (UTC)
Received: from localhost (ovpn-114-3.ams2.redhat.com [10.36.114.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D1C36FDA1;
 Thu, 13 Aug 2020 07:45:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] build: Don't make object files for dtrace on macOS
Date: Thu, 13 Aug 2020 06:22:51 +0100
Message-Id: <20200813052257.226142-4-stefanha@redhat.com>
In-Reply-To: <20200813052257.226142-1-stefanha@redhat.com>
References: <20200813052257.226142-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUm9tYW4gQm9sc2hha292IDxyLmJvbHNoYWtvdkB5YWRyby5jb20+CgpkdHJhY2Ugb24g
bWFjT1MgdXNlcyB1bnJlc29sdmVkIHN5bWJvbHMgd2l0aCBhIHNwZWNpYWwgcHJlZml4IHRvIGRl
ZmluZQpwcm9iZXMgWzFdLCBvbmx5IGhlYWRlcnMgc2hvdWxkIGJlIGdlbmVyYXRlZCBmb3IgVVNE
VCAoZHRyYWNlKDEpKS4gQnV0Cml0IGRvZXNuJ3Qgc3VwcG9ydCBiYWNrd2FyZHMgY29tcGF0aWJs
ZSBuby1vcCAtRyBmbGFnIFsyXSBhbmQgaW1wbGljaXQKYnVpbGQgcnVsZXMgZmFpbC4KCjEuIGh0
dHBzOi8vbWFya21haWwub3JnL21lc3NhZ2UvNmdycTJ5Z3I1bndkd3NuYgoyLiBodHRwczovL21h
cmttYWlsLm9yZy9tZXNzYWdlLzV4cnh0Mnc1bTQybm9qa3oKClJldmlld2VkLWJ5OiBEYW5pZWwg
UC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogU3RlZmFuIEhh
am5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBSb21hbiBCb2xzaGFr
b3YgPHIuYm9sc2hha292QHlhZHJvLmNvbT4KTWVzc2FnZS1pZDogMjAyMDA3MTcwOTM1MTcuNzMz
OTctNC1yLmJvbHNoYWtvdkB5YWRyby5jb20KQ2M6IENhbWVyb24gRXNmYWhhbmkgPGRpcnR5QGFw
cGxlLmNvbT4KU2lnbmVkLW9mZi1ieTogUm9tYW4gQm9sc2hha292IDxyLmJvbHNoYWtvdkB5YWRy
by5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4KLS0tCiBNYWtlZmlsZS5vYmpzIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL01ha2VmaWxlLm9ianMgYi9NYWtlZmlsZS5vYmpzCmluZGV4IGQy
MmIzYjQ1ZDcuLjk4MmYxNWJhMzAgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlLm9ianMKKysrIGIvTWFr
ZWZpbGUub2JqcwpAQCAtMjExLDUgKzIxMSw3IEBAIHRyYWNlLWV2ZW50cy1maWxlcyA9ICQoU1JD
X1BBVEgpL3RyYWNlLWV2ZW50cyAkKHRyYWNlLWV2ZW50cy1zdWJkaXJzOiU9JChTUkNfUEFUCiB0
cmFjZS1vYmoteSA9IHRyYWNlLXJvb3QubwogdHJhY2Utb2JqLXkgKz0gJCh0cmFjZS1ldmVudHMt
c3ViZGlyczolPSUvdHJhY2UubykKIHRyYWNlLW9iai0kKENPTkZJR19UUkFDRV9VU1QpICs9IHRy
YWNlLXVzdC1hbGwubworaWZuZXEgKCQoQ09ORklHX0RBUldJTikseSkKIHRyYWNlLW9iai0kKENP
TkZJR19UUkFDRV9EVFJBQ0UpICs9IHRyYWNlLWR0cmFjZS1yb290Lm8KIHRyYWNlLW9iai0kKENP
TkZJR19UUkFDRV9EVFJBQ0UpICs9ICQodHJhY2UtZXZlbnRzLXN1YmRpcnM6JT0lL3RyYWNlLWR0
cmFjZS5vKQorZW5kaWYKLS0gCjIuMjYuMgoK


