Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7366FC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F3A20770
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX8WdHC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F3A20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIpcD-0003Xu-Hg
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kIpao-0002fK-3a
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kIpam-0000s7-8H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600332515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=weF61XmpHvhR4ykJW3ekkdBp80Ji+s/5+mFziiNXn4Y=;
 b=VX8WdHC/Ed1yQ14YKFBbfhCbj1kwrmqEKLcCszFLU8wOjIF49ykGrQP4+GVuntDQojX8hr
 caCnD80w15PwSoLOv51O894j5BJujDZiEvO/Ww3Nc6vSyMkP+Z3q+6wrpbAFc0SZLm9WE0
 nol0A2cDjU+PRaug0aUuWP5xftWuu6A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-ZragheoOPDWdkEkfZuLE0w-1; Thu, 17 Sep 2020 04:48:33 -0400
X-MC-Unique: ZragheoOPDWdkEkfZuLE0w-1
Received: by mail-wr1-f71.google.com with SMTP id j7so606026wro.14
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 01:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=weF61XmpHvhR4ykJW3ekkdBp80Ji+s/5+mFziiNXn4Y=;
 b=JDCX3X8TDoAANjjA1EXhyWMeF9Ft0Fo7oFHA+OpLFJI60DhR6TtWq3bx/OFI9exwuB
 3TNW/9c6WkvNQlgML3FpfnXhYlY0YBCqQahh6uhG/PZjt6udLnBJy9zYPm1uRpZffkef
 /mrkdnP8CmDvQ1MIE7BL1H9TxjVamwrP0/AOemxzhU6OjaVG3YxElkpyq8LnMJU4I4+p
 u+6uLUG8q+CYpgLCv57l53fJ56NED0NqgIcICSDxtiRvVp7fEZgLuD8rYHp9E9TOG7By
 nVqx7Uuj+8IxiUTlPE3jguNl8jwmcnSXLwfifS7DnJ6gjgvTk5GRngbc9c/PAoWKKR2s
 Qi2w==
X-Gm-Message-State: AOAM533CfEA3YC1AfIKjYzLUm8U4/1CGxf6WUkRVeLrwzaOK/DlVG+w+
 r/+BBz8gzEG3BYP/NDfPgntXGHP75GOB1C4YbHyv5W5vsNEcbJeZnDI4gh3kLiJEJWEAmqe5aMg
 Gm+k80pzdXWQ+j3o=
X-Received: by 2002:adf:f382:: with SMTP id m2mr29569261wro.327.1600332512003; 
 Thu, 17 Sep 2020 01:48:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRvVG939CDbZ4TKTzwezaGxgW+kigl31H1brPHXaoLEkKbJG944tywUGljw6EGINHLeHchvA==
X-Received: by 2002:adf:f382:: with SMTP id m2mr29569227wro.327.1600332511643; 
 Thu, 17 Sep 2020 01:48:31 -0700 (PDT)
Received: from steredhat (host-79-51-197-141.retail.telecomitalia.it.
 [79.51.197.141])
 by smtp.gmail.com with ESMTPSA id l126sm9623330wmf.39.2020.09.17.01.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 01:48:31 -0700 (PDT)
Date: Thu, 17 Sep 2020 10:48:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] virtio: skip legacy support check on machine types
 less than 5.1
Message-ID: <20200917084828.p7j3fc6p4almxbxw@steredhat>
References: <20200915130514.80989-1-sgarzare@redhat.com>
 <20200916110848.47395807.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200916110848.47395807.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 11:08:48AM +0200, Cornelia Huck wrote:
> On Tue, 15 Sep 2020 15:05:14 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > Commit 9b3a35ec82 ("virtio: verify that legacy support is not accidentally
> > on") added a check that returns an error if legacy support is on, but the
> > device is not legacy.
> > 
> > Unfortunately some devices were wrongly declared legacy even if they
> > were not (e.g vhost-vsock).
> > 
> > To avoid migration issues, we disable this error for machine types < 5.1,
> > but we print a warning.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")
> > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v2:
> >  - fixed Cornelia's e-mail address
> > ---
> >  include/hw/virtio/virtio.h |  1 +
> >  hw/core/machine.c          |  1 +
> >  hw/virtio/virtio.c         | 18 ++++++++++++++++--
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 807280451b..ed7cee348b 100644
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
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index ea26d61237..b686eab798 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -44,6 +44,7 @@ GlobalProperty hw_compat_5_0[] = {
> >      { "vmport", "x-signal-unsupported-cmd", "off" },
> >      { "vmport", "x-report-vmx-type", "off" },
> >      { "vmport", "x-cmds-v2", "off" },
> > +    { "virtio-device", "x-disable-legacy-check", "true" },
> 
> Hm... not sure if we actually should add a new device property for
> that. Maybe we can use a flag in the base machine type instead?

I am not very experienced with machine types.
I used the device property to easily access it from virtio devices.

Please, can you give me some suggestions where to look for the flags?

> 
> >  };
> >  const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
> >  
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index e983025217..30ccc43b8c 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3287,6 +3287,8 @@ void virtio_init(VirtIODevice *vdev, const char *name,
> >   */
> >  bool virtio_legacy_allowed(VirtIODevice *vdev)
> >  {
> > +    bool ret = false;
> > +
> >      switch (vdev->device_id) {
> >      case VIRTIO_ID_NET:
> >      case VIRTIO_ID_BLOCK:
> > @@ -3298,10 +3300,20 @@ bool virtio_legacy_allowed(VirtIODevice *vdev)
> >      case VIRTIO_ID_9P:
> >      case VIRTIO_ID_RPROC_SERIAL:
> >      case VIRTIO_ID_CAIF:
> > +        ret = true;
> > +    }
> > +
> > +    /*
> > +     * For backward compatibility, we allow legacy mode with old machine types
> > +     * to get the migration working.
> > +     */
> > +    if (!ret && vdev->disable_legacy_check) {
> > +        warn_report("device is modern-only, but for backward compatibility "
> > +                    "legacy is allowed");
> 
> I don't think we should warn in the function that returns whether
> legacy is allowed or not. Future code might want to call this function
> for other purposes, and returning true with a warning is not that
> useful for code that wants to find out whether legacy is supported for
> a type in principle.
> 
> So even though it is more work, I think we should move this warning to
> the code that is actively trying to fence off misconfigured devices.

Yes, I got it. At first I did so, but then I wanted to reduce the
duplicate code.

But you're right, it's ugly.
I'll send a v3.

Thanks,
Stefano


