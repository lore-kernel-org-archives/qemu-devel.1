Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A37CC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E383820768
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF6E9f1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E383820768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLsmo-0008OS-VV
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 14:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLsm0-0007wN-56
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLslv-0003R4-Bm
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:16:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47535
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLslv-0003Qi-3o
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586283386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMapuAZmDhzAhlmvM7BXhFh1UeKga5JGU6s0flbQba8=;
 b=EF6E9f1+SUBLafYcs7EsxcZoeTwUr1dUatsFpNZZpb4hjhzcJ16hjVzYykxW/lIPcSXeoa
 91rLiwcK++lx339z1urbP6q7XBvLHQlELpwKs/Vwxyf2OD4I52DFnFu+jRRYQ46T0U3GJL
 z9t/GF3ArywNlUw5ktxSRPs38uL5YAU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-KdKpfLOfPkabkgR75sZ-KQ-1; Tue, 07 Apr 2020 14:16:22 -0400
X-MC-Unique: KdKpfLOfPkabkgR75sZ-KQ-1
Received: by mail-wr1-f71.google.com with SMTP id j12so2403840wrr.18
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 11:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LMapuAZmDhzAhlmvM7BXhFh1UeKga5JGU6s0flbQba8=;
 b=sqTuSUvGXm0H+YprzHqrL22CQ7QlND90ICAVySYdw904wOsnFjkP9AOeNrmQ3Iub2s
 lejgaAtHLx4FCcVRr9MKBRVQxsv5uT9j6AQenWdxHEMFf644ykhwXj6VmdUPUzfXH1Tj
 Kk69ovjOy+69eICxdHNZYPVtQCNDS9Z8xgBnVaPkDdcXv0HJ1bjLDJUlwFm9j2u2TprU
 HpdCxza25IxkdKI1DKbJUqW+BvecBZuK+qR6NAwNMVlXdZ8cGSh4rIKMj8v1xaER7Uk+
 Yi5ijoBpNifcX6CeW22HbBC39wYmrUH4zRs2BUYjLA8O0dRO9Tt1fIr2qA/L5arvBEe+
 33vg==
X-Gm-Message-State: AGi0PubcgnI4Ku1EsHqDEXIP9fsj9sWDHfqeJJYUl9O4sR64iaFRlrzE
 HiKMFVPHc+sWzq0fnPQHBgXGTvJk4ppzQqZPvX2/Gpsxe/i02Th0lnYZPflWufVUCCYSKeLskTz
 yk56jMhk5/53KHef+h9ezw5U8+bQNBkE=
X-Received: by 2002:adf:e991:: with SMTP id h17mr3896964wrm.17.1586283381284; 
 Tue, 07 Apr 2020 11:16:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXpQr0dsGsFaEOcXYjKehzMfiNAvNOTPB4BKfTqX9Scg1VYm2JBGPnj9euNB0G0LeM/YHcKlAyEw6mOcx7GZA=
X-Received: by 2002:adf:e991:: with SMTP id h17mr3896933wrm.17.1586283380971; 
 Tue, 07 Apr 2020 11:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-49-f4bug@amsat.org>
 <04663728-06f3-85bf-74b7-45184f90aa0a@virtuozzo.com>
 <ac7213fd-3ea2-e80c-7308-5f2de02c341c@redhat.com>
 <ae9ced39-f039-ffb5-b33b-df93b0f35e36@virtuozzo.com>
 <ffd970c9-c8f3-b6c4-3592-cbace296f986@redhat.com>
 <50d08d50-3ce2-2ee1-7529-5cfbfbcc5331@redhat.com>
 <044eece3-542a-8e99-c865-e77368478fb1@virtuozzo.com>
In-Reply-To: <044eece3-542a-8e99-c865-e77368478fb1@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 7 Apr 2020 20:16:09 +0200
Message-ID: <CAP+75-Vbu1ywKRpaqcmZPS3vaSm1=2Vp1bqMcGPqH_6gXd_=tg@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v2 48/54] scripts/coccinelle: Use &error_abort in
 TypeInfo::instance_init()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 7, 2020 at 7:55 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> 07.04.2020 20:27, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 4/7/20 3:07 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 4/7/20 3:01 PM, Vladimir Sementsov-Ogievskiy wrote:
> >>> 07.04.2020 14:03, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>> On 4/7/20 9:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> >>>>> 06.04.2020 20:47, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>>> The instance_init() calls are not suppose to fail. Add a
> >>>>>> Coccinelle script to use &error_abort instead of ignoring
> >>>>>> errors by using a NULL Error*.
> >>>>>>
> >>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>>>> ---
> >>>>>>   .../use-error_abort-in-instance_init.cocci    | 52 +++++++++++++=
++++++
> >>>>>>   MAINTAINERS                                   |  1 +
> >>>>>>   2 files changed, 53 insertions(+)
> >>>>>>   create mode 100644 scripts/coccinelle/use-error_abort-in-instanc=
e_init.cocci
> >>>>>>
> >>>>>> diff --git a/scripts/coccinelle/use-error_abort-in-instance_init.c=
occi b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
> >>>>>> new file mode 100644
> >>>>>> index 0000000000..8302d74a0c
> >>>>>> --- /dev/null
> >>>>>> +++ b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
> >>>>>> @@ -0,0 +1,52 @@
> >>>>>> +// Use &error_abort in TypeInfo::instance_init()
> >>>>>> +//
> >>>>>> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
> >>>>>> +// This work is licensed under the terms of the GNU GPLv2 or late=
r.
> >>>>>> +//
> >>>>>> +// spatch \
> >>>>>> +//  --macro-file scripts/cocci-macro-file.h --include-headers \
> >>>>>> +//  --sp-file scripts/coccinelle/use-error_abort-in-instance_init=
.cocci \
> >>>>>> +//  --keep-comments --in-place
> >>>>>> +//
> >>>>>> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org=
/msg692500.html
> >>>>>> +// and https://www.mail-archive.com/qemu-devel@nongnu.org/msg6936=
37.html
> >>>>>> +
> >>>>>> +
> >>>>>> +@ has_qapi_error @
> >>>>>> +@@
> >>>>>> +    #include "qapi/error.h"
> >>>>>> +
> >>>>>> +
> >>>>>> +@ match_instance_init @
> >>>>>> +TypeInfo info;
> >>>>>> +identifier instance_initfn;
> >>>>>> +@@
> >>>>>> +    info.instance_init =3D instance_initfn;
> >>>>>> +
> >>>>>> +
> >>>>>> +@ use_error_abort @
> >>>>>> +identifier match_instance_init.instance_initfn;
> >>>>>> +identifier func_with_error;
> >>>>>> +expression parentobj, propname, childobj, size, type, errp;
> >>>>>> +position pos;
> >>>>>> +@@
> >>>>>> +void instance_initfn(...)
> >>>>>> +{
> >>>>>> +   <+...
> >>>>>> +(
> >>>>>> +   object_initialize_child(parentobj, propname,
> >>>>>> +                           childobj, size, type,
> >>>>>> +                           errp, NULL);
> >>>
> >>> I think, it doesn't actually differs from just object_initialize_chil=
d(..., NULL); and you don't need all these metavaraibles
> >>>
> >>>>>> +|
> >>>>>> +   func_with_error@pos(...,
> >>>>>> +-                           NULL);
> >>>>>> ++                           &error_abort);
> >>>>>> +)
> >>>>>
> >>>>>
> >>>>> Hmm. I don't follow, what are you trying to achieve by this ( | ) c=
onstruction? The second pattern (func_with_error...) will be matched anyway=
, with or without first pattern (object_initialize_child...) matched. And f=
irst pattern does nothing.
> >>>>
> >>>> Expected behavior :)
> >>>>
> >>>> If object_initialize_child() matched:
> >>>>    do nothing.
> >>>> Else:
> >>>>    transform.
> >>>
> >>> Ah, understand, thanks. Checked, it works.
> >>>
> >>> Possibly simpler way is just define func_with_errno identifier like t=
his:
> >>>
> >>> identifier func_with_error !=3D object_initialize_child;
> >
> > Thanks for the tip Vladimir, I simplified as:
> >
> > @ use_error_abort @
> > identifier match_instance_init.instance_initfn;
> > identifier func_with_error !=3D {qbus_create_inplace, object_initialize=
_child};
>
> New syntax for me, great)
>
> > position pos;
> > @@
> > void instance_initfn(...)
> > {
> >     <+...
> >     func_with_error@pos(...,
> > -                           NULL);
> > +                           &error_abort);
> >     ...+>
> > }
> >
> > BTW do you know how to automatically add an include ("qapi/error.h" bel=
ow)?
>
> No, I don't.
>
> I can guess something like this
>
> @ already_has_include @
> @@
>
> #include <qapi/error.h>
>
> @ depends on !already_has_include && use_error_abort @
>
>   #include ...
> +#include <qapi/error.h>

OMG this works!

@ depends on !has_qapi_error && use_error_abort @
@@
    #include ...
+   #include "qapi/error.h"

Produces:

diff -u -p a/e1000.c b/e1000.c
--- a/e1000.c
+++ b/e1000.c
@@ -39,6 +39,7 @@

 #include "e1000x_common.h"
 #include "trace.h"
+#include "qapi/error.h"

 static const uint8_t bcast[] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};

@@ -1774,7 +1775,7 @@ static void e1000_instance_init(Object *
     E1000State *n =3D E1000(obj);
     device_add_bootindex_property(obj, &n->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(n), NULL);
+                                  DEVICE(n), &error_abort);
 }


>
> =3D=3D=3D
>
> or maybe in one rule:
>
> @@
> ... when !=3D error.h
>   #include ...
> +#include <qapi/error.h>
> ... when !=3D error.h
>
>
> (possibly last line is not needed)..
>
> what spec says about includes:
>
> An #include may be followed by "...", <...> or simply .... With either qu=
otes or angle brackets, it is possible to put a partial path, ending with .=
.., such as <include/...>, or to put a complete path. A #include with ... m=
atches any include, with either quotes or angle brackets. Partial paths or =
complete are not allowed in the latter case. Something that is added before=
 an include will be put before the last matching include that is not under =
an ifdef in the file. Likewise, something that is added after an include wi=
ll be put after the last matching include that is not under an ifdef in the=
 file.
>
> >
> >>>
> >>>>
> >>>>>
> >>>>>
> >>>>>> +   ...+>
> >>>>>> +}
> >>>>>> +
> >>>>>> +
> >>>>>> +@script:python depends on use_error_abort && !has_qapi_error@
> >>>>>> +p << use_error_abort.pos;
> >>>>>> +@@
> >>>>>> +print('[[manual edit required, %s misses #include "qapi/error.h"]=
]' % p[0].file)
> >>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>>>> index 14de2a31dc..ae71a0a4b0 100644
> >>>>>> --- a/MAINTAINERS
> >>>>>> +++ b/MAINTAINERS
> >>>>>> @@ -2059,6 +2059,7 @@ F: scripts/coccinelle/error-use-after-free.c=
occi
> >>>>>>   F: scripts/coccinelle/error_propagate_null.cocci
> >>>>>>   F: scripts/coccinelle/remove_local_err.cocci
> >>>>>>   F: scripts/coccinelle/simplify-init-realize-error_propagate.cocc=
i
> >>>>>> +F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
> >>>>>>   F: scripts/coccinelle/use-error_fatal.cocci
> >>>>>>   F: scripts/coccinelle/use-error_propagate-in-realize.cocci
> >>>>>>
> >>>>>
> >>>>>
> >>>>
> >>>
> >>>
> >
>
>
> --
> Best regards,
> Vladimir
>


