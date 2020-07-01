Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0372AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7F420760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVPudWdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7F420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfFG-0003Pq-SY
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqfDj-0001g8-0w
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:04:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44911
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqfDg-0004os-F9
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593619459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gzfRBi+SA8gcr1TtSb39vjjSloXc7wy99tJc6PgzrNo=;
 b=VVPudWdAoIOrhmbv0VQJGzUyn+5kzZTQHqdksX3+yXEMBmFqYCftuFaafCihsJWY3Zi4vb
 A8BVZcZTEzJuIZb+itwKizR4/xw0OjjXlRuPIkmJeS3xi2TVSb+2w1k8B4/6lzbhl47xeX
 DwZ/z2NJiWQloshNrTB47hLRfk5HGnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-xeg-4fiEMcuff3b9tRcMGg-1; Wed, 01 Jul 2020 12:04:15 -0400
X-MC-Unique: xeg-4fiEMcuff3b9tRcMGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 180721898AB9;
 Wed,  1 Jul 2020 16:03:38 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93AAD6109F;
 Wed,  1 Jul 2020 16:03:29 +0000 (UTC)
Date: Wed, 1 Jul 2020 17:03:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 12/12] block/nvme: Use per-queue AIO context
Message-ID: <20200701160328.GS126613@stefanha-x1.localdomain>
References: <20200630191318.30021-1-philmd@redhat.com>
 <20200630191318.30021-13-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630191318.30021-13-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Vy6UCbb9EK60RK4A"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Vy6UCbb9EK60RK4A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 09:13:18PM +0200, Philippe Mathieu-Daud=E9 wrote:
> To be able to use multiple queues on the same hardware,
> we need to have each queue able to receive IRQ notifications
> in the correct AIO context.
> The AIO context and the notification handler have to be proper
> to each queue, not to the block driver. Move aio_context and
> irq_notifier from BDRVNVMeState to NVMeQueuePair.

If I understand correctly, after this patch:

1. Each queue pair has an EventNotifier irq_notifier but only the admin
   queuepair's irq_notifier is hooked up to VFIO. This means all
   interrupts come via the admin queuepair.

   (This also means all queuepairs still need to be polled for
   completions when the interrupt fires because we don't know which
   queuepair had a completion event.)

2. AioContexts must be identical across all queuepairs and
   BlockDriverStates. Although they all have their own AioContext
   pointer there is no true support for different AioContexts yet.

   (For example, nvme_cmd_sync() is called with a bs argument but
   AIO_WAIT_WHILE(q->aio_context, ...) uses the queuepair aio_context so
   the assumption is that they match.)

Please confirm and add something equivalent into the commit description
so the assumptions/limitations are clear.

--Vy6UCbb9EK60RK4A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78s9AACgkQnKSrs4Gr
c8jKhggAtxXMK8Jq1ar63mDURxlPrb6LJIT5UtKR0OFnkZGp5wJAYBJnnaHTMzyD
YoEjU1wiIrRMOj7GQ8JWNm9g7Y/eT+rfaeVhhLcp4L2NnEvLrzHyBL4tHaz82KPW
CvvXRUgm+CVJmNYN7tk2l0xp609wIervUIVoiDpUbazq77SAE0V2Z1AS3ui8c7Vt
WHvOrznPUxm1/pNoHrJGfU4oKcgUlc2PWO52tetXBIuq4gR7gTJK8CamDq+TCeap
gTlAvUQIZgK2rUQu9UkPav8moDp+zIq3qYIykJEV/ckJIRaqDWyTRvERYrVAir7K
f5GNX8VQZdfkDPfC6PRqyoL5ZBsrfw==
=296D
-----END PGP SIGNATURE-----

--Vy6UCbb9EK60RK4A--


