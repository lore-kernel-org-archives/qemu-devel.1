Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4280AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A84E2072F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgUlaNN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A84E2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigWw-0002lC-Ag
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigVn-0002Ct-UA
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:50:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52833
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigVm-0000iK-FK
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591717800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFWNxNde1vTYJgTV4lANEApKbzH0UkuyOhZZoG9ZU4c=;
 b=IgUlaNN6fVIwXYNXHTpZGqOAARBFost6qRMWqu0juE7I+PTTfxG6ZH09BEAfZjWcx4aNNF
 Fh+83npLl9mwMDt5HclIQV50QARdIIThferXcLBnisGS8NExHxwUMsSGz7ecCgogFv4w8e
 K7/O4Y4XItcArcV6QZoHTGE5HUfxjc4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-x_4dySliPr2k8jvOeOi84A-1; Tue, 09 Jun 2020 11:49:53 -0400
X-MC-Unique: x_4dySliPr2k8jvOeOi84A-1
Received: by mail-wr1-f70.google.com with SMTP id c14so8754504wrm.15
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 08:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=S1Esajda9S9e8THZ9671S8QWja5KJbJyTuMFgZ4z6/o=;
 b=HITB6rwpJpHYy3rilgIm3n9RwSqJiNAE0/vd/xhNIbrGnhqyizKiV9pe5UP1jWRQbE
 /1ouzuVDLvZVzEwn87FQDYnaJM7bA9Mp+XmKTx4hoCO+2bIvt+lg5q7gpRrcK4yVHT0A
 Jo8t8utcW6L4rGxQUYkRYZ1O9N20rn+IysThoZqOBUB2CqQ9UGMLonjaYdCst8qn+ivd
 nkwyZtKym8yKtSr7n8hERSSj9w6Sp1Iayj/XhYl1g3DqWNk4n5uDppyNF/x5TFcUjqMj
 xFc3y2FCmmsWCMRPNHhGD+3ydUJmF6AaFB7+Q72Y6GI6ofuEB0Xixn2Q61i3sxhBu0wo
 Qn7A==
X-Gm-Message-State: AOAM532yEVY0IfFKZUVC1VaKv7FD5kbs7m8caALrvwWdn4qr722rn4Z2
 69UtIBbFW4+oJqf0qDe+JPgQDDntTjP68LwKQYdq6bPSAyHNPAXcHxjWqxQE6PZtJbvgMGWsDBH
 QuZBFGh8KfZ76kAY=
X-Received: by 2002:a1c:2644:: with SMTP id m65mr4644363wmm.178.1591717792691; 
 Tue, 09 Jun 2020 08:49:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaRrjLHMh1VMl4724sasuhXwIUrZDYBKaMyIJy7dn5KLx7QkccoqsxD9NPuN3eF0XV2ZBP8Q==
X-Received: by 2002:a1c:2644:: with SMTP id m65mr4644340wmm.178.1591717792416; 
 Tue, 09 Jun 2020 08:49:52 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id j18sm3965718wrn.59.2020.06.09.08.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 08:49:51 -0700 (PDT)
Date: Tue, 9 Jun 2020 11:49:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
Message-ID: <20200609114913-mutt-send-email-mst@kernel.org>
References: <20200317195908.283800-1-peterx@redhat.com>
 <6beb4b5d-91c6-2536-64ab-18217be71134@redhat.com>
 <20200317201153.GB233068@xz-x1>
 <2847e5da-4cc3-8273-f51f-86b0995943de@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2847e5da-4cc3-8273-f51f-86b0995943de@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
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
Cc: Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 18, 2020 at 06:06:02PM +0100, Philippe Mathieu-Daudé wrote:
> On 3/17/20 9:11 PM, Peter Xu wrote:
> > On Tue, Mar 17, 2020 at 03:02:57PM -0500, Eric Blake wrote:
> > > On 3/17/20 2:59 PM, Peter Xu wrote:
> > > > Sometimes it would be good to be able to read the pin number along
> > > > with the IRQ number allocated.  Since we'll dump the IRQ number, no
> > > > reason to not dump the pin information.  For example, the vfio-pci
> > > > device will overwrite the pin with the hardware pin number.  It would
> > > > be nice to know the pin number of one assigned device from QMP/HMP.
> > > > 
> > > > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > CC: Alex Williamson <alex.williamson@redhat.com>
> > > > CC: Michael S. Tsirkin <mst@redhat.com>
> > > > CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > > CC: Julia Suvorova <jusual@redhat.com>
> > > > CC: Markus Armbruster <armbru@redhat.com>
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > > 
> > > > This helped me to debug an IRQ sharing issue, so may good to have it
> > > > in master too.
> > > 
> > > We're right at soft freeze.
> > > 
> > > 
> > > > +++ b/qapi/misc.json
> > > > @@ -403,6 +403,8 @@
> > > >    #
> > > >    # @irq: if an IRQ is assigned to the device, the IRQ number
> > > >    #
> > > > +# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
> > > > +#
> > > 
> > > But if we really do want it in 5.0, this needs a tweak.  Does the delay
> > > hurt?
> > 
> > No it won't; it's something good to have only.  I'll let the
> > maintainers to decide...
> > 
> > > 
> > > Naming convention: We prefer  unless there is a consistency
> > > issue....
> > > 
> > > >    # @qdev_id: the device name of the PCI device
> > > >    #
> > > >    # @pci_bridge: if the device is a PCI bridge, the bridge information
> > > > @@ -417,8 +419,8 @@
> > > >    { 'struct': 'PciDeviceInfo',
> > > >      'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
> > > >               'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
> > > > -           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
> > > > -           'regions': ['PciMemoryRegion']} }
> > > > +           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
> > > > +           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegion'] }}
> > > 
> > > and the pre-existing pci_bridge is indeed the consistency issue.
> > 
> > Yeh, actually every key in this struct. :)
> 
> Using 'irq-pin':
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


Peter can you fix and repost pls?

> > 
> > Thanks,
> > 


