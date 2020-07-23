Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A547C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F04207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dbpill+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F04207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyadQ-0007ra-Ji
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyach-0007FY-7b
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:46:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45442
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyacf-0006Rm-Gj
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqDjNoa40RQ2D/QJ8iMwYzddlX+gaK+RJ2wPh7ag0A8=;
 b=Dbpill+sef74IxbyndWK2DfF/DyswY7XBk4ByWPzmZOiv1ucpQ19fJz7bNTA5M8UHSJC+c
 OUnmWVThzB/vrEFolw67/erd4UQqURxVR8wJEvKE5Df3Lfp1if2nKNuNRa1HZT+931qCkE
 Ad42aYhU2V1iyw17jKHe5KQbgmMv++o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-xR0QlAm-MDuYFArpp6emkA-1; Thu, 23 Jul 2020 08:46:50 -0400
X-MC-Unique: xR0QlAm-MDuYFArpp6emkA-1
Received: by mail-wr1-f69.google.com with SMTP id h4so1370901wrh.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 05:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bfHlCQjilkZPoVtutIeW5pxlXzKAg6whEOZgejSpOPU=;
 b=dUavvQudWxuDQWW6JkQ82itvqxYNP9vIKl5LMMtWm7avSj6vu5D/GewlexER4kU2ou
 g1jyX5Q8xhVKNbBKf7rER7hJGdCbUIREybHsVIkXmtxz8/8oybwRGvAEULDGELLU7gar
 cWFyo8aVkMaJnH0A7/80Xzq0dp9O9vlQa4VTynt0PV0rDRrG9q7ExB03es17sP8ArT3e
 QC0zc8JxuWR1FXbis6+g2OMBPXnWWWEQf+/dzNKq3L2/40r35AhsnTk3AWuPbJBUzL0f
 OStp6IW83qCCE/ZreChfpprygrsQws7ANgJNtvQXkC4k2f1v49BN0dSZUm7BVM69s5mN
 erhw==
X-Gm-Message-State: AOAM533LOziOGNoXaPsXzHRtJxOL7xAwQn0sLRAOYUVjA8/Bu2y46Es9
 xwReOPB4KHTtZp66g7EdzjnppWDRtOTCYtydaMkhhP7wuubKJAFaAoF86fUm72Wp5wpyq6mVN2a
 iOiexXIaoXg2i7jk=
X-Received: by 2002:a05:600c:21ca:: with SMTP id
 x10mr3950846wmj.63.1595508409502; 
 Thu, 23 Jul 2020 05:46:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKbW4gBjCJP6BzX6YO7HU8CyY8SMLqxEK1DxT1SUafX4TEFhpYxAVyAAsF7mvzYQ//neBWtg==
X-Received: by 2002:a05:600c:21ca:: with SMTP id
 x10mr3950808wmj.63.1595508409137; 
 Thu, 23 Jul 2020 05:46:49 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id p14sm3848125wrx.90.2020.07.23.05.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 05:46:48 -0700 (PDT)
Date: Thu, 23 Jul 2020 08:46:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] acpi: Fix access to PM1 control and status registers
Message-ID: <20200723084554-mutt-send-email-mst@kernel.org>
References: <20200701110549.148522-1-anthony.perard@citrix.com>
 <20200701075914-mutt-send-email-mst@kernel.org>
 <20200701124836.GD2030@perard.uk.xensource.com>
 <20200702063310-mutt-send-email-mst@kernel.org>
 <0a9c7f42-c6e3-4103-febc-3811319341d9@kaod.org>
MIME-Version: 1.0
In-Reply-To: <0a9c7f42-c6e3-4103-febc-3811319341d9@kaod.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, pbonzini@redhat.com,
 Anthony PERARD <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, "open list:PReP" <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 11:05:06AM +0200, Cédric Le Goater wrote:
> On 7/2/20 1:12 PM, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2020 at 01:48:36PM +0100, Anthony PERARD wrote:
> >> On Wed, Jul 01, 2020 at 08:01:55AM -0400, Michael S. Tsirkin wrote:
> >>> On Wed, Jul 01, 2020 at 12:05:49PM +0100, Anthony PERARD wrote:
> >>>> The ACPI spec state that "Accesses to PM1 control registers are
> >>>> accessed through byte and word accesses." (In section 4.7.3.2.1 PM1
> >>>> Control Registers of my old spec copy rev 4.0a).
> >>>>
> >>>> With commit 5d971f9e6725 ("memory: Revert "memory: accept mismatching
> >>>> sizes in memory_region_access_valid""), it wasn't possible anymore to
> >>>> access the pm1_cnt register by reading a single byte, and that is use
> >>>> by at least a Xen firmware called "hvmloader".
> >>>>
> >>>> Also, take care of the PM1 Status Registers which also have "Accesses
> >>>> to the PM1 status registers are done through byte or word accesses"
> >>>> (In section 4.7.3.1.1 PM1 Status Registers).
> >>>>
> >>>> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> >>>
> >>>
> >>> Can't we set impl.min_access_size to convert byte accesses
> >>> to word accesses?
> >>
> >> I actually tried, but when reading `addr` or `addr+1` I had the same
> >> value. So I guess `addr` wasn't taken into account.
> >>
> >> I've checked again, with `.impl.min_access_size = 2`, the width that the
> >> function acpi_pm_cnt_read() get is 2, but addr isn't changed so the
> >> function is still supposed to shift the result (or the value to write)
> >> based on addr, I guess.
> > 
> > True address is misaligned.  I think memory core should just align it -
> > this is what devices seem to expect.
> > However result is shifted properly so just align addr and be done with
> > it.
> > 
> > 
> > In fact I have a couple more questions. Paolo - maybe you can answer some of these?
> > 
> > 
> > 
> >     if (!access_size_min) {
> >         access_size_min = 1;
> >     }
> >     if (!access_size_max) {
> >         access_size_max = 4;
> >     }
> > 
> >>>>>
> > 
> > So 8 byte accesses are split up unless one requests 8 bytes.
> > Undocumented right?  Why are we doing this?
> > 
> >>>>>
> > 
> > 
> >     /* FIXME: support unaligned access? */
> > 
> >>>>>
> > 
> > Shouldn't we document impl.unaligned is ignored right now?
> > Shouldn't we do something to make sure callbacks do not get
> > unaligned accesses they don't expect?
> > 
> > 
> > In fact, there are just 2 devices which set valid.unaligned but
> > not impl.unaligned:
> >     aspeed_smc_ops
> >     raven_io_ops
> > 
> > 
> > Is this intentional? 
> 
> I think it is a leftover from the initial implementation. The model works fine 
> without valid.unaligned being set and with your patch.
> 
> C. 

Oh good, we can drop this. What about raven? Hervé could you comment pls?


> 
> > Do these in fact expect memory core to
> > provide aligned addresses to the callbacks?
> > Given impl.unaligned is not implemented, can we drop it completely?
> > Cc a bunch of people who might know.
> > 
> > Can relevant maintainers please comment? Thanks a lot!
> > 
> >>>>>
> > 
> > 
> >     access_size = MAX(MIN(size, access_size_max), access_size_min);
> >     access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> > 
> >>>>>
> > 
> > 
> > So with a 1 byte access at address 1, with impl.min_access_size = 2, we get:
> >     access_size = 2
> >     access_mask = 0xffff
> >     addr = 1
> > 
> > 
> > 
> > <<<<
> > 
> > 
> >     if (memory_region_big_endian(mr)) {
> >         for (i = 0; i < size; i += access_size) {
> >             r |= access_fn(mr, addr + i, value, access_size,
> >                         (size - access_size - i) * 8, access_mask, attrs);
> > 
> >>>>
> > 
> > now shift is -8.
> > 
> > <<<<
> > 
> > 
> >         }
> >     } else {
> >         for (i = 0; i < size; i += access_size) {
> >             r |= access_fn(mr, addr + i, value, access_size, i * 8,
> >                         access_mask, attrs);
> >         }
> >     }
> > 
> > 
> > <<<<
> > 
> > callback is invoked with addr 1 and size 2:
> > 
> >>>>>
> > 
> > 
> >     uint64_t tmp;
> > 
> >     tmp = mr->ops->read(mr->opaque, addr, size);
> >     if (mr->subpage) {
> >         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
> >     } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ)) {
> >         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
> >         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
> >     }
> >     memory_region_shift_read_access(value, shift, mask, tmp);
> >     return MEMTX_OK;
> > 
> > <<<<
> > 
> > let's assume callback returned 0xabcd
> > 
> > this is where we are shifting the return value:
> > 
> >>>>>
> > 
> > 
> > static inline void memory_region_shift_read_access(uint64_t *value,
> >                                                    signed shift,
> >                                                    uint64_t mask,
> >                                                    uint64_t tmp)
> > {
> >     if (shift >= 0) {
> >         *value |= (tmp & mask) << shift;
> >     } else {
> >         *value |= (tmp & mask) >> -shift;
> >     }
> > }
> > 
> > 
> > So we do 0xabcd & 0xffff >> 8, and we get 0xab.
> > 
> >>>>
> > 
> > How about aligning address for now? Paolo?
> > 
> > -->
> > 
> > memory: align to min access size
> > 
> > If impl.min_access_size > valid.min_access_size access callbacks
> > can get a misaligned access as size is increased.
> > They don't expect that, let's fix it in the memory core.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > 
> > 
> > diff --git a/memory.c b/memory.c
> > index 9200b20130..ea489ce405 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -532,6 +532,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
> >      }
> >  
> >      /* FIXME: support unaligned access? */
> > +    addr &= ~(access_size_min - 1);
> >      access_size = MAX(MIN(size, access_size_max), access_size_min);
> >      access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> >      if (memory_region_big_endian(mr)) {
> >> -- 
> >> Anthony PERARD
> > 


