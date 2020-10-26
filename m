Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C16C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D9620715
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8rp5HQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D9620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX574-00052k-CZ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4x8-0002vB-Ue
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4x7-0005rJ-2R
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603728152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pVujzGXOlIuEv9NTkGhQPcnRAOW7vGixWHrQP+e65lQ=;
 b=Q8rp5HQ18ZcuDmRdzyd5ZMogdaET1okX47Q0SGyTAVvB/jG6Ci2Wrts2QxeVm0xTsVNSVB
 Url9KVFX60XelILTFEbFiZnxV9NamrHHr5aroEILoXoUam3YI6RMmzEHBb6EmyxhBJB+d3
 QtWq33TPYKYZ2atQERWPS3qHXt23tqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-QsVJQM93PZSz1ZwEzIgT0Q-1; Mon, 26 Oct 2020 12:02:29 -0400
X-MC-Unique: QsVJQM93PZSz1ZwEzIgT0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF442809DDD;
 Mon, 26 Oct 2020 16:02:25 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 631775C1BB;
 Mon, 26 Oct 2020 16:02:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/2] Tracing patches
Date: Mon, 26 Oct 2020 16:02:19 +0000
Message-Id: <20201026160221.62704-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA0YzViOTdiZmQwZGQ1NGRjMjc3MTdh
ZThkMWNkMTBlMTRlZWYxNDMwOg0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMva3JheGVsL3RhZ3MvbW9kdWxlcy0yMDIwMTAyMi1wdWxsLXJlcXVlc3QnIGludG8gc3Rh
Z2luZyAoMjAyMC0xMC0yMiAxMjozMzoyMSArMDEwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUg
R2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXRsYWIuY29tL3N0ZWZhbmhhL3FlbXUu
Z2l0IHRhZ3MvdHJhY2luZy1wdWxsLXJlcXVlc3QNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2Vz
IHVwIHRvIDFlOGViZjExMTZhNzAyM2I0ZGQxOTE5ZDMxYWY4YjRlMTczMjFkYTQ6DQoNCiAgQWRk
IGV4ZWN1dGUgYml0IGJhY2sgdG8gc2NyaXB0cy90cmFjZXRvb2wucHkgKDIwMjAtMTAtMjYgMTM6
MjI6MzYgKzAwMDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClB1bGwgcmVxdWVzdA0KDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkFudGhv
bnkgUEVSQVJEIHZpYSAoMSk6DQogIEFkZCBleGVjdXRlIGJpdCBiYWNrIHRvIHNjcmlwdHMvdHJh
Y2V0b29sLnB5DQoNCkpvc2ggRHVCb2lzICgxKToNCiAgdHJhY2Uvc2ltcGxlOiBFbmFibGUgdHJh
Y2luZyBvbiBzdGFydHVwIG9ubHkgaWYgdGhlIHVzZXIgc3BlY2lmaWVzIGENCiAgICB0cmFjZSBv
cHRpb24NCg0KIHRyYWNlL2NvbnRyb2wuYyAgICAgIHwgNiArKysrKy0NCiBzY3JpcHRzL3RyYWNl
dG9vbC5weSB8IDANCiAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KIG1vZGUgY2hhbmdlIDEwMDY0NCA9PiAxMDA3NTUgc2NyaXB0cy90cmFjZXRvb2wucHkN
Cg0KLS0gDQoyLjI2LjINCg0K


