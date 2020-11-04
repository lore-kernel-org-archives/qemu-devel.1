Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0060C388F2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 03:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5732074F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 03:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkvbjD5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5732074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka9YU-0002tx-Kb
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 22:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ka9Xi-0002Tl-4Y
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 22:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ka9Xe-00029J-ON
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 22:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604460777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYz+77WTNaIuwzdCFkd8ia/LtRGUkw3mWOb1xCLiKI8=;
 b=BkvbjD5swJ0zdDInftzMeHDL54asMDovCHsPdwie47EcFxd/unQ+7w3Ut2X9VJibMZcGmn
 uhUFsmhWd71BA3xefh/VBvGVU7uYFWEHBxlwyBJC3ESx9bzqCIgQFVcUu6X1vZ0VvOO2N6
 TTn43wmEOHGUi/QWYpBLcLNWkRINMT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-BdQUlT6ZNxqOExDeRhMfFQ-1; Tue, 03 Nov 2020 22:32:48 -0500
X-MC-Unique: BdQUlT6ZNxqOExDeRhMfFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39672802B7D;
 Wed,  4 Nov 2020 03:32:47 +0000 (UTC)
Received: from [10.72.13.133] (ovpn-13-133.pek2.redhat.com [10.72.13.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABFE619C4F;
 Wed,  4 Nov 2020 03:32:35 +0000 (UTC)
Subject: Re: VFIO Migration
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <ac694df6-0842-3483-dfc6-db82830bb02b@redhat.com>
 <20201103121515.GB243332@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <311b467a-3000-7091-77d1-4d6c0e42c1fd@redhat.com>
Date: Wed, 4 Nov 2020 11:32:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201103121515.GB243332@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 quintela@redhat.com, qemu-devel@nongnu.org,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/11/3 下午8:15, Stefan Hajnoczi wrote:
> On Tue, Nov 03, 2020 at 04:46:53PM +0800, Jason Wang wrote:
>> On 2020/11/2 下午7:11, Stefan Hajnoczi wrote:
>>> There is discussion about VFIO migration in the "Re: Out-of-Process
>>> Device Emulation session at KVM Forum 2020" thread. The current status
>>> is that Kirti proposed a VFIO device region type for saving and loading
>>> device state. There is currently no guidance on migrating between
>>> different device versions or device implementations from different
>>> vendors. This is known to be non-trivial and raised discussion about
>>> whether it should really be handled by VFIO or centralized in QEMU.
>>>
>>> Below is a document that describes how to ensure migration compatibility
>>> in VFIO. It does not require changes to the VFIO migration interface. It
>>> can be used for both VFIO/mdev kernel devices and vfio-user devices.
>>>
>>> The idea is that the device state blob is opaque to the VMM but the same
>>> level of migration compatibility that exists today is still available.
>>
>> So if we can't mandate this or there's no way to validate this. Vendor is
>> still free to implement their own protocol which could lead a lot of
>> maintaining burden.
> Yes, the device state representation is their responsibility. We can't
> do that for them since they define the hardware interface and internal
> state.
>
> As Michael and Paolo have mentioned in the other thread, we can provide
> guidelines and standardize common aspects.
>
>>> Migration can fail if loading the device state is not possible. It should fail
>>> early with a clear error message. It must not appear to complete but leave the
>>> device inoperable due to a migration problem.
>>
>> For VFIO-user, how management know that a VM can be migrated from src to
>> dst? For kernel, we have sysfs.
> vfio-user devices will normally be instantiated in one of two ways:
>
> 1. Launching a device backend and passing command-line parameters:
>
>       $ my-nic --socket-path /tmp/my-nic-vfio-user.sock \
>                --model https://vendor-a.com/my-nic \
> 	      --rss on
>
>     Here "model" is the device model URL. The program could support
>     multiple device models.
>
>     The "rss" device configuration parameter enables Receive Side Scaling
>     (RSS) as an example of a configuration parameter.
>
> 2. Creating a device using an RPC interface:
>
>       (qemu) device-add my-nic,rss=on
>
> If the device instantiation succeeds then it is safe to live migrate.
> The device is exposing the desired hardware interface and expecting the
> right device state representation.


Does this mean there will still be a "my-nic" stub in qemu? (I thought 
it should be a generic one like device-add "vfio-user-pci")


>
>>> The rest of this document describes how these requirements can be met.
>>>
>>> Device Models
>>> -------------
>>> Devices have a *hardware interface* consisting of hardware registers,
>>> interrupts, and so on.
>>>
>>> The hardware interface together with the device state representation is called
>>> a *device model*. Device models can be assigned URIs such as
>>> https://qemu.org/devices/e1000e to uniquely identify them.
>>
>> It looks worse than "pci://vendor_id.device_id.subvendor_id.subdevice_id".
>> "e1000e" means a lot of different 8275X implementations that have subtle but
>> easy to be ignored differences.
> If you wish to reflect those differences in the device model URI then
> you can use:
>
>    https://qemu.org/devices/pci/<vendor-id>/<device-id>/<subvendor-id>/<subdevice-id>
>
> Another option is to use device configuration parameters to express
> differences.
>
> The important thing is that this device model URI has one owner. No one
> else will use qemu.org. There can be many different e1000e device model
> URIs, if necessary (with slightly different hardware interfaces and/or
> device state representations). This avoids collisions.
>
>> And is it possible to have a list of URIs here?
> A device implementation (mdev driver, vfio-user device backend, etc) may
> support multiple device model URIs.
>
> A device instance has an immutable device model URI and list of
> configuration parameters. In other words, once the device is created its
> ABI is fixed for the lifetime of the device. A new device instance can
> be configured by powering off the machine, hotplug, etc.
>
>>> Multiple implementations of a device model may exist. They are they are
>>> interchangeable if they follow the same hardware interface and device
>>> state representation.
>>>
>>> Multiple implementations of the same hardware interface may exist with
>>> different device state representations, in which case the device models are not
>>> interchangeable and must be assigned different URIs.
>>>
>>> Migration is only possible when the same device model is supported by the
>>> *source* and the *destination* devices.
>>>
>>> Device Configuration
>>> --------------------
>>> Device models may have parameters that affect the hardware interface or device
>>> state representation. For example, a network card may have a configurable
>>> address filtering table size parameter called ``rx-filter-size``. A
>>> device state saved with ``rx-filter-size=32`` cannot be safely loaded
>>> into a device with ``rx-filter-size=0``, because changing the size from
>>> 32 to 0 may disrupt device operation.
>>
>> Do we allow the migration from "rx-filter-size=16" to "rx-filter-size=32" (I
>> guess not?) And should we extend the concept to "device capability" instead
>> of just state representation.  E.g src has CAP_X=on,CAP_Y=off but dst has
>> CAP_X=on,CAP_Y=on, so we disallow the migration from src to dst.
> A device instance's configuration parameters are immutable.
> rx-filter-size=16 cannot be migrated to rx-filter-size=32.


But then it looks to me we can't migrate back, or do you mean it is 
required to have the ability to change the max rx-filter-size.


>
> Yes, configuration parameters can describe capabilities. I think of
> capabilities as something that affects the guest-visible hardware
> interface (e.g. the RSS feature bit is enabled) that is mentioned in the
> text, but it would be clearer to mention them explicitly.
>
>>> A list of configuration parameters is called the *device configuration*.
>>> Migration is expected to succeed when the same device model and configuration
>>> that was used for saving the device state is used again to load it.
>>>
>>> Note that not all parameters used to instantiate a device need to be part of
>>> the device configuration. For example, assigning a network card to a specific
>>> physical port is not part of the device configuration since it is not part of
>>> the device's hardware interface or the device state representation.
>>
>> Yes, but the task needs to be done by management somehow. So do you expect a
>> vendor specific provisioning API here?
> There seems to be no consensus on this yet. It's the question of how to
> manage the lifecycle of VFIO, mdev, vhost-user, and vfio-user devices.
> There are attempts to standardize in some of these areas.
>
> For mdev drivers we can standardize the sysfs interface so management
> tools can query source devices and instantiate destination devices
> without device-specific code.


Even for mdev, it should be have some class defined for sysfs which 
could be a standard way to configure NVME or virtio device.


>
> For vhost-user devices there is the backend program conventions
> specification, which aims to standardize common parameters. This makes
> integrating support for new device implementations easier (there is less
> device implementation-specific code).
>
> For vfio-user devices something based on the vhost-user backend program
> conventions spec could work well.
>
> The main issue could be that avoiding vendor-specific provisioning code
> in management software either requires you to restrict yourself to a few
> standard device types or to pass through configuration data.
>
> A libvirt opinion would be interesting.
>
>>> The device
>>> state can be loaded and run on a different physical port without affecting the
>>> operation of the device. Therefore the physical port is not part of the device
>>> configuration.
>>>
>>> However, secondary aspects related to the physical port may affect the device's
>>> hardware interface and need to be reflected in the device configuration. The
>>> link speed may depend on the physical port and be reported through the device's
>>> hardware interface. In that case a ``link-speed`` configuration parameter is
>>> required to prevent unexpected changes to the link speed after migration.
>>>
>>> Note that the device configuration is a conservative bound on device
>>> states that can be migrated successfully since not all configuration
>>> parameters may be strictly required to match on the source and
>>> destination devices. For example, if the device's hardware interface has
>>> not yet been initialized then changes to the link speed may not be
>>> noticed. However, accurately representing runtime constraints is complex
>>> and risks introducing migration bugs, so no attempt is made to support
>>> them to achieve more relaxed bounds on successful migrations.
>>>
>>> Device Versions
>>> ---------------
>>> As a device evolves, the number of configuration parameters required may become
>>> inconvenient for users to express in full. A device configuration can be
>>> aliased by a *device version*, which is a shorthand for the full device
>>> configuration. This makes it easy to apply a standard device configuration
>>> without listing every configuration parameter explicitly.
>>
>> I'm not sure how to apply the device versions consider the device state is
>> opaque or the device needs to export another API to do this?
> Versions are just aliases for a list of configuration parameters. For
> example, version=2 expands to rx-filter-size=32. The purpose of versions
> is to provide a human-readable shorthand notation.
>
> Versions are not involved in migration compatibility checking, instead
> the device model URI and expanded configuration parameters are compared.
>
> The version has no direct effect on the device state representation. It
> has an indirect effect due to the configuration parameters that it
> expands to. For example, the rx-filter-size=32 configuration parameter
> may change the device state representation to include the 32 addresses
> that the device is filtering on.
>
> No "version check" is necessary when loading the device state
> representation because the device was already instantiated with the
> exact configuration parameters that determine the device state
> representation.
>
>>> For example, if address filtering support was added to a network card then
>>> device versions and the corresponding configurations may look like this:
>>> * ``version=1`` - Behaves as if ``rx-filter-size=0``
>>> * ``version=2`` - ``rx-filter-size=32``
>>>
>>> Device States
>>> -------------
>>> The details of the device state representation are not covered in this document
>>> but the general requirements are discussed here.
>>>
>>> The device state consists of data accessible through the device's hardware
>>> interface and internal state that is needed to restore device operation.
>>> State in the hardware interface includes the values of hardware registers.
>>> An example of internal state is an index value needed to avoid processing
>>> queued requests more than once.
>>>
>>> Changes can be made to the device state representation as follows. Each change
>>> to device state must have a corresponding device configuration parameter that
>>> allows the change to toggled:
>>>
>>> * When the parameter is disabled the hardware interface and device state
>>>     representation are unchanged. This allows old device states to be loaded.
>>>
>>> * When the parameter is enabled the change comes into effect.
>>>
>>> * The parameter's default value disables the change. Therefore old versions do
>>>     not have to explicitly specify the parameter.
>>>
>>> The following example illustrates migration from an old device
>>> implementation to a new one. A version=1 network card is migrated to a
>>> new device implementation that is also capable of version=2 and adds the
>>> rx-filter-size=32 parameter. The new device is instantiated with
>>> version=1, which disables rx-filter-size and is capable of loading the
>>> version=1 device state. The migration completes successfully but note
>>> the device is still operating at version=1 level in the new device.
>>>
>>> The following example illustrates migration from a new device
>>> implementation back to an older one. The new device implementation
>>> supports version=1 and version=2. The old device implementation supports
>>> version=1 only. Therefore the device can only be migrated when
>>> instantiated with version=1 or the equivalent full configuration
>>> parameters.
>>
>> In qemu we have subsection to facilitate the case when some fields were
>> forgot to migrate. Do we need something similar here?
> This is an important question and I'm not sure.
>
> The problem with subsection semantics is that they break rollback. Once
> the old device state has been loaded by the new device implementation,
> saving the device state produces the new device state representation.
> The old device implementation can no longer load it :(.


Only when subsection is needed.


>    Manual
> intervention is necessary to tell the new device implementation to save
> in the old representation.


If we don't support subsection, could we end up with a deadlock like we 
do migration since want upgrade the kernel, but if we don't upgrade the 
kernel, we can't do live migration.


>
> In the migration model described in this document it works the other
> way around: back and forth migration is always safe. If you wish to
> change the device you need to create a new instance (after poweroff or
> through hotplug).
>
> One way of achieving something similar is to provide additional
> information about safe transitions between configuration parameter
> lists. It is not safe to change arbitrary device configuration
> parameters, but certain parameters can be safely changed.
>
> I'm not sure if the complexity is worth it though. The downside to the
> current approach is that devices must eventually be reconfigured to
> upgrade to new versions, even if there is no guest-visible hardware
> interface change.
>
> Stefan


Thanks


