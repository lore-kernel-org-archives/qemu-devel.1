Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EADC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2FC215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2FC215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i58lx-0000I8-99
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i58lB-0007wB-PS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i58lA-00078R-2W
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i58l9-00077v-QO
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:22:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3CD33082133;
 Tue,  3 Sep 2019 13:22:10 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C6D95D6B2;
 Tue,  3 Sep 2019 13:22:09 +0000 (UTC)
Date: Tue, 3 Sep 2019 14:22:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190903132207.GH2744@work-vm>
References: <20190731144225.3784-1-richardw.yang@linux.intel.com>
 <20190731144225.3784-3-richardw.yang@linux.intel.com>
 <20190823110609.GF2784@work-vm> <20190823113801.GF9654@redhat.com>
 <20190823130502.GH2784@work-vm>
 <20190824162216.ypo6vp2c6u2om4o7@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824162216.ypo6vp2c6u2om4o7@master>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 03 Sep 2019 13:22:10 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org, "Daniel P. Berrang?" <berrange@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richard.weiyang@gmail.com) wrote:
> On Fri, Aug 23, 2019 at 02:05:02PM +0100, Dr. David Alan Gilbert wrote:
> >* Daniel P. Berrang? (berrange@redhat.com) wrote:
> >> On Fri, Aug 23, 2019 at 12:06:09PM +0100, Dr. David Alan Gilbert wrote:
> >> > (Copying Dan in)
> >> > 
> >> > * Wei Yang (richardw.yang@linux.intel.com) wrote:
> >> > > In add_to_iovec(), qemu_fflush() will be called if iovec is full. If
> >> > > this happens, buf_index is reset. Currently, this is not checked and
> >> > > buf_index would always been adjust with buf size.
> >> > > 
> >> > > This is not harmful, but will waste some space in file buffer.
> >> > 
> >> > That's a nice find.
> >> > 
> >> > > This patch make add_to_iovec() return 1 when it has flushed the file.
> >> > > Then the caller could check the return value to see whether it is
> >> > > necessary to adjust the buf_index any more.
> >> > > 
> >> > > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> > 
> >> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> > 
> >> > (I wonder if there's a way to wrap that little add_to_iovec, check, add
> >> > to index, flush in a little wrapper).
> >> 
> >> Given the name "add_to_iovec" I think it is pretty surprising
> >> that it calls "qemu_flush" at all.
> >> 
> >> It is also pretty wierd that we're checking two different
> >> conditions in two different places.
> >> 
> >> Right now the code is essentially doing this:
> >> 
> >>      if (f->iovcnt >= MAX_IOV_SIZE) {
> >>         qemu_fflush(f);
> >>      }
> >>      if (f->buf_index == IO_BUF_SIZE) {
> >>         qemu_fflush(f);
> >>      }
> >> 
> >> Except that in the qemu_put_buffer_async() case, we're
> >> only doing the first of these two checks. This feels
> >> very odd indeed - I would have thought either it should
> >> do both, or do neither.
> >
> >No, there's two separate types of buffers.
> >
> >There's f->buf which is a single allocated buffer in the QEMUFile
> >with an offset buf_index, and there are arbitrary RAM pages
> >added typically via qemu_put_buffer_async.
> >
> 
> qemu_put_buffer_async is the only one which put a range not in f->buf into the
> iovec.
> 
> And one thing confused me is even its name is async, add_to_iovec still would
> call qemu_fflush when iovec is full. So it is not a always async function.
> From the function name, it is a little difficult to differentiate
> qemu_put_buffer and qemu_put_buffer_async.

It's a bit confusing, but I think it is the right name;  the 'async'
refers to the fact that the data is read from the buffer we pass
sometime later, not synchronously before the return of the
qemu_put_buffer_async call.

Dave

> >The check for >= IO_BUF_SIZE is only done when adding to the f->buf,
> >where as the check on f->iovcnt is done when you add an element to
> >the iovec and that can happen potentially in either case.
> >
> >Dave
> >
> >> Assuming doing both flushs is ok for qemu_put_buffer_async
> >> then I'd suggest renaming 'add_to_iovec' to 'queue_buffer'
> >> and have that method do both of these qemu_fflush() calls.
> >> 
> >> > > ---
> >> > >  migration/qemu-file.c | 42 ++++++++++++++++++++++++++++--------------
> >> > >  1 file changed, 28 insertions(+), 14 deletions(-)
> >> > > 
> >> > > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> >> > > index 35c22605dd..05d9f42ddb 100644
> >> > > --- a/migration/qemu-file.c
> >> > > +++ b/migration/qemu-file.c
> >> > > @@ -343,8 +343,16 @@ int qemu_fclose(QEMUFile *f)
> >> > >      return ret;
> >> > >  }
> >> > >  
> >> > > -static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
> >> > > -                         bool may_free)
> >> > > +/*
> >> > > + * Add buf to iovec. Do flush if iovec is full.
> >> > > + *
> >> > > + * Return values:
> >> > > + * 1 iovec is full and flushed
> >> > > + * 0 iovec is not flushed
> >> > > + *
> >> > > + */
> >> > > +static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
> >> > > +                        bool may_free)
> >> > >  {
> >> > >      /* check for adjacent buffer and coalesce them */
> >> > >      if (f->iovcnt > 0 && buf == f->iov[f->iovcnt - 1].iov_base +
> >> > > @@ -362,7 +370,10 @@ static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
> >> > >  
> >> > >      if (f->iovcnt >= MAX_IOV_SIZE) {
> >> > >          qemu_fflush(f);
> >> > > +        return 1;
> >> > >      }
> >> > > +
> >> > > +    return 0;
> >> > >  }
> >> > >  
> >> > >  void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
> >> > > @@ -391,10 +402,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
> >> > >          }
> >> > >          memcpy(f->buf + f->buf_index, buf, l);
> >> > >          f->bytes_xfer += l;
> >> > > -        add_to_iovec(f, f->buf + f->buf_index, l, false);
> >> > > -        f->buf_index += l;
> >> > > -        if (f->buf_index == IO_BUF_SIZE) {
> >> > > -            qemu_fflush(f);
> >> > > +        if (!add_to_iovec(f, f->buf + f->buf_index, l, false)) {
> >> > > +            f->buf_index += l;
> >> > > +            if (f->buf_index == IO_BUF_SIZE) {
> >> > > +                qemu_fflush(f);
> >> > > +            }
> >> > >          }
> >> > >          if (qemu_file_get_error(f)) {
> >> > >              break;
> >> > > @@ -412,10 +424,11 @@ void qemu_put_byte(QEMUFile *f, int v)
> >> > >  
> >> > >      f->buf[f->buf_index] = v;
> >> > >      f->bytes_xfer++;
> >> > > -    add_to_iovec(f, f->buf + f->buf_index, 1, false);
> >> > > -    f->buf_index++;
> >> > > -    if (f->buf_index == IO_BUF_SIZE) {
> >> > > -        qemu_fflush(f);
> >> > > +    if (!add_to_iovec(f, f->buf + f->buf_index, 1, false)) {
> >> > > +        f->buf_index++;
> >> > > +        if (f->buf_index == IO_BUF_SIZE) {
> >> > > +            qemu_fflush(f);
> >> > > +        }
> >> > >      }
> >> > >  }
> >> > >  
> >> > > @@ -717,10 +730,11 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
> >> > >      }
> >> > >  
> >> > >      qemu_put_be32(f, blen);
> >> > > -    add_to_iovec(f, f->buf + f->buf_index, blen, false);
> >> > > -    f->buf_index += blen;
> >> > > -    if (f->buf_index == IO_BUF_SIZE) {
> >> > > -        qemu_fflush(f);
> >> > > +    if (!add_to_iovec(f, f->buf + f->buf_index, blen, false)) {
> >> > > +        f->buf_index += blen;
> >> > > +        if (f->buf_index == IO_BUF_SIZE) {
> >> > > +            qemu_fflush(f);
> >> > > +        }
> >> > >      }
> >> > >      return blen + sizeof(int32_t);
> >> > >  }
> >> > > -- 
> >> > > 2.17.1
> >> > > 
> >> > --
> >> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >> > 
> >> 
> >> Regards,
> >> Daniel
> >> -- 
> >> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> >> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> >> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> >--
> >Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> -- 
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

