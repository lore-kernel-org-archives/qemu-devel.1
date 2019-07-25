Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F57C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 06:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3C12173E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 06:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3C12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqXO1-0005Ck-Rs
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 02:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46165)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hqXNr-0004oU-3m
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hqXNp-0003h5-LT
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:37:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hqXNp-0003gO-Eu
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:37:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so22494431pgl.11
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 23:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yFH9XAQHTL04fowA8sNGAuziUcrHu12d/1VrtDBKAw0=;
 b=KeGht3hoDHxMPnLugTN7lZBjM0D+Ht5z9UTMB/JIrD3XSI/pOEaMfncqGeo+PGI+D1
 G2b8l46metATgGCtUnsmvpLdE4hYxNeHIHNKBuZX3Cd3NjPSy9+iyOToJlSdFOUhqRgm
 J64zYVtmXxGfCFsUNhTYEtKY527CieV5hYRjCz+lJKNcu14cvoAXKds8QZXoarBxPr5r
 U+TzhDY9BcI/oMhgYGzFGCBy219vfKtWmauTrlEqJtyY6D5mnly6wBYbZtHnKqgBCh/t
 /rUg2TGBFJDYNoHSAX6+J0DsaSnKXfpztnIBDJjYixS4jzlcTpMg5wnd5Hm2wTYfJlct
 yHcg==
X-Gm-Message-State: APjAAAXZqlaEcIUur9+9Yme8UtFajIy7usVnba0X/6tTQuABT4idyZ6Y
 /VCCQ/Wk+Xf7tT/QfcwxZHVLbQ==
X-Google-Smtp-Source: APXvYqz3ZTRBOw9fORX4LdGiItJ/0GRdVPccbEkm/ITXMKSLQgVVQ1jCia8WD26On2hyXMMuAz4C3g==
X-Received: by 2002:a63:f13:: with SMTP id e19mr84585952pgl.132.1564036664174; 
 Wed, 24 Jul 2019 23:37:44 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u69sm59841400pgu.77.2019.07.24.23.37.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 23:37:43 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Thu, 25 Jul 2019 14:37:33 +0800
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190725063733.GH14454@xz-x1>
References: <155364082689.15803.7062874513041742278.stgit@gimli.home>
 <20190329104904.450fefef@x1.home>
 <dbe614f5-47c8-b05d-dd73-2fbcd1579ae3@amd.com>
 <20190723112618.0efafa8d@x1.home> <20190724071439.GB18771@xz-x1>
 <20190724040837-mutt-send-email-mst@kernel.org>
 <20190724100331.GA14454@xz-x1> <20190724084355.627d44cf@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190724084355.627d44cf@x1.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
Subject: Re: [Qemu-devel] [RFC PATCH] pci: Use PCI aliases when determining
 device IOMMU address space
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <zhexu@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 08:43:55AM -0600, Alex Williamson wrote:
> On Wed, 24 Jul 2019 18:03:31 +0800
> Peter Xu <zhexu@redhat.com> wrote:
> 
> > On Wed, Jul 24, 2019 at 05:39:22AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jul 24, 2019 at 03:14:39PM +0800, Peter Xu wrote:  
> > > > On Tue, Jul 23, 2019 at 11:26:18AM -0600, Alex Williamson wrote:  
> > > > > > On 3/29/19 11:49 AM, Alex Williamson wrote:  
> > > > > > > [Cc +Brijesh]
> > > > > > > 
> > > > > > > Hi Brijesh, will the change below require the IVRS to be updated to
> > > > > > > include aliases for all BDF ranges behind a conventional bridge?  I
> > > > > > > think the Linux code handles this regardless of the firmware provided
> > > > > > > aliases, but is it required per spec for the ACPI tables to include
> > > > > > > bridge aliases?  Thanks,
> > > > > > >     
> > > > > > 
> > > > > > We do need to includes aliases in ACPI table. We need to populate the
> > > > > > IVHD type 0x43 and 0x4 for alias range start and end. I believe host
> > > > > > IVRS would contain similar information.
> > > > > > 
> > > > > > Suravee, please correct me if I am missing something?  
> > > > > 
> > > > > I finally found some time to investigate this a little further, yes the
> > > > > types mentioned are correct for defining start and end of an alias
> > > > > range.  The challenge here is that these entries require a DeviceID,
> > > > > which is defined as a BDF, AIUI.  The IVRS is created in QEMU, but bus
> > > > > numbers are defined by the guest firmware, and potentially redefined by
> > > > > the guest OS.  This makes it non-trivial to insert a few IVHDs into the
> > > > > IVRS to describe alias ranges.  I'm wondering if the solution here is
> > > > > to define a new linker-loader command that would instruct the guest to
> > > > > write a bus number byte to a given offset for a described device.
> > > > > These commands would be inserted before the checksum command, such that
> > > > > these bus number updates are calculated as part of the checksum.
> > > > > 
> > > > > I'm imagining the command format would need to be able to distinguish
> > > > > between the actual bus number of a described device, the secondary bus
> > > > > number of the device, and the subordinate bus number of the device.
> > > > > For describing the device, I'm envisioning stealing from the DMAR
> > > > > definition, which already includes a bus number invariant mechanism to
> > > > > describe a device, starting with a segment and root bus, follow a chain
> > > > > of devfns to get to the target device.  Therefore the guest firmware
> > > > > would follow the path to the described device, pick the desired bus
> > > > > number, and write it to the indicated table offset.
> > > > > 
> > > > > Does this seem like a reasonable approach?  Better ideas?  I'm not
> > > > > thrilled with the increased scope demanded by IVRS support, but so long
> > > > > as we have an AMD IOMMU model, I don't see how to avoid it.  Thanks,  
> > > > 
> > > > I don't have a better idea yet, but just want to say that accidentally
> > > > I was trying to look into this as well starting from this week and I'd
> > > > say that's mostly what I thought about too (I was still reading a bit
> > > > seabios when I saw this email)... so at least this idea makes sense to
> > > > me.
> > > > 
> > > > Would the guest OS still change the PCI bus number even after the
> > > > firmware (BIOS/UEFI)?  Could I ask in what case would that happen?
> > > > 
> > > > Thanks,  
> > > 
> > > Guest OSes can in theory rebalance resources. Changing bus numbers
> > > would be useful if new bridges are added by hotplug.
> > > In practice at least Linux doesn't do the rebalancing.
> > > I think that if we start reporting PNP OS support in BIOS then windows
> > > might start doing that more aggressively.  
> > 
> > It's surprising me a bit...  IMHO if we allow the bus number to change
> > then at least many scripts can even fail which might work before.
> > E.g. , a very common script can run "lspci-like" program to list each
> > device and then do "lspci-like -vvv" again upon the BDF it fetched
> > from previous commands.  Any kind of BDF caching would be invalid
> > since that from either userspace or kernel.
> > 
> > Also, obviously the data to be stored in IVRS is closely bound to how
> > bus number is defined.  Even if we can add a new linker-loader command
> > to all the open firmwares like seabios or OVMF but still we can't do
> > that to Windows (or, could we?...).
> > 
> > Now one step back, I'm also curious on the reason behind on why AMD
> > spec required the IVRS with BDF information, rather than the scope
> > information like what Intel DMAR spec was asking for.
> 
> It's a deficiency of the IVRS spec, but it's really out of scope here.
> It's not the responsibility of the hypervisor to resolve this sort of
> design issue, we should simply maintain the bare metal behavior and the
> bare metal limitations of the design.

Yes this is a better perspective.  It's not the first time I totally
forgot to go back to reference the bare-metal as that's what we're
emulating and normally that'll have very similar problem.  And the
"data point" email does give a proper supporting material for this.

> 
> Michael did invoke some interesting ideas regarding QEMU updating the
> IRVS table though.  QEMU does know when bus apertures are programmed on
> devices and the config writes for these updates could trigger IVRS
> updates.  I think we'd want to allow such updates only between machine
> reset and the guest firmware writing the table checksum.  This reduces
> the scope of the necessary changes, though still feels a little messy
> to have these config writes making table updates.
> 
> Another approach, and maybe what Michael was really suggesting, is that
> we essentially create the ACPI tables twice AFAICT.  Once initially,
> then again via a select callback in fw_cfg.  For SeaBIOS, it looks like
> this second generation would be created after the PCI bus has been
> enumerated and initialized.  I've been trying to see if the same is
> likely for OVMF, though it's not clear to me that this is a reasonable
> ordering to rely on.  It would be entirely reasonable that firmware
> could process ACPI tables in advance of enumerating PCI, even
> potentially as a prerequisite to enumerating PCI.  So ultimately I'm not
> sure if there are valid ordering assumptions to use these callbacks
> this way, though I'd appreciate any further discussion.  Thanks,

After re-read Michael's reply, I feel like what Michael suggested is
that we can simply ignore the bus-number-change case by the guest OS
for now, but I might be wrong.  In all cases, this will be a problem
only if "we still need to fill in the BDF information" somehow, while
that statement seems to be questionable now.

Thanks,

-- 
Peter Xu

