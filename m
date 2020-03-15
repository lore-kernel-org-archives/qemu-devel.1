Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB9C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929AA2051A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF3szn++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929AA2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDaxc-0000Zw-Hx
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 17:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDac5-0000dN-LS
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDac3-00026d-42
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:16:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56227
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDac2-0001yg-R0
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584306957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUE8BS0Dbl/DM0vl4aMKKbqcb3TBNkvGujss/2g2swY=;
 b=EF3szn++uz8e2h+J4LqWrJdpQpDbQZKhLhOJ99Mt4QdcHpW+pa8gyaa5oFl0P07+1loEec
 mW5Koio6YBUO0Ce+Ak4wBB2UOE2pwjOgBBbSCX0UrsE6sHldHx6wNih7+WE29CYT9DkQFx
 +jATbCtBtPWI9seIHoeRbHf4QWjtbJ8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-xz21AksEP5OkXPbTfbm9Tw-1; Sun, 15 Mar 2020 17:15:53 -0400
X-MC-Unique: xz21AksEP5OkXPbTfbm9Tw-1
Received: by mail-qv1-f72.google.com with SMTP id o102so3594654qvo.14
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 14:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FNo3TnA/ZxhfhCjSiw914wzVo0FiX0AIpTzHMDZsIUQ=;
 b=oCs+kju27Iavowl8dg2I+AswwArm5DnLeFelpfi/ikRxYAnGtM95Bs60O9Qo6f+x61
 CFw7ju/yQnNlI6HZFJjES6H0o1ifZrvZ9LJkEXVSAQnXZg2VQ1yt6TG29Tr+CsmrtyAb
 jacTixUpx5cjPyzq+D/TPXPqCUYMTC5MqqsUnP2Wp5dRRgoSDwP3ZNSN86cSdBT67K9h
 tQWTTYxu87Wc0eGsNr3SBXJBXVkIEQwdCWqFKjAA8YI6wG/7ctCJAdyCWLgKG5ERdsvz
 9tyyY1q+Eh/QIZMMadWvUYVTM0MNvySiCLq/GGVcrnE+EEjgMt6t2yH3AWWh80f15Nv2
 39Bg==
X-Gm-Message-State: ANhLgQ2EzPKNahJUb9cRi8rHxFW0DwYkNmcGbSA2gdJZK52GbpgDijL4
 5bAJbuKdpE/lwFZE/yX/q4fmIhd4JNr89ujxQko2LD2MFlhW0V6CAiKWRb4l1D+OeyF1Ux2Xz0J
 lqzRAtSIlweqq6zM=
X-Received: by 2002:a37:5b81:: with SMTP id
 p123mr20948717qkb.284.1584306952958; 
 Sun, 15 Mar 2020 14:15:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvY0OSAo0tpx6m4Ow0UCjeOXgTV0JUAnwWCpVjVMV4NB07gJWxwGLw3CCa5DQVmC+jVIf6J5w==
X-Received: by 2002:a37:5b81:: with SMTP id
 p123mr20948698qkb.284.1584306952654; 
 Sun, 15 Mar 2020 14:15:52 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 u40sm3131808qtc.62.2020.03.15.14.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 14:15:51 -0700 (PDT)
Date: Sun, 15 Mar 2020 17:15:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 2/2] mmap-alloc: Include osdep.h before checking
 CONFIG_LINUX
Message-ID: <20200315170229-mutt-send-email-mst@kernel.org>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-3-ehabkost@redhat.com>
 <20200315154559.GW1187748@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200315154559.GW1187748@habkost.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: peter.maydell@linaro.org, jingqi.liu@intel.com, jtomko@redhat.com,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 15, 2020 at 11:45:59AM -0400, Eduardo Habkost wrote:
> On Wed, Mar 11, 2020 at 07:23:42PM -0400, Eduardo Habkost wrote:
> > The CONFIG_LINUX check at the top of mmap-alloc.c never worked
> > because it was done before including osdep.h.
> >=20
> > This means MAP_SYNC and MAP_SHARED_VALIDATE would always be set
> > to 0 at the beginning of the file.  Luckily, this didn't break
> > when using recent glibc versions (2.28+), because those macros
> > were redefined by glibc headers.
> >=20
> > Move the CONFIG_LINUX check after the main include lines, so the
> > CONFIG_LINUX check works and we actually include <linux/mman.h>.
> > This will make MAP_SYNC and MAP_SHARED_VALIDATE available even if
> > the host has an older glibc version.

Wait a second, MAP_SHARED_VALIDATE is from
linux-headers/linux/mman.h - it's available on all architectures.

> >=20
> > Reported-by: Jingqi Liu <jingqi.liu@intel.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * (none)
> > ---
> >  util/mmap-alloc.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> > index 27dcccd8ec..7c2ce98eb0 100644
> > --- a/util/mmap-alloc.c
> > +++ b/util/mmap-alloc.c
> > @@ -9,6 +9,9 @@
> >   * This work is licensed under the terms of the GNU GPL, version 2 or
> >   * later.  See the COPYING file in the top-level directory.
> >   */
> > +#include "qemu/osdep.h"
> > +#include "qemu/mmap-alloc.h"
> > +#include "qemu/host-utils.h"
> > =20
> >  #ifdef CONFIG_LINUX
> >  #include <linux/mman.h>
>=20
> This breaks the build on mips, because mips doesn't have MAP_SYNC
> defined at linux/mman.h:
>=20
> https://app.shippable.com/github/ehabkost/qemu-hacks/runs/9/9/console


Oops. But that in fact means it's currently building on mips but not
working correctly there! MAP_SHARED_VALIDATE 0x0 is especially
problematic. I'm unsure what's the right thing to do is,
I guess as a first step we can go back and device MAP_SYNC to 0,






>=20
> > @@ -17,10 +20,6 @@
> >  #define MAP_SHARED_VALIDATE   0x0
> >  #endif /* CONFIG_LINUX */
> > =20
> > -#include "qemu/osdep.h"
> > -#include "qemu/mmap-alloc.h"
> > -#include "qemu/host-utils.h"
> > -
> >  #define HUGETLBFS_MAGIC       0x958458f6
> > =20
> >  #ifdef CONFIG_LINUX
> > --=20
> > 2.24.1
> >=20
>=20
> --=20
> Eduardo


