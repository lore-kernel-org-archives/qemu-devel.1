Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD525C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BED22173E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1Dwo4wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BED22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUZsZ-0000dc-SD
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 13:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUZrW-0007ss-Bn
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jUZrU-0000r5-NZ
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:54:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUZrU-0000nE-7c
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588355646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYtZJOBQrxllvnPzykUoJdXdrlfAI4FU5nO2FNZLgTc=;
 b=h1Dwo4wcoxYedmMbhVkzLfatJKzLOQUn0VG/+31zCSxvmzPQlDoQD6JODMgA9Tuzy8xIJr
 9nLIGM3mwm50YHGYy8fgYk42qxx2zO06mux6k0InIaKuVYjyyhxP40LhRty92BFclcmhKy
 Jh/xdnBcBx8Cvg1HxaPKUnqpsY7u0Hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-19IjASBOOiyUdt93CUHl2w-1; Fri, 01 May 2020 13:53:47 -0400
X-MC-Unique: 19IjASBOOiyUdt93CUHl2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F3051009635
 for <qemu-devel@nongnu.org>; Fri,  1 May 2020 17:53:46 +0000 (UTC)
Received: from work-vm (ovpn-112-191.ams2.redhat.com [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B9C82B4CC;
 Fri,  1 May 2020 17:53:29 +0000 (UTC)
Date: Fri, 1 May 2020 18:53:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200501175326.GC38251@work-vm>
References: <20200424133516.73077-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200424133516.73077-1-mreitz@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 08:22:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Max Reitz (mreitz@redhat.com) wrote:
> Currently, setup_mounts() bind-mounts the shared directory without
> MS_REC.  This makes all submounts disappear.
>=20
> Pass MS_REC so that the guest can see submounts again.
>=20
> Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Queued.

> ---
>  tools/virtiofsd/passthrough_ll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 4c35c95b25..9d7f863e66 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
>      int oldroot;
>      int newroot;
> =20
> -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
> +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
>          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", source, s=
ource);
>          exit(1);
>      }
> --=20
> 2.25.3
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


