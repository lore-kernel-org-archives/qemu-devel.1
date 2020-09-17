Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75541C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA71F204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXvQkHhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA71F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIrVP-0002fQ-SB
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kIrRt-00083H-KH
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kIrRr-00082y-0W
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600339649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fSBLuyY/4Db4479lMBDFHwguW/mwKv2RQTC1ob6bw1g=;
 b=iXvQkHhVN+W86r66zUTUs4CLQI+9XlDMGSVKiPxc+xhmSqNTdWAkw/s5x/Z8YtZYFjsVJi
 OwnJvrzvxazXq3Zm0mmYO0fizaRDZlx3XLCyYX3gF/bWU7B1VRna2SGbdgOJy3r3RofGHz
 A4gEJIPKOY8sgtHpyA1slT4N7UItfzI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-qNKOIbJTNIGXpLvyA-mTDg-1; Thu, 17 Sep 2020 06:47:26 -0400
X-MC-Unique: qNKOIbJTNIGXpLvyA-mTDg-1
Received: by mail-wr1-f71.google.com with SMTP id o6so730933wrp.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 03:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fSBLuyY/4Db4479lMBDFHwguW/mwKv2RQTC1ob6bw1g=;
 b=tXtMJRggAtA6sNLAN2mrX56R4bW5mhjTH/vId1JEFXUKNF8P9mH2/XqBLtve80XuD6
 P4C1szcmFsvhd91aICNwaZj4UKxUtrOtI5vLy7J8z8noyOZvIhXRZovELgoRkcUIJmPH
 evNBKfQrevziS61yJFGcIvkw8SlF4OT/TPFi/NTakaaOPzV5v55bYz+nNEPdfUef1SRB
 hrSwCLAAjT9m6W+7lwYYT0BZuzyjB2PJTvGTt1lvw/p/91CqHz+A3+OYI0axJ1P7wGE6
 OsepXU6aaB22U0t0HapWM/IUQC9KyjSr5tDZmzluvhcKCVtgRcazgbZHJAkxN1GV98Pj
 yhgw==
X-Gm-Message-State: AOAM532MlirQq3a0agSrOTzcKQF4kDkqjKh42qGHtcw/J3BBTtOSFEJ9
 TXpZWMlxxUpyHTrTWxxZnA6vFHz+dXQNgB5/TsrCs1e4hG3Y9iU2C7182fZO5i1U+KvRbyzqc+i
 mTox6ZZ1j0Pufsmk=
X-Received: by 2002:a5d:6cd4:: with SMTP id c20mr30514876wrc.234.1600339644952; 
 Thu, 17 Sep 2020 03:47:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGbICulSbWWCn4enX48xMwtNOdMR0J/ONywcBfL58aWgZRhStw4xlgLYbPHc7gpuZlsxRQnA==
X-Received: by 2002:a5d:6cd4:: with SMTP id c20mr30514859wrc.234.1600339644719; 
 Thu, 17 Sep 2020 03:47:24 -0700 (PDT)
Received: from steredhat (host-79-51-197-141.retail.telecomitalia.it.
 [79.51.197.141])
 by smtp.gmail.com with ESMTPSA id d83sm10788655wmf.23.2020.09.17.03.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 03:47:24 -0700 (PDT)
Date: Thu, 17 Sep 2020 12:47:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] virtio: skip legacy support check on machine types
 less than 5.1
Message-ID: <20200917104721.pbfik4t6zszflama@steredhat>
References: <20200915130514.80989-1-sgarzare@redhat.com>
 <20200916110848.47395807.cohuck@redhat.com>
 <20200917084828.p7j3fc6p4almxbxw@steredhat>
 <20200917112256.796f620d.cohuck@redhat.com>
 <20200917100000.GF2793@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200917100000.GF2793@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
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
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 11:00:00AM +0100, Dr. David Alan Gilbert wrote:
> * Cornelia Huck (cohuck@redhat.com) wrote:
> > On Thu, 17 Sep 2020 10:48:28 +0200
> > Stefano Garzarella <sgarzare@redhat.com> wrote:
> > 
> > > On Wed, Sep 16, 2020 at 11:08:48AM +0200, Cornelia Huck wrote:
> > > > On Tue, 15 Sep 2020 15:05:14 +0200
> > > > Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > >   
> > > > > Commit 9b3a35ec82 ("virtio: verify that legacy support is not accidentally
> > > > > on") added a check that returns an error if legacy support is on, but the
> > > > > device is not legacy.
> > > > > 
> > > > > Unfortunately some devices were wrongly declared legacy even if they
> > > > > were not (e.g vhost-vsock).
> > > > > 
> > > > > To avoid migration issues, we disable this error for machine types < 5.1,
> > > > > but we print a warning.
> > > > > 
> > > > > Cc: qemu-stable@nongnu.org
> > > > > Fixes: 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")
> > > > > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > ---
> > > > > v2:
> > > > >  - fixed Cornelia's e-mail address
> > > > > ---
> > > > >  include/hw/virtio/virtio.h |  1 +
> > > > >  hw/core/machine.c          |  1 +
> > > > >  hw/virtio/virtio.c         | 18 ++++++++++++++++--
> > > > >  3 files changed, 18 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > > > index 807280451b..ed7cee348b 100644
> > > > > --- a/include/hw/virtio/virtio.h
> > > > > +++ b/include/hw/virtio/virtio.h
> > > > > @@ -103,6 +103,7 @@ struct VirtIODevice
> > > > >      bool use_started;
> > > > >      bool started;
> > > > >      bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
> > > > > +    bool disable_legacy_check;
> > > > >      VMChangeStateEntry *vmstate;
> > > > >      char *bus_name;
> > > > >      uint8_t device_endian;
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index ea26d61237..b686eab798 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -44,6 +44,7 @@ GlobalProperty hw_compat_5_0[] = {
> > > > >      { "vmport", "x-signal-unsupported-cmd", "off" },
> > > > >      { "vmport", "x-report-vmx-type", "off" },
> > > > >      { "vmport", "x-cmds-v2", "off" },
> > > > > +    { "virtio-device", "x-disable-legacy-check", "true" },  
> > > > 
> > > > Hm... not sure if we actually should add a new device property for
> > > > that. Maybe we can use a flag in the base machine type instead?  
> > > 
> > > I am not very experienced with machine types.
> > > I used the device property to easily access it from virtio devices.
> > > 
> > > Please, can you give me some suggestions where to look for the flags?
> > 
> > I was thinking about adding a new virtio_legacy_check flag into
> > MachineClass to get a machine-wide config and avoid introducing a new
> > config knob. The drawback is that every machine type supporting compat
> > machines would need to take care about disabling the check in their
> > 5.1-or-older machines themselves.

Thank you for clarifying!

> > 
> > Not sure what the preferable solution is; I'm not really opposed to
> > your approach, though.
> 
> I think a device property is fine - they make it easy to add it to the
> global compat list.
>

Okay, so I'll leave the device property.


I also need to update a series [1] that I sent to force virtio version 1
on vhost-vsock devices.
Also in this case I need to care about migration and force it only on new
machine types.

Do you think I can reuse the same property also in vhost-vsock-pci and
vhost-vsock-ccw to force virtio version 1, or it is better to add a new
property for each device.

The two things (disable legacy check and force version 1) are related,
so maybe I can use a single property in the virtio-device class,

Thanks,
Stefano

[1] https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg04437.html


