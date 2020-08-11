Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48A3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 18:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF64206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 18:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9GjppG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF64206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Ymq-000414-UE
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 14:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k5YkL-0002YC-Di
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 14:11:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k5YkJ-0004bY-EC
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 14:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597169494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QqRF/4xikJa+obEUFEjMSpHLfuvTg5pyQfZpnzEsxR8=;
 b=N9GjppG17Vp9d818S9w45R7g4HmzM1Cu33s8DZTUIWmcTEMZBt4lVjxTyq/FWaAWSC2+y9
 2HOY0j6hx5JTH7wqkh+0k78+3coPCmjz9pGLKjgnySwpMrMeB2MrWurzUorUu8Dr/uUFFX
 KLDqM3oxoCXFrJMfSwcjrW4N/Ag5MsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-DIL1jsnNO9G0OIrTH8-80A-1; Tue, 11 Aug 2020 14:11:32 -0400
X-MC-Unique: DIL1jsnNO9G0OIrTH8-80A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 864AB1902EA8;
 Tue, 11 Aug 2020 18:11:31 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F7196111F;
 Tue, 11 Aug 2020 18:11:24 +0000 (UTC)
Date: Tue, 11 Aug 2020 12:11:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 2/3] util/vfio-helpers: Add trace event to display
 device IRQs available
Message-ID: <20200811121124.635cdf21@x1.home>
In-Reply-To: <20200811172845.16698-3-philmd@redhat.com>
References: <20200811172845.16698-1-philmd@redhat.com>
 <20200811172845.16698-3-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Aug 2020 19:28:44 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Add a trace event to display the amount of IRQs available
> on the device.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  util/vfio-helpers.c | 1 +
>  util/trace-events   | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 6defefcc01..3ad7e6be52 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -192,6 +192,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNot=
ifier *e,
>          error_setg(errp, "Device interrupt doesn't support eventfd");
>          return -EINVAL;
>      }
> +    trace_qemu_vfio_pci_init_irq(irq_info.count);
> =20
>      irq_set_size =3D sizeof(*irq_set) + sizeof(int32_t);
>      irq_set =3D g_malloc0(irq_set_size);
> diff --git a/util/trace-events b/util/trace-events
> index 0ce42822eb..351dbdbe3c 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -83,3 +83,4 @@ qemu_vfio_new_mapping(void *s, void *host, size_t size,=
 int index, uint64_t iova
>  qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s=
 %p host %p size %zu iova 0x%"PRIx64
>  qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint=
64_t *iova) "s %p host %p size %zu temporary %d iova %p"
>  qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
> +qemu_vfio_pci_init_irq(uint32_t count) "device interrupt count: %"PRIu32

Knowing the count independent of which index we're looking at doesn't
seem very useful.  Thanks,

Alex


