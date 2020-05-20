Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C94C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CE720758
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpXQidi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CE720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbMwC-00048Z-Q7
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 07:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbMuz-0003M6-Pl
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:29:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbMux-0003pz-2e
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589974185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qA5iOilG7hQqv3eHXqwOF+2JkOQWt/B7T+d7HCasV5U=;
 b=EpXQidi5641yRMtZFMpnJQ2yQllf+NgW5GJSeiHjnHaNMM5Q4YLa2dpVpPcfQGb541DpuY
 J1W1UYVkfFl02mRAKBdSBSu2cLcTaWd7qKSV6es7e5CbZqJh6CDxqG39dtxtG++IbEFx2r
 xw64zIIQKV1Jc/aWYNmAwBFwjtnZpbc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-UjLwGLgiNbCBHY7izyan3A-1; Wed, 20 May 2020 07:29:29 -0400
X-MC-Unique: UjLwGLgiNbCBHY7izyan3A-1
Received: by mail-wm1-f72.google.com with SMTP id u11so793424wmc.7
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 04:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qA5iOilG7hQqv3eHXqwOF+2JkOQWt/B7T+d7HCasV5U=;
 b=kumrQ0+Zjq/cHHgal70G3Cttk5+Yzk8NlTBb7ol3COHjtKvDl5Y8iH7F1p2oUHg5+d
 3hHIXo7XxI2AYoD7JkBNaCrCJjx5yxk9MRBxmG4DYc8jSUWdn/i0szqWrBqtWl1Nmoy+
 Plhm+PmUDpFivnoF1DonckL7R4JoZHu7L2X3sYSZTC9ozOt+LWU9mNa/rlf52VrEHXiQ
 XkqA4vDDkI7RvkKNWqRjDQwv0IA1Q9WqG6seKq3TQdOWhW5zO0Se/Frs30AssFMWsjwo
 X0cmTYKA1Qp2wxZQYCbl4nW9333UfGFvK3Qhph75don9lYnApr7vpIOMw3hfn8qd4pEu
 1VMA==
X-Gm-Message-State: AOAM532L2BDN/6FP7sm+C8JotJt4e3F+CTH3FIhXXAlf0sV6577voSyR
 yXp8U2BJ22V3yKbgVArX7+4vEI9qQ1IK8Lhu7JEv/3MJ7RDvbfXwqgbdPBqBLyl/tQqnjqz7b70
 3Ab7YSmY8AFWncts=
X-Received: by 2002:a5d:660e:: with SMTP id n14mr1133572wru.221.1589974168580; 
 Wed, 20 May 2020 04:29:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmWu/882fNfPpWwFNkbM88nEyQaGZcl1YOSr69ymg/cz9IFPt20aR8VxFymLBRNNNh7y76Bw==
X-Received: by 2002:a5d:660e:: with SMTP id n14mr1133541wru.221.1589974168293; 
 Wed, 20 May 2020 04:29:28 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 j2sm2503533wrp.47.2020.05.20.04.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 04:29:27 -0700 (PDT)
Date: Wed, 20 May 2020 07:29:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200520072749-mutt-send-email-mst@kernel.org>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200511205352.05ff541a@redhat.com>
 <9941B800-BBEF-4DF8-BEE0-EC39D2A20D98@nutanix.com>
 <20200513214312.0dfa4752@redhat.com>
 <7FF83CE8-F25A-4458-80A7-EAA6296EF175@nutanix.com>
 <20200520114354.1982cb63@nas.mammed.net>
 <20200520054714-mutt-send-email-mst@kernel.org>
 <20200520115626.6a2a2355@nas.mammed.net>
 <20200520100628.GF2194189@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200520100628.GF2194189@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedow <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 11:06:28AM +0100, Daniel P. Berrangé wrote:
> On Wed, May 20, 2020 at 11:56:26AM +0200, Igor Mammedow wrote:
> > On Wed, 20 May 2020 05:47:53 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Wed, May 20, 2020 at 11:43:54AM +0200, Igor Mammedow wrote:
> > > > On Fri, 15 May 2020 12:13:53 +0000
> > > > Ani Sinha <ani.sinha@nutanix.com> wrote:
> > > >   
> > > > > > On May 14, 2020, at 1:13 AM, Igor Mammedov <imammedo@redhat.com>
> > > > > > wrote:   
> > > > > >> 
> > > > > >>     
> > > > > >>> Will following hack work for you?
> > > > > >>> possible permutations
> > > > > >>> 1) ACPI hotplug everywhere
> > > > > >>> -global PIIX4_PM.acpi-pci-hotplug=on -global
> > > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on -device
> > > > > >>> pci-bridge,chassis_nr=1,shpc=doesnt_matter -device
> > > > > >>> e1000,bus=pci.1,addr=01,id=netdev1 
> > > > > >>> 
> > > > > >>> 2) No hotplug at all
> > > > > >>> -global PIIX4_PM.acpi-pci-hotplug=off -global
> > > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on -device
> > > > > >>> pci-bridge,chassis_nr=1,shpc=off -device
> > > > > >>> e1000,bus=pci.1,addr=01,id=netdev1
> > > > > >>> 
> > > > > >>> -global PIIX4_PM.acpi-pci-hotplug=off -global
> > > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off -device
> > > > > >>> pci-bridge,chassis_nr=1,shpc=doesnt_matter  -device
> > > > > >>> e1000,bus=pci.1,addr=01,id=netdev1      
> > > > > >> 
> > > > > >> Given that my patch is not acceptable, I’d prefer the
> > > > > >> following in the order of preference:
> > > > > >> 
> > > > > >> (a) Have an option to disable hot ejection of PCI-PCI bridge so
> > > > > >> that Windows does not even show this HW in the “safely remove
> > > > > >> HW” option. If we can do this then from OS perspective the GUI
> > > > > >> options will be same as what is available with PCIE/q35 - none
> > > > > >> of the devices will be hot ejectable if the hot plug option is
> > > > > >> turned off from the PCIE slots where devices are plugged into.
> > > > > >> I looked at the code. It seems to manipulate ACPI tables of
> > > > > >> the empty slots of the root bus where no devices are attached
> > > > > >> (see comment "/* add hotplug slots for non present devices */
> > > > > >> “). For cold plugged bridges, it recurses down to scan the
> > > > > >> slots of the bridge. Is it possible to disable hot plug for
> > > > > >> the slot to which the bridge is attached?    
> > > > > > 
> > > > > > I don't think it's possible to have per slot hotplug on
> > > > > > conventional PCI hardware. it's per bridge property.    
> > > > > 
> > > > > We add the AMLs per empty slot though. When the pic bridge is
> > > > > attached, we do nothing, just recurse into the bridge slots. That
> > > > > is what I was asking, if it was possible to just disable the AMLs
> > > > > or use some tricks to say that this particular slot is not
> > > > > hotpluggable. I am not sure why Windows is trying to eject the
> > > > > PCI bridge and failing. Maybe something related to this comment?
> > > > > 
> > > > > 
> > > > > /* When hotplug for bridges is enabled, bridges are
> > > > >                               
> > > > >          * described in ACPI separately (see build_pci_bus_end).
> > > > >                                       
> > > > >          * In this case they aren't themselves hot-pluggable.
> > > > >                                       
> > > > >          * Hotplugged bridges *are* hot-pluggable.
> > > > > */  
> > > > 
> > > > thinking some more on this topic, it seems that with ACPI hotplug we
> > > > already have implicit non-hotpluggble slot (slot with bridge) while
> > > > the rest are staying hotpluggable.
> > > > 
> > > > So my question is: if it's acceptable to add
> > > > 'PCIDevice::hotpluggable" property to all PCI devices so that user
> > > > / libvirt could set it to false in case they do not want
> > > > coldplugged device be considered as hotpluggable? (this way other
> > > > devices could be treated the same way as bridges)
> > > > 
> > > > [...]  
> > > 
> > > 
> > > I think Julia already posted a patch adding this to downstream pcie
> > > bridges. Adding this to pci slots sounds like a reasonable thing.
> > Question was more about external interface, were we do not have ports
> > as separate devices with conventional PCI. The only knob we have is a
> > a PCI device, where we have a property to turn on/off hotplug. ex:
> >   -device e1000,hotpluggable=off
> > and if libvirt would be able to use it
> 
> Libvirt can certainly use a property that is settable per-device,
> instead of against the pcie-root-port.  In fact the application
> that requested hotplug control (KubeVirt) would strongly prefer
> if this was doable per-device, because they really dislike the
> idea of having to deal with pcie-root-port devices.
> 
> So if you added it per-device, libvirt would support both the
> per-device option, and the pcie-root-port option.
> 
> Regards,
> Daniel

The issue is that there then is no a way to check whether the option
is supported on a given slot, without simply trying.
This is why we added it on the port, there, presence of the option
is a signal that it will work.
Is this a concern for libvirt?


> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


