Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A049C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FC520787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bexXdKXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FC520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzJu-0006Hj-Vh
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jdzJC-00053n-HC
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:53:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jdzJB-0005e9-9u
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590598416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdgpVcV25VK4wq5CaCOICvSj3CuHoAuwKa/8HsBttUI=;
 b=bexXdKXsWJ0bOUFXmHyqME2MS8hYAKyUikXusPtVTdcN1ZVTGSE71kONQUZUY9EQfmk+bO
 u8d6lPE/AfQZbXl7yYRHHqg58LnhHGyjpmUivnZEk0jtn5u1wQ9sfEMk5FeXp6eP1z42i7
 18zPODQCbc/ZzWct51bdwSRbluaiVNE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-WCddi3xNMyq6uw1n1W4Eeg-1; Wed, 27 May 2020 12:53:34 -0400
X-MC-Unique: WCddi3xNMyq6uw1n1W4Eeg-1
Received: by mail-qk1-f200.google.com with SMTP id p5so84719qkg.12
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SdgpVcV25VK4wq5CaCOICvSj3CuHoAuwKa/8HsBttUI=;
 b=UqO7rRyA/PNLAvWsOaRvoIjk6yPeSVOOu+BTEVSqIxP6nBBtwRCJ5xgcymiOrKUf/l
 UqynVO20mmKGMNlgDpLJGgYylULlCQ4lRthNKUmZnfXnn8XxecisFdY5rMEAT1fccEDD
 3OsfR+EmkroONFh+DeHKvsjrBL+dnQcFQzC/FsyfmWsmfWHpAUUN29L1/LSukxuxxlZX
 jN06GvyNKCfdw6f9/jjZ43nwg7ClsRclGKXFWouKapLKALEtTjNulQWq+Gje4CBgK5pq
 tDSIJWgYZr95sNFFjDC85WoqqcKts42FDXN5zkA6U6zV8d25d6x7yAXPeFKCGK5HmZZx
 B5jw==
X-Gm-Message-State: AOAM531mW+YRSifc45EtjL6VoiOMNvB+iSpWYdbMb3bS5F4DpO7+i8rk
 dB+RCLjCR19qq2SXFJLqxjNBtvfGsfu7wziHtz2EBMxYO6DJfEadHLT6MMGg/CXoUkkVZSDUW8q
 lOH8RKDp2ZWQVAmM=
X-Received: by 2002:a37:8883:: with SMTP id k125mr4984395qkd.14.1590598413745; 
 Wed, 27 May 2020 09:53:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgBV+42NvjJnCD76lQiizOO7MnePAVlhc2VSZtnkn8aK0ObJB2xEu2nemL6arKVOhPo30I4g==
X-Received: by 2002:a37:8883:: with SMTP id k125mr4984371qkd.14.1590598413402; 
 Wed, 27 May 2020 09:53:33 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id j5sm327696qtr.73.2020.05.27.09.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 09:53:32 -0700 (PDT)
Date: Wed, 27 May 2020 12:53:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/vfio/common: Trace in which mode a IOMMU is opened
Message-ID: <20200527165330.GG1194141@xz-x1>
References: <20200526173542.28710-1-philmd@redhat.com>
 <6c7c445d-0335-f67d-bb72-5b0c046bb247@redhat.com>
 <24f88212-9b32-b6dc-fcd4-685cde8bf5d7@redhat.com>
 <864ac8ab-e21e-393e-d1eb-08b3c4579bbf@redhat.com>
 <20200527161603.GF1194141@xz-x1>
 <3e364895-e5e5-09fe-ee8c-782f3632e2b8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3e364895-e5e5-09fe-ee8c-782f3632e2b8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 06:27:38PM +0200, Philippe Mathieu-Daudé wrote:
> On 5/27/20 6:16 PM, Peter Xu wrote:
> > On Wed, May 27, 2020 at 05:53:16PM +0200, Philippe Mathieu-Daudé wrote:
> >>>>> +    for (i = 0; i < ARRAY_SIZE(iommu); i++) {
> >>>>> +        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].type)) {
> >>>>> +            trace_vfio_get_iommu_type(iommu[i].type, iommu[i].name);
> >>>> Just wondering why you want to trace the type as you now have the name
> >>>> string.
> >>>
> >>> You are right :)
> >>>
> >>>>> +            return iommu[i].type;
> >>>>>          }
> >>>>>      }
> >>>>> +    trace_vfio_get_iommu_type(-1, "Not available or not supported");
> >>>> nit: from a debugging pov, this may be not needed as
> >>>> vfio_get_group/vfio_connect_container() fails and this leads to an error
> >>>> output.
> >>
> >> But you can reach this for example using No-IOMMU. If you don't mind, I
> >> find having this information in the trace log clearer.
> > 
> > I kinda agree with Eric - AFAICT QEMU vfio-pci don't work with no-iommu, then
> > it seems meaningless to trace it...
> > 
> > I'm not sure whether this trace is extremely helpful because syscalls like this
> > could be easily traced by things like strace or bpftrace as general tools (and
> > this information should be a one-time thing rather than dynamically changing),
> > no strong opinion though.  Also, if we want to dump something, maybe it's
> > better to do in vfio_init_container() after vfio_get_iommu_type() succeeded, so
> > we dump which container is enabled with what type of iommu.
> 
> OK. I'm a recent VFIO user so maybe I am not using the good information.
> 
> This trace helps me while working on a new device feature, I didn't
> thought about gathering it in a production because there I'd expect
> things to work.
> 
> Now in my case what I want is to know is if I'm using a v1 or v2 type.
> Maybe this information is already available in /proc or /sys and we
> don't need this patch...

I don't know such /proc or /sys, so maybe it's still useful. I guess Alex would
have the best judgement. The strace/bpftrace things are not really reasons I
found to nak this patch, but just something I thought first that could be
easier when any of us wants to peak at those information, probably something
just FYI. :-)

Thanks,

-- 
Peter Xu


