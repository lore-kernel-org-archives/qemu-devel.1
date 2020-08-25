Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B53C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30F92075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTCJ1zBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30F92075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaOM-0002Mm-3R
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAaNT-0001Xj-WB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAaNS-0001Ty-Ad
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598367405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDicIlOJAxhcXPHgD28WdiSnWZsBmqzxIu/H/6pfn/M=;
 b=JTCJ1zBOD0N3sNRmsFwnIgjEXlKQ9g4d8sUbpWr+kykwaofNd+KfhoYkGdLEZKUDj9H8PN
 ey+oxjK2F/vr3O0mPnQp9B2KaJuy3ptcLxi8gthzpnsYes0VpO4qMw5CT+xuA7E27Qyu2p
 ttdo/6vFXBBsyFhQwX62BUUqam4WOZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-9yCBfdUdOTa2Q7-oUL402Q-1; Tue, 25 Aug 2020 10:56:43 -0400
X-MC-Unique: 9yCBfdUdOTa2Q7-oUL402Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55DF11DE00;
 Tue, 25 Aug 2020 14:56:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2478C6F802;
 Tue, 25 Aug 2020 14:56:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A5A6A112D737; Tue, 25 Aug 2020 16:56:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 2/6] util: refactor qemu_open_old to split off variadic
 args handling
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-3-berrange@redhat.com>
Date: Tue, 25 Aug 2020 16:56:40 +0200
In-Reply-To: <20200821172105.608752-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 21 Aug 2020 18:21:01
 +0100")
Message-ID: <874koqdb9z.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 06:38:59
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

> This simple refactoring prepares for future patches. The variadic args
> handling is split from the main bulk of the open logic. The duplicated
> calls to open() are removed in favour of updating the "flags" variable
> to have O_CLOEXEC.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/osdep.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/util/osdep.c b/util/osdep.c
> index 9df1b6adec..9ff92551e7 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
> =20
>  /* Needed early for CONFIG_BSD etc. */
> =20
> @@ -282,10 +283,10 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_=
t len, bool exclusive)
>  /*
>   * Opens a file with FD_CLOEXEC set
>   */
> -int qemu_open_old(const char *name, int flags, ...)
> +static int
> +qemu_open_internal(const char *name, int flags, mode_t mode)
>  {
>      int ret;
> -    int mode =3D 0;
> =20
>  #ifndef _WIN32
>      const char *fdset_id_str;
> @@ -323,22 +324,35 @@ int qemu_open_old(const char *name, int flags, ...)
>      }
>  #endif
> =20
> -    if (flags & O_CREAT) {
> -        va_list ap;
> -
> -        va_start(ap, flags);
> -        mode =3D va_arg(ap, int);
> -        va_end(ap);
> -    }
> -
>  #ifdef O_CLOEXEC
> -    ret =3D open(name, flags | O_CLOEXEC, mode);
> -#else
> +    flags |=3D O_CLOEXEC;
> +#endif /* O_CLOEXEC */
> +
>      ret =3D open(name, flags, mode);
> +
> +#ifndef O_CLOEXEC
>      if (ret >=3D 0) {
>          qemu_set_cloexec(ret);
>      }
> -#endif
> +#endif /* ! O_CLOEXEC */

I dislike this part, to be honest.  I find

    #ifdef O_CLOEXEC
        flags |=3D O_CLOEXEC;
    #endif /* O_CLOEXEC */

        ret =3D open(name, flags, mode);

    #ifndef O_CLOEXEC
        if (ret >=3D 0) {
            qemu_set_cloexec(ret);
        }
    #endif /* ! O_CLOEXEC */

harder to read than

    #ifdef O_CLOEXEC
        ret =3D open(name, flags | O_CLOEXEC, mode);
    #else
        ret =3D open(name, flags, mode);
        if (ret >=3D 0) {
            qemu_set_cloexec(ret);
        }
    #endif

> +
> +    return ret;
> +}
> +
> +
> +int qemu_open_old(const char *name, int flags, ...)
> +{
> +    va_list ap;
> +    mode_t mode =3D 0;
> +    int ret;
> +
> +    va_start(ap, flags);
> +    if (flags & O_CREAT) {
> +        mode =3D va_arg(ap, int);
> +    }
> +    va_end(ap);
> +
> +    ret =3D qemu_open_internal(name, flags, mode);
> =20
>  #ifdef O_DIRECT
>      if (ret =3D=3D -1 && errno =3D=3D EINVAL && (flags & O_DIRECT)) {


