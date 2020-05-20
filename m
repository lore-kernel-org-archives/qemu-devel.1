Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80745C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B7F204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLLY75AY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B7F204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbN8e-0002fK-DL
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 07:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbN84-00023v-2r
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:43:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27091
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbN80-0006hk-Vb
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589974994;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhFUkELwCuKlnZVmZfxedD+a4O3+KSRPaKl4kOh6CPc=;
 b=gLLY75AY3JypSjvmeQEaIyLA8eh2U9R9ld4nvKV0xyOC6IGCuhYdgH0L32u3L3I1K+XElx
 gbAsfH4Q360FAHUxQQGdezQWZzfZ8p0JkS8mUcX6G/FdUQS8kJ0kKbRMD5bIp/DH85p6A/
 Ac5Ip5zZa8EDDKXiNnSvrALu4S77NjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-SCYnP1aFPna70yfVRFhscA-1; Wed, 20 May 2020 07:43:13 -0400
X-MC-Unique: SCYnP1aFPna70yfVRFhscA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB44483DE2F;
 Wed, 20 May 2020 11:43:11 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1697638E;
 Wed, 20 May 2020 11:43:00 +0000 (UTC)
Date: Wed, 20 May 2020 12:42:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200520114247.GG2194189@redhat.com>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200511205352.05ff541a@redhat.com>
 <9941B800-BBEF-4DF8-BEE0-EC39D2A20D98@nutanix.com>
 <20200513214312.0dfa4752@redhat.com>
 <7FF83CE8-F25A-4458-80A7-EAA6296EF175@nutanix.com>
 <20200520114354.1982cb63@nas.mammed.net>
 <20200520054714-mutt-send-email-mst@kernel.org>
 <20200520115626.6a2a2355@nas.mammed.net>
 <20200520100628.GF2194189@redhat.com>
 <20200520072749-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200520072749-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedow <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 07:29:25AM -0400, Michael S. Tsirkin wrote:
> On Wed, May 20, 2020 at 11:06:28AM +0100, Daniel P. Berrangé wrote:
> > On Wed, May 20, 2020 at 11:56:26AM +0200, Igor Mammedow wrote:
> > > On Wed, 20 May 2020 05:47:53 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > > > On Wed, May 20, 2020 at 11:43:54AM +0200, Igor Mammedow wrote:
> > > > > On Fri, 15 May 2020 12:13:53 +0000
> > > > > Ani Sinha <ani.sinha@nutanix.com> wrote:
> > > > >   
> > > > > > > On May 14, 2020, at 1:13 AM, Igor Mammedov <imammedo@redhat.com>
> > > > > > > wrote:   
> > > > > > >> 
> > > > > > >>     
> > > > > > >>> Will following hack work for you?
> > > > > > >>> possible permutations
> > > > > > >>> 1) ACPI hotplug everywhere
> > > > > > >>> -global PIIX4_PM.acpi-pci-hotplug=on -global
> > > > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on -device
> > > > > > >>> pci-bridge,chassis_nr=1,shpc=doesnt_matter -device
> > > > > > >>> e1000,bus=pci.1,addr=01,id=netdev1 
> > > > > > >>> 
> > > > > > >>> 2) No hotplug at all
> > > > > > >>> -global PIIX4_PM.acpi-pci-hotplug=off -global
> > > > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on -device
> > > > > > >>> pci-bridge,chassis_nr=1,shpc=off -device
> > > > > > >>> e1000,bus=pci.1,addr=01,id=netdev1
> > > > > > >>> 
> > > > > > >>> -global PIIX4_PM.acpi-pci-hotplug=off -global
> > > > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off -device
> > > > > > >>> pci-bridge,chassis_nr=1,shpc=doesnt_matter  -device
> > > > > > >>> e1000,bus=pci.1,addr=01,id=netdev1      
> > > > > > >> 
> > > > > > >> Given that my patch is not acceptable, I’d prefer the
> > > > > > >> following in the order of preference:
> > > > > > >> 
> > > > > > >> (a) Have an option to disable hot ejection of PCI-PCI bridge so
> > > > > > >> that Windows does not even show this HW in the “safely remove
> > > > > > >> HW” option. If we can do this then from OS perspective the GUI
> > > > > > >> options will be same as what is available with PCIE/q35 - none
> > > > > > >> of the devices will be hot ejectable if the hot plug option is
> > > > > > >> turned off from the PCIE slots where devices are plugged into.
> > > > > > >> I looked at the code. It seems to manipulate ACPI tables of
> > > > > > >> the empty slots of the root bus where no devices are attached
> > > > > > >> (see comment "/* add hotplug slots for non present devices */
> > > > > > >> “). For cold plugged bridges, it recurses down to scan the
> > > > > > >> slots of the bridge. Is it possible to disable hot plug for
> > > > > > >> the slot to which the bridge is attached?    
> > > > > > > 
> > > > > > > I don't think it's possible to have per slot hotplug on
> > > > > > > conventional PCI hardware. it's per bridge property.    
> > > > > > 
> > > > > > We add the AMLs per empty slot though. When the pic bridge is
> > > > > > attached, we do nothing, just recurse into the bridge slots. That
> > > > > > is what I was asking, if it was possible to just disable the AMLs
> > > > > > or use some tricks to say that this particular slot is not
> > > > > > hotpluggable. I am not sure why Windows is trying to eject the
> > > > > > PCI bridge and failing. Maybe something related to this comment?
> > > > > > 
> > > > > > 
> > > > > > /* When hotplug for bridges is enabled, bridges are
> > > > > >                               
> > > > > >          * described in ACPI separately (see build_pci_bus_end).
> > > > > >                                       
> > > > > >          * In this case they aren't themselves hot-pluggable.
> > > > > >                                       
> > > > > >          * Hotplugged bridges *are* hot-pluggable.
> > > > > > */  
> > > > > 
> > > > > thinking some more on this topic, it seems that with ACPI hotplug we
> > > > > already have implicit non-hotpluggble slot (slot with bridge) while
> > > > > the rest are staying hotpluggable.
> > > > > 
> > > > > So my question is: if it's acceptable to add
> > > > > 'PCIDevice::hotpluggable" property to all PCI devices so that user
> > > > > / libvirt could set it to false in case they do not want
> > > > > coldplugged device be considered as hotpluggable? (this way other
> > > > > devices could be treated the same way as bridges)
> > > > > 
> > > > > [...]  
> > > > 
> > > > 
> > > > I think Julia already posted a patch adding this to downstream pcie
> > > > bridges. Adding this to pci slots sounds like a reasonable thing.
> > > Question was more about external interface, were we do not have ports
> > > as separate devices with conventional PCI. The only knob we have is a
> > > a PCI device, where we have a property to turn on/off hotplug. ex:
> > >   -device e1000,hotpluggable=off
> > > and if libvirt would be able to use it
> > 
> > Libvirt can certainly use a property that is settable per-device,
> > instead of against the pcie-root-port.  In fact the application
> > that requested hotplug control (KubeVirt) would strongly prefer
> > if this was doable per-device, because they really dislike the
> > idea of having to deal with pcie-root-port devices.
> > 
> > So if you added it per-device, libvirt would support both the
> > per-device option, and the pcie-root-port option.
> 
> The issue is that there then is no a way to check whether the option
> is supported on a given slot, without simply trying.
> This is why we added it on the port, there, presence of the option
> is a signal that it will work.
> Is this a concern for libvirt?

I'm not sure. What are the scenarios in which it is supported vs not
supported, as I'm unclear if they affect libvirt or not ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


