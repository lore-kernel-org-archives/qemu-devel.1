Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A99AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D399207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuWskjzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D399207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnKr-0003h7-FZ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laine@redhat.com>) id 1jbnJY-0002Mt-Ae
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:40:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27869
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <laine@redhat.com>) id 1jbnJW-0000j6-W5
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590075653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qF5RoCYSnqszjimp66eF4VRzp1kqbZYYfjPTWLG4gQ4=;
 b=OuWskjzWhJVuG34rD5hkYKSzk8C6V+KvXRnKe3oauP1USNrYzh5G7E4cqRkUPHB9jFCWVF
 twiV14SgXTx8r+9wf84H4OajyFTDZ0eJziHT1L193OQUfxEN66LAUb9h+e7zRtLficYJzC
 XLMRswKHu9DMOqnvk7RCd3u+Q7gQkwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-xoiOBXtkOf6PWnaqTllK6Q-1; Thu, 21 May 2020 11:40:52 -0400
X-MC-Unique: xoiOBXtkOf6PWnaqTllK6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 143481005510;
 Thu, 21 May 2020 15:40:49 +0000 (UTC)
Received: from [10.10.112.130] (ovpn-112-130.rdu2.redhat.com [10.10.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7635707BA;
 Thu, 21 May 2020 15:40:38 +0000 (UTC)
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <7FF83CE8-F25A-4458-80A7-EAA6296EF175@nutanix.com>
 <20200520114354.1982cb63@nas.mammed.net>
 <20200520054714-mutt-send-email-mst@kernel.org>
 <20200520115626.6a2a2355@nas.mammed.net>
 <20200520060645-mutt-send-email-mst@kernel.org>
 <20200520130547.7ac568b8@nas.mammed.net>
 <20200520072055-mutt-send-email-mst@kernel.org>
 <20200520142012.5394b2f6@nas.mammed.net>
 <20200520121043-mutt-send-email-mst@kernel.org>
 <20200521093217.4f440fbc@nas.mammed.net>
 <20200521060511-mutt-send-email-mst@kernel.org>
 <20200521152330.5958bae1@redhat.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <9fd75e93-4bd7-6a34-607d-a30ae273ccfd@redhat.com>
Date: Thu, 21 May 2020 11:40:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521152330.5958bae1@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=laine@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
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
 Ani Sinha <ani@anisinha.ca>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 9:23 AM, Igor Mammedov wrote:
> On Thu, 21 May 2020 06:07:25 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Thu, May 21, 2020 at 09:32:17AM +0200, Igor Mammedow wrote:
>>> On Wed, 20 May 2020 12:13:35 -0400
>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>    
>>>> On Wed, May 20, 2020 at 02:20:12PM +0200, Igor Mammedow wrote:
>>>>> On Wed, 20 May 2020 07:23:21 -0400
>>>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>>      
>>>>>> On Wed, May 20, 2020 at 01:05:47PM +0200, Igor Mammedow wrote:
>>>>>>> On Wed, 20 May 2020 06:28:37 -0400
>>>>>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>>>>        
>>>>>>>> On Wed, May 20, 2020 at 11:56:26AM +0200, Igor Mammedow
>>>>>>>> wrote:
>>>>>>>>> On Wed, 20 May 2020 05:47:53 -0400
>>>>>>>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>>>>>>          
>>>>>>>>>> On Wed, May 20, 2020 at 11:43:54AM +0200, Igor Mammedow
>>>>>>>>>> wrote:
>>>>>>>>>>> On Fri, 15 May 2020 12:13:53 +0000
>>>>>>>>>>> Ani Sinha <ani.sinha@nutanix.com> wrote:
>>>>>>>>>>>            
>>>>>>>>>>>>> On May 14, 2020, at 1:13 AM, Igor Mammedov
>>>>>>>>>>>>> <imammedo@redhat.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>              
>>>>>>>>>>>>>>> Will following hack work for you?
>>>>>>>>>>>>>>> possible permutations
>>>>>>>>>>>>>>> 1) ACPI hotplug everywhere
>>>>>>>>>>>>>>> -global PIIX4_PM.acpi-pci-hotplug=on -global
>>>>>>>>>>>>>>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on
>>>>>>>>>>>>>>> -device pci-bridge,chassis_nr=1,shpc=doesnt_matter
>>>>>>>>>>>>>>> -device e1000,bus=pci.1,addr=01,id=netdev1
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 2) No hotplug at all
>>>>>>>>>>>>>>> -global PIIX4_PM.acpi-pci-hotplug=off -global
>>>>>>>>>>>>>>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on
>>>>>>>>>>>>>>> -device pci-bridge,chassis_nr=1,shpc=off -device
>>>>>>>>>>>>>>> e1000,bus=pci.1,addr=01,id=netdev1
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> -global PIIX4_PM.acpi-pci-hotplug=off -global
>>>>>>>>>>>>>>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off
>>>>>>>>>>>>>>> -device pci-bridge,chassis_nr=1,shpc=doesnt_matter
>>>>>>>>>>>>>>> -device e1000,bus=pci.1,addr=01,id=netdev1
>>>>>>>>>>>>>>>        
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Given that my patch is not acceptable, I’d prefer
>>>>>>>>>>>>>> the following in the order of preference:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> (a) Have an option to disable hot ejection of
>>>>>>>>>>>>>> PCI-PCI bridge so that Windows does not even show
>>>>>>>>>>>>>> this HW in the “safely remove HW” option. If we
>>>>>>>>>>>>>> can do this then from OS perspective the GUI
>>>>>>>>>>>>>> options will be same as what is available with
>>>>>>>>>>>>>> PCIE/q35 - none of the devices will be hot
>>>>>>>>>>>>>> ejectable if the hot plug option is turned off
>>>>>>>>>>>>>> from the PCIE slots where devices are plugged
>>>>>>>>>>>>>> into. I looked at the code. It seems to manipulate
>>>>>>>>>>>>>> ACPI tables of the empty slots of the root bus
>>>>>>>>>>>>>> where no devices are attached (see comment "/* add
>>>>>>>>>>>>>> hotplug slots for non present devices */ “). For
>>>>>>>>>>>>>> cold plugged bridges, it recurses down to scan the
>>>>>>>>>>>>>> slots of the bridge. Is it possible to disable hot
>>>>>>>>>>>>>> plug for the slot to which the bridge is attached?
>>>>>>>>>>>>>>             
>>>>>>>>>>>>>
>>>>>>>>>>>>> I don't think it's possible to have per slot
>>>>>>>>>>>>> hotplug on conventional PCI hardware. it's per
>>>>>>>>>>>>> bridge property.
>>>>>>>>>>>>
>>>>>>>>>>>> We add the AMLs per empty slot though. When the pic
>>>>>>>>>>>> bridge is attached, we do nothing, just recurse into
>>>>>>>>>>>> the bridge slots. That is what I was asking, if it was
>>>>>>>>>>>> possible to just disable the AMLs or use some tricks
>>>>>>>>>>>> to say that this particular slot is not hotpluggable.
>>>>>>>>>>>> I am not sure why Windows is trying to eject the PCI
>>>>>>>>>>>> bridge and failing. Maybe something related to this
>>>>>>>>>>>> comment?
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> /* When hotplug for bridges is enabled, bridges are
>>>>>>>>>>>>                                
>>>>>>>>>>>>           * described in ACPI separately (see
>>>>>>>>>>>> build_pci_bus_end).
>>>>>>>>>>>>           * In this case they aren't themselves
>>>>>>>>>>>> hot-pluggable.
>>>>>>>>>>>>           * Hotplugged bridges *are* hot-pluggable.
>>>>>>>>>>>> */
>>>>>>>>>>>
>>>>>>>>>>> thinking some more on this topic, it seems that with
>>>>>>>>>>> ACPI hotplug we already have implicit non-hotpluggble
>>>>>>>>>>> slot (slot with bridge) while the rest are staying
>>>>>>>>>>> hotpluggable.
>>>>>>>>>>>
>>>>>>>>>>> So my question is: if it's acceptable to add
>>>>>>>>>>> 'PCIDevice::hotpluggable" property to all PCI devices so
>>>>>>>>>>> that user / libvirt could set it to false in case they
>>>>>>>>>>> do not want coldplugged device be considered as
>>>>>>>>>>> hotpluggable? (this way other devices could be treated
>>>>>>>>>>> the same way as bridges)
>>>>>>>>>>>
>>>>>>>>>>> [...]
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I think Julia already posted a patch adding this to
>>>>>>>>>> downstream pcie bridges. Adding this to pci slots sounds
>>>>>>>>>> like a reasonable thing.
>>>>>>>>> Question was more about external interface, were we do not
>>>>>>>>> have ports as separate devices with conventional PCI. The
>>>>>>>>> only knob we have is a a PCI device, where we have a
>>>>>>>>> property to turn on/off hotplug. ex: -device
>>>>>>>>> e1000,hotpluggable=off and if libvirt would be able to use
>>>>>>>>> it
>>>>>>>>
>>>>>>>> It would make sense but is it practical to add the capability
>>>>>>>> is added in a generic way to all bridges and hosts?
>>>>>>>> If not how do users probe for presence of the capability?
>>>>>>> it probably won't work with native SHPC hotplug (which looks to
>>>>>>> be incomplete in QEMU anyway), but it should work with ACPI and
>>>>>>> per port PCIE hotplugs.
>>>>>>> In case of SHPC, we probably should be able to cleanly error out
>>>>>>> with 'unsupported' reason if  "hotpluggable" conflicts with
>>>>>>> bridge policy.
>>>>>>
>>>>>> "Try it and see if it works" is somewhat problematic from
>>>>>> management POV since there's a never ending stream of new things
>>>>>> they would have to try. If this approach is taken, we'd have to
>>>>>> try to loop in some people from libvirt and see what's their
>>>>>> take.
>>>>> to clarify, we are talking here about bridges to conventional
>>>>> PCI with native SHPC hotplug semantics wrt mgmt and
>>>>> potential pcidevice.hotpluggable property.
>>>>> (the later should work fine in ACPI and PCIE hoptlug cases).
>>>>>
>>>>> currently by default pci bridges have property shpc=off, so mgmt
>>>>> should know that deals with PCI bridge and has to enable SHPC
>>>>> on bridge explicitly,
>>>>
>>>> Wait a second does that actually affect hotplug with ACPI too?
>>> What do you mean exactly?
>>
>> I just tried to figure out why do you say
>> "mgmt should know that deals with PCI bridge and has to enable SHPC
>>   on bridge explicitly,"
>> since on x86 bridges support hotplug through ACPI bypassing SHPC.
> 
> Current state in QEMU is that for ACPI hotplug, it doesn't have to do anything
> "acpi-pci-hotplug-with-bridge-support=on" by default and it's global setting for
> coldplugged bridges, also it (sort of) overrides SHPC (even if was enabled with
> 'shpc=on' on a concrete coldplugged bridge).
> (I wouldn't be surprised if mixing modes actually isn't functional)
> 
> Then there is hotplugged bridges (added at -S time or at runtime),

Aren't hotplugged bridges ignored by essentially every guest OS in 
existence? (since it requires the entire topology to be rescanned, or 
something like that - forgive my lack of knowledge about the details, I 
just remember being told "that doesn't work")

> for those
> mgmt has to set 'shpc=on' explicitly to be able to hotplug devices into it.
> (so mgmt has to know that it's dealing wants SHPC and I suppose it can be taught
> that SHPC doesn't support mixed hotplug policy on slots/devices attached to it).
> Whether mgmt actually does something with shpc or not, I have no slightest idea.
> (CCing Laine, perhaps he can clarify if we should care about SHPC here)


libvirt does nothing with shpc. It uses the bridges with whatever is the 
default setting of shpc in qemu. I recall at one time someone (Marcel 
maybe?) proposed changing the default of that setting, but don't 
remember why.


> 
> 
>>>>> in which case it could probably be taught that
>>>>> using conflicting hotpluggable for device attached to bridge and
>>>>> shpc values is wrong thing.
>>>>> If that's not it, then I'm not sure what kind of discovery you are
>>>>> talking about.
>>>>
>>>>
>>>>
>>>>    
>>
> 


