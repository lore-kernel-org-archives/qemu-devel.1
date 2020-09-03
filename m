Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CC5C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8989C2071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0TwXBck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8989C2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlAa-0007gS-IM
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDlA0-0007Bq-Bm
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDl9y-0005iu-8L
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599123837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATmG/ZnO8UZhC6g500ZpPUhbnbbscxE7oIK0dG9LtXE=;
 b=Z0TwXBckG5YBrOnVzZp+9ehFNnQVKiu0in2a9BhWxaIra3aDH4bDvCjd/GB6t0QNM7B6+3
 ZJog79wunV+tFxyHP8lOF0g48mSQZs5f6+kxc1dU6MGewZLjJkD8asL+DgzsSz+nB0bFcG
 s5NH0TuWQFVqjLGN6fZfVPFpiQTOEr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-oXgm2S9zOtSEiV-GHuwpww-1; Thu, 03 Sep 2020 05:03:55 -0400
X-MC-Unique: oXgm2S9zOtSEiV-GHuwpww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC41B1019627;
 Thu,  3 Sep 2020 09:03:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79EEF5C1C2;
 Thu,  3 Sep 2020 09:03:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCE2E113865F; Thu,  3 Sep 2020 11:03:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v5 5/8] util: add Error object for qemu_open_internal
 error reporting
References: <20200902170913.1785194-1-berrange@redhat.com>
 <20200902170913.1785194-6-berrange@redhat.com>
Date: Thu, 03 Sep 2020 11:03:52 +0200
In-Reply-To: <20200902170913.1785194-6-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 2 Sep 2020 18:09:10
 +0100")
Message-ID: <87363zs03r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
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

> Instead of relying on the limited information from errno, we can now
> also provide detailed error messages to callers that ask for it.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/osdep.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/util/osdep.c b/util/osdep.c
> index dd34b58bb7..28aa89adc9 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -298,7 +298,7 @@ static int qemu_open_cloexec(const char *name, int fl=
ags, mode_t mode)
>   * Opens a file with FD_CLOEXEC set
>   */
>  static int
> -qemu_open_internal(const char *name, int flags, mode_t mode)
> +qemu_open_internal(const char *name, int flags, mode_t mode, Error **err=
p)
>  {
>      int ret;
> =20
> @@ -312,12 +312,15 @@ qemu_open_internal(const char *name, int flags, mod=
e_t mode)
> =20
>          fdset_id =3D qemu_parse_fdset(fdset_id_str);
>          if (fdset_id =3D=3D -1) {
> +            error_setg(errp, "Could not parse fdset %s", name);
>              errno =3D EINVAL;
>              return -1;
>          }
> =20
>          dupfd =3D monitor_fdset_dup_fd_add(fdset_id, flags);
>          if (dupfd =3D=3D -1) {
> +            error_setg_errno(errp, errno, "Could not dup FD for %s flags=
 %x",
> +                             name, flags);

You kept the reporting of flags here.  Intentional?

>              return -1;
>          }
> =20
> @@ -327,6 +330,13 @@ qemu_open_internal(const char *name, int flags, mode=
_t mode)
> =20
>      ret =3D qemu_open_cloexec(name, flags, mode);
> =20
> +    if (ret =3D=3D -1) {
> +        const char *action =3D flags & O_CREAT ? "create" : "open";
> +        error_setg_errno(errp, errno, "Could not %s '%s'",
> +                         action, name);
> +    }
> +
> +
>      return ret;
>  }

Much neater.  Thanks!

> =20
> @@ -343,7 +353,7 @@ int qemu_open_old(const char *name, int flags, ...)
>      }
>      va_end(ap);
> =20
> -    ret =3D qemu_open_internal(name, flags, mode);
> +    ret =3D qemu_open_internal(name, flags, mode, NULL);
> =20
>  #ifdef O_DIRECT
>      if (ret =3D=3D -1 && errno =3D=3D EINVAL && (flags & O_DIRECT)) {

Reviewed-by: Markus Armbruster <armbru@redhat.com>


