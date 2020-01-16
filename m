Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E95C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD402051A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGUyYVAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD402051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is67I-0007fK-PV
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1is5zl-000663-F4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1is5zh-00024M-I7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:19:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49065
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1is5zh-00024A-EM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579184373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ymcP5E+Xkkkoj7FWJgYJu0YhxEGReUCWZNO/PgXFfQA=;
 b=KGUyYVAlERJaXaVQ33IUZLPuyeR0dY5MoU7WWzQ8rwBbpqsY6CwPTl8AQ8/uM6yMDUaG08
 kGAJcQPdXCd35BjIMUZZaM+Ab8Wy8vt+SCv96uI6v4CqNv2Ex/zHANZJ14QDpbNkVrA16V
 qY9XoyXJPRIXZbiVaz45nb2h1OfROs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-StgQyL2UMzGWv_1wY2sRhA-1; Thu, 16 Jan 2020 09:19:31 -0500
X-MC-Unique: StgQyL2UMzGWv_1wY2sRhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDC87108121B
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 14:19:30 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75201845A8;
 Thu, 16 Jan 2020 14:19:24 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-43-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 042/104] virtiofsd: validate input buffer sizes in
 do_write_buf()
In-reply-to: <20191212163904.159893-43-dgilbert@redhat.com>
Date: Thu, 16 Jan 2020 15:19:22 +0100
Message-ID: <87v9pbwkk5.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> There is a small change in behavior: if fuse_write_in->size doesn't
> match the input buffer size then the request is failed.  Previously
> write requests with 1 fuse_buf element would truncate to
> fuse_write_in->size.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/fuse_lowlevel.c | 49 ++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 19 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4gcOoACgkQ9GknjS8M
AjX83A/+MyX1lxmy1BZbDMZJh1wvqVxj4O/cQzshHcuXQtpMEcYyw8DjdWC7bEZY
u962n0wo0Hnn40SHf/BBIUYpcQqwU4y24kfzpeOyw89CBzlczCPmUbxwxmFdk/Zr
tny3ym23VRLVDRk/mRl7QhoMOk1qxadVx4vN7hv2u+GbCv6NTds/3udHBQ8y0//m
qY64TAW+BIrxjIOytITDGYDfkZF1RZhFnJwsWxyTRtvsOguoSdsd1s9hAm4qhyFb
5KMiqtcDbZy0rLauO+ybLS1uxLvqusOg2gLX28mRcTkJQeASo/iKWMdENyD/RnWx
Xccyh1gkUCTLJSF+XQAhNiOfY0/6xhc7lP24IrcDs+3CHhiBJhsjYHgXlgbct/G4
q6aDABA+zVucShIG9GKxZpRXKBcaboo2HOes0NWvopOokV9/CpDMWFAqD/nJzUVq
JKcxWWTjCS877uQH4wMI17Kug9wiHD+CvhSuR9ENftBDUdx/he9LsfTLvo2aS/ku
o4Guq+KqjpIt1hkZy3aT1R8T4ugvS8Dhmqt9h3ipe/4QyHd298W8dVf2LfxxOARQ
TbEXm6iqsLYmMcfm0ns2TYL9wWkARiPkyg5Fvnf0cPVocpXvdVjpdPdUPUdjjqcL
2zvQ2Y2kTayhd0TY45lx0dWQ4Y5TX1gJS0sUouqatE/eZx4fDks=
=G2kR
-----END PGP SIGNATURE-----
--=-=-=--


