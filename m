Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D885C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266F224686
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmp+CAAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266F224686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdrU-0003hJ-Dl
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBdqK-0002hy-G8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBdqI-00056k-C9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:18:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56620
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBdqI-00053F-1e
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583842717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfyPok11MZ8J5n99ozeRU9gZ3fn0tq2uRIYvkzpnd0U=;
 b=gmp+CAAw4h8DT/Xe8vfvxznB7lkclRm6BQaUglXqPfYJBDLIy+w3rCtEzG3j6zOCcjAK2H
 52Y99bS+cmhqVR6FL3cztciFbMx2zxtbHSYtszCri6HKO1qJzvzMe9d8bvH0OccVsaVE64
 hYkTPM2pl0Z63t+eWPaamKxx0A1+3VY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-le3LE8rrNxuoKFg9n-EBjw-1; Tue, 10 Mar 2020 08:18:35 -0400
X-MC-Unique: le3LE8rrNxuoKFg9n-EBjw-1
Received: by mail-qk1-f200.google.com with SMTP id w6so9551108qki.13
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Pr0mGD+tqJi6OimJjxOBwgp2uJE/+Y4aF7S++4eyC/g=;
 b=gisZfR5VX/HNmLG6fvhHJTSRkv6tcB6ZEfro8MVBwa47+dTHy1LFXHVemcvVhQ8dPI
 Tkl8xpaAwrDukxweY0isuxCdc8nuIQHzA6bjVgu1JZMbDSVesEovnzzuMlVnvyH0oKlG
 N7C/5Vx2LoPG+asvz5HD6LXsz0cfAfS6yr6+eZRrvRfJZI8oPqJscBdwYS89iP17kMi6
 AZTlupbYvxT3o4X9IBzB/m7/PVnC7JoJzELFYZd7cnf5NyqjTqqUcJ4rHkeJtG0x1ro+
 uVeiTSkU8PMxXnUm667uWuFs78oEw4W1o5q20vLGcI6rBil/3RQr86aPo9txC2chqRkq
 sY1g==
X-Gm-Message-State: ANhLgQ03AnqVDlft2KZboHZKtuNK03NAw7FyD3JKfCdIjnTyhSAQrcPg
 U2/0KB7J5jOY8MT2xWY7QrYp7I9vMpDsOPRrMwawIxs72sDIQ9j+Ehmvab9Re2cEHkqJNdzYmRt
 EF7XBhuWP4r9bDB8=
X-Received: by 2002:a05:6214:294:: with SMTP id
 l20mr18906125qvv.28.1583842715193; 
 Tue, 10 Mar 2020 05:18:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtE/v5nU6RKZ1Iwl3iuSZAqGPpkwCnVToJoUXLtznjHi70aSuiFUwEjaLfFP+AkIfhJ2buHng==
X-Received: by 2002:a05:6214:294:: with SMTP id
 l20mr18906107qvv.28.1583842714938; 
 Tue, 10 Mar 2020 05:18:34 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id 17sm21312597qkc.81.2020.03.10.05.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 05:18:34 -0700 (PDT)
Date: Tue, 10 Mar 2020 08:18:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH RESEND 2/3] vhost: fix a null pointer reference of
 vhost_log
Message-ID: <20200310081723-mutt-send-email-mst@kernel.org>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-3-longpeng2@huawei.com>
 <20200310014623-mutt-send-email-mst@kernel.org>
 <7da2b8b6-afe7-7f1f-9252-925b6bc543d8@huawei.com>
 <20200310042017-mutt-send-email-mst@kernel.org>
 <6d5f2e31-cbf2-f7e5-adbd-7a3a03fb67ee@huawei.com>
MIME-Version: 1.0
In-Reply-To: <6d5f2e31-cbf2-f7e5-adbd-7a3a03fb67ee@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: weifuqiang@huawei.com, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, arei.gonglei@huawei.com,
 huangzhichao@huawei.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 08:02:30PM +0800, Longpeng (Mike) wrote:
> =E5=9C=A8 2020/3/10 16:23, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > On Tue, Mar 10, 2020 at 04:04:35PM +0800, Longpeng (Mike, Cloud Infrast=
ructure Service Product Dept.) wrote:
> >>
> >>
> >> On 2020/3/10 13:57, Michael S. Tsirkin wrote:
> >>> On Mon, Feb 24, 2020 at 02:42:18PM +0800, Longpeng(Mike) wrote:
> >>>> From: Longpeng <longpeng2@huawei.com>
> >>>>
> >>>> vhost_log_alloc() may fails and returned pointer of log is null.
> >>>> However there're two places derefernce the return pointer without
> >>>> check.
> >>>>
> [...]
>=20
> >>>>  static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint=
64_t size)
> >>>>  {
> >>>> -    struct vhost_log *log =3D vhost_log_get(size, vhost_dev_log_is_=
shared(dev));
> >>>> -    uint64_t log_base =3D (uintptr_t)log->log;
> >>>> +    struct vhost_log *log;
> >>>> +    uint64_t log_base;
> >>>>      int r;
> >>>> =20
> >>>> +    log =3D vhost_log_get(size, vhost_dev_log_is_shared(dev));
> >>>> +    if (!log) {
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>
> >>> I'm not sure silently failing like this is safe. Callers assume
> >>> log can be resized. What can be done? I suspect not much
> >>> beside exiting ...
> >>> Speaking of which, lots of other failures in log resizing
> >>> path seem to be silently ignored.
> >>> I guess we should propagate them, and fix callers to check
> >>> the return code?
> >>>
> >> How about to let the callers treat the failure of log_resize as a fata=
l error ?
> >>
> [...]
>=20
> >>
> >> @@ -510,7 +525,9 @@ static void vhost_commit(MemoryListener *listener)
> >>  #define VHOST_LOG_BUFFER (0x1000 / sizeof *dev->log)
> >>      /* To log more, must increase log size before table update. */
> >>      if (dev->log_size < log_size) {
> >> -        vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER);
> >> +        if (vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER) < =
0) {
> >> +            abort();
> >> +        }
> >>      }
> >>      r =3D dev->vhost_ops->vhost_set_mem_table(dev, dev->mem);
> >>      if (r < 0) {
> >> @@ -518,7 +535,9 @@ static void vhost_commit(MemoryListener *listener)
> >>      }
> >>      /* To log less, can only decrease log size after table update. */
> >>      if (dev->log_size > log_size + VHOST_LOG_BUFFER) {
> >> -        vhost_dev_log_resize(dev, log_size);
> >> +        if (vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER) < =
0) {
> >> +            abort();
> >> +        }
> >>      }
> >>
> >>  out:
> >=20
> >=20
> > I think the suggested handling is
> > =09error_report() and exit().
> > we also need to propagate errno. So how about passing in Error then?
> >=20
> vhost_dev_log_resize
>   vhost_log_get
>     vhost_log_alloc
>       error_report_err (fail path, errno is in the errp)
>   VHOST_OPS_DEBUG (if ->vhost_set_log_base fail)
>       error_report (errno)
>=20
> Um, it seems log_resize will report error with errno internal, do we need
> error_report once more ?

Well we need to convert this over to something other than
VHOST_OPS_DEBUG, that will go away at some point.

> >=20
> >> @@ -818,7 +837,11 @@ static int vhost_migration_log(MemoryListener *li=
stener,
> >> int enable)
> >>          }
> >>          vhost_log_put(dev, false);
> >>      } else {
> >> -        vhost_dev_log_resize(dev, vhost_get_log_size(dev));
> >> +        r =3D vhost_dev_log_resize(dev, vhost_get_log_size(dev));
> >> +        if (r < 0) {
> >> +            return r;
> >> +        }
> >> +
> >>          r =3D vhost_dev_set_log(dev, true);
> >>          if (r < 0) {
> >>              return r;
> >>
> >>
> >>>
> >>> .
> >>>
> >>
> >> --=20
> >> ---
> >> Regards,
> >> Longpeng(Mike)
> >=20
> >=20
> > .
> >=20
>=20
>=20
> --=20
> Regards,
> Longpeng(Mike)


