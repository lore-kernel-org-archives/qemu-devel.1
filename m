Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D702CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6338220650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7ivHhEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6338220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNEPs-0002Tw-EM
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iNDks-0005jG-MM
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iNDkr-0001E1-LH
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:20:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21709
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iNDkq-000184-SI
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571826025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OquOmkEfZF5p6tudPamBAGc+vmIYN15LADIIIuBk+Co=;
 b=T7ivHhEzt2MzTXMyLIaaxQnQgRGZIz1FAgWknvgS4g4Hk6aFHw5grOtxtDa2kJUZ46c8Qi
 Eu7CltoMJI5tGpm3UjxfrWSxt04IeoHVPot0upE558AT6M0FCEMNzNSD+gk8j1n6DMqYoP
 /IiL7s6kEtuMEFZkzlhufzxLf1IwVOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-sd6wuK3APz-zqobgdpb-tw-1; Wed, 23 Oct 2019 06:20:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5C04107AD31;
 Wed, 23 Oct 2019 10:20:20 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98F3060C57;
 Wed, 23 Oct 2019 10:20:20 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 83C5C4EE50;
 Wed, 23 Oct 2019 10:20:20 +0000 (UTC)
Date: Wed, 23 Oct 2019 06:20:20 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <653174242.8144394.1571826020499.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191023100425.12168-7-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
 <20191023100425.12168-7-stefanha@redhat.com>
Subject: Re: [PATCH v4 06/16] libqos: add missing virtio-9p feature negotiation
MIME-Version: 1.0
X-Originating-IP: [149.14.88.107, 10.4.196.23, 10.5.100.50, 10.4.195.12]
Thread-Topic: libqos: add missing virtio-9p feature negotiation
Thread-Index: jj5HLj1cpVr3Yy1BdGgTdhsTltAWgA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sd6wuK3APz-zqobgdpb-tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 qemu-block@nongnu.org, slp@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> From: "Stefan Hajnoczi" <stefanha@redhat.com>
> Sent: Wednesday, October 23, 2019 12:04:15 PM
>=20
> VIRTIO Device Initialization requires feature negotiation.  The libqos
> virtio-9p driver lacks feature negotiation and is therefore
> non-compliant.
>=20
> libqos tests acknowledge all feature bits advertised by the device,
> except VIRTIO_F_BAD_FEATURE (which devices use to detect broken
> drivers!) and VIRTIO_RING_F_EVENT_IDX (which is not implemented in
> libqos and accepting it would break notifications).
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/libqos/virtio-9p.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Thomas Huth" <thuth@redhat.com>


