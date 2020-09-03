Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38827C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB13720709
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qlw6XXSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB13720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDl7X-0006PQ-3p
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDl6o-0005uL-Gk
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDl6n-0005Kb-1N
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599123639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDEanCI89e1SVJ3ymXhxqqr/IH1Yigambllh9KeN7Wo=;
 b=Qlw6XXSa5AQ0lpNZm5m9Tof+wuMBJCebStbMdFXD5JaNSArbrMgZnlEcwIMvjlucy00w3T
 FGUjwEhMZHeuzTiVPyAJh0p9BHwu5bdVc3nYSEK4PS156Db3jdBqRbMFnbLeOIFVlDEpPt
 9tBzJxTsFWqncSHaX4BU7l5olIxl+mM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-nECCmwChPfmmL5ePURsJ_A-1; Thu, 03 Sep 2020 05:00:36 -0400
X-MC-Unique: nECCmwChPfmmL5ePURsJ_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2EE71DDE2;
 Thu,  3 Sep 2020 09:00:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A830910023A7;
 Thu,  3 Sep 2020 09:00:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 25295113865F; Thu,  3 Sep 2020 11:00:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v5 4/8] util: refactor qemu_open_old to split off
 variadic args handling
References: <20200902170913.1785194-1-berrange@redhat.com>
 <20200902170913.1785194-5-berrange@redhat.com>
Date: Thu, 03 Sep 2020 11:00:33 +0200
In-Reply-To: <20200902170913.1785194-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 2 Sep 2020 18:09:09
 +0100")
Message-ID: <878sdrs09a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This simple refactoring prepares for future patches. The variadic args
> handling is split from the main bulk of the open logic. The duplicated
> calls to open() are removed in favour of updating the "flags" variable
> to have O_CLOEXEC.

Drop the second sentence, it is no longer true in this revision.

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/osdep.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/util/osdep.c b/util/osdep.c
> index 7504c156e8..dd34b58bb7 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"

This patch doesn't use anything from qapi/error.h as far as I can tell.
Does the hunk belong to another patch?

> =20
>  /* Needed early for CONFIG_BSD etc. */
> =20
> @@ -296,10 +297,10 @@ static int qemu_open_cloexec(const char *name, int =
flags, mode_t mode)
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
> @@ -324,15 +325,25 @@ int qemu_open_old(const char *name, int flags, ...)
>      }
>  #endif
> =20
> -    if (flags & O_CREAT) {
> -        va_list ap;
> +    ret =3D qemu_open_cloexec(name, flags, mode);
> +
> +    return ret;
> +}
> +
> =20
> -        va_start(ap, flags);
> +int qemu_open_old(const char *name, int flags, ...)
> +{
> +    va_list ap;
> +    mode_t mode =3D 0;
> +    int ret;
> +
> +    va_start(ap, flags);
> +    if (flags & O_CREAT) {
>          mode =3D va_arg(ap, int);
> -        va_end(ap);
>      }
> +    va_end(ap);
> =20
> -    ret =3D qemu_open_cloexec(name, flags, mode);
> +    ret =3D qemu_open_internal(name, flags, mode);
> =20
>  #ifdef O_DIRECT
>      if (ret =3D=3D -1 && errno =3D=3D EINVAL && (flags & O_DIRECT)) {

With the minor inaccuracies tidied up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


