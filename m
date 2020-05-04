Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41F5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E60A2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cow85Ahk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E60A2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbUn-00057G-J9
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVbTY-0004BJ-5G
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:49:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVbTW-0002yj-VA
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:49:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id h4so8535261wmb.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=701IHL97AJLPqzxksKXgI0+OQ6FtCyzXsDsf0H0loI8=;
 b=Cow85AhkcasGHTczjWACpOPclFJcDoNPs3/nH0v6c3/4+WBKYKU2NmphuCH86XsH9E
 MloASgdSQzHNIOGUGwXAf0p4rKTNVw/lU5Zs5X/MMsaiYdx7INwYWtZm4CWfOBLiy5Ld
 YbaN5nCPxzzI000A8i0WBWPsDEeeE+oHF90YAj6IcztbzynsmUeLgXBA+0aDLiJDn/kk
 OWzvIRMZWn4yTFvGK8MgXb5adVizS5q8TYOb8gO23R72mAqG/z9TDqvlZ5QaG6Y7sGYN
 qTLVcfvFPKE4X6bOGjzZbr/4hnm31oRz05nKf7pVQ1Zi6FOjQm/LV0lA0iRTHtMFTuFp
 Y92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=701IHL97AJLPqzxksKXgI0+OQ6FtCyzXsDsf0H0loI8=;
 b=BZeUZqP9sndnCN8LGkKxb+Ucygm6+BDZouhFwgHl5oOuXXMV912OzRGmQg4EeC/2bm
 CkKVeprhlnyxFv3ZTiqZQF8lc6TvbCmbkmLvbn6hl4eMf414kJJpueNtYh7za63HjNye
 cvqEwDXmWdC5lFn3+/vgzco5XN755qIR25tE0ePeKs2yxGAmPsluKXb5jMD76ONWW9wN
 S4GKeOmu1rAZw7mVtNkNRVoep9tSG5kMVhSOnYK+o+xfKm1Bjmu9uzd7UdGSt62AP6uq
 HFB8nDAy6doW3YMNWg/BcymcIWtbTQgfv4DJ37EjfHZq7TiibbVxQmFsUqY20G/ZGaTa
 KlqQ==
X-Gm-Message-State: AGi0PuaIhVfrwalMwgEzZQo0NtZOXqIlLq9sGmJ7MnaJCsJDMDSvK0CW
 sVSmYNgsWTtDaKLFFTNB1gQ=
X-Google-Smtp-Source: APiQypJBY8BnFGFOW99t34oAw9sC0boKI8IHBT8WFNw21Bugp01pkQgMQzMBTeiKYe++WaOugApXqQ==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr13719013wml.132.1588600177489; 
 Mon, 04 May 2020 06:49:37 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n21sm5465886wra.15.2020.05.04.06.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 06:49:36 -0700 (PDT)
Date: Mon, 4 May 2020 14:49:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Colin Walters <walters@verbum.org>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(), support non-root
Message-ID: <20200504134935.GI354891@stefanha-x1.localdomain>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Content-Disposition: inline
In-Reply-To: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: virtio-fs@redhat.com, Daniel Walsh <dwalsh@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/8E7gjuj425jZz9t
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

Great, thanks for posting this! The topic of how and when to do the
sandboxing, as well as whether to require root, has come up several
times.

Please update the man page to explain the behavior that users should
expect when running as non-root:
1. What happens to uid/gid of files from the perspective of a user
   outside the sandbox?
2. Are there any limitations (certain operations that don't work)?

Thanks,
Stefan

>=20
> Signed-off-by: Colin Walters <walters@verbum.org>
> ---
>  tools/virtiofsd/passthrough_ll.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 4c35c95b25..468617f6d6 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2530,6 +2530,21 @@ static void print_capabilities(void)
>      printf("}\n");
>  }
> =20
> +/* Copied from bubblewrap */
> +static int
> +raw_clone(unsigned long flags, void *child_stack)
> +{
> +#if defined(__s390__) || defined(__CRIS__)
> +  /*
> +   * On s390 and cris the order of the first and second arguments
> +   * of the raw clone() system call is reversed.
> +   */
> +    return (int) syscall(__NR_clone, child_stack, flags);
> +#else
> +    return (int) syscall(__NR_clone, flags, child_stack);
> +#endif
> +}
> +
>  /*
>   * Move to a new mount, net, and pid namespaces to isolate this process.
>   */
> @@ -2547,14 +2562,15 @@ static void setup_namespaces(struct lo_data *lo, =
struct fuse_session *se)
>       * an empty network namespace to prevent TCP/IP and other network
>       * activity in case this process is compromised.
>       */
> -    if (unshare(CLONE_NEWPID | CLONE_NEWNS | CLONE_NEWNET) !=3D 0) {
> -        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWPID | CLONE_NEWNS): %m\=
n");
> -        exit(1);
> +    int clone_flags =3D SIGCHLD | CLONE_NEWPID | CLONE_NEWNS | CLONE_NEW=
NET;
> +    /* If we're non root, we need a new user namespace */
> +    if (getuid() !=3D 0) {
> +        clone_flags |=3D CLONE_NEWUSER;
>      }
> =20
> -    child =3D fork();
> +    child =3D raw_clone(clone_flags, NULL);
>      if (child < 0) {
> -        fuse_log(FUSE_LOG_ERR, "fork() failed: %m\n");
> +        fuse_log(FUSE_LOG_ERR, "clone() failed: %m\n");
>          exit(1);
>      }
>      if (child > 0) {
> --=20
> 2.24.1
>=20
>=20

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6wHW4ACgkQnKSrs4Gr
c8jEKwf/Tc5syIJkh/dNa9X4ofgIChixMbtjdgeAlTVDZwUY2ZHGpCTW9K/s6a8a
0nvYZXWw/u/E0/RA18udges0FShOEqbku/k/5RoT8GMV+FEOGIENIvlm2Un9PsYV
wxjRQed/npg2DWZl3yKMKrdAbGMwee5RazGZnjxID3RUTpMi6HIAJMfUw1PkwJN7
Ebs70rsKFeN+mOojCsy6K5x/yGoizEwEnUYbhqDq0Yl/K4Da2SXY6cd2rsyYR7IU
0LniOMTpb4gX5BuZGvqN2yb24eQa7wvkvM9vPxC3KjmoVOfljkRvZkG15IwYN0qa
5z4y8zzcKwYdwgVXy2XzIVrIuKftRw==
=eoEn
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--

