Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB78AC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DAFC2076B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is/jjkA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAFC2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKINy-0002ku-9m
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kKINI-0002Dj-PU
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:44:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42967
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kKINE-0003AB-S2
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600681479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JtIaGIRQH+XKmLToCgcjltukAzXZYnxy92kz6UYau3E=;
 b=is/jjkA4hnKuf0BjI6J5ZDUnJWyRqwU7zuWrM3jCJXACIrOAYBzm8/hicpaOA6eetyC+a9
 H5mcNQeDLXgGonHHI9x1S1+5IeKHUyj3vXNBg0z4Z551bnF9IEhc9m6+EHMtvWKEiRGlWL
 KgjIhYO0buTvJ9pnBmIkTTPgugu6+cQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-z7Zs1Z4nOn2w8a2iMaL9cg-1; Mon, 21 Sep 2020 05:44:37 -0400
X-MC-Unique: z7Zs1Z4nOn2w8a2iMaL9cg-1
Received: by mail-wm1-f71.google.com with SMTP id c200so3523855wmd.5
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 02:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JtIaGIRQH+XKmLToCgcjltukAzXZYnxy92kz6UYau3E=;
 b=WgAExnuvSu7hfnLfOnTF/NjbxRK8a7klY2v+jcOpXGyHZ7poyLnCUA+vnZwgG1Dacv
 ddEjWy7Mq5aKwvk6lfkTHTkV7sPsU8fFs6M9Ao9cF7diCwz8l3iPCm5Lu5AMsOI/ZLKo
 bZ/Jq/OUbr1/255ZiV/8TpLd4xna+jLFA78xGvT6wsCFOgs5mJj0QwxIboxsDnDoh4eL
 wzYXRnjs9BhHQkmKE844YRYdFEzlPoINij8ZBHwPCA1Lmr8td74wIhFm8sJ+/UyR+7PI
 FyPgpioGDDGgJyxWzwr9p3GpQ/rVuXs2yAFKrS9W5a0QtDCySNhnUhePSZZDef8401N/
 tIoA==
X-Gm-Message-State: AOAM532KLNmz0DT3sdwh5s9GHbAx3RojBRrzNMBGNXN8nOlm7z6UY3nj
 38W2nzfqx9JojTpfO62canOVwPLmIdCcFGofDdQxgiUcxYKIM/THJPv+P90cVaXEBw+lCYON1T0
 iBlW+n/DALDvYCXQ=
X-Received: by 2002:a1c:7308:: with SMTP id d8mr28916013wmb.55.1600681476745; 
 Mon, 21 Sep 2020 02:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3OEAJlLjjfnD4TbspwoTTAVOAYYn0hhtIzVlHhCCK99+HhceE9Vd3BEejnRh6ybcpKFZiuw==
X-Received: by 2002:a1c:7308:: with SMTP id d8mr28915983wmb.55.1600681476460; 
 Mon, 21 Sep 2020 02:44:36 -0700 (PDT)
Received: from steredhat (host-79-13-204-53.retail.telecomitalia.it.
 [79.13.204.53])
 by smtp.gmail.com with ESMTPSA id z14sm19749551wrh.14.2020.09.21.02.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 02:44:35 -0700 (PDT)
Date: Mon, 21 Sep 2020 11:44:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 1/4] virtio: skip legacy support check on machine
 types less than 5.1
Message-ID: <20200921094428.2ttnxzgtvtma3dm2@steredhat>
References: <20200921083807.48380-1-sgarzare@redhat.com>
 <20200921083807.48380-2-sgarzare@redhat.com>
 <20200921114054.75917251.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921114054.75917251.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Qian Cai <caiqian@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 11:40:54AM +0200, Cornelia Huck wrote:
> On Mon, 21 Sep 2020 10:38:04 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > Commit 9b3a35ec82 ("virtio: verify that legacy support is not accidentally
> > on") added a check that returns an error if legacy support is on, but the
> > device does not support legacy.
> > 
> > Unfortunately some devices were wrongly declared legacy capable even if
> > they were not (e.g vhost-vsock).
> > 
> > To avoid migration issues, we add a virtio-device property
> > (x-disable-legacy-check) to skip the legacy error, printing a warning
> > instead, for machine types < 5.1.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")
> > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v4:
> >  - fixed commit message and warning message [Cornelia]
> > v3:
> >  - added virtio_legacy_check_disabled() helper
> >  - moved warning where error was returned [Cornelia]
> > v2:
> >  - fixed Cornelia's e-mail address
> > ---
> >  include/hw/virtio/virtio.h |  2 ++
> >  hw/core/machine.c          |  1 +
> >  hw/s390x/virtio-ccw.c      | 15 ++++++++++++---
> >  hw/virtio/virtio-pci.c     | 14 ++++++++++++--
> >  hw/virtio/virtio.c         |  7 +++++++
> >  5 files changed, 34 insertions(+), 5 deletions(-)
> > 
> 
> (...)
> 
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > index 8feb3451a0..c534cdf2e5 100644
> > --- a/hw/s390x/virtio-ccw.c
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -1122,9 +1122,18 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
> >      }
> >  
> >      if (!virtio_ccw_rev_max(dev) && !virtio_legacy_allowed(vdev)) {
> > -        error_setg(errp, "Invalid value of property max_rev "
> > -                   "(is %d expected >= 1)", virtio_ccw_rev_max(dev));
> > -        return;
> > +        /*
> > +         * To avoid migration issues, we allow legacy mode when legacy
> > +         * check is disabled in the old machine types (< 5.1).
> > +         */
> > +        if (virtio_legacy_check_disabled(vdev)) {
> > +            warn_report("device requires revision >= 1, but for backward "
> > +                        "compatibility max_revision=0 is allowed");

I forgot to mention that I changed 'max_rev' to 'max_revision' since it
is the parameter that the user can touch.

> 
> Message looks good to me.

Thanks!

Stefano

> 
> > +        } else {
> > +            error_setg(errp, "Invalid value of property max_rev "
> > +                       "(is %d expected >= 1)", virtio_ccw_rev_max(dev));
> > +            return;
> > +        }
> >      }
> >  
> >      if (virtio_get_num_queues(vdev) > VIRTIO_QUEUE_MAX) {
> 
> (...)
> 


