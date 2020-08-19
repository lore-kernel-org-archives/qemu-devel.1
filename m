Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52DA2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="if1clXuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52DA2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8JAY-00084b-5J
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 04:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8J9b-0007Gq-UO
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:09:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8J9Z-0007st-Ej
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597824540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VXgHLvBUeMfb6VwxSPhAW5XkhQHsIbYiALWizZQGWGQ=;
 b=if1clXuY6YCsF4LLr/FnJlySlmMjqL9pau2mgOUacgb1zqzbq90bsr1uwYNz1WzXhxOGL+
 zRaQf2Z5y+TZJmdxqiw7G/bgM2vISJxh7VyH8wEqd0IoFHPO4DzxqQw6xOyyJ1CTHal0sH
 JKiwo0Mm4x9ebk39uMMig+HSibvAlBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-So1KnDn-M0qWPm0RT04BGw-1; Wed, 19 Aug 2020 04:08:58 -0400
X-MC-Unique: So1KnDn-M0qWPm0RT04BGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32DA9186A567;
 Wed, 19 Aug 2020 08:08:57 +0000 (UTC)
Received: from localhost (ovpn-114-41.ams2.redhat.com [10.36.114.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 772A85D9E2;
 Wed, 19 Aug 2020 08:08:53 +0000 (UTC)
Date: Wed, 19 Aug 2020 09:08:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v3 1/5] block/nvme: Use an array of EventNotifier
Message-ID: <20200819080852.GA339340@stefanha-x1.localdomain>
References: <20200818164509.736367-1-philmd@redhat.com>
 <20200818164509.736367-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200818164509.736367-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2020 at 06:45:05PM +0200, Philippe Mathieu-Daud=E9 wrote:
> In preparation of using multiple IRQ (thus multiple eventfds)
> make BDRVNVMeState::irq_notifier an array (for now of a single
> element, the admin queue notifier).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)

This looks like an intermediate step before using multiple irqs. I think
it makes the code confusing because on one hand INDEX_ADMIN gives the
impression that INDEX_IO() should be used for io queues, while on the
other hand only a single EventNotifier is allocated and we actually
can't use INDEX_IO() yet.

If this intermediate patch is really necessary, please don't use
INDEX_ADMIN. Define a new constant instead:

  /* This driver shares a single MSIX IRQ for the admin and I/O queues */
  #define MSIX_SHARED_IRQ_IDX 0

In the future the array index can be changed to INDEX_ADMIN and
INDEX_IO(n) when there are multiple EventNotifiers.

I think that would make the code clearer.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl883hMACgkQnKSrs4Gr
c8ilhwf+KmwjJiRnf3LMyiJtQ6l4t8rbRxhbt43wP52+Q6hl2P86VBLbL6/sFYWL
xG+O9khr0KPLH2SFCzh7f4Qk01rIQ/Negw7phHvXsGIk/LGlVF1T5CHPuyKA36x9
0CJP2kuen/Y8nDk0sOcY7MMgdkiMs1/AUywACc/CQ7GvjWO4+7H9/3CoKlS+2O/G
IvW6kghpLZG/5Ba56qzWsANZtglGAg8rwaH0FgGe4ejj6jbq76MHKF0Er+F6Rl8g
8J5QNrfBC2Lb4OqCbIh/NxlQm1dAPG+C4Y2t19q4G//ThM2PBKdT8DbLEEM8Esn0
uy6fP6DLOKVLH45Kl53Aw8P8s4DLnQ==
=RKvr
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--


