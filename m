Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F711C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4A120674
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMlwpOiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4A120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaxO-00040Y-KO
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBawP-00034H-NH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBawO-0003oE-Gb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:12:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34362
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBawO-0003mJ-8B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583831563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6O4iT76gCiGRMyV/amB507yw/m6I8oU6cCXm0Yec2uw=;
 b=eMlwpOiTGi94B6yXzAAgkNqVXWICvMdfpTGNxOm7JCvSWzRaXcqwTed6Tk9KqRij7Ti3gi
 JQvRpmIlRaNeqrH9/hasMRgLMHOfxMFT23vqt2w3PNrk2tajlt/2QOUx1X0CtB0UUR6Awk
 +FA0M+J5vZ3NoBwc8x+d4HNxbFIMNHs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-OyWpa1ZTOAauqFQUrX3WNA-1; Tue, 10 Mar 2020 05:12:42 -0400
X-MC-Unique: OyWpa1ZTOAauqFQUrX3WNA-1
Received: by mail-qk1-f198.google.com with SMTP id x21so9231951qkn.18
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=LS12gnDHLw5ZupnQy4h59xDUY2WlTX3XnrxY1oWCUE0=;
 b=aAn5BejXJv2VGQPcrrb1BjXKmgHXUJ5Njar/xyYWNwPuXY7upbTZeBNH/d/imb2Y8g
 YpdFdV+KABjhBiMJWkSBeB3KVeu2oaWRKDkldEP5UWnZfkV83qSvSIBys9sB+o9k2MKN
 +2pYSF84AWy8yZKceQSmLHju1UlfC+OYpLibqHTlz0QW3gYVAiVXjWETSNJ2hvO6MUW1
 vcmb2sy0eo32Yv2QXbcOMlUXYwaoYNOleAkQe/IIdKVKfpeaFZhrDeRi9wopCVOe5Agc
 XBYp5zivSpMR2idSXVuBn6xMhUyQy4/PZiQvM5DLP8rrZQ3DbTheAI7cNTgO+N2kTVDt
 4Ipw==
X-Gm-Message-State: ANhLgQ1feRasUN9j45twZdOr+0y7VhcWTcBCUb98Wwv4VgJxz3AFRCqB
 Vk8a6O8dm/U9ZCMMQb8AJ92uIgNu4kTXy7m8/E88WyoWzAxROj895yX2z/J6CQ5TKsMplwCuEIg
 FyqzbZ4FaCDKHHMY=
X-Received: by 2002:ac8:4914:: with SMTP id e20mr17709467qtq.199.1583831561665; 
 Tue, 10 Mar 2020 02:12:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsvVkqmViuLWmDEjoV9sSJOVAPJhsmSUKzqJZUOb1mGQF+823HWjoPijSjZSsWKTZ5YJsOPzA==
X-Received: by 2002:ac8:4914:: with SMTP id e20mr17709452qtq.199.1583831561374; 
 Tue, 10 Mar 2020 02:12:41 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id v80sm23403576qka.15.2020.03.10.02.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:12:40 -0700 (PDT)
Date: Tue, 10 Mar 2020 05:12:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Liu, Jingqi" <jingqi.liu@intel.com>
Subject: Re: [PATCH] util: fix to get configuration macros in util/mmap-alloc.c
Message-ID: <20200310051003-mutt-send-email-mst@kernel.org>
References: <20200305154142.63070-1-jingqi.liu@intel.com>
 <20200305161047.GB3627464@lpt>
 <CAFEAcA-OQncMrU_-DJJ9g5rEcrJvbhTOjOVs0YqO3NS_Y413OQ@mail.gmail.com>
 <f774652b-5145-1e47-62c4-99a69a037506@intel.com>
 <CAFEAcA8HMSg8nS27YGPEQsPeGW2UicWRxeJDQf3oKbyHH2TY6Q@mail.gmail.com>
 <a57d479a-c9d5-0acc-b808-fe4e5a20ae80@intel.com>
MIME-Version: 1.0
In-Reply-To: <a57d479a-c9d5-0acc-b808-fe4e5a20ae80@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 04:58:38PM +0800, Liu, Jingqi wrote:
> On 3/9/2020 9:35 PM, Peter Maydell wrote:
> > On Mon, 9 Mar 2020 at 13:23, Liu, Jingqi <jingqi.liu@intel.com> wrote:
> > > On 3/6/2020 12:40 AM, Peter Maydell wrote:
> > > > On Thu, 5 Mar 2020 at 16:11, J=E1n Tomko <jtomko@redhat.com> wrote:
> > > > > On a Thursday in 2020, Jingqi Liu wrote:
> > > > > > The CONFIG_LINUX symbol is always not defined in this file.
> > > > > > This fixes that "config-host.h" header file is not included
> > > > > > for getting macros.
> > > > > >=20
> > > > > > Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> > > > > > ---
> > > > > > util/mmap-alloc.c | 2 ++
> > > > > > 1 file changed, 2 insertions(+)
> > > > > >=20
> > > > > > diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> > > > > > index 27dcccd8ec..24c0e380f3 100644
> > > > > > --- a/util/mmap-alloc.c
> > > > > > +++ b/util/mmap-alloc.c
> > > > > > @@ -10,6 +10,8 @@
> > > > > >    * later.  See the COPYING file in the top-level directory.
> > > > > >    */
> > > > > >=20
> > > > > > +#include "config-host.h"
> > > > > > +
> > > > > According to CODING_STYLE.rst, qemu/osdep.h is the header file
> > > > > that should be included first, before all the other includes.
> > > > >=20
> > > > > So the minimal fix would be moving qemu/osdep.h up here.
> > > > Yes, osdep must always be first.
> > > >=20
> > > > > > #ifdef CONFIG_LINUX
> > > > > > #include <linux/mman.h>
> > > > > > #else  /* !CONFIG_LINUX */
> > > > Do we really need this? osdep.h will pull in sys/mman.h
> > > > for you, which should define the MAP_* constants.
> > > >=20
> > > > Also, you have no fallbmack for "I'm on Linux but the
> > > > system headers don't define MAP_SHARED_VALIDATE or
> > > > MAP_SYNC". Wouldn't it be better to just have
> > > > #ifndef MAP_SYNC
> > > > #define MAP_SYNC 0
> > > > #endif
> > > >=20
> > > > etc ?
> > > osdep.h pulls in sys/mman.h, which defines the MAP_* constants
> > >=20
> > > except for MAP_SYNC and MAP_SHARED_VALIDATE on Linux.
> > Why not? Is this just "not yet in the version of glibc
> > we're using", or is it a bug/missed feature in glibc
> > that needs to be addressed there ?
>=20
> I'm using the version 2.27 of glibc.
>=20
> I downloaded the version 2.28 of glibc source for compilation and
> installation.
>=20
> I found MAP_SYNC and MAP_SHARED_VALIDATE are defined in this version.
>=20
> Seems it's older glibc version issue.
>=20
> >=20
> > > How about just adding the following code in util/mmap-alloc.c ?
> > > #ifndef MAP_SYNC
> > > #define MAP_SYNC 0x80000
> > > #endif
> > >=20
> > > #ifndef MAP_SHARED_VALIDATE
> > > #define MAP_SHARED_VALIDATE 0x03
> > > #endif
> > You don't want to do that for non-Linux systems, so there
> > you need to fall back to defining them to be 0.
> >=20
> > Are there any systems (distros) where the standard system
> > sys/mman.h does not define these new MAP_* constants but we
> > still really really need to use them? If not, then we
> > could just have the fallback-to-0 fallback everywhere.
>=20
> Good point.
>=20
> So as you mentioned, it would be better to just have the following code:
>=20
> #ifndef MAP_SYNC
> #define MAP_SYNC 0
> #endif
>=20
> #ifndef MAP_SHARED_VALIDATE
> #define MAP_SHARED_VALIDATE 0
> #endif

Won't this defeat the purpose of MAP_SHARED_VALIDATE?

We really have linux-headers/linux/mman.h for exactly this purpose.

> Thanks,
>=20
> Jingqi
>=20
> >=20
> > thanks
> > -- PMM


