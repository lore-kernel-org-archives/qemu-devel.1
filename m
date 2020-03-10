Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC7C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0CD24677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvOTmHqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0CD24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaDA-0007aq-Ae
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBaAw-0004aZ-2E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBaAu-0001d3-OB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:23:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBaAu-0001bI-J6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583828619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYyMF0SYhMcB9q/PrJidBG3YyscB2bBcWXaPes19A0U=;
 b=NvOTmHqylf/iiKqaFnotfwIqz/3sBJdd/5u339hYZ5etHEgiZM5qcq4pIkPAurpxaPIHVJ
 Fcsd/lYkaD4zYcAbTBVLOVxk27JTOFWoN7G20rB1ZJPZT6wgLZiAtrVDUCkSoK0MX3A4mt
 1qZQQMnQxLdkFGNxGSoPJvjZ22ZPmVc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-qzSLJWIAODaC-KXnltu6Bw-1; Tue, 10 Mar 2020 04:23:38 -0400
X-MC-Unique: qzSLJWIAODaC-KXnltu6Bw-1
Received: by mail-qk1-f197.google.com with SMTP id t186so9158297qkh.22
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 01:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4kcjNagKtBmbwTHZG5jQmqgCDI41Q7T81jp0gK06mV8=;
 b=cbUucVJeCKhZVrtSDgYcP2jh07QTslUwf8ddXwU6AiqiSNSsALe5EY113jGfMLcg59
 IYHzJE6LTRQUz+zPNXMlaSE1hYZsUEoENu5KW1TVs0PP/ZmCp+nz1R+6BSl1qfyMlqrs
 AdhRBS8jp1Uqi88RJb1ytoq2NGkg0HaeYShtOdbnhnY3B2hOixS3rCaaUKN57gtj0hZq
 hyukdTeK8WODHbWyXC6l7KCjIpilcfdHqJmYJ+rce1VGmn+D/iHyffEdahei9uS/kM/J
 wvbdq1ilfJBuWNKDViBYxiMfES5+0WV/A4MZviIq06Uvt4g5hN0eRobkaxNPZ6hJdjsO
 7yvA==
X-Gm-Message-State: ANhLgQ0W9JXQtmttB0X3SpdvRJ1iKKwyKJW6h5taRe/shPYK94mRhjvk
 BZ0Mn19zrHGgmnGM7BpV57/e1fsheSQas/JDtkduAeLHhN+BHdtfEuhOJRGU/zHm26Xp4Pio/HH
 vWyp2gDOqHbEh0HU=
X-Received: by 2002:a05:620a:2f1:: with SMTP id
 a17mr5283092qko.438.1583828617567; 
 Tue, 10 Mar 2020 01:23:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvOk++5q56j3DIqOkp7eTpuv4mkLGC+d/+KbVhrAUCrDszy2TVOWOcuB/NnToD4hUgQ+sVD/g==
X-Received: by 2002:a05:620a:2f1:: with SMTP id
 a17mr5283075qko.438.1583828617138; 
 Tue, 10 Mar 2020 01:23:37 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id q142sm3716528qke.45.2020.03.10.01.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 01:23:35 -0700 (PDT)
Date: Tue, 10 Mar 2020 04:23:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
Subject: Re: [PATCH RESEND 2/3] vhost: fix a null pointer reference of
 vhost_log
Message-ID: <20200310042017-mutt-send-email-mst@kernel.org>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-3-longpeng2@huawei.com>
 <20200310014623-mutt-send-email-mst@kernel.org>
 <7da2b8b6-afe7-7f1f-9252-925b6bc543d8@huawei.com>
MIME-Version: 1.0
In-Reply-To: <7da2b8b6-afe7-7f1f-9252-925b6bc543d8@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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

On Tue, Mar 10, 2020 at 04:04:35PM +0800, Longpeng (Mike, Cloud Infrastruct=
ure Service Product Dept.) wrote:
>=20
>=20
> On 2020/3/10 13:57, Michael S. Tsirkin wrote:
> > On Mon, Feb 24, 2020 at 02:42:18PM +0800, Longpeng(Mike) wrote:
> >> From: Longpeng <longpeng2@huawei.com>
> >>
> >> vhost_log_alloc() may fails and returned pointer of log is null.
> >> However there're two places derefernce the return pointer without
> >> check.
> >>
> >> Signed-off-by: Longpeng <longpeng2@huawei.com>
> >> ---
> >>  hw/virtio/vhost.c | 19 +++++++++++++++++--
> >>  1 file changed, 17 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> index 9edfadc..c7ad6e5 100644
> >> --- a/hw/virtio/vhost.c
> >> +++ b/hw/virtio/vhost.c
> >> @@ -219,6 +219,10 @@ static struct vhost_log *vhost_log_get(uint64_t s=
ize, bool share)
> >> =20
> >>      if (!log || log->size !=3D size) {
> >>          log =3D vhost_log_alloc(size, share);
> >> +        if (!log) {
> >> +            return NULL;
> >> +        }
> >> +
> >>          if (share) {
> >>              vhost_log_shm =3D log;
> >>          } else {
> >> @@ -270,10 +274,17 @@ static bool vhost_dev_log_is_shared(struct vhost=
_dev *dev)
> >> =20
> >>  static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64=
_t size)
> >>  {
> >> -    struct vhost_log *log =3D vhost_log_get(size, vhost_dev_log_is_sh=
ared(dev));
> >> -    uint64_t log_base =3D (uintptr_t)log->log;
> >> +    struct vhost_log *log;
> >> +    uint64_t log_base;
> >>      int r;
> >> =20
> >> +    log =3D vhost_log_get(size, vhost_dev_log_is_shared(dev));
> >> +    if (!log) {
> >> +        return;
> >> +    }
> >> +
> >=20
> > I'm not sure silently failing like this is safe. Callers assume
> > log can be resized. What can be done? I suspect not much
> > beside exiting ...
> > Speaking of which, lots of other failures in log resizing
> > path seem to be silently ignored.
> > I guess we should propagate them, and fix callers to check
> > the return code?
> >=20
> How about to let the callers treat the failure of log_resize as a fatal e=
rror ?
>=20
> -static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t =
size)
> +static inline int vhost_dev_log_resize(struct vhost_dev *dev, uint64_t s=
ize)
>  {
> -    struct vhost_log *log =3D vhost_log_get(size, vhost_dev_log_is_share=
d(dev));
> -    uint64_t log_base =3D (uintptr_t)log->log;
> +    struct vhost_log *log;
> +    uint64_t log_base;
>      int r;
>=20
> +    log =3D vhost_log_get(size, vhost_dev_log_is_shared(dev));
> +    if (!log) {
> +        r =3D -1;
> +        goto out;
> +    }
> +
> +    log_base =3D (uintptr_t)log->log;
> +
>      /* inform backend of log switching, this must be done before
>         releasing the current log, to ensure no logging is lost */
>      r =3D dev->vhost_ops->vhost_set_log_base(dev, log_base, log);
> @@ -284,6 +296,9 @@ static inline void vhost_dev_log_resize(struct vhost_=
dev
> *dev, uint64_t size)
>      vhost_log_put(dev, true);
>      dev->log =3D log;
>      dev->log_size =3D size;
> +
> +out:
> +    return 0;
>  }
>=20
>=20
> @@ -510,7 +525,9 @@ static void vhost_commit(MemoryListener *listener)
>  #define VHOST_LOG_BUFFER (0x1000 / sizeof *dev->log)
>      /* To log more, must increase log size before table update. */
>      if (dev->log_size < log_size) {
> -        vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER);
> +        if (vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER) < 0) =
{
> +            abort();
> +        }
>      }
>      r =3D dev->vhost_ops->vhost_set_mem_table(dev, dev->mem);
>      if (r < 0) {
> @@ -518,7 +535,9 @@ static void vhost_commit(MemoryListener *listener)
>      }
>      /* To log less, can only decrease log size after table update. */
>      if (dev->log_size > log_size + VHOST_LOG_BUFFER) {
> -        vhost_dev_log_resize(dev, log_size);
> +        if (vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER) < 0) =
{
> +            abort();
> +        }
>      }
>=20
>  out:


I think the suggested handling is
=09error_report() and exit().
we also need to propagate errno. So how about passing in Error then?


> @@ -818,7 +837,11 @@ static int vhost_migration_log(MemoryListener *liste=
ner,
> int enable)
>          }
>          vhost_log_put(dev, false);
>      } else {
> -        vhost_dev_log_resize(dev, vhost_get_log_size(dev));
> +        r =3D vhost_dev_log_resize(dev, vhost_get_log_size(dev));
> +        if (r < 0) {
> +            return r;
> +        }
> +
>          r =3D vhost_dev_set_log(dev, true);
>          if (r < 0) {
>              return r;
>=20
>=20
> >=20
> > .
> >=20
>=20
> --=20
> ---
> Regards,
> Longpeng(Mike)


