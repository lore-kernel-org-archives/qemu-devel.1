Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA40BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6648E20786
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q93Za6B0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6648E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAako-0000qr-MN
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAajy-0008IK-Bj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAajw-0005WT-Mf
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598368800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=se9sO8jreycLljbjBwbC7pWldI4+TZFGLNc6Y00EnPw=;
 b=Q93Za6B0zFO/a4qjrOrsE/GjwIK6hpLR7aT3Z6j9mEFtmpcoi7e3rOO9KLFugcwm5RkBpw
 +y8o7SY0TR2odP8ZgeAEBit0DO5B6cuwrRbvlcTZf/fn3ao34832W/GDTDHbVNyskZIsa8
 kk4qLQFVM+/lvPK8aNGYxePNTca12z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-f6OcYccqMiSp2ShVVdJYxQ-1; Tue, 25 Aug 2020 11:19:56 -0400
X-MC-Unique: f6OcYccqMiSp2ShVVdJYxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D45A10ABDCE;
 Tue, 25 Aug 2020 15:19:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E05485D9CA;
 Tue, 25 Aug 2020 15:19:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 936E3112D737; Tue, 25 Aug 2020 17:19:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 5/6] util: give a specific error message when O_DIRECT
 doesn't work
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-6-berrange@redhat.com>
Date: Tue, 25 Aug 2020 17:19:53 +0200
In-Reply-To: <20200821172105.608752-6-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 21 Aug 2020 18:21:04
 +0100")
Message-ID: <87o8mybvmu.fsf@dusky.pond.sub.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> A common error scenario is to tell QEMU to use O_DIRECT in combination
> with a filesystem that doesn't support it. To aid users to diagnosing
> their mistake we want to provide a clear error message when this happens.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/osdep.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/util/osdep.c b/util/osdep.c
> index a4956fbf6b..6c24985f7a 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -345,6 +345,19 @@ qemu_open_internal(const char *name, int flags, mode=
_t mode, Error **errp)
> =20
>      if (ret =3D=3D -1) {
>          const char *action =3D flags & O_CREAT ? "create" : "open";
> +#ifdef O_DIRECT
> +        if (errno =3D=3D EINVAL && (flags & O_DIRECT)) {
> +            ret =3D open(name, flags & ~O_DIRECT, mode);
> +            if (ret !=3D -1) {
> +                close(ret);
> +                error_setg(errp, "Could not %s '%s' flags 0x%x: "
> +                           "filesystem does not support O_DIRECT",
> +                           action, name, flags);
> +                errno =3D EINVAL; /* close() clobbered earlier errno */

More precise: close() may have clobbered

Sure open() can only fail with EINVAL here?

> +                return -1;
> +            }
> +        }
> +#endif /* O_DIRECT */
>          error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
>                           action, name, flags);
>      }

There is no qemu_set_cloexec().  Intentional?


