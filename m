Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB998C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767A72064C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbSJwcJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767A72064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkSY-0008H1-Ju
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwkRv-0007pH-KM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwkRu-0007AQ-69
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:19:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwkRu-00079t-2Y
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580293193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UY8dQMkwdK+lZ/KDHorN14CYxcMPM1BQvaGlt12PIIA=;
 b=gbSJwcJ6IgAt7drGjilKErDrdKMjUloJ3zpwzbDTLF6/9wOA4YxYuX0groVfom4+29wY9F
 17aQa/RlusNqlMrBeUWsmE273kG2C/DhyVeJ/Q8LHNm+228cwMm6l97Lgg9h4VzJYnfWPX
 xGpYjozAlgJAHvWnxhbmHDR8TSnGWCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-_YA0FzKlN8ykFrmpWV_hRg-1; Wed, 29 Jan 2020 05:19:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3FA4477;
 Wed, 29 Jan 2020 10:19:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D81A845B8;
 Wed, 29 Jan 2020 10:19:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B31861138404; Wed, 29 Jan 2020 11:19:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 03/13] monitor/hmp: rename device-hotplug.c to
 block/monitor/block-hmp-cmds.c
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-4-mlevitsk@redhat.com>
 <20200128165606.GU3215@work-vm>
 <b8acc4b96e1016e0cae454d8e5980474b4e01374.camel@redhat.com>
Date: Wed, 29 Jan 2020 11:19:45 +0100
In-Reply-To: <b8acc4b96e1016e0cae454d8e5980474b4e01374.camel@redhat.com>
 (Maxim Levitsky's message of "Tue, 28 Jan 2020 21:28:47 +0200")
Message-ID: <87lfpq7ef2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _YA0FzKlN8ykFrmpWV_hRg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Tue, 2020-01-28 at 16:56 +0000, Dr. David Alan Gilbert wrote:
>> * Maxim Levitsky (mlevitsk@redhat.com) wrote:
>> > These days device-hotplug.c only contains the hmp_drive_add
>> > In the next patch, rest of hmp_drive* functions will be moved
>> > there.
>> >=20
>> > Also change the license of that file to GPL2+ since most
>> > of the code that will be moved there is under that license
>>=20
>> How do we check that's OK?
>
> Currently that code is BSD licensed, and in next patches I will move
> here GPLv2+ code, and as far as I know combining them gives you GPLv2+

Yes, it does.

I'd change the license in the patch that moves in GPLv2+ code.

> I wasn't even aware that we have mixed licenses, and so this change was d=
one
> after Markus pointed this out in the previous patchset review.
>
> Best regards,
> =09Maxim Levitsky
>
>>=20
>> > Also add block-hmp-commands.h to contain prototypes of these
>> > functions
>> >=20
>> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> > ---
>> >  MAINTAINERS                                   |  1 +
>> >  Makefile.objs                                 |  2 +-
>> >  block/Makefile.objs                           |  1 +
>> >  block/monitor/Makefile.objs                   |  1 +
>> >  .../monitor/block-hmp-cmds.c                  | 23 ++++--------------=
-
>> >  include/block/block-hmp-commands.h            |  8 +++++++
>> >  include/sysemu/sysemu.h                       |  3 ---
>> >  monitor/misc.c                                |  1 +
>> >  8 files changed, 18 insertions(+), 22 deletions(-)
>> >  create mode 100644 block/monitor/Makefile.objs
>> >  rename device-hotplug.c =3D> block/monitor/block-hmp-cmds.c (55%)
>> >  create mode 100644 include/block/block-hmp-commands.h
>> >=20
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index f6511d5120..5d50d09ad8 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -1882,6 +1882,7 @@ Block QAPI, monitor, command line
>> >  M: Markus Armbruster <armbru@redhat.com>
>> >  S: Supported
>> >  F: blockdev.c
>> > +F: blockdev-hmp-cmds.c
>> >  F: block/qapi.c
>> >  F: qapi/block*.json
>> >  F: qapi/transaction.json
>> > diff --git a/Makefile.objs b/Makefile.objs
>> > index ff396b9209..15209eb6b5 100644
>> > --- a/Makefile.objs
>> > +++ b/Makefile.objs
>> > @@ -48,7 +48,7 @@ common-obj-y +=3D dump/
>> >  common-obj-y +=3D job-qmp.o
>> >  common-obj-y +=3D monitor/
>> >  common-obj-y +=3D net/
>> > -common-obj-y +=3D qdev-monitor.o device-hotplug.o
>> > +common-obj-y +=3D qdev-monitor.o
>> >  common-obj-$(CONFIG_WIN32) +=3D os-win32.o
>> >  common-obj-$(CONFIG_POSIX) +=3D os-posix.o
>> > =20
>> > diff --git a/block/Makefile.objs b/block/Makefile.objs
>> > index 330529b0b7..3f65544a6b 100644
>> > --- a/block/Makefile.objs
>> > +++ b/block/Makefile.objs
>> > @@ -44,6 +44,7 @@ block-obj-y +=3D crypto.o
>> >  block-obj-y +=3D aio_task.o
>> >  block-obj-y +=3D backup-top.o
>> >  block-obj-y +=3D filter-compress.o
>> > +common-obj-y +=3D monitor/
>> > =20
>> >  common-obj-y +=3D stream.o
>> > =20
>> > diff --git a/block/monitor/Makefile.objs b/block/monitor/Makefile.objs
>> > new file mode 100644
>> > index 0000000000..0a74f9a8b5
>> > --- /dev/null
>> > +++ b/block/monitor/Makefile.objs
>> > @@ -0,0 +1 @@
>> > +common-obj-y +=3D block-hmp-cmds.o
>> > diff --git a/device-hotplug.c b/block/monitor/block-hmp-cmds.c
>> > similarity index 55%
>> > rename from device-hotplug.c
>> > rename to block/monitor/block-hmp-cmds.c
>> > index 554e4d98db..c65aaa86ea 100644
>> > --- a/device-hotplug.c
>> > +++ b/block/monitor/block-hmp-cmds.c
>> > @@ -1,25 +1,11 @@
>> >  /*
>> > - * QEMU device hotplug helpers
>> > + * Blockdev HMP commands
>> >   *
>> >   * Copyright (c) 2004 Fabrice Bellard
>> >   *
>> > - * Permission is hereby granted, free of charge, to any person obtain=
ing a copy
>> > - * of this software and associated documentation files (the "Software=
"), to deal
>> > - * in the Software without restriction, including without limitation =
the rights
>> > - * to use, copy, modify, merge, publish, distribute, sublicense, and/=
or sell
>> > - * copies of the Software, and to permit persons to whom the Software=
 is
>> > - * furnished to do so, subject to the following conditions:
>> > - *
>> > - * The above copyright notice and this permission notice shall be inc=
luded in
>> > - * all copies or substantial portions of the Software.
>> > - *
>> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EX=
PRESS OR
>> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL
>> > - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES =
OR OTHER
>> > - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, AR=
ISING FROM,
>> > - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN
>> > - * THE SOFTWARE.
>> > + * This work is licensed under the terms of the GNU GPL, version 2.
>> > + * or (at your option) any later version.
>> > + * See the COPYING file in the top-level directory.
>> >   */
>> > =20
>> >  #include "qemu/osdep.h"
>> > @@ -33,6 +19,7 @@
>> >  #include "sysemu/sysemu.h"
>> >  #include "monitor/monitor.h"
>> >  #include "block/block_int.h"
>> > +#include "block/block-hmp-commands.h"
>> > =20
>> > =20
>> >  void hmp_drive_add(Monitor *mon, const QDict *qdict)
>> > diff --git a/include/block/block-hmp-commands.h b/include/block/block-=
hmp-commands.h
>> > new file mode 100644
>> > index 0000000000..4f9033a8a6
>> > --- /dev/null
>> > +++ b/include/block/block-hmp-commands.h
>> > @@ -0,0 +1,8 @@
>> > +#ifndef BLOCK_HMP_COMMANDS_H
>> > +#define BLOCK_HMP_COMMANDS_H
>> > +
>> > +/* HMP commands related to the block layer*/

Space before */, please.

>> Should this file get a copyright header as well?

I think it should.

>> > +
>> > +void hmp_drive_add(Monitor *mon, const QDict *qdict);
>> > +
>> > +#endif
>> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> > index 80c57fdc4e..c48635666d 100644
>> > --- a/include/sysemu/sysemu.h
>> > +++ b/include/sysemu/sysemu.h
>> > @@ -68,9 +68,6 @@ extern int nb_option_roms;
>> >  extern const char *prom_envs[MAX_PROM_ENVS];
>> >  extern unsigned int nb_prom_envs;
>> > =20
>> > -/* generic hotplug */
>> > -void hmp_drive_add(Monitor *mon, const QDict *qdict);
>> > -
>> >  /* pcie aer error injection */
>> >  void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
>> > =20
>> > diff --git a/monitor/misc.c b/monitor/misc.c
>> > index de1ca4d114..0466c00830 100644
>> > --- a/monitor/misc.c
>> > +++ b/monitor/misc.c
>> > @@ -79,6 +79,7 @@
>> >  #include "sysemu/cpus.h"
>> >  #include "qemu/cutils.h"
>> >  #include "tcg/tcg.h"
>> > +#include "block/block-hmp-commands.h"

Put this next to #include "block/qapi.h", please.

>> > =20
>> >  #if defined(TARGET_S390X)
>> >  #include "hw/s390x/storage-keys.h"
>> > --=20
>> > 2.17.2
>> >=20

Preferably with my nitpicks addressed:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


