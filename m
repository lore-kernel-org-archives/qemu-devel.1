Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC008C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFCD20720
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVLhPKDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFCD20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVNF-0002pY-VE
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsVM7-0000hM-Eb
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 13:56:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21410
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsVM5-0000E5-29
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 13:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594058195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/bAsQc43DcsDe3d2tdXZyZqU/80dcguX0Tp3skamcA=;
 b=XVLhPKDknOAaL6aZaFv4Bf4jPkRnOCMJEu/fbmWrgFB7875okyA1OSC+kHMnCjLoPu7VSZ
 Aps7y9h/NmUVYI93TIRSPKW/k9QQ8OB+hX+4B78Sn1eTNrZXqzo8tr+CWj8lYLmhr9Wvx8
 2CHCrOwsF10ccqOvCyLbQcPOZqC9v4s=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-TmuqysC9O128w1yXRj38lw-1; Mon, 06 Jul 2020 13:56:32 -0400
X-MC-Unique: TmuqysC9O128w1yXRj38lw-1
Received: by mail-oo1-f70.google.com with SMTP id a24so11350160oos.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 10:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=E/bAsQc43DcsDe3d2tdXZyZqU/80dcguX0Tp3skamcA=;
 b=DaTwkgGY+9+/NF4NRUFM+cNsZ8LgTWWfIEwoYZ2VMolYB27MJHfgbvgapHtqeq0+ti
 6YEt4YCTvK6kxdRo9S+0c7qgzdFd5AnAIQsW566ZJAz6EhJ0mJ2wVhf8EU2sMJSJc0aG
 EavEmk9kJUxwRzUhJ5aJJxQmmAS2IRaphL3eJ/pUG+5gcMQXa9JTrDzGuCpAfZDMgdmJ
 rKNK2BhdoYEWnK0snXDyyy6GHqP3gwmjroeoJKkRYCFOChJ+MM3/DAoXCBysMt1PKSXz
 HoUnEQljNsEOaukSIjGAQlGG70Sd14FRweB/a+g+llCDsURDFtFhDhNv0XqhT3Qfuqq3
 QRZg==
X-Gm-Message-State: AOAM530ygjBOvxaxpLTUypRgUL4CZEDHSy77cmZOYApUJhixiUMN0bPz
 kEQZxMtw9WiIbUbVmaRysv6myqNQJEV+NqDQzMRt/h+pDoIlJaJryD+lHJ7YtHb3xeY+bkcbIti
 sGsqYoLCr6sgq/F+MBn/s6hxS5uPYt6I=
X-Received: by 2002:aca:de56:: with SMTP id v83mr362832oig.118.1594058189186; 
 Mon, 06 Jul 2020 10:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgJt72i4ieH3enPxRBtvTljLxbKKBnZnn3XVyN7b/9vSBQNuIFp+EfN7vEzRMjJBCQF8Z2115+SJm8AnHtJiY=
X-Received: by 2002:aca:de56:: with SMTP id v83mr362814oig.118.1594058188941; 
 Mon, 06 Jul 2020 10:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200704092317.12943-1-peter.maydell@linaro.org>
 <c247fc94-f8f7-efe1-017f-fc1c03fee811@redhat.com>
 <5F00C6D6.8010001@mindspring.com>
 <239dfc36-404f-3439-3f1e-5d8750d31f5b@vivier.eu>
In-Reply-To: <239dfc36-404f-3439-3f1e-5d8750d31f5b@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 6 Jul 2020 19:56:16 +0200
Message-ID: <CAP+75-XTzoS7DWAt3QfuyXUw07ohrotKy71-KXGnFkxnxO0SuA@mail.gmail.com>
Subject: Re: [PATCH] net/tap-solaris.c: Include qemu-common.h for TFR macro
To: Laurent Vivier <laurent@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 6, 2020 at 7:30 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 04/07/2020 =C3=A0 20:13, Michele Denber a =C3=A9crit :
> > On 07/04/20 13:11, Thomas Huth wrote:
> >> On 04/07/2020 11.23, Peter Maydell wrote:
> >>> In commit a8d2532645cf5ce4 we cleaned up usage of the qemu-common.h h=
eader
> >>> so that it was always included from .c files and never from other .h =
files.
> >>> We missed adding it to net/tap-solaris.c (which previously was pullin=
g it
> >>> in via tap-int.h), which broke building on Solaris hosts.
> >>>
> >>> Fixes: a8d2532645cf5ce4
> >>> Reported-by: Michele Denber <denber@mindspring.com>
> >>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>> ---
> >>> Untested: Michele, could you give this a try?
> >>> ---
> >>>  net/tap-solaris.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> >>> index 4725d2314ee..d03165c57c9 100644
> >>> --- a/net/tap-solaris.c
> >>> +++ b/net/tap-solaris.c
> >>> @@ -27,6 +27,7 @@
> >>>  #include "tap_int.h"
> >>>  #include "qemu/ctype.h"
> >>>  #include "qemu/cutils.h"
> >>> +#include "qemu-common.h"
> >>>
> >>>  #include <sys/ethernet.h>
> >>>  #include <sys/sockio.h>
> >>>
> > I can confirm that this works in Solaris 11.4:
> >
> > root@hemlock:~/qemu-5.0.0# gpatch -p1 < tap-solaris.patch.diff
> > patching file net/tap-solaris.c
> > root@hemlock:~/qemu-5.0.0#
>
> Do you mean building on Solaris hosts works well now?

This only shows the patch applies properly, but ...

>
> In this case, you can add a "Tested-by:" tag.

Here after you have the confirmation the patch worked:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg720033.html
So IMO this is worth a:
Tested-by: Michele Denber <denber@mindspring.com>

>
> Thanks,
> Laurent
>
>


