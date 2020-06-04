Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B709C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698A820738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TD68hjWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698A820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoZO-0003Mg-JD
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoYO-0002Ay-Ht
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:01:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoYN-0008QC-GG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591272058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZK/hlzhErYEyMTjYpUO/g2kS7P21Rpr+uPhT36mN0Y=;
 b=TD68hjWV/yVB5zd4MsejJ3qixErptwFDtIYTY3CVDSI4cXOdVRqT6okk5Yf1n6Ny/PVc32
 V8w3frUV6OkA9D+XOcqYjTgH87/QYaL2jTiZxS3CebUHXnCTjn+pQ1mnv8VAl3fIgkmOcV
 /A6XWIHYo3dh6ly92ATnj7T7JXGKGZM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-ZB2FyiBiNMW7ZVce15tzqw-1; Thu, 04 Jun 2020 08:00:57 -0400
X-MC-Unique: ZB2FyiBiNMW7ZVce15tzqw-1
Received: by mail-wm1-f72.google.com with SMTP id 18so1735356wmu.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 05:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3VR8K9+ws4NiWJVkQCxKLls2ryLpXnJSyiFZusq1DrM=;
 b=ubqDLnSbdx904u91BMH4IS6ACJPZR1mN3PH8aH6t/u/WyvKbxPJ4gFmhdkMZSMy20M
 GyzyGSnSbvfoN0XmBrwfnRpcNzLlOd2OdDA13gBqb8GG3kJqrgPGmTCIyaGBhU7mQy+/
 qxxpu2X66BgjD3FQmyqMCYioz9fy9w44JIhg53SFTVRILzG04qcCbvMLh91PFRwwA8J/
 G1SLXDlpFEVFESYQLnLJpYEJTs/lYJD/sSP+M3CbaiJ0Sndef6NyHxDlsLf28BzgkMBf
 izTH5mjS5bmk/RpdA1BbUGYyxMNZTXJ2CbpmoJmO4VIefee4ookgKL6J1XUSmPvjJBM3
 htLg==
X-Gm-Message-State: AOAM532g6AcygejyUMCZAcOO+dXxp6xQgXcqkCK1dhhtsBhrsK/kI1/d
 Dr282IcVvhvNPKihGrMu6Xr8z61e79oPJJ3eqqVY458CY2hX1OuFPI3mDN/soLuv1e9w6fbDDa0
 YUvV+C/v0+ZW+FNI=
X-Received: by 2002:a1c:bc0a:: with SMTP id m10mr3602204wmf.173.1591272055849; 
 Thu, 04 Jun 2020 05:00:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw51RvtbVp+FT0+zzblSffkyVLzytVN6h/jE4gEH+IY31RKupZzW3W0H/S6Uzbue4jwmz+IlQ==
X-Received: by 2002:a1c:bc0a:: with SMTP id m10mr3602186wmf.173.1591272055619; 
 Thu, 04 Jun 2020 05:00:55 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id z22sm7136414wmf.9.2020.06.04.05.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 05:00:54 -0700 (PDT)
Date: Thu, 4 Jun 2020 08:00:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3] ati-vga: check address before reading configuration
 bytes (CVE-2020-13791)
Message-ID: <20200604075931-mutt-send-email-mst@kernel.org>
References: <20200604105524.46158-1-ppandit@redhat.com>
 <20200604074539-mutt-send-email-mst@kernel.org>
 <88d6e41e-c486-4a35-af43-84018491071f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <88d6e41e-c486-4a35-af43-84018491071f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>, pbonzini@redhat.com, P J P <ppandit@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 01:56:45PM +0200, Philippe Mathieu-Daudé wrote:
> On 6/4/20 1:49 PM, Michael S. Tsirkin wrote:
> > On Thu, Jun 04, 2020 at 04:25:24PM +0530, P J P wrote:
> >> From: Prasad J Pandit <pjp@fedoraproject.org>
> >>
> >> While reading PCI configuration bytes, a guest may send an
> >> address towards the end of the configuration space. It may lead
> >> to an OOB access issue. Add check to ensure 'address + size' is
> >> within PCI configuration space.
> >>
> >> Reported-by: Ren Ding <rding@gatech.edu>
> >> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> >> Reported-by: Yi Ren <c4tren@gmail.com>
> >> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > 
> > BTW, this only happens on unaligned accesses.
> > And the IO memory region in question does not set valid.unaligned
> > or .impl.unaligned.
> > 
> > And the documentation says:
> > 
> > - .valid.unaligned specifies that the *device being modelled* supports
> >   unaligned accesses; if false, unaligned accesses will invoke the
> >   appropriate bus or CPU specific behaviour.
> > 
> > and
> > 
> > - .impl.unaligned specifies that the *implementation* supports unaligned
> >   accesses; if false, unaligned accesses will be emulated by two aligned
> >   accesses.
> > 
> > Is this then another case of a memory core bug which should have either
> > failed the access or split it?
> 
> Related:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg695362.html
> earlier comment:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg694805.html

Yea looks like more devices following documentation and memory core
doing something else instead.

> > 
> >> ---
> >>  hw/display/ati.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> Update v3: avoid modifying 'addr' variable
> >>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00834.html
> >>
> >> diff --git a/hw/display/ati.c b/hw/display/ati.c
> >> index 67604e68de..b4d0fd88b7 100644
> >> --- a/hw/display/ati.c
> >> +++ b/hw/display/ati.c
> >> @@ -387,7 +387,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
> >>          val = s->regs.crtc_pitch;
> >>          break;
> >>      case 0xf00 ... 0xfff:
> >> -        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
> >> +        if ((addr - 0xf00) + size <= pci_config_size(&s->dev)) {
> >> +            val = pci_default_read_config(&s->dev, addr - 0xf00, size);
> >> +        }
> >>          break;
> >>      case CUR_OFFSET:
> >>          val = s->regs.cur_offset;
> >> -- 
> >> 2.26.2
> > 


