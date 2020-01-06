Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B903C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2718E2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKnf1Rj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2718E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioWU8-0007No-7k
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ioWTM-0006iq-Pb
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ioWTK-0007ZU-8l
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:47:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48322
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ioWTJ-0007YP-Qc
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578332840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrobEeInUPtc3CuJ14AmmzMRJiMTqPJxuLcWnISNATI=;
 b=IKnf1Rj7wO9kFnXDiL7NqvzvNESYp0pszFQudh5dAABjNm46dPIEzGfCDCOxtc0Tw2mkIb
 6bRSeoDvCXJQQFB8XubAsPjXrywQIX8/z5oH0N50cWvLkDLYJBQyeF90UIL1XcOnGRPfdH
 F6nimajmLEZqM3A9tHO3jAolWOEeEJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-rbI9mxzAP5yjy9HNhyIMxA-1; Mon, 06 Jan 2020 12:47:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97376DB20
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 17:47:15 +0000 (UTC)
Received: from work-vm (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6EA2271B4;
 Mon,  6 Jan 2020 17:47:11 +0000 (UTC)
Date: Mon, 6 Jan 2020 17:47:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 059/104] virtiofsd: Add ID to the log with FUSE_LOG_DEBUG
 level
Message-ID: <20200106174709.GK2798@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-60-dgilbert@redhat.com>
 <20200106151819.GW2930416@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200106151819.GW2930416@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rbI9mxzAP5yjy9HNhyIMxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Dec 12, 2019 at 04:38:19PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >=20
> > virtiofsd has some threads, so we see a lot of logs with debug option.
> > It would be useful for debugging if we can identify the specific thread
> > from the log.
> >=20
> > Add ID, which is got by gettid(), to the log with FUSE_LOG_DEBUG level
> > so that we can grep the specific thread.
> >=20
> > The log is like as:
> >=20
> >   ]# ./virtiofsd -d -o vhost_user_socket=3D/tmp/vhostqemu0 -o source=3D=
/tmp/share0 -o cache=3Dauto
> >   ...
> >   [ID: 00000097]    unique: 12696, success, outsize: 120
> >   [ID: 00000097] virtio_send_msg: elem 18: with 2 in desc of length 120
> >   [ID: 00000003] fv_queue_thread: Got queue event on Queue 1
> >   [ID: 00000003] fv_queue_thread: Queue 1 gave evalue: 1 available: in:=
 65552 out: 80
> >   [ID: 00000003] fv_queue_thread: Waiting for Queue 1 event
> >   [ID: 00000071] fv_queue_worker: elem 33: with 2 out desc of length 80=
 bad_in_num=3D0 bad_out_num=3D0
> >   [ID: 00000071] unique: 12694, opcode: READ (15), nodeid: 2, insize: 8=
0, pid: 2014
> >   [ID: 00000071] lo_read(ino=3D2, size=3D65536, off=3D131072)
> >=20
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 6f398a7ff2..8e00a90e6f 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -42,6 +42,7 @@
> >  #include <cap-ng.h>
> >  #include <dirent.h>
> >  #include <errno.h>
> > +#include <glib.h>
> >  #include <inttypes.h>
> >  #include <limits.h>
> >  #include <pthread.h>
> > @@ -2248,12 +2249,18 @@ static void setup_nofile_rlimit(void)
> >      }
> >  }
> > =20
> > -static void log_func(enum fuse_log_level level, const char *fmt, va_li=
st ap)
> > +static void log_func(enum fuse_log_level level, const char *_fmt, va_l=
ist ap)
> >  {
> > +    char *fmt =3D (char *)_fmt;
>=20
> Reusing a variable for data that may be const from stack or
> non-const from heap is really gross & asking for trouble.

Yeh, that is a bit of a hack.

> If instead it does:
>=20
>     g_autofree *localfmt =3D NULL;

                 ^ char

> > +
> >      if (current_log_level < level) {
> >          return;
> >      }
> > =20
> > +    if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
> > +        fmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_gettid)=
, _fmt);
>=20
> Then:
>=20
>            localfmt =3D g_strdup_printf(....)
> =09   fmt =3D localfmt;
>=20
> > +    }
> > +
> >      if (use_syslog) {
> >          int priority =3D LOG_ERR;
> >          switch (level) {
> > @@ -2286,6 +2293,10 @@ static void log_func(enum fuse_log_level level, =
const char *fmt, va_list ap)
> >      } else {
> >          vfprintf(stderr, fmt, ap);
> >      }
> > +
> > +    if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
> > +        g_free(fmt);
> > +    }
>=20
> This can then be deleted.

Yes, that works nicely.

Dave

> >  }
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


