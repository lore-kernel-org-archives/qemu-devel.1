Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EDECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6660E20679
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHaG1F24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6660E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxs8-00005P-J0
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iMxOE-0007yb-Ri
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iMxOD-00037D-QM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:52:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39222
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iMxOD-000374-N9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571763129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FP9OfujuMXPnc05uatDJDsk9/3Ngir+jIMpvI0HfuFo=;
 b=RHaG1F24PrcKN5Gq0qgStaJ6InDuTVhMQmN5tK95XLsJSKb9y5hItcmOCSIYVLhNClcDIN
 0jIAb98owyBz1ptZNICYeF3hI/9SBwIhCBUyHDZ37+FBkUDZWDR8e7l7JMWud+3meOR5N7
 eyL2eQq8ffOdDusk3projuPCmrrUpk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-V6OQk6rVP0W6XMLYqII2ZA-1; Tue, 22 Oct 2019 12:52:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741D3800D49;
 Tue, 22 Oct 2019 16:52:04 +0000 (UTC)
Received: from ptitpuce (ovpn-117-172.ams2.redhat.com [10.36.117.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E45C19C69;
 Tue, 22 Oct 2019 16:51:48 +0000 (UTC)
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-10-stefanha@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 09/16] libqos: access VIRTIO 1.0 vring in little-endian
In-reply-to: <20191019063810.6944-10-stefanha@redhat.com>
Date: Tue, 22 Oct 2019 18:51:39 +0200
Message-ID: <m136fkoh9g.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: V6OQk6rVP0W6XMLYqII2ZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi writes:
[...]
> +static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, uint64_=
t addr)
> +{
> +    uint16_t val =3D qtest_readw(qts, addr);
> +
> +    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(q=
ts)) {

For my education, I was wondering why tests use the (1ull << FEATURE)
notation and not an equivalent of virtio_has_feature()? Is this
intentional, or just legacy?


--
Cheers,
Christophe de Dinechin (IRC c3d)


