Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7792AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AB52075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3r68on+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AB52075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAah0-0005zN-JX
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAagO-0005Pq-VA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAagN-0005Bl-77
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598368578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGfaGwuEN6eA/p+u8BTRkMtrIgtiCoI4munND+5yroA=;
 b=b3r68on+ejgH75fegi/KTVpSKMNJ7Q9Ee2nm1NSjAcC3UdPs5pzIbB1pTpJDONpLFU14jw
 7fLEUWfNFHZ5LkikN3Jb4JOv0IE9Z0PygkrT0J8K/2CwyIOCth1bzxbkeiRrJ+dlRxcLDF
 H9ZI+FTViWcstGOilPpKGaY4voYGRHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-5WUdl1jeMhC9RmdvHBWuWQ-1; Tue, 25 Aug 2020 11:16:16 -0400
X-MC-Unique: 5WUdl1jeMhC9RmdvHBWuWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56B168799F0;
 Tue, 25 Aug 2020 15:16:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DECF5D9CA;
 Tue, 25 Aug 2020 15:16:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 959B4112D737; Tue, 25 Aug 2020 17:16:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 4/6] util: introduce qemu_open and qemu_create with
 error reporting
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-5-berrange@redhat.com>
Date: Tue, 25 Aug 2020 17:16:12 +0200
In-Reply-To: <20200821172105.608752-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 21 Aug 2020 18:21:03
 +0100")
Message-ID: <87sgcabvsz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> qemu_open_old() works like open(): set errno and return -1 on failure.
> It has even more failure modes, though.  Reporting the error clearly
> to users is basically impossible for many of them.
>
> Our standard cure for "errno is too coarse" is the Error object.
> Introduce two new helper methods:
>
>   int qemu_open(const char *name, int flags, Error **errp);
>   int qemu_create(const char *name, int flags, mode_t mode, Error **errp)=
;
>
> Note that with this design we no longer require or even accept the
> O_CREAT flag. Avoiding overloading the two distinct operations
> means we can avoid variable arguments which would prevent 'errp' from
> being the last argument. It also gives us a guarantee that the 'mode' is
> given when creating files, avoiding a latent security bug.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qemu/osdep.h |  6 ++++++
>  util/osdep.c         | 21 +++++++++++++++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 18333e9006..13a821845b 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -497,7 +497,13 @@ int qemu_madvise(void *addr, size_t len, int advice)=
;
>  int qemu_mprotect_rwx(void *addr, size_t size);
>  int qemu_mprotect_none(void *addr, size_t size);
> =20
> +/*
> + * Don't introduce new usage of this function, prefer the following
> + * qemu_open/qemu_create that take an "Error **errp"
> + */
>  int qemu_open_old(const char *name, int flags, ...);
> +int qemu_open(const char *name, int flags, Error **errp);
> +int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
>  int qemu_close(int fd);
>  int qemu_unlink(const char *name);
>  #ifndef _WIN32
> diff --git a/util/osdep.c b/util/osdep.c
> index 9c7118d3cb..a4956fbf6b 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -344,10 +344,7 @@ qemu_open_internal(const char *name, int flags, mode=
_t mode, Error **errp)
>  #endif /* ! O_CLOEXEC */
> =20
>      if (ret =3D=3D -1) {
> -        const char *action =3D "open";
> -        if (flags & O_CREAT) {
> -            action =3D "create";
> -        }
> +        const char *action =3D flags & O_CREAT ? "create" : "open";
>          error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
>                           action, name, flags);
>      }

Squash this hunk into PATCH 3, please.

> @@ -357,6 +354,22 @@ qemu_open_internal(const char *name, int flags, mode=
_t mode, Error **errp)
>  }
> =20
> =20
> +int qemu_open(const char *name, int flags, Error **errp)
> +{
> +    assert(!(flags & O_CREAT));
> +
> +    return qemu_open_internal(name, flags, 0, errp);
> +}
> +
> +
> +int qemu_create(const char *name, int flags, mode_t mode, Error **errp)
> +{
> +    assert(!(flags & O_CREAT));
> +
> +    return qemu_open_internal(name, flags | O_CREAT, mode, errp);
> +}
> +
> +
>  int qemu_open_old(const char *name, int flags, ...)
>  {
>      va_list ap;

Other than that:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


