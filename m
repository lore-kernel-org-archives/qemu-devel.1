Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4EAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA3320709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYT5ugBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA3320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRZz-0003Q6-S2
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbRZS-0002zA-5J
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:27:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbRZQ-0000zL-F7
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589992071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wACVE3Jj6uu4TXJSNbR6f3Xpd2Kjvwt8t7NrVlvVSgM=;
 b=aYT5ugBpekKKLAzE5YJXxi69sx3B20GiUqHtXpor/MX+GmEk2AlA/mAJi1s4Nvy/bow9VN
 dVPg0aKoCrun3ak6WGqsc97UjW/b9+6QaHtiz7rhM8nBhgXPRJkvYKf4c3D0TL1mfo/UT3
 kSz93SdbBYYYr6r2Fg/y8G3WVqwYQ8k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-yHT1guYqMH6zAwqzSMpI4g-1; Wed, 20 May 2020 12:27:48 -0400
X-MC-Unique: yHT1guYqMH6zAwqzSMpI4g-1
Received: by mail-wm1-f70.google.com with SMTP id e15so194657wme.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8ei8hcXZvxRPIcwDezsbFd4I4SeE8ZoyVUlnCYJsAXU=;
 b=YzQSnHdBqOcDcDYS+le6ZOE7aN6DnS8s6xVtoqCSXuqkdmq2/ZSeEx3Xu9nhpLs6PI
 ibCKXsktRq8lVamecm+JYBfOdyzGdGQGsIdNMBslyVs9+RN8Wp8MMJt8Tm79AF5DSNSc
 kZDbnzAkr7GjaQIzB6Z1m3hXhAIEmJCzPYPF+AJ9HcJgEAdVZRe/kA4rpB3HcyuPJ+8l
 DyHDK5db5iPS5vTQ5h1fDMJzyIGiPRo6bqjhaB+nkqHtVHO3EH6IFrb6nOQ1XEZ+5dLi
 /uV8SzKOSnh4sWlnNvY0QSi1mMplCaho8j6itlT2qVRq5HPOSraYnE5vfxJ5T7hxsWNq
 XWSw==
X-Gm-Message-State: AOAM530At8OHwp+U4INEBAfq4tx02X8x/70yr3X3os+Bod2ePM9/2YUK
 WOzr77czB4Ae9w3MZSfkp4zDQt75gCUN32sGBfuYbjswn4EO18VUyppG+ZJw9pgxjUrszY5tJPp
 qLwxapVFf6+G8tWs=
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr5294739wmh.18.1589992066610; 
 Wed, 20 May 2020 09:27:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrNxP2Qff3BdtvfKvqWij8rIlBpwZM0W1Z5qWIMrtIb850zYTuIeWzhuHZNLZAUlSwQYbpdg==
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr5294698wmh.18.1589992066267; 
 Wed, 20 May 2020 09:27:46 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 32sm3433393wrg.19.2020.05.20.09.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 09:27:45 -0700 (PDT)
Date: Wed, 20 May 2020 12:27:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
Message-ID: <20200520122421-mutt-send-email-mst@kernel.org>
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
 <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
 <67e1ba850c5fbf84b09ec8266ab70dd08a10c2e3.camel@ndufresne.ca>
 <CAD90VcaqE7PsLV=-xwWHXkct61wsiAuOCH78aLGSObfX9LqGsw@mail.gmail.com>
 <92ac2db087ccf8fae853284ecc8bdf187e292097.camel@ndufresne.ca>
 <CAPBb6MXUsMtNhxEPAdn4aTN8kNgt1eL8oLDDyNtXrD9bew_kMA@mail.gmail.com>
 <17ef7d07c50d419324a9191b216c8cc9ee95b1ae.camel@ndufresne.ca>
MIME-Version: 1.0
In-Reply-To: <17ef7d07c50d419324a9191b216c8cc9ee95b1ae.camel@ndufresne.ca>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Samiullah Khawaja <samiullah.khawaja@opensynergy.com>,
 Saket Sinha <saket.sinha89@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Kiran Pawar <Kiran.Pawar@opensynergy.com>,
 Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org,
 qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Hans Verkuil <hverkuil@xs4all.nl>, Dmitry Sepp <dmitry.sepp@opensynergy.com>,
 Emil Velikov <emil.velikov@collabora.com>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 12:21:05PM -0400, Nicolas Dufresne wrote:
> Le mercredi 20 mai 2020 à 12:19 +0900, Alexandre Courbot a écrit :
> > On Wed, May 20, 2020 at 2:29 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
> > > Le mardi 19 mai 2020 à 17:37 +0900, Keiichi Watanabe a écrit :
> > > > Hi Nicolas,
> > > > 
> > > > On Fri, May 15, 2020 at 8:38 AM Nicolas Dufresne <
> > > > nicolas@ndufresne.ca
> > > > > wrote:
> > > > > Le lundi 11 mai 2020 à 20:49 +0900, Keiichi Watanabe a écrit :
> > > > > > Hi,
> > > > > > 
> > > > > > Thanks Saket for your feedback. As Dmitry mentioned, we're focusing on
> > > > > > video encoding and decoding, not camera. So, my reply was about how to
> > > > > > implement paravirtualized video codec devices.
> > > > > > 
> > > > > > On Mon, May 11, 2020 at 8:25 PM Dmitry Sepp <
> > > > > > dmitry.sepp@opensynergy.com
> > > > > > wrote:
> > > > > > > Hi Saket,
> > > > > > > 
> > > > > > > On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> > > > > > > > Hi Keiichi,
> > > > > > > > 
> > > > > > > > I do not support the approach of  QEMU implementation forwarding
> > > > > > > > requests to the host's vicodec module since  this can limit the scope
> > > > > > > > of the virtio-video device only for testing,
> > > > > > > 
> > > > > > > That was my understanding as well.
> > > > > > 
> > > > > > Not really because the API which the vicodec provides is V4L2 stateful
> > > > > > decoder interface [1], which are also used by other video drivers on
> > > > > > Linux.
> > > > > > The difference between vicodec and actual device drivers is that
> > > > > > vicodec performs decoding in the kernel space without using special
> > > > > > video devices. In other words, vicodec is a software decoder in kernel
> > > > > > space which provides the same interface with actual video drivers.
> > > > > > Thus, if the QEMU implementation can forward virtio-video requests to
> > > > > > vicodec, it can forward them to the actual V4L2 video decoder devices
> > > > > > as well and VM gets access to a paravirtualized video device.
> > > > > > 
> > > > > > The reason why we discussed vicodec in the previous thread was it'll
> > > > > > allow us to test the virtio-video driver without hardware requirement.
> > > > > > 
> > > > > > [1]
> > > > > > https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.html
> > > > > > 
> > > > > > 
> > > > > > > > which instead can be used with multiple use cases such as -
> > > > > > > > 
> > > > > > > > 1. VM gets access to paravirtualized  camera devices which shares the
> > > > > > > > video frames input through actual HW camera attached to Host.
> > > > > > > 
> > > > > > > This use-case is out of the scope of virtio-video. Initially I had a plan to
> > > > > > > support capture-only streams like camera as well, but later the decision was
> > > > > > > made upstream that camera should be implemented as separate device type. We
> > > > > > > still plan to implement a simple frame capture capability as a downstream
> > > > > > > patch though.
> > > > > > > 
> > > > > > > > 2. If Host has multiple video devices (especially in ARM SOCs over
> > > > > > > > MIPI interfaces or USB), different VM can be started or hotplugged
> > > > > > > > with selective video streams from actual HW video devices.
> > > > > > > 
> > > > > > > We do support this in our device implementation. But spec in general has no
> > > > > > > requirements or instructions regarding this. And it is in fact flexible
> > > > > > > enough
> > > > > > > to provide abstraction on top of several HW devices.
> > > > > > > 
> > > > > > > > Also instead of using libraries like Gstreamer in Host userspace, they
> > > > > > > > can also be used inside the VM userspace after getting access to
> > > > > > > > paravirtualized HW camera devices .
> > > > > > 
> > > > > > Regarding Gstreamer, I intended this video decoding API [2]. If QEMU
> > > > > > can translate virtio-video requests to this API, we can easily support
> > > > > > multiple platforms.
> > > > > > I'm not sure how feasible it is though, as I have no experience of
> > > > > > using this API by myself...
> > > > > 
> > > > > Not sure which API you aim exactly, but what one need to remember is that
> > > > > mapping virtio-video CODEC on top of VAAPI, V4L2 Stateless, NVDEC or other type
> > > > > of "stateless" CODEC is not trivial and can't be done without userspace. Notably
> > > > > because we don't want to do bitstream parsing in the kernel on the main CPU as
> > > > > security would otherwise be very hard to guaranty. The other driver using same
> > > > > API as virtio-video do bitstream parsing on a dedicated co-processor (through
> > > > > firmware blobs though).
> > > > > 
> > > > > Having bridges between virtio-video, qemu and some abstraction library like
> > > > > FFMPEG or GStreamer is certainly the best solution if you want to virtualize any
> > > > > type of HW accelerated decoder or if you need to virtualized something
> > > > > proprietary (like NVDEC). Please shout if you need help.
> > > > > 
> > > > 
> > > > Yeah, I meant we should map virtio-video commands to a set of
> > > > abstracted userspace APIs to avoid having many platform-dependent code
> > > > in QEMU.
> > > > This is the same with what we implemented in crosvm, a VMM on
> > > > ChromiumOS. Crosvm's video device translates virtio-video commands
> > > > into our own video decoding APIs [1, 2] which supports VAAPI, V4L2
> > > > stateful and V4L2 stateless. Unfortunately, since our library is
> > > > highly depending on Chrome, we cannot reuse this for QEMU.
> > > > 
> > > > So, I agree that using FFMPEG or GStreamer is a good idea. Probably,
> > > > APIs in my previous link weren't for this purpose.
> > > > Nicolas, do you know any good references for FFMPEG or GStreamer's
> > > > abstracted video decoding APIs? Then, I may be able to think about how
> > > > virtio-video protocols can be mapped to them.
> > > 
> > > The FFMpeg API for libavcodec can be found here:
> > > 
> > >   http://git.videolan.org/?p=ffmpeg.git;a=blob;f=libavcodec/avcodec.h
> > > 
> > > GStreamer does not really have such a low level CODEC API. So while
> > > it's possible to use it (Wine project uses it for it's parsers as an
> > > example, and Firefox use to have CODEC support wrapping GStreamer
> > > CODEC), there will not be any one-to-one mapping. GStreamer is often
> > > chosen as it's LGPL code does not carry directly any patented
> > > implementation. It instead rely on plugins, which maybe provided as
> > > third party, allowing to distribute your project while giving uses the
> > > option to install potentially non-free technologies.
> > > 
> > > But overall, I can describe GStreamer API for CODEC wrapping (pipeline
> > > less) as:
> > > 
> > >   - Push GstCaps describing the stream format
> > >   - Push bitstream buffer on sink pad
> > >   - When ready, buffers will be pushed through the push function
> > >     callback on src pad
> > > 
> > > Of course nothing prevent adding something like the vda abstraction in
> > > qemu and make this multi-backend capable.
> > 
> > My understanding is that we don't need a particularly low-level API to
> > interact with. The host virtual device is receiving the whole encoded
> > data, and can thus easily reconstruct the original stream (minus the
> > container) and pass it to ffmpeg/gstreamer. So we can be pretty
> > high-level here.
> > 
> > Now the choice of API will also determine whether we want to allow
> > emulation of codec devices, or whether we stay on a purely
> > para-virtual track. If we use e.g. gstreamer, then the host can
> > provide a virtual device that is backed by a purely software
> > implementation. This can be useful for testing purposes, but for
> > real-life usage the guest would be just as well using gstreamer
> > itself.
> 
> Agreed.
> 
> > 
> > If we want to make sure that there is hardware on the host side, then
> > an API like libva might make more sense, but it would be more
> > complicated and may not support all hardware (I don't know if the V4L2
> > backends are usable for instance).
> 
> To bring VAAPI into Qemu directly you'd have to introduce bitstream
> parser, DPB management and other CODEC specific bits. I cannot speak
> for the project, but that's re-inventing the wheel again with very
> little gain. Best is to open the discussion with them early.
> 
> Note that it's relatively simple in both framework to only choose HW
> accelerated CODECs. In ffmpeg, HW accelerator codecs can only be used
> with HWContext, so your wrapper need to know specific HWContext for the
> specific accelerator. In GStreamer, since 1.16, we add a metadata that
> let the user know which decoder is hardware accelerated. (This is
> usually used to disable HW acceleration at the moment).

I don't know too much about the options here, unfortunately. But I
wonder about security implications of all these approaches.

We have this issue with other cases such as libusb where the
library we are using is not expecting hostile input so does
not validate it fully.
This is often the case for pass-through approaches.
Do all the options here expect untrusted input?


-- 
MST


