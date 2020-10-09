Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A904C43467
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E268D2231B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhvXsJds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E268D2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyIT-0001Pu-N0
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCU-0002Jt-Hs
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCS-000323-W3
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8ny9QtzgUGgEYvuG+OIh0U68kHOCSKsdAU9hhp1erY=;
 b=VhvXsJds+2bDZiN1myaXk+r5jOPKiwQWGpP5OBUbccF7GxfF1Io2UaUuQvbcpBh+7i9pZL
 XZFfSAOEIokTjKbyYPyH910VIXM7MNXx7Arhr8Aoh6q2cyaasOA57bj9NnZ88AwzymPgC+
 2WxqLCkT/FOJnX2c7UhMGkPKo0Qx+3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-cwmLTKGFPeGk9Modok9O-g-1; Fri, 09 Oct 2020 15:37:03 -0400
X-MC-Unique: cwmLTKGFPeGk9Modok9O-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 653F11084D80;
 Fri,  9 Oct 2020 19:37:02 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D46FB19D7C;
 Fri,  9 Oct 2020 19:36:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 17/30] block/export: report flush errors
Date: Fri,  9 Oct 2020 20:35:16 +0100
Message-Id: <20201009193529.322822-18-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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

UHJvcGFnYXRlIHRoZSBmbHVzaCByZXR1cm4gdmFsdWUgc2luY2UgZXJyb3JzIGFyZSBwb3NzaWJs
ZS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4K
TWVzc2FnZS1pZDogMjAyMDA5MjQxNTE1NDkuOTEzNzM3LTExLXN0ZWZhbmhhQHJlZGhhdC5jb20K
U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0K
IGJsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYyB8IDExICsrKysrKystLS0tCiAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYyBiL2Jsb2NrL2V4cG9ydC92
aG9zdC11c2VyLWJsay1zZXJ2ZXIuYwppbmRleCBiNjA5YTNlNGQ2Li40NGQzYzQ1ZmEyIDEwMDY0
NAotLS0gYS9ibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKKysrIGIvYmxvY2sv
ZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jCkBAIC03OCwxMSArNzgsMTEgQEAgdnVfYmxv
Y2tfZGlzY2FyZF93cml0ZV96ZXJvZXMoVnVCbG9ja1JlcSAqcmVxLCBzdHJ1Y3QgaW92ZWMgKmlv
diwKICAgICByZXR1cm4gLUVJTlZBTDsKIH0KIAotc3RhdGljIHZvaWQgY29yb3V0aW5lX2ZuIHZ1
X2Jsb2NrX2ZsdXNoKFZ1QmxvY2tSZXEgKnJlcSkKK3N0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIHZ1
X2Jsb2NrX2ZsdXNoKFZ1QmxvY2tSZXEgKnJlcSkKIHsKICAgICBWdUJsb2NrRGV2ICp2ZGV2X2Js
ayA9IGdldF92dV9ibG9ja19kZXZpY2VfYnlfc2VydmVyKHJlcS0+c2VydmVyKTsKICAgICBCbG9j
a0JhY2tlbmQgKmJhY2tlbmQgPSB2ZGV2X2Jsay0+YmFja2VuZDsKLSAgICBibGtfY29fZmx1c2go
YmFja2VuZCk7CisgICAgcmV0dXJuIGJsa19jb19mbHVzaChiYWNrZW5kKTsKIH0KIAogc3RhdGlj
IHZvaWQgY29yb3V0aW5lX2ZuIHZ1X2Jsb2NrX3ZpcnRpb19wcm9jZXNzX3JlcSh2b2lkICpvcGFx
dWUpCkBAIC0xNTIsOCArMTUyLDExIEBAIHN0YXRpYyB2b2lkIGNvcm91dGluZV9mbiB2dV9ibG9j
a192aXJ0aW9fcHJvY2Vzc19yZXEodm9pZCAqb3BhcXVlKQogICAgICAgICBicmVhazsKICAgICB9
CiAgICAgY2FzZSBWSVJUSU9fQkxLX1RfRkxVU0g6Ci0gICAgICAgIHZ1X2Jsb2NrX2ZsdXNoKHJl
cSk7Ci0gICAgICAgIHJlcS0+aW4tPnN0YXR1cyA9IFZJUlRJT19CTEtfU19PSzsKKyAgICAgICAg
aWYgKHZ1X2Jsb2NrX2ZsdXNoKHJlcSkgPT0gMCkgeworICAgICAgICAgICAgcmVxLT5pbi0+c3Rh
dHVzID0gVklSVElPX0JMS19TX09LOworICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgcmVx
LT5pbi0+c3RhdHVzID0gVklSVElPX0JMS19TX0lPRVJSOworICAgICAgICB9CiAgICAgICAgIGJy
ZWFrOwogICAgIGNhc2UgVklSVElPX0JMS19UX0dFVF9JRDogewogICAgICAgICBzaXplX3Qgc2l6
ZSA9IE1JTihpb3Zfc2l6ZSgmZWxlbS0+aW5fc2dbMF0sIGluX251bSksCi0tIAoyLjI2LjIKCg==


