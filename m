Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A3CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C137206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ax5qbB46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C137206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5xm-0001Ee-9V
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX5vr-0008DX-Ix
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX5vp-0006PX-RG
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603731917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yTAzjh0IBYYkL6Cj5XRvHM+n45NsFUhaKp+6Z2D1UZU=;
 b=ax5qbB46GSAqferEsF9S8tGUh4HEttx/Ptf5DT0Ew7rugIU6HhSrvpNjwqrSK5E9gZGogh
 Q68H0qgSVSQMIWWWAaNk1j9Pw4eMIpsizBSf1jj9gcc08HBwy6G93D8cwm3d3gctsMrmdJ
 /AKx37X0MdFcd4qpdS29V1Ou95PN/jU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-NFUNfDChObePEjX9xIEZRw-1; Mon, 26 Oct 2020 13:05:14 -0400
X-MC-Unique: NFUNfDChObePEjX9xIEZRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6772804B8C;
 Mon, 26 Oct 2020 17:05:13 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08C2B1002393;
 Mon, 26 Oct 2020 17:05:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 v2 2/2] Add execute bit back to scripts/tracetool.py
Date: Mon, 26 Oct 2020 17:05:02 +0000
Message-Id: <20201026170502.65786-3-stefanha@redhat.com>
In-Reply-To: <20201026170502.65786-1-stefanha@redhat.com>
References: <20201026170502.65786-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQW50aG9ueSBQRVJBUkQgPGFudGhvbnkucGVyYXJkQGNpdHJpeC5jb20+CgpDb21taXQg
YTgxZGYxYjY4YjY1ICgibGlicWVtdXV0aWwsIHFhcGksIHRyYWNlOiBjb252ZXJ0IHRvIG1lc29u
IikKcmVtb3ZlZCBpdCB3aXRob3V0IGV4cGxhbmF0aW9uIGFuZCBpdCBpcyB1c2VmdWwgdG8gYmUg
YWJsZSB0byBydW4gYQpzY3JpcHQgd2l0aG91dCBoYXZpbmcgdG8gZmlndXJlIG91dCB3aGljaCBp
bnRlcnByZXRlciB0byB1c2UuCgpTaWduZWQtb2ZmLWJ5OiBBbnRob255IFBFUkFSRCA8YW50aG9u
eS5wZXJhcmRAY2l0cml4LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVm
YW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFu
Z2VAcmVkaGF0LmNvbT4KTWVzc2FnZS1JZDogPDIwMjAwOTIzMTAzNjIwLjE5ODAxNTEtMS1hbnRo
b255LnBlcmFyZEBjaXRyaXguY29tPgotLS0KIHNjcmlwdHMvdHJhY2V0b29sLnB5IHwgMAogMSBm
aWxlIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIG1vZGUgY2hhbmdl
IDEwMDY0NCA9PiAxMDA3NTUgc2NyaXB0cy90cmFjZXRvb2wucHkKCmRpZmYgLS1naXQgYS9zY3Jp
cHRzL3RyYWNldG9vbC5weSBiL3NjcmlwdHMvdHJhY2V0b29sLnB5Cm9sZCBtb2RlIDEwMDY0NApu
ZXcgbW9kZSAxMDA3NTUKLS0gCjIuMjYuMgoK


