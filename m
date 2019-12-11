Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30873C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15EC20836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="bT6yRxUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15EC20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if1nG-0000qm-RE
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1if1iW-0005Uu-GY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1if1iU-0004fq-KC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:07:48 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:43192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1if1iT-0004cF-VR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:07:46 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 0B83696EF0;
 Wed, 11 Dec 2019 12:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576068754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7c1ky3rbjTV7aYyPV6ptikkDopxg9ofpvW5Pnoq/7fY=;
 b=bT6yRxUWB/7JW1m6/pPB2zXUyvVYFkb7i8+JAPHSd1oPNaUQvPJw+VSF7egmxkzsKzmUOA
 c0IdulQ+6XCLLPXbuiK2OsvKZJ8oKdh7V0yNaQvW2J0X0ZWwr+kJfpiofaLWnVrhoGi5BU
 qFNSpG+rWBzUkG9cLdb25Z2/VRjK/Y4=
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
To: Jens Freimann <jfreimann@redhat.com>
References: <20191128182705.0635d1d4@redhat.com>
 <CAFEAcA-qA6n49KdHsGLqt422L_b_9xPfSaJB3tATQvRdfKt-xw@mail.gmail.com>
 <20191129132641.4c7da6c5@redhat.com>
 <CAFEAcA_gcxqu+N5iV0L5WLyWmm5yxTFNMtmqQryBgVd4CCCT8A@mail.gmail.com>
 <20191129200545.GG14595@habkost.net>
 <CAFEAcA-BkETOSpOwBegDcbO3bqxDO_a9xoTB7Fc8Ajw_+CDcFA@mail.gmail.com>
 <20191203214004.GS14595@habkost.net>
 <20191204091824.cwufcnlfj5vm4vqu@jenstp.localdomain>
 <20191204143537.GA498046@habkost.net>
 <20191204162125.udpzdse3zchpfinw@jenstp.localdomain>
 <20191204185106.GC498046@habkost.net>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <54dc79b4-d033-7990-2f8d-e3787a2803d8@greensocs.com>
Date: Wed, 11 Dec 2019 13:52:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191204185106.GC498046@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576068754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7c1ky3rbjTV7aYyPV6ptikkDopxg9ofpvW5Pnoq/7fY=;
 b=Gu4Gqcx8Y7cs3hHy7lMol/BIfdXYZoA7294PpGYc59+dXOoEsct4HsTu8dgLKGvMchwERP
 NtPttewjdELGafpBbktuznMxGBAQHpgb+UcpEGMzedUePfwcj7J7EeF2Q9CPcCu7C1xZ/K
 oXMoKcR/3yIhPt+k+Jnn9QJDfiYnFJo=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576068754; a=rsa-sha256; cv=none;
 b=hsQWsxnGm51RYTZJ+0nvddqeFw0FMFXVMjuTIrCKhaOY3RquPArBdLW13l2H7od3JwltJG
 sC68mW2SuEEfHQUiRawkfU7eZ4aIYVwFmnEf9urKZnptokB9dRCUYBVLp2hak16L0gnmBQ
 xC8tzu9NMyeOfxUZ6uGXeA23N4WN3/8=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/4/19 7:51 PM, Eduardo Habkost wrote:
> On Wed, Dec 04, 2019 at 05:21:25PM +0100, Jens Freimann wrote:
>> On Wed, Dec 04, 2019 at 11:35:37AM -0300, Eduardo Habkost wrote:
>>> On Wed, Dec 04, 2019 at 10:18:24AM +0100, Jens Freimann wrote:
>>>> On Tue, Dec 03, 2019 at 06:40:04PM -0300, Eduardo Habkost wrote:
>>>>> +jfreimann, +mst
>>>>>
>>>>> On Sat, Nov 30, 2019 at 11:10:19AM +0000, Peter Maydell wrote:
>>>>>> On Fri, 29 Nov 2019 at 20:05, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>>>> So, to summarize the current issues:
>>>>>>>
>>>>>>> 1) realize triggers a plug operation implicitly.
>>>>>>> 2) unplug triggers unrealize implicitly.
>>>>>>>
>>>>>>> Do you expect to see use cases that will require us to implement
>>>>>>> realize-without-plug?
>>>>>>
>>>>>> I don't think so, but only because of the oddity that
>>>>>> we put lots of devices on the 'sysbus' and claim that
>>>>>> that's plugging them into the bus. The common case of
>>>>>> 'realize' is where one device (say an SoC) has a bunch of child
>>>>>> devices (like UARTs); the SoC's realize method realizes its child
>>>>>> devices. Those devices all end up plugged into the 'sysbus'
>>>>>> but there's no actual bus there, it's fictional and about
>>>>>> the only thing it matters for is reset propagation (which
>>>>>> we don't model right either). A few devices don't live on
>>>>>> buses at all.
>>>>>
>>>>> That's my impression as well.
>>>>>
>>>>>>
>>>>>>> Similarly, do you expect use cases that will require us to
>>>>>>> implement unplug-without-unrealize?
>>>>>>
>>>>>> I don't know enough about hotplug to answer this one:
>>>>>> it's essentially what I'm hoping you'd be able to answer.
>>>>>> I vaguely had in mind that eg the user might be able to
>>>>>> create a 'disk' object, plug it into a SCSI bus, then
>>>>>> unplug it from the bus without the disk and all its data
>>>>>> evaporating, and maybe plug it back into the SCSI
>>>>>> bus (or some other SCSI bus) later ? But I don't know
>>>>>> anything about how we expose that kind of thing to the
>>>>>> user via QMP/HMP.
>>>>>
>>>>> This ability isn't exposed to the user at all.  Our existing
>>>>> interfaces are -device, device_add and device_del.
>>>>>
>>>>> We do have something new that sounds suspiciously similar to
>>>>> "unplugged but not unrealized", though: the new hidden device
>>>>> API, added by commit f3a850565693 ("qdev/qbus: add hidden device
>>>>> support").
>>>>>
>>>>> Jens, Michael, what exactly is the difference between a "hidden"
>>>>> device and a "unplugged" device?
>>>>
>>>> "hidden" the way we use it for virtio-net failover is actually unplugged. But it
>>>> doesn't have to be that way. You can register a function that decides
>>>> if the device should be hidden, i.e. plugged now, or do something else
>>>> with it (in the virtio-net failover case we just save everything we
>>>> need to plug the device later).
>>>>
>>>> We did introduce a "unplugged but not unrealized" function too as part
>>>> of the failover feature. See "a99c4da9fc pci: mark devices partially
>>>> unplugged"
>>>>
>>>> This was needed so we would be able to re-plug the device in case a
>>>> migration failed and we need to hotplug the primary device back to the
>>>> guest. To avoid the risk of not getting the resources the device needs
>>>> we don't unrealize but just trigger the unplug from the guest OS.
>>>
>>> Thanks for the explanation.  Let me confirm if I understand the
>>> purpose of the new mechanisms: should_be_hidden is a mechanism
>>> for implementing realize-without-plug.  partially_hotplugged is a
>>> mechanism for implementing unplug-without-unrealize.  Is that
>>> correct?
>>
>>
>> partially_hotplugged is a mechanism for implementing
>> unplug-without-unrealize: yes.

I'm currently trying to understand if my multi-phase reset series has
some interference with this new mechanism and I have some question.

IIUC when migration starts. the vfio-pci device is partially unplugged
using failover_unplug_primary():
> static bool failover_unplug_primary(VirtIONet *n)
> {
>     [...]
>         pci_dev->partially_hotplugged = true;
>         hotplug_handler_unplug_request(hotplug_ctrl, n->primary_dev,
>     [...]
> }

And if migration fails this same device is plugged back using
failover_replug_primary():
> static bool failover_replug_primary(VirtIONet *n, Error **errp)
> {
>     [...]
>     qdev_set_parent_bus(n->primary_dev, n->primary_bus);
>     [...]
>     hotplug_ctrl = qdev_get_hotplug_handler(n->primary_dev);
>     if (hotplug_ctrl) {
>         hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, &err);
>         if (err) {
>             goto out;
>         }
>         hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
>     }
>     [...]
> }

My concern is about the qdev_set_parent_bus() call above (because I
touch this function in my series) and don't want to have side effects there.

I looked at the code and thought the partial unplug has the effect of
cutting off the unplug procedure just before doing the qdev real unplug.
In pcie_unplug_device() we return before doing the object_unparent():
> static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, ...
>  {
>      [...]
>      if (dev->partially_hotplugged) {
>          dev->qdev.pending_deleted_event = false;
>          return;
>      }
>      hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
>      object_unparent(OBJECT(dev));
>  }

From my understanding, object_unparent() is the only way to really
unplug a device from a bus regarding qdev (and it also unrealizes the
device). So I have the feeling that qdev_set_parent_bus() here is a
no-op (because primary_dev is already on primary_bus).

Am I wrong ? Is there any other cases I missed where the primary_dev is
not already on the primary_bus when failover_replug_primary() is called ?

Thanks,
--
Damien

