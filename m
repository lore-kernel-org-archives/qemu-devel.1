Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339C9C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28A8206DB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUip0jUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28A8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVud-0004fV-5z
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ioVoi-0006wf-Ng
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ioVof-0007hq-SL
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:05:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ioVof-0007em-7L
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578330320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gV8JUI+Cmd8JgdTBVK7Cut4Q9MQRkogNpLPSNJ8sMhk=;
 b=VUip0jUSj8LDkqi3XlYeg7ByEYN7HhrrITjU/RaMfr5UWf75MGJThslGAfyz9h/4RhatLY
 nshhnpeuboYCXs4hoYTxTeSmPaoiqqyCGsjgMk3P172RalotHR8hw8JSmPl6gV8UusMC1w
 FaKvXvDVesnxRN+U+/Sk1dQn8D5XWGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-Qb2HqUEyPvy0b8FTXw4RVA-1; Mon, 06 Jan 2020 12:05:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A5611800D4E
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 17:05:17 +0000 (UTC)
Received: from work-vm (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B94345C1B0;
 Mon,  6 Jan 2020 17:05:13 +0000 (UTC)
Date: Mon, 6 Jan 2020 17:05:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 058/104] virtiofsd: print log only when priority is high
 enough
Message-ID: <20200106170511.GI2798@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-59-dgilbert@redhat.com>
 <20200106151048.GV2930416@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200106151048.GV2930416@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Qb2HqUEyPvy0b8FTXw4RVA-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Dec 12, 2019 at 04:38:18PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Eryu Guan <eguan@linux.alibaba.com>
> >=20
> > Introduce "-o log_level=3D" command line option to specify current log
> > level (priority), valid values are "debug info warn err", e.g.
> >=20
> >     ./virtiofsd -o log_level=3Ddebug ...
> >=20
> > So only log priority higher than "debug" will be printed to
> > stderr/syslog. And the default level is info.
> >=20
> > The "-o debug"/"-d" options are kept, and imply debug log level.
> >=20
> > Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
> > dgilbert: Reworked for libfuse's log_func
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/fuse_log.c       |   4 ++
> >  tools/virtiofsd/fuse_lowlevel.c  |  75 ++++++++------------
> >  tools/virtiofsd/fuse_lowlevel.h  |   1 +
> >  tools/virtiofsd/helper.c         |  10 ++-
> >  tools/virtiofsd/passthrough_ll.c | 118 +++++++++++++------------------
> >  5 files changed, 92 insertions(+), 116 deletions(-)
>=20
> > diff --git a/tools/virtiofsd/fuse_log.c b/tools/virtiofsd/fuse_log.c
> > index 11345f9ec8..79a18a7aaa 100644
> > --- a/tools/virtiofsd/fuse_log.c
> > +++ b/tools/virtiofsd/fuse_log.c
> > @@ -8,6 +8,10 @@
> >   * See the file COPYING.LIB
> >   */
> > =20
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdarg.h>
> > +#include <syslog.h>
> >  #include "fuse_log.h"
> > =20
> >  #include <stdarg.h>
>=20
> Why do we need to add these headers if there are no code changes in this
> file ?

Thanks, those are left overs from an earlier version; I've deleted them now=
.

> > diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_low=
level.c
> > index f3c8bdf7cb..0abb369b3d 100644
> > --- a/tools/virtiofsd/fuse_lowlevel.c
> > +++ b/tools/virtiofsd/fuse_lowlevel.c
> > @@ -158,19 +158,17 @@ static int fuse_send_msg(struct fuse_session *se,=
 struct fuse_chan *ch,
> >      struct fuse_out_header *out =3D iov[0].iov_base;
> > =20
> >      out->len =3D iov_length(iov, count);
> > -    if (se->debug) {
> > -        if (out->unique =3D=3D 0) {
> > -            fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n"=
, out->error,
> > -                     out->len);
> > -        } else if (out->error) {
> > -            fuse_log(FUSE_LOG_DEBUG,
> > -                     "   unique: %llu, error: %i (%s), outsize: %i\n",
> > -                     (unsigned long long)out->unique, out->error,
> > -                     strerror(-out->error), out->len);
> > -        } else {
> > -            fuse_log(FUSE_LOG_DEBUG, "   unique: %llu, success, outsiz=
e: %i\n",
> > -                     (unsigned long long)out->unique, out->len);
> > -        }
> > +    if (out->unique =3D=3D 0) {
> > +        fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n", ou=
t->error,
> > +                 out->len);
> > +    } else if (out->error) {
> > +        fuse_log(FUSE_LOG_DEBUG,
> > +                 "   unique: %llu, error: %i (%s), outsize: %i\n",
> > +                 (unsigned long long)out->unique, out->error,
> > +                 strerror(-out->error), out->len);
> > +    } else {
> > +        fuse_log(FUSE_LOG_DEBUG, "   unique: %llu, success, outsize: %=
i\n",
> > +                 (unsigned long long)out->unique, out->len);
> >      }
>=20
> Removing all the 'if (se->debug)' checks means that we take the
> performance hit of calling many logging functions in the common
> case where debug is disabled. Hopefully 'fuse_log' is smart
> enough to avoid printf formatting of the msg + args unless
> it is actually goiing to output the message

It is; we go through fuse_log (fuse_log.c an imported file) that just
does the va_start and then calls the log_func that was set later in this
patch and the first thing it does is check the level and exit.

Dave

>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


