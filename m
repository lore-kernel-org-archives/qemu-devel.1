Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C94C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4718204EA
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYsQ34Yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4718204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmas-0004tv-3h
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jgmaJ-0004Sp-35
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:54:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jgmaH-0005yY-0h
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591264486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtQO1PHizJRNEjLMYPCE+ygNSPTAXbLO8rC4l0RpJc4=;
 b=ZYsQ34YuJ+PKh5IXuNxD/xq9XQNNtF9hRD5fIFZ9Nr1mVS6Bz0INqzE8MGdKmgxbnjjOI0
 TqaEN4/g7FZGeToiHQI/SHNt9SIHWoIySPgo7JsCgE1Tc9suoVQWpUaYrc0VM9eZ8YPjRm
 OH3oeTp7cRE5BUfM5UIKdeTdyKiNA6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-ceWFD_30MjKrafUAF8YRGQ-1; Thu, 04 Jun 2020 05:54:44 -0400
X-MC-Unique: ceWFD_30MjKrafUAF8YRGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CCC8A0BDC;
 Thu,  4 Jun 2020 09:54:43 +0000 (UTC)
Received: from localhost (unknown [10.40.208.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37BCD7CCC8;
 Thu,  4 Jun 2020 09:54:34 +0000 (UTC)
Date: Thu, 4 Jun 2020 11:54:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [Question] Regarding containers
 "unattached/peripheral/anonymous" - their relation with hot(un)plug of
 devices
Message-ID: <20200604115430.029c488a@redhat.com>
In-Reply-To: <ab94a6dec7b9435cbb36ca9d488a0daa@huawei.com>
References: <70446b6cbf5442488a40fe809f38c3c8@huawei.com>
 <20200124145404.1d15209e@redhat.com>
 <77dbc712482545078986adcd72567630@huawei.com>
 <20200124170645.3d794ac6@redhat.com>
 <b8fccc99d7344b2485c0db76886af9c8@huawei.com>
 <20200127160352.54f95875@redhat.com>
 <ab94a6dec7b9435cbb36ca9d488a0daa@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
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
Cc: Andrew Jones <drjones@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, pbonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 15:13:26 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Igor,
> My sincere Apologies, I just realized that I missed to reply this mail.
> I was distracted to something else in  the month of the February and
> had only resumed working on hotplug in march. But will still reply to
> this mail. Also, I have incorporated most of the below points as in the
> vcpu hotplug patches as per your suggestions.
> 
> 
> > From: Qemu-arm [mailto:qemu-arm-bounces+salil.mehta=huawei.com@nongnu.org]
> > On Behalf Of Igor Mammedov
> > Sent: Monday, January 27, 2020 3:04 PM
> > To: Salil Mehta <salil.mehta@huawei.com>
> > 
> > On Fri, 24 Jan 2020 18:44:16 +0000
> > Salil Mehta <salil.mehta@huawei.com> wrote:
> >   
> > > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > > Sent: Friday, January 24, 2020 4:07 PM
> > > >
> > > > On Fri, 24 Jan 2020 15:02:10 +0000
> > > > Salil Mehta <salil.mehta@huawei.com> wrote:
> > > >  
> > > > > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > > > > Sent: Friday, January 24, 2020 1:54 PM
> > > > > > To: Salil Mehta <salil.mehta@huawei.com>
> > > > > >
> > > > > > On Fri, 24 Jan 2020 11:20:15 +0000
> > > > > > Salil Mehta <salil.mehta@huawei.com> wrote:
> > > > > >  
> > > > > > > Hello,
> > > > > > > I am working on vCPU Hotplug feature for ARM64 and I am in mid of understanding
> > > > > > > some aspect of device_add/device_del interface of the QEMU.
> > > > > > >
> > > > > > > Observations:
> > > > > > > 1. Any object initialised by qmp_device_add() gets into /machine/unattached
> > > > > > > container. I traced the flow to code leg inside  device_set_realized()
> > > > > > > 2. I could see the reverse qmp_device_del() expects the device to be in
> > > > > > > /machine/peripheral container.
> > > > > > > 3. I could see any object initially added to unattached container did not had
> > > > > > > their parents until object_add_property_child() was called further in the leg.
> > > > > > > which effectively meant a new property was created and property table
> > > > > > > populated and child was parented.
> > > > > > > 4. Generally, container  /machine/peripheral was being used wherever
> > > > > > > DEVICE(dev)->id was present and non-null.
> > > > > > >
> > > > > > > Question:
> > > > > > > 1. Wanted to confirm my understanding about the use of having separate
> > > > > > > containers like unattached, peripheral and anonymous.  
> > > > > >  
> > > > > > > 2. At init time all the vcpus goes under *unattached* container. Now,
> > > > > > > qmp_device_del() cannot be used to unplug them. I am wondering  
> > > > > >
> > > > > > device is put into 'unattached' in case it wasn't assigned a parent.
> > > > > > Usually it happens when board creates device directly.  
> > > > >
> > > > >
> > > > > Sure, but if we decide that certain number(N) of vcpus are hotplugabble
> > > > > and certain subset of N (say 'n' < 'N') should be allowed to be present
> > > > > or cold-plugged at the init time then I wonder which of the following
> > > > > is correct approach:
> > > > >
> > > > > 1. Bring all of N vcpus at boot time under "peripheral" container
> > > > >                                    OR
> > > > > 2. Just bring subset 'n' of 'N' under "peripheral" container and rest
> > > > >     under "unattached" container? And later as and when rest of the
> > > > >     vcpus are hotplugged they should be transferred from "unattached"
> > > > >     container to "peripheral" container?  
> > > >
> > > > issue with that is that to put device into "peripheral" container,
> > > > 'the user' must provide 'id'. (currently QEMU isn't able to do it on its own
> > > > [1])
> > > >
> > > > But it doesn't mean that cold-plugged CPUs can't be unpluged.
> > > > What current users could do is start QEMU like this (simplified version):
> > > >
> > > >  $QEMU -smp 1,maxcpus=N -device foo-cpu-type,id=CPU00 -device
> > > > foo-cpu-type,id=CPU01 ...
> > > >
> > > > i.e. 1st CPU is not manageable due to lack if 'id' and is created by board code,
> > > > the rest have 'id' and could be managed.  
> > >
> > >
> > > I understand, that we can somehow assign ids from the QMP interface but
> > > above will not push vcpus into "peripheral" container. They will appear
> > > in "unattached" container but with specified names and as-far-as I can
> > > see in the code 'device_del' can only delete objects/devices from the
> > > 'peripheral' container?  
> > 
> > qemu-system-x86_64 -monitor stdio \
> >     -smp 1,maxcpus=3 \
> >     -device qemu64-x86_64-cpu,id=foo,socket-id=1,core-id=0,thread-id=0 \
> >     -device qemu64-x86_64-cpu,socket-id=2,core-id=0,thread-id=0
> > 
> > (qemu) info hotpluggable-cpus
> > Hotpluggable CPUs:
> >   type: "qemu64-x86_64-cpu"
> >   vcpus_count: "1"
> >   qom_path: "/machine/peripheral-anon/device[0]"
> >                       ^^^^^^^^^^^^^^^
> >   CPUInstance Properties:
> >     socket-id: "2"
> >     core-id: "0"
> >     thread-id: "0"
> >   type: "qemu64-x86_64-cpu"
> >   vcpus_count: "1"
> >   qom_path: "/machine/peripheral/foo"
> >                       ^^^^^^^^^^
> > 
> > in gist, if device is created with any variant of device_add,
> > it goes to "peripheral[-anon]" including cold-plugged one.  
> 
> 
> I am not sure why you said "including cold-plugged one"? I hope by
> cold-plug'ging you mean here are the CPUs which already exist at
> the boot time of the Guest VM and plugged using -device?

yes, it's about a plugged one with  '-device'

 
> >   CPUInstance Properties:
> >     socket-id: "1"
> >     core-id: "0"
> >     thread-id: "0"
> >   type: "qemu64-x86_64-cpu"
> >   vcpus_count: "1"
> >   qom_path: "/machine/unattached/device[0]"  
>                           ^^^^^^^^^^^^^
> 
> Unless you have pasted wrongly here, above output also shows qom path
> as 'unattached' for cold-plugged CPUs. Am I missing something? :)
> 
> 
> >   CPUInstance Properties:
> >     socket-id: "0"
> >     core-id: "0"
> >     thread-id: "0"  
> 
> 
> 
> > > Plus, having those many ids specified for over large number of vcpus
> > > does not looks very practical solution. We need interface like auto  
> > number of IDs is not a problem since it's usually handled by management
> > software just fine (ex: libvirt does it)
> >   
> > > Generation of ids even at the boot time. I could see from the link you
> > > have shared that it is already being used by ID_BLOCK subsystem. Can we
> > > create a new subsystem for cpus under this and do the auto Generation
> > > of vcpu ids as well?  
> > 
> > I'm not sure that auto ids was actually merged.
> > (I thought it wasn't)  
> 
> 
> Well if you were referring to below then it has been part of qemu for quite
> long now:
> 
> Patch: util - add automated ID generation utility
> File: https://github.com/qemu/qemu/blob/master/util/id.c
> Commit-id: https://github.com/qemu/qemu/commit/a0f1913637e6

Thanks, I didn't know that it eventually got merged.

> 
> > Anyway auto IDs are not directly related to enabling CPU hotplug for ARM,
> > if you feel they should be generated you can try to propose patches.  
> 
> Sure. 
> 
> 
[...]


