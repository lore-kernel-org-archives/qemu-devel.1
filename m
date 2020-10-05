Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99466C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84EB20663
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzti2mxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84EB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPT1G-0001mt-1N
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSfB-00068b-Fl
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSf7-0008JZ-Ak
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601912667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEG96Vq3zca1dV7GtODnKY3xRUbdfFUuNtY9jPqD7TE=;
 b=gzti2mxmbRf+leVLcYl2TKlyzFYnXBQc8kgpoBwMYzqKR8YWttL4tN5tTn226W77Ce3pAU
 0AEn3/nbspOSRzSfWjUQZqs5t/WvDxyNsfypWBgfWXZu/i5JGUo4DkRZzOlQeyuT5CiTfI
 i/0n7wbJqyH3lvFhp625+jSqjq6Ksis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-FEa5eziRMa-aT7T_jg94Tg-1; Mon, 05 Oct 2020 11:44:25 -0400
X-MC-Unique: FEa5eziRMa-aT7T_jg94Tg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CF3787315B;
 Mon,  5 Oct 2020 15:44:24 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 294D855764;
 Mon,  5 Oct 2020 15:44:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 15/17] docs: add 'io_uring' option to 'aio' param in
 qemu-options.hx
Date: Mon,  5 Oct 2020 16:43:21 +0100
Message-Id: <20201005154323.31347-16-stefanha@redhat.com>
In-Reply-To: <20201005154323.31347-1-stefanha@redhat.com>
References: <20201005154323.31347-1-stefanha@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKV2hlbiB3ZSBh
ZGRlZCBpb191cmluZyBBSU8gZW5naW5lLCB3ZSBmb3Jnb3QgdG8gdXBkYXRlIHFlbXUtb3B0aW9u
cy5oeCwKc28gcWVtdSgxKSBtYW4gcGFnZSBhbmQgcWVtdSBoZWxwIHdlcmUgb3V0ZGF0ZWQuCgpT
aWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+ClNp
Z25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3
ZWQtYnk6IEp1bGlhIFN1dm9yb3ZhIDxqdXN1YWxAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBh
bmthaiBHdXB0YSA8cGFua2FqLmd1cHRhLmxpbnV4QGdtYWlsLmNvbT4KTWVzc2FnZS1JZDogPDIw
MjAwOTI0MTUxNTExLjEzMTQ3MS0xLXNnYXJ6YXJlQHJlZGhhdC5jb20+Ci0tLQogcWVtdS1vcHRp
b25zLmh4IHwgMTAgKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9xZW11LW9wdGlvbnMuaHggYi9xZW11LW9wdGlv
bnMuaHgKaW5kZXggMzU2NGMyMzAzZi4uMWRhNTJhMjY5YyAxMDA2NDQKLS0tIGEvcWVtdS1vcHRp
b25zLmh4CisrKyBiL3FlbXUtb3B0aW9ucy5oeApAQCAtMTA1Myw3ICsxMDUzLDggQEAgU1JTVAog
ICAgICAgICAgICAgVGhlIHBhdGggdG8gdGhlIGltYWdlIGZpbGUgaW4gdGhlIGxvY2FsIGZpbGVz
eXN0ZW0KIAogICAgICAgICBgYGFpb2BgCi0gICAgICAgICAgICBTcGVjaWZpZXMgdGhlIEFJTyBi
YWNrZW5kICh0aHJlYWRzL25hdGl2ZSwgZGVmYXVsdDogdGhyZWFkcykKKyAgICAgICAgICAgIFNw
ZWNpZmllcyB0aGUgQUlPIGJhY2tlbmQgKHRocmVhZHMvbmF0aXZlL2lvX3VyaW5nLAorICAgICAg
ICAgICAgZGVmYXVsdDogdGhyZWFkcykKIAogICAgICAgICBgYGxvY2tpbmdgYAogICAgICAgICAg
ICAgU3BlY2lmaWVzIHdoZXRoZXIgdGhlIGltYWdlIGZpbGUgaXMgcHJvdGVjdGVkIHdpdGggTGlu
dXggT0ZECkBAIC0xMTc1LDcgKzExNzYsOCBAQCBERUYoImRyaXZlIiwgSEFTX0FSRywgUUVNVV9P
UFRJT05fZHJpdmUsCiAgICAgIi1kcml2ZSBbZmlsZT1maWxlXVssaWY9dHlwZV1bLGJ1cz1uXVss
dW5pdD1tXVssbWVkaWE9ZF1bLGluZGV4PWldXG4iCiAgICAgIiAgICAgICBbLGNhY2hlPXdyaXRl
dGhyb3VnaHx3cml0ZWJhY2t8bm9uZXxkaXJlY3RzeW5jfHVuc2FmZV1bLGZvcm1hdD1mXVxuIgog
ICAgICIgICAgICAgWyxzbmFwc2hvdD1vbnxvZmZdWyxyZXJyb3I9aWdub3JlfHN0b3B8cmVwb3J0
XVxuIgotICAgICIgICAgICAgWyx3ZXJyb3I9aWdub3JlfHN0b3B8cmVwb3J0fGVub3NwY11bLGlk
PW5hbWVdWyxhaW89dGhyZWFkc3xuYXRpdmVdXG4iCisgICAgIiAgICAgICBbLHdlcnJvcj1pZ25v
cmV8c3RvcHxyZXBvcnR8ZW5vc3BjXVssaWQ9bmFtZV1cbiIKKyAgICAiICAgICAgIFssYWlvPXRo
cmVhZHN8bmF0aXZlfGlvX3VyaW5nXVxuIgogICAgICIgICAgICAgWyxyZWFkb25seT1vbnxvZmZd
Wyxjb3B5LW9uLXJlYWQ9b258b2ZmXVxuIgogICAgICIgICAgICAgWyxkaXNjYXJkPWlnbm9yZXx1
bm1hcF1bLGRldGVjdC16ZXJvZXM9b258b2ZmfHVubWFwXVxuIgogICAgICIgICAgICAgW1ssYnBz
PWJdfFtbLGJwc19yZD1yXVssYnBzX3dyPXddXV1cbiIKQEAgLTEyNDcsOCArMTI0OSw4IEBAIFNS
U1QKICAgICAgICAgVGhlIGRlZmF1bHQgbW9kZSBpcyBgYGNhY2hlPXdyaXRlYmFja2BgLgogCiAg
ICAgYGBhaW89YWlvYGAKLSAgICAgICAgYWlvIGlzICJ0aHJlYWRzIiwgb3IgIm5hdGl2ZSIgYW5k
IHNlbGVjdHMgYmV0d2VlbiBwdGhyZWFkIGJhc2VkCi0gICAgICAgIGRpc2sgSS9PIGFuZCBuYXRp
dmUgTGludXggQUlPLgorICAgICAgICBhaW8gaXMgInRocmVhZHMiLCAibmF0aXZlIiwgb3IgImlv
X3VyaW5nIiBhbmQgc2VsZWN0cyBiZXR3ZWVuIHB0aHJlYWQKKyAgICAgICAgYmFzZWQgZGlzayBJ
L08sIG5hdGl2ZSBMaW51eCBBSU8sIG9yIExpbnV4IGlvX3VyaW5nIEFQSS4KIAogICAgIGBgZm9y
bWF0PWZvcm1hdGBgCiAgICAgICAgIFNwZWNpZnkgd2hpY2ggZGlzayBmb3JtYXQgd2lsbCBiZSB1
c2VkIHJhdGhlciB0aGFuIGRldGVjdGluZyB0aGUKLS0gCjIuMjYuMgoK


