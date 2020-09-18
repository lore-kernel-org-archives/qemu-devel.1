Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30446C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E1921973
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7U81oSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E1921973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCpN-00037x-Mn
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 05:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kJCo2-0001iN-5b
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kJCnx-00061w-PV
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600421744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YAzN6N8VyBY3z1Q7BdD6OG+xNZrTZ3WUsfJ/l5QOU94=;
 b=e7U81oSiJmcFX0GQgaHE5CYUIRUp4nB/k+Woa3jwV8+shc7o6kKt2pa4GmEJG1D9Fg/yTH
 Z5xrFCbGgWXEDSnbP+/1ag3lKBXMPBMEXBLigchA7V7ZzdHv2fb/2WAOYSCfzrgybxhUm+
 8J+lhBZ9vm94Q5plX+deREaOH19VW4I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-rNIB3cXjMtyENrOtxJlJKA-1; Fri, 18 Sep 2020 05:35:42 -0400
X-MC-Unique: rNIB3cXjMtyENrOtxJlJKA-1
Received: by mail-wr1-f70.google.com with SMTP id d9so1917040wrv.16
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 02:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YAzN6N8VyBY3z1Q7BdD6OG+xNZrTZ3WUsfJ/l5QOU94=;
 b=G1HyxETi+io+QoAvkxnaDYgrD3tXfn7Lylujg9tt3qLPoICjVceruyNFaauBjDF1ZC
 TlVHnvMULgnoOXcO8xiG69gGk4FtvuSaeXHmSCfFDpruhGVy19jqH9twgqXaFXHS7cy6
 gq82RMGPesSreSTKBFS3WtRuLXury0GEBoCAdn6b5C3dbbVqW8ZwxgRnZ6AJaQLWhYt8
 tRcmWQ69h5dejQimoDA+WO9ad5p44gcObWOwwrBXJEaJ0E/JJ1WPXJkXAJNGrZe+y2qZ
 DZAudqinNS2bDA/DrspgYL+TCMrqM95P4OWXVDKNXxKGoAvYo90TeBTFHcnRXe3qdiXA
 CX/w==
X-Gm-Message-State: AOAM531JkiF4cDVt9HpzAj0LzK8IU9DBUfLFq95UPFB0YiPBPH9OjZqn
 4HB2LBYfk5MT0y4bTxWSZk7PVSpPUqi1GEJn8ryxVnZodHwCA6SlWNEwLU45vOHXKQJpn5ZOM9b
 i/G8CKTP8G2N89i0=
X-Received: by 2002:adf:f203:: with SMTP id p3mr37424602wro.339.1600421741230; 
 Fri, 18 Sep 2020 02:35:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynM0n6DajPY+tWo6OV9/fzAK/WO90Z0lyCNR9dnY4QQmZfForr7LGHAmc34ngfCrQKeQ3HOQ==
X-Received: by 2002:adf:f203:: with SMTP id p3mr37424566wro.339.1600421740891; 
 Fri, 18 Sep 2020 02:35:40 -0700 (PDT)
Received: from steredhat (host-79-51-197-141.retail.telecomitalia.it.
 [79.51.197.141])
 by smtp.gmail.com with ESMTPSA id a5sm4143054wrp.37.2020.09.18.02.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 02:35:40 -0700 (PDT)
Date: Fri, 18 Sep 2020 11:35:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/4] virtio: skip legacy support check on machine
 types less than 5.1
Message-ID: <20200918093536.mwh5u46ekkfxjwgp@steredhat>
References: <20200918074710.27810-1-sgarzare@redhat.com>
 <20200918074710.27810-2-sgarzare@redhat.com>
 <20200918111342.01fd51c0.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918111342.01fd51c0.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Qian Cai <caiqian@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 11:13:42AM +0200, Cornelia Huck wrote:
> On Fri, 18 Sep 2020 09:47:07 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > Commit 9b3a35ec82 ("virtio: verify that legacy support is not accidentally
> > on") added a check that returns an error if legacy support is on, but the
> > device is not legacy.
> 
> s/is not legacy/does not support legacy/ ?
> 
> > 
> > Unfortunately some devices were wrongly declared legacy even if they
> 
> s/legacy/legacy capable/ ?
> 
> > were not (e.g vhost-vsock).
> > 
> > To avoid migration issues, we add a virtio-device property
> > (x-disable-legacy-check) to skip the legacy error, printing a warning
> > instaed, for machine types < 5.1.
> 
> s/instaed/instead/
> 

Much better, I'll fix them in v4.

> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")
> > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
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
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 807280451b..f90cfb03e3 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -103,6 +103,7 @@ struct VirtIODevice
> >      bool use_started;
> >      bool started;
> >      bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
> > +    bool disable_legacy_check;
> >      VMChangeStateEntry *vmstate;
> >      char *bus_name;
> >      uint8_t device_endian;
> > @@ -396,5 +397,6 @@ static inline bool virtio_device_disabled(VirtIODevice *vdev)
> >  }
> >  
> >  bool virtio_legacy_allowed(VirtIODevice *vdev);
> > +bool virtio_legacy_check_disabled(VirtIODevice *vdev);
> >  
> >  #endif
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index ea26d61237..b686eab798 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -44,6 +44,7 @@ GlobalProperty hw_compat_5_0[] = {
> >      { "vmport", "x-signal-unsupported-cmd", "off" },
> >      { "vmport", "x-report-vmx-type", "off" },
> >      { "vmport", "x-cmds-v2", "off" },
> > +    { "virtio-device", "x-disable-legacy-check", "true" },
> >  };
> >  const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
> >  
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > index 8feb3451a0..97a01bc48a 100644
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
> > +            warn_report("device is modern-only, but for backward "
> > +                        "compatibility legacy is allowed");
> 
> Hm...
> 
> "device requires revision >= 1, but for backward compatibility
> max_rev=0 is allowed"
> 
> seems more appropriate.

Me too, I forgot to update...

> 
> (I think I need to rethink the checking for ccw anyway.)
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
> With the message for ccw changed,
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,
Stefano


