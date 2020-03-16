Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3F7C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5073B206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlxnUf84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5073B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuuK-00022u-E9
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jDttv-0004Tq-2C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jDttt-0000ht-H8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:51:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jDttt-0000cz-BG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584381100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWBhD9BUHMhVZEDre29Jb6URjO2zAYEx3Tp6SxXzKCM=;
 b=DlxnUf84dCSkBQozaNHbBftX8W/I2tURb0IcXOcLnJMrtHZujeXVRVAwJc+lBAb6klIg0l
 yfm02T272e9KHnIQCE2SmyH0o6n5EjwAiOaQK+4i+uPz5GU5aOMXjEnB29Qu/uNuUeENMl
 F1wdygcEp047cg0K7tvmnsY7VwfGnCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-4rPVl1pFOKyiqs8IJxMZaQ-1; Mon, 16 Mar 2020 13:51:33 -0400
X-MC-Unique: 4rPVl1pFOKyiqs8IJxMZaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6151A8DEA1B;
 Mon, 16 Mar 2020 17:30:43 +0000 (UTC)
Received: from localhost (ovpn-119-85.phx2.redhat.com [10.3.119.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA6325C1B2;
 Mon, 16 Mar 2020 17:30:40 +0000 (UTC)
Date: Mon, 16 Mar 2020 13:30:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] mmap-alloc: Include osdep.h before checking
 CONFIG_LINUX
Message-ID: <20200316173039.GB1817047@habkost.net>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-3-ehabkost@redhat.com>
 <20200315154559.GW1187748@habkost.net>
 <20200315170229-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200315170229-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On Sun, Mar 15, 2020 at 05:15:46PM -0400, Michael S. Tsirkin wrote:
> On Sun, Mar 15, 2020 at 11:45:59AM -0400, Eduardo Habkost wrote:
> > On Wed, Mar 11, 2020 at 07:23:42PM -0400, Eduardo Habkost wrote:
> > > The CONFIG_LINUX check at the top of mmap-alloc.c never worked
> > > because it was done before including osdep.h.
> > >=20
> > > This means MAP_SYNC and MAP_SHARED_VALIDATE would always be set
> > > to 0 at the beginning of the file.  Luckily, this didn't break
> > > when using recent glibc versions (2.28+), because those macros
> > > were redefined by glibc headers.
> > >=20
> > > Move the CONFIG_LINUX check after the main include lines, so the
> > > CONFIG_LINUX check works and we actually include <linux/mman.h>.
> > > This will make MAP_SYNC and MAP_SHARED_VALIDATE available even if
> > > the host has an older glibc version.
>=20
> Wait a second, MAP_SHARED_VALIDATE is from
> linux-headers/linux/mman.h - it's available on all architectures.

Yes, but both MAP_SYNC and MAP_SHARED_VALIDATE aren't available
if the host is not Linux.

>=20
> > >=20
> > > Reported-by: Jingqi Liu <jingqi.liu@intel.com>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > > Changes v1 -> v2:
> > > * (none)
> > > ---
> > >  util/mmap-alloc.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> > > index 27dcccd8ec..7c2ce98eb0 100644
> > > --- a/util/mmap-alloc.c
> > > +++ b/util/mmap-alloc.c
> > > @@ -9,6 +9,9 @@
> > >   * This work is licensed under the terms of the GNU GPL, version 2 o=
r
> > >   * later.  See the COPYING file in the top-level directory.
> > >   */
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/mmap-alloc.h"
> > > +#include "qemu/host-utils.h"
> > > =20
> > >  #ifdef CONFIG_LINUX
> > >  #include <linux/mman.h>
> >=20
> > This breaks the build on mips, because mips doesn't have MAP_SYNC
> > defined at linux/mman.h:
> >=20
> > https://app.shippable.com/github/ehabkost/qemu-hacks/runs/9/9/console
>=20
>=20
> Oops. But that in fact means it's currently building on mips but not
> working correctly there! MAP_SHARED_VALIDATE 0x0 is especially
> problematic. I'm unsure what's the right thing to do is,
> I guess as a first step we can go back and device MAP_SYNC to 0,

Defining MAP_SYNC to 0 on MIPS would restore the existing
behavior, so it seems like a reasonable step to fix the build
failure.  But not even printing a warning when the host doesn't
have MAP_SYNC (the existing behavior on MIPS and non-Linux) seems
wrong.

--=20
Eduardo


