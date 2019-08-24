Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84666C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 16:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8EE2133F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 16:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPUreMh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8EE2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Ypc-0002HF-F4
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 12:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1i1Yo1-00019g-7c
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 12:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1i1Ynz-0001YN-P4
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 12:22:21 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:38761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1i1Ynz-0001X4-Ho
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 12:22:19 -0400
Received: by mail-ed1-x543.google.com with SMTP id r12so18921056edo.5
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xV35PQTVCpcmCYGCnp4650KahGAkmXbrekQ72U/q1FE=;
 b=bPUreMh3HoM3q5c0q8lX+G/qA5no5PkBgmnjWI6f30CHUZdwRQ30KaydkKDto9c6xg
 rHuWMKaUrDnfPARPPYbrmSrkNEM0TD/N+htH+1oyaelBFoT/w8WSG1Vpsm+pQpaWLVRY
 U0yinWnzCiIrCZP0siMpfDjmnYEhbCbB5ScpEzt2hX9sjj1XEHao0Fv/8w71kksArrUa
 E8Svkx7vOyKFqYl+nEiX7M0YplBIuj6neOgyOtvabBDuj8OtVd0rWTI4lu6BHhiAQIO8
 AA9DCLj4sGt25wxiG7UTfbOoxu3BMReLkhn6sUoob/Hd98rzzspHDJvuljZ+tHETLpsp
 orTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=xV35PQTVCpcmCYGCnp4650KahGAkmXbrekQ72U/q1FE=;
 b=nwGEXqSJCcXnSxUrvbO7F8JfkeSTb2srR2zUsquHSEXGmrlkPAQPl+8OuPEgV40pbh
 OexfATEU0PDCuLoimHvkiL/nd2z3pUoZGy3/T27Wiw1KcHCw5PkKcYJlen/pd8bjgpBz
 uaE2g78hhQwt3i2cSzBQ2J3/8y1GP9t8j5HLzpAUb8Nib23mHzqDjD5mks2xTlQVHXUx
 rEqaCtjffkkd27ETStZrLzSoKz+ERmv9f+eC4QluAmZ34K1R6ylOttcfZ7VMaUe3IuMf
 kFgNhxP9KzGNpbiB6xTAaH5JBUTdUrCBVURbB7BU83AMrZSzV+LWc/lw0779H40ZvrLL
 9QSw==
X-Gm-Message-State: APjAAAX6pQzngBS16xah0t84xM6AOtPRITRrZXw7eNHAAibhWaCJHlmP
 ZANbUI86QadilX8Cr+Qaj10=
X-Google-Smtp-Source: APXvYqzPcMSmR3Ysl7hpWnOoO5sxgHEq4WI+KEcETYpQDt8o631vl3kDBy27dl9MSijS0uK7mtc6Sg==
X-Received: by 2002:a05:6402:1214:: with SMTP id
 c20mr10235588edw.111.1566663738414; 
 Sat, 24 Aug 2019 09:22:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id y14sm1274421ejo.76.2019.08.24.09.22.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 24 Aug 2019 09:22:17 -0700 (PDT)
Date: Sat, 24 Aug 2019 16:22:16 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190824162216.ypo6vp2c6u2om4o7@master>
References: <20190731144225.3784-1-richardw.yang@linux.intel.com>
 <20190731144225.3784-3-richardw.yang@linux.intel.com>
 <20190823110609.GF2784@work-vm> <20190823113801.GF9654@redhat.com>
 <20190823130502.GH2784@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823130502.GH2784@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrang?" <berrange@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 02:05:02PM +0100, Dr. David Alan Gilbert wrote:
>* Daniel P. Berrang? (berrange@redhat.com) wrote:
>> On Fri, Aug 23, 2019 at 12:06:09PM +0100, Dr. David Alan Gilbert wrote:
>> > (Copying Dan in)
>> > 
>> > * Wei Yang (richardw.yang@linux.intel.com) wrote:
>> > > In add_to_iovec(), qemu_fflush() will be called if iovec is full. If
>> > > this happens, buf_index is reset. Currently, this is not checked and
>> > > buf_index would always been adjust with buf size.
>> > > 
>> > > This is not harmful, but will waste some space in file buffer.
>> > 
>> > That's a nice find.
>> > 
>> > > This patch make add_to_iovec() return 1 when it has flushed the file.
>> > > Then the caller could check the return value to see whether it is
>> > > necessary to adjust the buf_index any more.
>> > > 
>> > > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> > 
>> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> > 
>> > (I wonder if there's a way to wrap that little add_to_iovec, check, add
>> > to index, flush in a little wrapper).
>> 
>> Given the name "add_to_iovec" I think it is pretty surprising
>> that it calls "qemu_flush" at all.
>> 
>> It is also pretty wierd that we're checking two different
>> conditions in two different places.
>> 
>> Right now the code is essentially doing this:
>> 
>>      if (f->iovcnt >= MAX_IOV_SIZE) {
>>         qemu_fflush(f);
>>      }
>>      if (f->buf_index == IO_BUF_SIZE) {
>>         qemu_fflush(f);
>>      }
>> 
>> Except that in the qemu_put_buffer_async() case, we're
>> only doing the first of these two checks. This feels
>> very odd indeed - I would have thought either it should
>> do both, or do neither.
>
>No, there's two separate types of buffers.
>
>There's f->buf which is a single allocated buffer in the QEMUFile
>with an offset buf_index, and there are arbitrary RAM pages
>added typically via qemu_put_buffer_async.
>

qemu_put_buffer_async is the only one which put a range not in f->buf into the
iovec.

And one thing confused me is even its name is async, add_to_iovec still would
call qemu_fflush when iovec is full. So it is not a always async function.
From the function name, it is a little difficult to differentiate
qemu_put_buffer and qemu_put_buffer_async.

>The check for >= IO_BUF_SIZE is only done when adding to the f->buf,
>where as the check on f->iovcnt is done when you add an element to
>the iovec and that can happen potentially in either case.
>
>Dave
>
>> Assuming doing both flushs is ok for qemu_put_buffer_async
>> then I'd suggest renaming 'add_to_iovec' to 'queue_buffer'
>> and have that method do both of these qemu_fflush() calls.
>> 
>> > > ---
>> > >  migration/qemu-file.c | 42 ++++++++++++++++++++++++++++--------------
>> > >  1 file changed, 28 insertions(+), 14 deletions(-)
>> > > 
>> > > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> > > index 35c22605dd..05d9f42ddb 100644
>> > > --- a/migration/qemu-file.c
>> > > +++ b/migration/qemu-file.c
>> > > @@ -343,8 +343,16 @@ int qemu_fclose(QEMUFile *f)
>> > >      return ret;
>> > >  }
>> > >  
>> > > -static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>> > > -                         bool may_free)
>> > > +/*
>> > > + * Add buf to iovec. Do flush if iovec is full.
>> > > + *
>> > > + * Return values:
>> > > + * 1 iovec is full and flushed
>> > > + * 0 iovec is not flushed
>> > > + *
>> > > + */
>> > > +static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>> > > +                        bool may_free)
>> > >  {
>> > >      /* check for adjacent buffer and coalesce them */
>> > >      if (f->iovcnt > 0 && buf == f->iov[f->iovcnt - 1].iov_base +
>> > > @@ -362,7 +370,10 @@ static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>> > >  
>> > >      if (f->iovcnt >= MAX_IOV_SIZE) {
>> > >          qemu_fflush(f);
>> > > +        return 1;
>> > >      }
>> > > +
>> > > +    return 0;
>> > >  }
>> > >  
>> > >  void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
>> > > @@ -391,10 +402,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>> > >          }
>> > >          memcpy(f->buf + f->buf_index, buf, l);
>> > >          f->bytes_xfer += l;
>> > > -        add_to_iovec(f, f->buf + f->buf_index, l, false);
>> > > -        f->buf_index += l;
>> > > -        if (f->buf_index == IO_BUF_SIZE) {
>> > > -            qemu_fflush(f);
>> > > +        if (!add_to_iovec(f, f->buf + f->buf_index, l, false)) {
>> > > +            f->buf_index += l;
>> > > +            if (f->buf_index == IO_BUF_SIZE) {
>> > > +                qemu_fflush(f);
>> > > +            }
>> > >          }
>> > >          if (qemu_file_get_error(f)) {
>> > >              break;
>> > > @@ -412,10 +424,11 @@ void qemu_put_byte(QEMUFile *f, int v)
>> > >  
>> > >      f->buf[f->buf_index] = v;
>> > >      f->bytes_xfer++;
>> > > -    add_to_iovec(f, f->buf + f->buf_index, 1, false);
>> > > -    f->buf_index++;
>> > > -    if (f->buf_index == IO_BUF_SIZE) {
>> > > -        qemu_fflush(f);
>> > > +    if (!add_to_iovec(f, f->buf + f->buf_index, 1, false)) {
>> > > +        f->buf_index++;
>> > > +        if (f->buf_index == IO_BUF_SIZE) {
>> > > +            qemu_fflush(f);
>> > > +        }
>> > >      }
>> > >  }
>> > >  
>> > > @@ -717,10 +730,11 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
>> > >      }
>> > >  
>> > >      qemu_put_be32(f, blen);
>> > > -    add_to_iovec(f, f->buf + f->buf_index, blen, false);
>> > > -    f->buf_index += blen;
>> > > -    if (f->buf_index == IO_BUF_SIZE) {
>> > > -        qemu_fflush(f);
>> > > +    if (!add_to_iovec(f, f->buf + f->buf_index, blen, false)) {
>> > > +        f->buf_index += blen;
>> > > +        if (f->buf_index == IO_BUF_SIZE) {
>> > > +            qemu_fflush(f);
>> > > +        }
>> > >      }
>> > >      return blen + sizeof(int32_t);
>> > >  }
>> > > -- 
>> > > 2.17.1
>> > > 
>> > --
>> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>> > 
>> 
>> Regards,
>> Daniel
>> -- 
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

