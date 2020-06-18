Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76112C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413862073E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ie46W++y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413862073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlx7V-0006I7-Hx
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jlx6o-0005nj-Fm
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:09:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jlx6l-0006S6-JB
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592496581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ddPQZfi1CHcReIXsC6K7COvAuvMOndgHmlEezNDZIzc=;
 b=Ie46W++ycAmyL1Yf80kVzJJ67ft+89KF8tB0gvfooja0WkUD2dYJ55PKT0wX/+8ZbBWmJX
 a8LV2VrWqkRTyGU+zGaV4GXTRTdPplVaQlUEs4T49n+6sg7mUShG3asdYvpNhUjukAQpJZ
 4bf7nEIljYHj6v8jddrcB1Da6YHX2t8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-iylLwl_-OEC9hjYnM38L_w-1; Thu, 18 Jun 2020 12:09:35 -0400
X-MC-Unique: iylLwl_-OEC9hjYnM38L_w-1
Received: by mail-wm1-f69.google.com with SMTP id h6so1962990wmb.7
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 09:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ddPQZfi1CHcReIXsC6K7COvAuvMOndgHmlEezNDZIzc=;
 b=cPD77e0lqP/ipIdttOCqWAB3ebqtMA2vU3sLKJq30T6tDlds/dvGbsDOstroOdXHXK
 nHlpdiFhBo1S8EL1L0sBQ7ip/rZfPX8H2OZWVp30NKQPV6W/8loXc4wP8G5FLzkfjxlG
 PXAFAf6M4m4pjB2Fs/lOWmQmVqdJD4EjuY3YS1QSvU1yn2tj6L+y4mAeNiMz4i14cbh6
 1WWonL1pd2BFLDhwo4+i2NdBA5Cjjh91N5fdVGBV8o4vyfjkhqcBciYQUb0ytnFsHDiL
 1FObkRJ1RVlfnVtG+RantaD7IAbp7CusV8tPxRwA5p7kdgTIUdZlsvdRkpHkhdAstCtG
 QC0Q==
X-Gm-Message-State: AOAM532GDIkUeBzccPdNmJNf8LncmLYNpRDP4i/A4NanEU3hjEcfxUlm
 kgcuWYmKtfAa5B/vc0tKJ0C2iLT6x/DD5SwcA51MR0AuwOhYFBq5Qdeah3Sjx6pDomjGRarEKLM
 zKWigGdHOSQz1dT8=
X-Received: by 2002:a7b:cb4c:: with SMTP id v12mr4685890wmj.43.1592496574369; 
 Thu, 18 Jun 2020 09:09:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRezrsXzQQI26Lgbs4fdiqZRMXGAhuQVhgeHkAJN0lZyTNOQHnVIhJtrPNdgqMI3LgQKLu8Q==
X-Received: by 2002:a7b:cb4c:: with SMTP id v12mr4685858wmj.43.1592496574055; 
 Thu, 18 Jun 2020 09:09:34 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id j14sm4210388wrs.75.2020.06.18.09.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 09:09:33 -0700 (PDT)
Date: Thu, 18 Jun 2020 12:09:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Message-ID: <20200618120121-mutt-send-email-mst@kernel.org>
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 05:58:28PM +0200, David Hildenbrand wrote:
> On 18.06.20 17:14, Alexander Duyck wrote:
> > On Thu, Jun 18, 2020 at 5:54 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 13.06.20 22:07, Alexander Duyck wrote:
> >>> On Tue, May 26, 2020 at 9:14 PM Alexander Duyck
> >>> <alexander.duyck@gmail.com> wrote:
> >>>>
> >>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>>
> >>>> In an upcoming patch a feature named Free Page Reporting is about to be
> >>>> added. In order to avoid any confusion we should drop the use of the word
> >>>> 'report' when referring to Free Page Hinting. So what this patch does is go
> >>>> through and replace all instances of 'report' with 'hint" when we are
> >>>> referring to free page hinting.
> >>>>
> >>>> Acked-by: David Hildenbrand <david@redhat.com>
> >>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>> ---
> >>>>  hw/virtio/virtio-balloon.c         |   78 ++++++++++++++++++------------------
> >>>>  include/hw/virtio/virtio-balloon.h |   20 +++++----
> >>>>  2 files changed, 49 insertions(+), 49 deletions(-)
> >>>>
> >>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >>>> index 3e2ac1104b5f..dc15409b0bb6 100644
> >>>> --- a/hw/virtio/virtio-balloon.c
> >>>> +++ b/hw/virtio/virtio-balloon.c
> >>>
> >>> ...
> >>>
> >>>> @@ -817,14 +817,14 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
> >>>>      return 0;
> >>>>  }
> >>>>
> >>>> -static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
> >>>> +static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
> >>>>      .name = "virtio-balloon-device/free-page-report",
> >>>>      .version_id = 1,
> >>>>      .minimum_version_id = 1,
> >>>>      .needed = virtio_balloon_free_page_support,
> >>>>      .fields = (VMStateField[]) {
> >>>> -        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
> >>>> -        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
> >>>> +        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
> >>>> +        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
> >>>>          VMSTATE_END_OF_LIST()
> >>>>      }
> >>>>  };
> >>>
> >>> So I noticed this patch wasn't in the list of patches pulled, but that
> >>> is probably for the best since I believe the change above might have
> >>> broken migration as VMSTATE_UINT32 does a stringify on the first
> >>> parameter.
> >>
> >> Indeed, it's the name of the vmstate field. But I don't think it is
> >> relevant for migration. It's and indicator if a field is valid and it's
> >> used in traces/error messages.
> >>
> >> See git grep "field->name"
> >>
> >> I don't think renaming this is problematic. Can you rebase and resent?
> >> Thanks!
> > 
> > Okay, I will.
> > 
> >>> Any advice on how to address it, or should I just give up on renaming
> >>> free_page_report_cmd_id and free_page_report_status?
> >>>
> >>> Looking at this I wonder why we even need to migrate these values? It
> >>> seems like if we are completing a migration the cmd_id should always
> >>> be "DONE" shouldn't it? It isn't as if we are going to migrate the
> >>
> >> The *status* should be DONE IIUC. The cmd_id might be relevant, no? It's
> >> always incremented until it wraps.
> > 
> > The thing is, the cmd_id visible to the driver if the status is DONE
> > is the cmd_id value for DONE. So as long as the driver acknowledges
> > the value we could essentially start over the cmd_id without any
> > negative effect. The driver would have to put down a new descriptor to
> > start a block of hinting in order to begin reporting again so there
> > shouldn't be any risk of us falsely hinting pages that were in a
> > previous epoch.
> > 
> > Ugh, although now looking at it I think we might have a bug in the
> > QEMU code in that the driver could in theory force its way past a
> > "STOP" by just replaying the last command_id descriptor and then keep
> > going. Should be a pretty easy fix though as we should only allow a
> > transition to S_START if the status is S_REQUESTED/
> 
> Ugh, ...
> 
> @MST, you might have missed that in another discussion, what's your
> general opinion about removing free page hinting in QEMU (and Linux)? We
> keep finding issues in the QEMU implementation, including non-trivial
> ones, and have to speculate about the actual semantics. I can see that
> e.g., libvirt does not support it yet.

Not maintaining two similar features sounds attractive.

I'm still trying to get my head around the list of issues.  So far they
all look kind of minor to me.  Would you like to summarize them
somewhere?
The appeal of hinting is that it's 0 overhead outside migration,
and pains were taken to avoid keeping pages locked while
hypervisor is busy.

If we are to drop hinting completely we need to show that reporting
can be comparable, and we'll probably want to add a mode for
reporting that behaves somewhat similarly.

-- 
MST


