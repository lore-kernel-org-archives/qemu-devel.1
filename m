Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BF7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF7F2166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y792sYJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF7F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ihy-0006rS-Gn
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 05:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j8ihG-0006Qw-CQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j8ihF-0003Sb-09
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:53:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j8ihE-0003SN-SL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583146392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTungxCJA5mw3iAhaP68NT0WzGbF847ZV9sohD68qhs=;
 b=Y792sYJ/hzwTS/Xfo2bezPXYK6WanMShqbajLyPbMZohpDiXy9gD6y+d8mXwSwEslzCtDy
 /QYY1s6yeb3Db1d2JCtmdToJZ5xy/2//4L7YeB0Er12AfMHPmIpcws/e4IbfzwzAqncnfF
 6pvlwb696dyISgFVmgpqcH2wq6J6koU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-9KRiwaaZP7eZWSy4BPFJBg-1; Mon, 02 Mar 2020 05:53:10 -0500
X-MC-Unique: 9KRiwaaZP7eZWSy4BPFJBg-1
Received: by mail-qv1-f71.google.com with SMTP id z39so8357520qve.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 02:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oiXakJUq85bGtTpNtxcz1EhuJ5nu6tcf/1k1Q+3y8T8=;
 b=JIoxBIQD6hDMSO48HUg6C2wPjh4lMi+kRWIQ8xIwg10g9xhOJH7wpMGfGWusK96013
 DLgw4nlNN8L9zyUHy0HiYSJe7WozhR0ft8LijU+F7ETBwZiEsgelRd8oe6vK7BXaAF+S
 Sz/kSpd5f4MhZX5yfCbZ6J/Xb833/I36AsyX0HNg17Dqbxe3W3bUdonJALFHDfeIJZ5s
 qn68kp+nbUgqyvK6otczsN4hHyqdTiAv3fdyPgdXD2oHPgPS0tNrOll4zLaL9y4eu+qb
 hb42N3bmZhDOG0Cn1/zkE1pIAEqNmfgN764SduG/9upN/UVG4mWeAy+MDHUtDhgJmSBp
 bIbg==
X-Gm-Message-State: APjAAAVsoRpd5DB5ai7Mj+8VaoCQQBu6+quGRR3gGJfOv+U/NaAOx6no
 ZKkHQBuDHX0KPKqYa7NewHAwdBABZI1H8S1Uh/DPoOZ0tHtnaAkqaxj1W7iaJd68MY5LCto+/nn
 bjmiq6z704Q2sxsQ=
X-Received: by 2002:ad4:53a8:: with SMTP id j8mr14602246qvv.149.1583146389974; 
 Mon, 02 Mar 2020 02:53:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqw39lzaXOelu69xuvhzJ5fsTV6cpACjqgZUiUO2wUdjVU+orVHKsYSte06q2m841ENOsGhm4w==
X-Received: by 2002:ad4:53a8:: with SMTP id j8mr14602226qvv.149.1583146389654; 
 Mon, 02 Mar 2020 02:53:09 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id b2sm9628413qkj.9.2020.03.02.02.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 02:53:08 -0800 (PST)
Date: Mon, 2 Mar 2020 05:53:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/2] tests/vhost-user-bridge: move to contrib/
Message-ID: <20200302055232-mutt-send-email-mst@kernel.org>
References: <20200207095412.794912-1-lvivier@redhat.com>
 <20200301071119-mutt-send-email-mst@kernel.org>
 <c68547be-3131-8069-70d9-f0a1758784d7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c68547be-3131-8069-70d9-f0a1758784d7@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 10:50:16AM +0100, Laurent Vivier wrote:
> On 01/03/2020 13:12, Michael S. Tsirkin wrote:
> > On Fri, Feb 07, 2020 at 10:54:11AM +0100, Laurent Vivier wrote:
> >> vhost-user-bridge is not a test. Move it to contrib/ and
> >> add it to the tools list.
> >>
> >> It will be built only if tools (--enable-tools) and
> >> vhost-user (--enable-vhost-user) are enabled (both are set
> >> by default).
> >>
> >> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >=20
> >=20
> > I had to drop this series from my tree since it cause failures
> > on OSX. Pls use something like travis CI to test when you repost
> > a fixed version. Thanks!
> >=20
>=20
> Do you have a link to the error logs?
>=20
> Thanks,
> Laurent


Peter sent me this:


Hi; this fails to build on OSX:

  CC      contrib/libvhost-user/libvhost-user.o
/Users/pm215/src/qemu-for-merges/contrib/libvhost-user/libvhost-user.c:27:1=
0:
fatal error: 'sys/eventfd.h' file not found
#include <sys/eventfd.h>
         ^~~~~~~~~~~~~~~
In file included from
/Users/pm215/src/qemu-for-merges/contrib/vhost-user-bridge/main.c:37:
/Users/pm215/src/qemu-for-merges/contrib/libvhost-user/libvhost-user.h:21:1=
0:
fatal error: 'linux/vhost.h' file not found
#include <linux/vhost.h>
         ^~~~~~~~~~~~~~~
1 error generated.

thanks
-- PMM

But pls do test on OSX before reposting.

--=20
MST


