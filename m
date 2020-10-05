Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBC1C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B45D2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfwukXrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B45D2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQyc-000713-Hn
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPQwo-00061I-My
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPQwm-0008Ti-UD
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601906076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1d0NRCoLzx8k7ULihqSWEZcOlNupW5zoqeBQ0+ZjudQ=;
 b=RfwukXrH6qJw+crc4jpprQNqIj3xM+TLHPmkh5san5+bjMD0oRyHlvY8tgpEbvM2AH9J54
 NP6ZOrp+KZci52Go/A5xMcgbaR/RQyQlajx5Gre3K1Dw+kjrUTo3MJQesFjDlvXkhzb9Lk
 LzD5tQ8JnaAClIR1JBPVq/GholfMRz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-uIiuCgKyODaBfPCh8g7Ocg-1; Mon, 05 Oct 2020 09:54:33 -0400
X-MC-Unique: uIiuCgKyODaBfPCh8g7Ocg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDE5C107ACF7;
 Mon,  5 Oct 2020 13:54:32 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 650337366A;
 Mon,  5 Oct 2020 13:54:32 +0000 (UTC)
Date: Mon, 5 Oct 2020 14:54:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] virtiofsd: Call qemu_init_exec_dir
Message-ID: <20201005135431.GD5029@stefanha-x1.localdomain>
References: <20201002124015.44820-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201002124015.44820-1-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 01:40:15PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Since fcb4f59c879 qemu_get_local_state_pathname relies on the
> init_exec_dir, and virtiofsd asserts because we never set it.
> Set it.
>=20
> Reported-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl97JZcACgkQnKSrs4Gr
c8hwyAf/S8GpiKwKuPzbSum7ajBUC1cDeTDkNOa/Dy6oVW4em0fVXB1DhSz+kAT/
GMEcu52Q3+XCDZZ4XKnpdg5MgvKk7aMbsAjPG0zIpAcOy0G9T/x5BxjoKFv9nCtX
SJVdSZUgGSLUi9ssjw+sBFctxPPAaZpdUpWJw6n04ZHIlrUxvjkkgZYpOsFz2B14
2+l+6lbVkh9wjHocxD+KyyLUy7HqfXj5GskOWIhoAQo/hQvGYu3Cj8yDer9pVqda
Y4L2UrxFPRl9kJ7ElSPvuHC6srK1+R02t7gbAB8YHIaZMsG9JPgM7jKFYHBz+7GT
a/0K7+ZHG+Rj/jehBwGSxsn5HUSs7g==
=DpIA
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--


