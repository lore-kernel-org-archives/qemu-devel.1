Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90C1C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5ACF2177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3xQSkpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5ACF2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIuo-0002ZK-PT
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBIu5-0001NF-9A
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:29:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26235
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBIu3-0004Hs-IY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598538562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dll7GMD/iJeTdEs3IUJps/RpF6bguLXoLZVx/4sMeKw=;
 b=H3xQSkpV44jKrQ4wRzyaXXOOkyPgVjj4Pafc4+GvxfwNfLnwT7+hev9qm0DWEmdAUEaf/9
 6u3q4Efiuvu05ciOZ1jC9aK2JGpj76UIYhrJw72q94KUzn9xQibgEbuB2K9C7erRa3Wv73
 PgM3+BhdtdNqrcRBsTVcM0SgIF856Nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-4XyZH5RrO1aPhagoEaonhw-1; Thu, 27 Aug 2020 10:29:20 -0400
X-MC-Unique: 4XyZH5RrO1aPhagoEaonhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEC1BAE407;
 Thu, 27 Aug 2020 14:29:19 +0000 (UTC)
Received: from localhost (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9685C74E23;
 Thu, 27 Aug 2020 14:29:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] tracetool: show trace-events filename/lineno in fmt
 string errors
Date: Thu, 27 Aug 2020 15:29:11 +0100
Message-Id: <20200827142915.108730-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBwYXRjaCBzZXJpZXMgaW1wcm92ZXMgZm9ybWF0IHN0cmluZyBjb21waWxlciBlcnJvciBt
ZXNzYWdlcy4gSW5zdGVhZCBvZg0Kc2hvd2luZyB0aGUgZ2VuZXJhdGVkIGZpbGUsIHNob3cgdGhl
IHRyYWNlLWV2ZW50cyBmaWxlIHdoZXJlIHRoZSBmb3JtYXQgc3RyaW5nDQppcyBkZWZpbmVkLg0K
DQpTdGVmYW4gSGFqbm9jemkgKDQpOg0KICB0cmFjZXRvb2w6IGFkZCBvdXRwdXQgZmlsZW5hbWUg
Y29tbWFuZC1saW5lIGFyZ3VtZW50DQogIHRyYWNldG9vbDogYWRkIG91dF9saW5lbm8gYW5kIG91
dF9uZXh0X2xpbmVubyB0byBvdXQoKQ0KICB0cmFjZXRvb2w6IGFkZCBpbnB1dCBmaWxlbmFtZSBh
bmQgbGluZSBudW1iZXIgdG8gRXZlbnQNCiAgdHJhY2V0b29sOiBzaG93IHRyYWNlLWV2ZW50cyBm
aWxlbmFtZS9saW5lbm8gaW4gZm10IHN0cmluZyBlcnJvcnMNCg0KIGRvY3MvZGV2ZWwvdHJhY2lu
Zy50eHQgICAgICAgICAgICAgIHwgIDMgKy0NCiBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAzICstDQogc2NyaXB0cy90cmFjZXRvb2wucHkgICAgICAgICAgICAgICAgfCAx
MiArKysrLS0tDQogc2NyaXB0cy90cmFjZXRvb2wvX19pbml0X18ucHkgICAgICAgfCA1MyArKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLQ0KIHNjcmlwdHMvdHJhY2V0b29sL2JhY2tlbmQvZnRy
YWNlLnB5IHwgIDQgKysrDQogc2NyaXB0cy90cmFjZXRvb2wvYmFja2VuZC9sb2cucHkgICAgfCAg
NCArKysNCiBzY3JpcHRzL3RyYWNldG9vbC9iYWNrZW5kL3N5c2xvZy5weSB8ICA0ICsrKw0KIHRy
YWNlL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgIHwgMjMgKysrKystLS0tLS0tLQ0KIDgg
ZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pDQoNCi0tIA0K
Mi4yNi4yDQoNCg==


