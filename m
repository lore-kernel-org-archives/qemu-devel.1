Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFCAC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 19:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5B12075A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 19:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anTWJChC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5B12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWPXd-00048J-Dp
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 15:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWPWu-0003bt-QW
 for qemu-devel@nongnu.org; Wed, 06 May 2020 15:16:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49037
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWPWs-00051i-4Z
 for qemu-devel@nongnu.org; Wed, 06 May 2020 15:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588792584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18sWelKQsD26LdM4FxrdQ7ldOmm/iTfoE1UGpFin83A=;
 b=anTWJChCvZUmvscxFMJJ9BeIUPwLLY6WnIdWqWMapx5FkgyDEMrNq+0KktamE7+7satbeK
 rnU5qZ9sRAXBnZ0tnEGObF1B6UHjmCIoCN9zQGNrRx3hGNWlFWal1du5rEywcOo+wc6Sxj
 uCXR/srzio0IbzQmg1L1817KaNcWY48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-oLA7OuRIPjaBwGGMra5SkA-1; Wed, 06 May 2020 15:16:21 -0400
X-MC-Unique: oLA7OuRIPjaBwGGMra5SkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47777107ACF6;
 Wed,  6 May 2020 19:16:20 +0000 (UTC)
Received: from work-vm (ovpn-114-245.ams2.redhat.com [10.36.114.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A586D10013D9;
 Wed,  6 May 2020 19:16:16 +0000 (UTC)
Date: Wed, 6 May 2020 20:16:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Colin Walters <walters@verbum.org>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(), support non-root
Message-ID: <20200506191614.GR2743@work-vm>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Colin Walters (walters@verbum.org) wrote:
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

Is it ever useful for root to run the code in a new user namespace?

Dave

> This is similar logic to that in https://github.com/containers/bubblewrap
> (Which...BTW, it could make sense for virtiofs to depend on bubblewrap
>  and re-exec itself rather than re-implementing the containerization
>  itself)
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
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


