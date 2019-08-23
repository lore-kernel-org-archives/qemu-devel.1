Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A368C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C63221848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C63221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i19Ls-0008JG-Gt
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 09:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i19Fc-0001Qu-3V
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i19Fa-0004ae-F6
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i19Fa-0004aQ-73
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:05:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 85F203090FC1;
 Fri, 23 Aug 2019 13:05:05 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B20A69506;
 Fri, 23 Aug 2019 13:05:04 +0000 (UTC)
Date: Fri, 23 Aug 2019 14:05:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190823130502.GH2784@work-vm>
References: <20190731144225.3784-1-richardw.yang@linux.intel.com>
 <20190731144225.3784-3-richardw.yang@linux.intel.com>
 <20190823110609.GF2784@work-vm> <20190823113801.GF9654@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190823113801.GF9654@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 23 Aug 2019 13:05:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] migration/qemu-file: fix potential buf
 waste for extra buf_index adjustment
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Fri, Aug 23, 2019 at 12:06:09PM +0100, Dr. David Alan Gilbert wrote:
> > (Copying Dan in)
> >=20
> > * Wei Yang (richardw.yang@linux.intel.com) wrote:
> > > In add_to_iovec(), qemu_fflush() will be called if iovec is full. I=
f
> > > this happens, buf_index is reset. Currently, this is not checked an=
d
> > > buf_index would always been adjust with buf size.
> > >=20
> > > This is not harmful, but will waste some space in file buffer.
> >=20
> > That's a nice find.
> >=20
> > > This patch make add_to_iovec() return 1 when it has flushed the fil=
e.
> > > Then the caller could check the return value to see whether it is
> > > necessary to adjust the buf_index any more.
> > >=20
> > > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >=20
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >=20
> > (I wonder if there's a way to wrap that little add_to_iovec, check, a=
dd
> > to index, flush in a little wrapper).
>=20
> Given the name "add_to_iovec" I think it is pretty surprising
> that it calls "qemu_flush" at all.
>=20
> It is also pretty wierd that we're checking two different
> conditions in two different places.
>=20
> Right now the code is essentially doing this:
>=20
>      if (f->iovcnt >=3D MAX_IOV_SIZE) {
>         qemu_fflush(f);
>      }
>      if (f->buf_index =3D=3D IO_BUF_SIZE) {
>         qemu_fflush(f);
>      }
>=20
> Except that in the qemu_put_buffer_async() case, we're
> only doing the first of these two checks. This feels
> very odd indeed - I would have thought either it should
> do both, or do neither.

No, there's two separate types of buffers.

There's f->buf which is a single allocated buffer in the QEMUFile
with an offset buf_index, and there are arbitrary RAM pages
added typically via qemu_put_buffer_async.

The check for >=3D IO_BUF_SIZE is only done when adding to the f->buf,
where as the check on f->iovcnt is done when you add an element to
the iovec and that can happen potentially in either case.

Dave

> Assuming doing both flushs is ok for qemu_put_buffer_async
> then I'd suggest renaming 'add_to_iovec' to 'queue_buffer'
> and have that method do both of these qemu_fflush() calls.
>=20
> > > ---
> > >  migration/qemu-file.c | 42 ++++++++++++++++++++++++++++-----------=
---
> > >  1 file changed, 28 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > > index 35c22605dd..05d9f42ddb 100644
> > > --- a/migration/qemu-file.c
> > > +++ b/migration/qemu-file.c
> > > @@ -343,8 +343,16 @@ int qemu_fclose(QEMUFile *f)
> > >      return ret;
> > >  }
> > > =20
> > > -static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t s=
ize,
> > > -                         bool may_free)
> > > +/*
> > > + * Add buf to iovec. Do flush if iovec is full.
> > > + *
> > > + * Return values:
> > > + * 1 iovec is full and flushed
> > > + * 0 iovec is not flushed
> > > + *
> > > + */
> > > +static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t si=
ze,
> > > +                        bool may_free)
> > >  {
> > >      /* check for adjacent buffer and coalesce them */
> > >      if (f->iovcnt > 0 && buf =3D=3D f->iov[f->iovcnt - 1].iov_base=
 +
> > > @@ -362,7 +370,10 @@ static void add_to_iovec(QEMUFile *f, const ui=
nt8_t *buf, size_t size,
> > > =20
> > >      if (f->iovcnt >=3D MAX_IOV_SIZE) {
> > >          qemu_fflush(f);
> > > +        return 1;
> > >      }
> > > +
> > > +    return 0;
> > >  }
> > > =20
> > >  void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t=
 size,
> > > @@ -391,10 +402,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8=
_t *buf, size_t size)
> > >          }
> > >          memcpy(f->buf + f->buf_index, buf, l);
> > >          f->bytes_xfer +=3D l;
> > > -        add_to_iovec(f, f->buf + f->buf_index, l, false);
> > > -        f->buf_index +=3D l;
> > > -        if (f->buf_index =3D=3D IO_BUF_SIZE) {
> > > -            qemu_fflush(f);
> > > +        if (!add_to_iovec(f, f->buf + f->buf_index, l, false)) {
> > > +            f->buf_index +=3D l;
> > > +            if (f->buf_index =3D=3D IO_BUF_SIZE) {
> > > +                qemu_fflush(f);
> > > +            }
> > >          }
> > >          if (qemu_file_get_error(f)) {
> > >              break;
> > > @@ -412,10 +424,11 @@ void qemu_put_byte(QEMUFile *f, int v)
> > > =20
> > >      f->buf[f->buf_index] =3D v;
> > >      f->bytes_xfer++;
> > > -    add_to_iovec(f, f->buf + f->buf_index, 1, false);
> > > -    f->buf_index++;
> > > -    if (f->buf_index =3D=3D IO_BUF_SIZE) {
> > > -        qemu_fflush(f);
> > > +    if (!add_to_iovec(f, f->buf + f->buf_index, 1, false)) {
> > > +        f->buf_index++;
> > > +        if (f->buf_index =3D=3D IO_BUF_SIZE) {
> > > +            qemu_fflush(f);
> > > +        }
> > >      }
> > >  }
> > > =20
> > > @@ -717,10 +730,11 @@ ssize_t qemu_put_compression_data(QEMUFile *f=
, z_stream *stream,
> > >      }
> > > =20
> > >      qemu_put_be32(f, blen);
> > > -    add_to_iovec(f, f->buf + f->buf_index, blen, false);
> > > -    f->buf_index +=3D blen;
> > > -    if (f->buf_index =3D=3D IO_BUF_SIZE) {
> > > -        qemu_fflush(f);
> > > +    if (!add_to_iovec(f, f->buf + f->buf_index, blen, false)) {
> > > +        f->buf_index +=3D blen;
> > > +        if (f->buf_index =3D=3D IO_BUF_SIZE) {
> > > +            qemu_fflush(f);
> > > +        }
> > >      }
> > >      return blen + sizeof(int32_t);
> > >  }
> > > --=20
> > > 2.17.1
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

