Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECA4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D032078D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kjynmjd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D032078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonhu-0003kQ-Td
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jongp-0002as-Ba
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:42:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42052
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jongm-0002Mc-NN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593175359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAJN0gymvAKyce6PjLLnce03RYyj9RRGHA8N3PfsXuo=;
 b=Kjynmjd/rvkzVhWdji3eorFS6hpjavIHJTNQ6Agz/ss6H1rD1fXRsK3PL67e6YbL+6KdhZ
 0FM5pxY4b0GVQRYo5uOZyWkOg9N/s8P7fMX1zrJMhHxbxm10Er362pHUm/SRziV6NTacNx
 RIaqNRks1cC9csdO8NzHb+9LKCgzC2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-CEzK0tsbO3yitDyRyzG2fA-1; Fri, 26 Jun 2020 08:42:37 -0400
X-MC-Unique: CEzK0tsbO3yitDyRyzG2fA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87567EC1A0;
 Fri, 26 Jun 2020 12:42:36 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB2D35D9CA;
 Fri, 26 Jun 2020 12:42:34 +0000 (UTC)
Date: Fri, 26 Jun 2020 13:42:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 15/17] block/nvme: Use per-queue AIO context
Message-ID: <20200626124233.GV281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-16-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-16-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jWL1oGPK2mPq0rME"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jWL1oGPK2mPq0rME
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:36PM +0200, Philippe Mathieu-Daud=E9 wrote:
> To be able to use multiple queues on the same hardware,
> we need to have each queue able to receive IRQ notifications
> in the correct AIO context.
> The context has to be proper to each queue, not to the block
> driver. Move aio_context from BDRVNVMeState to NVMeQueuePair.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> RFC because I'm not familiar with AIO context

This patch looks incomplete because there is still only 1
s->irq_notifier but the code already performs aio_set_event_notifer()
calls for each queue in nvme_close().

Either there should be 1 irq_notifier and singleton
aio_set_event_notifier() calls or irq_notifiers should really be
per-queue.

--jWL1oGPK2mPq0rME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl717TkACgkQnKSrs4Gr
c8jXDQf+I+eMzJsTda3Ba9Lmsu1O2m/92QKdnpNj8/wKpIudFXcVa0vxFDQ498X/
qPA8VA2qisxP85B9M74pQEGBoevm5u9M8rS7CBr9gPeyMnjalY6ZodckmvlgAbr4
wCLpNav/KPWK40DjW0gkhxMMwy16A2Rp3QOsx5Uo8VH2OhopgpfH7wnlc8djP2if
oNbO8m89jUm/dcjDRphC//YQBQyuxv0oqFi3b9CGMp5rAa3W+R3+I02d3w3JCKz8
z71jCffPsIC9olNeAOlsCwgUEHexI4rlmZpyIR2bzM7+VgAGhKZjdJiiy8UDLua4
Xga6A1Mhks/vH41Z1FSEEh8n/hQBFw==
=bvkw
-----END PGP SIGNATURE-----

--jWL1oGPK2mPq0rME--


