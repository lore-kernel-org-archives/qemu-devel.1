Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B36DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450DC206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXqk9/aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450DC206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIwG-0006ka-H9
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtIqq-00044A-3A
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:47:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60987
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtIqo-0004YC-6Y
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594248457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gRS51GNeRZLLA2FQkzIg8MqmmQnHjzAGDOBl64s6HFU=;
 b=JXqk9/aqrE/PBO3tfgInhVF5ytGF4ue6dHXmVz5hFcVN3naQOWr+Lm7RlzrMrqJ6Ri/k93
 b03hnZmo4EeZwMQvSd5hDM+JUbhbkARLUktYsEguUG7taf/XTcl4WAJiwjXvOBBqptANZV
 NsbNeFSAUm/X7qoTLQRy14/5Fapf1uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-fWMd7FskMcCDua8gzJL4yQ-1; Wed, 08 Jul 2020 02:45:49 -0400
X-MC-Unique: fWMd7FskMcCDua8gzJL4yQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6B76A0BD7;
 Wed,  8 Jul 2020 06:45:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7332C1A914;
 Wed,  8 Jul 2020 06:45:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F05101132FD2; Wed,  8 Jul 2020 08:45:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/3] util: validate whether O_DIRECT is supported after
 failure
References: <20200702125612.2176194-1-berrange@redhat.com>
 <20200702125612.2176194-2-berrange@redhat.com>
Date: Wed, 08 Jul 2020 08:45:46 +0200
In-Reply-To: <20200702125612.2176194-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 2 Jul 2020 13:56:10
 +0100")
Message-ID: <878sfu4i91.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 P J P <ppandit@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Currently we suggest that a filesystem may not support O_DIRECT after
> seeing an EINVAL. Other things can cause EINVAL though, so it is better
> to do an explicit check, and then report a definitive error message.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/osdep.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/util/osdep.c b/util/osdep.c
> index 4829c07ff6..e2b7507ee2 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -332,9 +332,11 @@ int qemu_open(const char *name, int flags, ...)
>      }
> =20
>  #ifdef O_CLOEXEC
> -    ret =3D open(name, flags | O_CLOEXEC, mode);
> -#else
> +    flags |=3D O_CLOEXEC;
> +#endif
>      ret =3D open(name, flags, mode);
> +
> +#ifndef O_CLOEXEC
>      if (ret >=3D 0) {
>          qemu_set_cloexec(ret);
>      }

I'd prefer something like

   #ifdef O_CLOEXEC
       flags |=3D O_CLOEXEC;
       ret =3D open(name, flags, mode);
   #else
       ret =3D open(name, flags, mode);
       if (ret >=3D 0) {
           qemu_set_cloexec(ret);
       }
   #endif

Continues to duplicate open(), but spares me the effort to fuse two
#ifdef sections in my head to understand what is being done in each
case.

> @@ -342,8 +344,13 @@ int qemu_open(const char *name, int flags, ...)
> =20
>  #ifdef O_DIRECT
>      if (ret =3D=3D -1 && errno =3D=3D EINVAL && (flags & O_DIRECT)) {
> -        error_report("file system may not support O_DIRECT");
> -        errno =3D EINVAL; /* in case it was clobbered */
> +        int newflags =3D flags & ~O_DIRECT;
> +        ret =3D open(name, newflags, mode);

I'd prefer the more concise

           ret =3D open(name, flags & ~O_DIRECT, mode);

> +        if (ret !=3D -1) {
> +            close(ret);
> +            error_report("file system does not support O_DIRECT");
> +            errno =3D EINVAL;
> +        }
>      }
>  #endif /* O_DIRECT */

The function now reports to stderr in just one of many failure modes.
That's wrong.  Looks like the next patch fixes this defect.  I'd swap
the two.


