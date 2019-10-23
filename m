Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCC0CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F25214B2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMRb1wCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F25214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNF8c-0004Oe-45
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iNEkC-0001CH-PM
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iNEkA-0003Xj-DE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:24:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iNEkA-0003WU-0R
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571829837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdyLITlbt1G2PAZ+zH6EalHEYyCkaolOk/S03WNTkWM=;
 b=GMRb1wCeNc7/Iyon5ftzak8W1nszg60vuUYjMqt/lqRdDHtu6SYN8ONuqEWlja+WpWyv9k
 99qjTDmRPZ29tlLogUxMCHVnzT9e0/BUhmFtJM7beEZz0PpZAv7GzzwiR3oU5oX3iCGOnv
 QKAssFjSJRnuU5XKvqfYL9TzH1lBsg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-dy8NPmurMU-6YVrqkGA5jA-1; Wed, 23 Oct 2019 07:23:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59236800D57;
 Wed, 23 Oct 2019 11:23:54 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CD6419C70;
 Wed, 23 Oct 2019 11:23:54 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3A3FE18089C8;
 Wed, 23 Oct 2019 11:23:54 +0000 (UTC)
Date: Wed, 23 Oct 2019 07:23:54 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1674218278.8152184.1571829834180.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191023100425.12168-8-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
 <20191023100425.12168-8-stefanha@redhat.com>
Subject: Re: [PATCH v4 07/16] libqos: enforce Device Initialization order
MIME-Version: 1.0
X-Originating-IP: [149.14.88.107, 10.4.196.10, 10.5.101.130, 10.4.195.24]
Thread-Topic: libqos: enforce Device Initialization order
Thread-Index: Ugg0Kwpe1CA5Nu705oUpG32OBPQ6MQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dy8NPmurMU-6YVrqkGA5jA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
 qemu-block@nongnu.org, slp@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> From: "Stefan Hajnoczi" <stefanha@redhat.com>
> Sent: Wednesday, October 23, 2019 12:04:16 PM
>=20
> According to VIRTIO 1.1 "3.1.1 Driver Requirements: Device
> Initialization", configuration space and virtqueues cannot be accessed
> before features have been negotiated.  Enforce this requirement.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v4:
>  * Introduce bool d->features_negotiated so that tests can negotiate a
>    0 feature bit set in Legacy mode [Thomas]
> ---
>  tests/libqos/virtio.h | 1 +
>  tests/libqos/virtio.c | 7 +++++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


