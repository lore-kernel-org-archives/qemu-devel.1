Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA30CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 09:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E6A20679
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 09:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIzS7b/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E6A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg3eo-0002V6-NU
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 05:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jg3eH-00025w-5O
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 05:55:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58536
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jg3eF-0002To-MR
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 05:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591091754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/TAeZYDNyhJVXO8HezZkxpjM0eCVqTgNp6ZtJNQvXs=;
 b=hIzS7b/dC++BYJIgRSkNUqyquJKSahRMb0t/FZXg9cbkVszhvKWDRrU/vl8aXGLnU6dDRh
 icKI/24DFDLiF3a+VJ48veiK2HHf2GhruDYxEhaYNl0YMK9Bj16amOghkcMF/6bPQ9cLFU
 PxWSUgTJrBNXK3LTyyWK4T4l47H5zvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-DQWM8UUKNVm_5sexuT3Pmg-1; Tue, 02 Jun 2020 05:55:50 -0400
X-MC-Unique: DQWM8UUKNVm_5sexuT3Pmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF1AF100CCC0;
 Tue,  2 Jun 2020 09:55:49 +0000 (UTC)
Received: from localhost (ovpn-115-9.ams2.redhat.com [10.36.115.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42F5E5C1D6;
 Tue,  2 Jun 2020 09:55:49 +0000 (UTC)
Date: Tue, 2 Jun 2020 10:55:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Colin Walters <walters@verbum.org>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(), support non-root
Message-ID: <20200602095547.GD9852@stefanha-x1.localdomain>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 02:25:48PM -0400, Colin Walters wrote:
> I'd like to make use of virtiofs as part of our tooling in
> https://github.com/coreos/coreos-assembler
> Most of the code runs as non-root today; qemu also runs as non-root.
> We use 9p right now.
>=20
> virtiofsd's builtin sandboxing effectively assumes it runs as
> root.
>=20
> First, change the code to use `clone()` and not `unshare()+fork()`.
>=20
> Next, automatically use `CLONE_NEWUSER` if we're running as non root.
>=20
> This is similar logic to that in https://github.com/containers/bubblewrap
> (Which...BTW, it could make sense for virtiofs to depend on bubblewrap
>  and re-exec itself rather than re-implementing the containerization
>  itself)
>=20
> Signed-off-by: Colin Walters <walters@verbum.org>
> ---
>  tools/virtiofsd/passthrough_ll.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

Ping Colin. It would be great if you have time to share your thoughts on
this discussion and explain how you are using this patch.

To summarize: I'm unclear what behavior a user can expect since I'm not
aware of anything that applies /etc/subuid for the user namespace. Does
this mean the expected behavior is that virtiofsd will map all uids/gids
to -1 when invoked non-root?

Could you document the behavior and consider supporting both -1 and
/etc/subuid operation? Both seem like useful behaviors for different use
cases.

Thanks,
Stefan

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7WIiMACgkQnKSrs4Gr
c8jx0gf+J+1x8Wi+g4PSJ1BljZpCuuUW4GUaY6DmPvg+R6KmHpMheK9BajREjMGx
Ah4xnlTxD75k2jT6xE4xLye5B98VoO2Zj6VG4oZAjtzbXey470JiRO/XgZpWjuog
b173t5+Jfg/dYIwGtFekcTtu7i1GeVIj8vCeA0K/9FoqgKTbwEjTwpmAWbn4bDAW
PPdbg2vDyR2b0iJ6vUIZrRyiwaCcXLswCcLwHBlQCM39lxumLzxocOVDArxMb7Ug
feqPDBOLukSF8NydVBLMgqnCyjJ8Z6RSPcD6xWqbw/dXXP0VYWekrkNq4RyV0i7w
0GgkIn97hk/dzXz7FS2l1/Fh4D9MBg==
=x38r
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--


