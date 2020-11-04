Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DB5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855E8206F1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/abU7He"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855E8206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMnr-0005HG-Gz
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kaMe5-0002c0-Fo
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:32:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kaMe2-0000d1-EO
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604511145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+8Ct4kzZTAUsLj8jIdH01adFGXevut1XjH40h4SvAY=;
 b=R/abU7HedqHwXxEVn5YQz/omBugGYxYAY6Arl0LeLbVQ8rxNaG1pQ1FfPdOm+onp1KYP0B
 Xgm02/zdZLaOt74MFJstw/9KjHQx9nqHY/JApymr7zIAI2cSEkTLbQG1y7nz5o5uzUUtzW
 GjGieoFrw3zV8aX/fausMSD67AqGf/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-Z9tZQF0FMhWqDXNN_UWrlQ-1; Wed, 04 Nov 2020 12:32:21 -0500
X-MC-Unique: Z9tZQF0FMhWqDXNN_UWrlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7E696D256;
 Wed,  4 Nov 2020 17:32:19 +0000 (UTC)
Received: from work-vm (ovpn-115-11.ams2.redhat.com [10.36.115.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9784C78800;
 Wed,  4 Nov 2020 17:32:05 +0000 (UTC)
Date: Wed, 4 Nov 2020 17:32:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201104173202.GG3896@work-vm>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201103121709.GD3566@work-vm>
 <20201103152752.GC253848@stefanha-x1.localdomain>
 <20201103184951.GM3566@work-vm>
 <20201104073636.GB390503@stefanha-x1.localdomain>
 <20201104101423.GB3896@work-vm>
 <20201104164744.GC425016@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201104164744.GC425016@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John G Johnson <john.g.johnson@oracle.com>, mtsirkin@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Wed, Nov 04, 2020 at 10:14:23AM +0000, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > On Tue, Nov 03, 2020 at 06:49:51PM +0000, Dr. David Alan Gilbert wrote:
> > > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > > On Tue, Nov 03, 2020 at 12:17:09PM +0000, Dr. David Alan Gilbert wrote:
> > > > > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > > > > Device Models
> > > > > > > -------------
> > > > > > > Devices have a *hardware interface* consisting of hardware registers,
> > > > > > > interrupts, and so on.
> > > > > > > 
> > > > > > > The hardware interface together with the device state representation is called
> > > > > > > a *device model*. Device models can be assigned URIs such as
> > > > > > > https://qemu.org/devices/e1000e to uniquely identify them.
> > > > > > 
> > > > > > I think this is a unique identifier, not actually a URI; the https://
> > > > > > isn't needed since no one expects to ever connect to this.
> > > > > 
> > > > > Yes, it could be any unique string. If the URI idea is not popular we
> > > > > can use any similar scheme.
> > > > 
> > > > I'm OK with it being a URI; just drop the https.
> > > 
> > > Okay.
> > > 
> > > > > > > However, secondary aspects related to the physical port may affect the device's
> > > > > > > hardware interface and need to be reflected in the device configuration. The
> > > > > > > link speed may depend on the physical port and be reported through the device's
> > > > > > > hardware interface. In that case a ``link-speed`` configuration parameter is
> > > > > > > required to prevent unexpected changes to the link speed after migration.
> > > > > > 
> > > > > > That's an interesting example; because depending on the device, it might
> > > > > > be:
> > > > > >     a) Completely virtualised so that the guest *shouldn't* know what
> > > > > > the physical link speed is, precisely to allow the physical network on
> > > > > > the destination to be different.
> > > > > > 
> > > > > >     b) Part of the migrated state
> > > > > > 
> > > > > >     c) Something that's allowed to be reloaded after migration
> > > > > > 
> > > > > >     d) Configurable
> > > > > > 
> > > > > > so I'm not sure whether it's a good example in this case or not.
> > > > > 
> > > > > Can you think of an example that has only one option?
> > > > > 
> > > > > I tried but couldn't. For example take a sound card. The guest is aware
> > > > > the device supports stereo playback (2 output channels), but which exact
> > > > > stereo host device is used doesn't matter, they are all suitable.
> > > > > 
> > > > > Now imagine migrating to a 7.1 surround-sound device. Similar options
> > > > > come into play:
> > > > > 
> > > > > a) Emulate stereo and mix it to 7.1 surround-sound on the physical
> > > > >    device. The guest still sees the stereo device.
> > > > > 
> > > > > b) Refuse migration.
> > > > > 
> > > > > c) Indicate that the output has switched and let the guest reconfigure
> > > > >    itself (e.g. a sound card with multiple outputs, where one of them is
> > > > >    stereo and another is 7.1 surround sound).
> > > > > 
> > > > > Which option is desirable depends on the use case.
> > > > 
> > > > Yes, but I think it might be worth calling out these differences;  there
> > > > are explicitly cases where you don't want external changes to be visible
> > > > and other cases where you do; both are valid, but both need thinking
> > > > about. (Another one, GPU whether you have a monitor plugged in!)
> > > 
> > > Okay.
> > > 
> > > > > > Maybe what's needed is a stronger instruction to abstract external
> > > > > > device state so that it's not part of the configuration in most cases.
> > > > > 
> > > > > Do you want to propose something?
> > > > 
> > > > I think something like 'Some part of a devices state may be irrelevant
> > > > to a migration; for example on some NICs it might be preferable to hide
> > > > the physical characteristics of the link from the guest.'
> > > 
> > > Got it.
> > > 
> > > > > > > For example, if address filtering support was added to a network card then
> > > > > > > device versions and the corresponding configurations may look like this:
> > > > > > > * ``version=1`` - Behaves as if ``rx-filter-size=0``
> > > > > > > * ``version=2`` - ``rx-filter-size=32``
> > > > > > 
> > > > > > Note configuration parameters might have been added during the life of
> > > > > > the device; e.g. if the original card had no support for rx-filters, it
> > > > > > might not have a rx-filter-size parameter.
> > > > > 
> > > > > version=1 does not explicitly set rx-filter-size=0. When a new parameter
> > > > > is introduced it must have a default value that disables its effect on
> > > > > the hardware interface and/or device state representation. This is
> > > > > described in a bit more detail in the next section, maybe it should be
> > > > > reordered.
> > > > 
> > > > We've generally found the definition of devices tends in practice to be
> > > > done newer->older; i.e. you define the current machine, and then define
> > > > the next older machine setting the defaults that used to be true; then
> > > > define the older version behind that....
> > > 
> > > That is not possible here because an older device implementation is
> > > unaware of new configuration parameters.
> > > 
> > > Looking at the example above, imagine a version=1 device is instantiated
> > > on a device implementation that supports both version=1 and version=2.
> > > Should the configuration parameter list for version=1 be empty or
> > > rx-filter-size=0?
> > > 
> > > It must to be empty, otherwise an older device implementation that only
> > > supports version=1 cannot instantiate the device. The older device
> > > implementation does not recognize the rx-filter-size configuration
> > > parameter (it was introduced in version=2) so we cannot set it to 0.
> > 
> > I think this question might come down to who expands the device version
> > definition.
> > If it's the device itself that expands that, then a version 2 device
> > knows about what it needs to do for version 1 compatibility.
> > But if you're saying someone outside the device needs to be able to
> > expand that list then I'm not sure how you'd keep that expansion in line
> > with the implementation of a device.
> 
> The current approach is that the version is expanded into configuration
> parameters when the device is instantiated. Those parameters are then
> used to check migration compatibility of the destination (versions don't
> play a role once the device has been created).
> 
> Michael replied in another sub-thread wondering if versions are really
> necessary since tools do the migration checks. Let's try dropping
> versions to simplify things. We can bring them back if needed later.

What does a user facing tool do?  If I say I want one of these NICs
and I'm on the latest QEMU machine type, who sets all these parameters?

Dave

> > > > > > > Device States
> > > > > > > -------------
> > > > > > > The details of the device state representation are not covered in this document
> > > > > > > but the general requirements are discussed here.
> > > > > > > 
> > > > > > > The device state consists of data accessible through the device's hardware
> > > > > > > interface and internal state that is needed to restore device operation.
> > > > > > > State in the hardware interface includes the values of hardware registers.
> > > > > > > An example of internal state is an index value needed to avoid processing
> > > > > > > queued requests more than once.
> > > > > > 
> > > > > > I try and emphasise that 'internal state' should be represented in a way
> > > > > > that reflects the problem rather than the particular implementation;
> > > > > > this gives it a better chance of migrating to future versions.
> > > > > 
> > > > > Sounds like a good idea.
> > > > > 
> > > > > > > Changes can be made to the device state representation as follows. Each change
> > > > > > > to device state must have a corresponding device configuration parameter that
> > > > > > > allows the change to toggled:
> > > > > > > 
> > > > > > > * When the parameter is disabled the hardware interface and device state
> > > > > > >   representation are unchanged. This allows old device states to be loaded.
> > > > > > > 
> > > > > > > * When the parameter is enabled the change comes into effect.
> > > > > > > 
> > > > > > > * The parameter's default value disables the change. Therefore old versions do
> > > > > > >   not have to explicitly specify the parameter.
> > > > > > > 
> > > > > > > The following example illustrates migration from an old device
> > > > > > > implementation to a new one. A version=1 network card is migrated to a
> > > > > > > new device implementation that is also capable of version=2 and adds the
> > > > > > > rx-filter-size=32 parameter. The new device is instantiated with
> > > > > > > version=1, which disables rx-filter-size and is capable of loading the
> > > > > > > version=1 device state. The migration completes successfully but note
> > > > > > > the device is still operating at version=1 level in the new device.
> > > > > > > 
> > > > > > > The following example illustrates migration from a new device
> > > > > > > implementation back to an older one. The new device implementation
> > > > > > > supports version=1 and version=2. The old device implementation supports
> > > > > > > version=1 only. Therefore the device can only be migrated when
> > > > > > > instantiated with version=1 or the equivalent full configuration
> > > > > > > parameters.
> > > > > > 
> > > > > > I'm sometimes asked for 'ways out' of buggy migration cases; e.g. what
> > > > > > happens if version=1 forgot to migrate the X register; or what happens
> > > > > > if verison=1 forgot to handle the special, rare case when X=5 and we
> > > > > > now need to migrate some extra state.
> > > > > 
> > > > > Can these cases be handled by adding additional configuration parameters?
> > > > > 
> > > > > If version=1 is lacks essential state then version=2 can add it. The
> > > > > user must configure the device to use version before they can save the
> > > > > full state.
> > > > > 
> > > > > If version=1 didn't handle the X=5 case then the same solution is
> > > > > needed. A new configuration parameter is introduced and the user needs
> > > > > to configure the device to be the new version before migrating.
> > > > > 
> > > > > Unfortunately this requires poweroff or hotplugging a new device
> > > > > instance. But some disruption is probably necessarily anyway so the
> > > > > migration code on the host side can be patched to use the updated device
> > > > > state representation.
> > > > 
> > > > There are some corner cases that people sometimes prefer; for example
> > > > lets say the X=5 case is actually really rare - but when it happens the
> > > > device is hopelessly broken, some device authors prefer to fix it and
> > > > send the extra data and let the migration fail if the destination
> > > > doesn't understand it (it would break anyway).
> > > 
> > > The device implementation needs to be updated to send the extra data. At
> > > that point a new device configuration parameter should be introduced and
> > > if the user wishes to run the new version of the device then the extra
> > > data will be sent.
> > > 
> > > If the destination doesn't support the new parameter then migration will
> > > be refused. That matches what you've described, so I think the approach
> > > in this document handles this case.
> > 
> > Well that's the ideal; but the case I'm describing is where you're
> > recovering from a screwup in which the migration is going to fail in a
> > rare (runtime defined) corner case, and only sending the extra data
> > in that rare case before you get a chance to define a new version.
> 
> You need to upgrade the migration code in order to produce that extra
> data. Why not define a configuration parameter alongside this code
> change?
> 
> > > > I've also been asked
> > > > by mst for a 'unexpected data' mechanism to send data that the
> > > > destination might not expect if it didn't know about it, for similar
> > > > cases.
> > > 
> > > Do you mean optional data that can be more or less safely dropped? A new
> > > device configuration parameter is not needed because the hardware
> > > interface and device state representation remain compatible. That
> > > feature can be defined in the device state representation spec and is
> > > not visible at the layer discussed in this document. But I think it's
> > > worth adding an explanation into this document explaining what to do.
> > 
> > I mean a way to send optional data that the destination can drop; but
> > that the destination doesn't know what it means and at the time the
> > destination was written, wasn't yet defined. It is part of the device
> > state;  it's similar to the X=5 case above - but in this case it allows
> > the migration not to fail even when you start sending the extra data.
> 
> The device state representation may have a way of sending optional data.
> Since it just gets dropped if the destination doesn't recognize it there
> is no need to introduce a configuration parameter and it doesn't play a
> part in migration compatibility checks.
> 
> Stefan


-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


