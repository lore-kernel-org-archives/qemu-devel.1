Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF3FC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CAE20578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjBQx+ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CAE20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmak-00055V-3h
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jHmZy-0004aW-Uz
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jHmZx-00083o-6F
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:51:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jHmZx-00082r-1Y
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585306268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0G89HAFhVDFZtAUvSa5w22L1Qv6aQQGMdJ7gszazqnE=;
 b=ZjBQx+ctxqzEBqVfvySnnJ+HwueLcnluX3SvMKUTfbXwomIReiVZMWngaoXbhFs6lxWDj5
 pK6502VyY0LVvjO/sEvwkVOaH6TD+GA7U9VugdatW81IcJBgzghbVqyykuB7jK04q3wEaP
 y+HRsJDQGNqsalJrNy+UkTLJ8gqDcaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-8lR_Vxs1O-SkMsHUfN1FeQ-1; Fri, 27 Mar 2020 06:51:00 -0400
X-MC-Unique: 8lR_Vxs1O-SkMsHUfN1FeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 350978018A6;
 Fri, 27 Mar 2020 10:50:59 +0000 (UTC)
Received: from [10.36.112.108] (ovpn-112-108.ams2.redhat.com [10.36.112.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85A335DA85;
 Fri, 27 Mar 2020 10:50:49 +0000 (UTC)
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when switching
 to protected mode
To: Halil Pasic <pasic@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
 <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
 <20200227132402.67a38047.pasic@linux.ibm.com>
 <8622efeb-1a4a-338f-d363-53818b00d195@redhat.com>
 <20200319164050.78a01702.pasic@linux.ibm.com>
 <d7d91f47-19d3-06cf-879c-c9556a924a2f@redhat.com>
 <20200320194317.1cf36b00.pasic@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <f29730ed-4327-3aa8-4057-fb6345632a92@redhat.com>
Date: Fri, 27 Mar 2020 11:50:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320194317.1cf36b00.pasic@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>> So, AFAIU, *any* virtio device (hypervisor side) has to present this
>> flag when PV is enabled.=20
>=20
> Yes, and balloon says bye bye when running in PV mode is only a secondary
> objective. I've compiled some references:

Thanks!

>=20
> "To summarize, the necessary conditions for a hack along these lines
> (using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:
>=20
>   - secure guest mode is enabled - so we know that since we don't share
>     most memory regular virtio code won't
>     work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLA=
TFORM"=20
> (Michael Tsirkin, https://lkml.org/lkml/2020/2/20/1021)
> I.e.: PV but !VIRTIO_F_ACCESS_PLATFORM \implies bugy hypervisor
>=20
>=20
> "If VIRTIO_F_ACCESS_PLATFORM is set then things just work.  If
> VIRTIO_F_ACCESS_PLATFORM is clear device is supposed to have access to
> all of memory.  You can argue in various ways but it's easier to just
> declare a behaviour that violates this a bug."
> (Michael Tsirkin, https://lkml.org/lkml/2020/2/21/1626)
> This one is about all memory guest, and not just the buffers transfered
> via the virtqueue, which surprised me a bit at the beginning. But balloon
> actually needs this.
>=20
> "A device SHOULD offer VIRTIO_F_ACCESS_PLATFORM if its access to memory
> is through bus addresses distinct from and translated by the platform to
> physical addresses used by the driver, and/or if it can only access
> certain memory addresses with said access specified and/or granted by
> the platform. A device MAY fail to operate further if
> VIRTIO_F_ACCESS_PLATFORM is not accepted. "
> (https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.htm=
l#x1-4120002)
>=20

>=20
>> In that regard, your patch makes perfect sense
>> (although I am not sure it's a good idea to overwrite these feature
>> bits
>> - maybe they should be activated on the cmdline permanently instead
>> when PV is to be used? (or enable )).
>=20
> I didn't understand the last part. I believe conserving the user
> specified value when not running in PV mode is better than the hard
> overwrite I did here. I wanted a discussion starter.
>=20
> I think the other option (with respect to let QEMU manage this for user,
> i.e. what I try to do here) is to fence the conversion if virtio devices
> that do not offer VIRTIO_F_ACCESS_PLATFORM are attached; and disallow
> hotplug of such devices at some point during the conversion.
>=20
> I believe that alternative is even uglier.
>=20
> IMHO we don't want the end user to fiddle with iommu_platform, because
> all the 'benefit' he gets from that is possibility to make a mistake.
> For example, I got an internal bug report saying virtio is broken with
> PV, which boiled down to an overlooked auto generated NIC, which of
> course had iommu_platform (VIRTIO_F_ACCESS_PLATFORM) not set.
>=20
>>
>>>
>>> The actual problem is that the pages denoted by the buffer
>>> transmitted via the virtqueue are normally not shared pages. I.e.
>>> the hypervisor can not reuse them (what is the point of balloon
>>> inflate). To make this work, the guest would need to share the pages
>>> before saying 'host these are in my balloon, so you can use them'.
>>> This is a piece of logic we
>>
>> What exactly would have to be done in the hypervisor to support it?
>=20
> AFAIK nothing. The guest needs to share the pages, and everything works.
> Janosch, can you help me with this one?=20
>=20

See below, making this work on the hypervisor side would be much cleaner
IMHO, but most probably not possible due to guest integrity.

FWIW, "Free page reporting" will (never) work with PV, where there is
basically no manual "deflation" step anymore.

>>
>> Assume we have to trigger sharing/unsharing - this sounds like a very
>> architecture specific thing?
>=20
> It is, but any guest having sovereignty about its memory may need
> something similar.
>=20
>> Or is this e.g., doing a map/unmap
>> operation like mapping/unmapping the SG?
>=20
> No this is something different. We need stronger guarantees than the
> streaming portion of the DMA API provides. And what we actually want
> is not DMA but something very different.

Right, that's what I was expecting ...

>=20
>>
>> Right now it sounds to me "we have to do $ARCHSPECIFIC when
>> inflating/deflating in the guest", which feels wrong.
>>
>=20
> It is wrong in a sense. Drivers are mostly supposed to be portable. But
> balloon is not a run of the mill device. I don't see any other way to
> make this work.

Well, it is mostly architecture independent until now ...

>=20
>>> need only if the host/the device does not have full access to the
>>> guest RAM. That is in my opinion why the balloon driver fences
>>> VIRTIO_F_ACCESS_PLATFORM.> Does that make sense?
>>
>> Yeah, I understood the "device has to set VIRTIO_F_ACCESS_PLATFORM"
>> part. Struggling with the "what can the guest driver actually do" part.
>>
>=20
> Let me try to reword this. The point of PV is that the guest has
> exclusive access to his pages unless the guest decides to share some
> of the using a dedicated ultravisor call.
>=20
> The point of the memballoon is, as far as I understand, to effectively
> dynamically manage the guests memory size within given boundaries, and
> without requiring memory hotplug. The basic idea is that the pages in
> the balloon belong to the host. The host attempting to re-use a
> non-shared page of a guest leads to problems. AFAIR the main problem
> was that shall we ever want to deflate such a page (make it again
> available for guest use) we would need to do an import, and that can
> only work if we have the exact same content as when it was exported.
> Otherwise integrity check fails as if we had a malicious hypervisor,
> that is trying to inject stuff into the guest.
>=20
> I'm sure Janosch can provide a better explanation.
>=20
> I really don't see another way, how memory ballooning could work with
> something like PV, without the balloon driver relinquishing the guests
> ownership of the pages that are going to leave the guest via the balloon.=
>
> On that note ccing the AMD SEV people. Balloon is at this point
> dysfunctional for them as well. @Tom: Right? If yes what problems need to
> be solved so virtio-balloon can work under SEV?

SEV even pins all guest memory, so it's useless and would be even
dangerous to use.


Some thoughts:


1. I would really prefer if there is a way to zero-out+share a page and
zero-out+unshare a page triggered by the hypervisor. Then only the
hypervisor has to do "the right thing" when
inflating/deflating/rebooting etc. I know we can "unshare all" via the
UV - we e.g., have to do that on reboots. But I assume this might mess
with "guest integrity" (being able to zero out random guest pages
technically) and is therefore not possible.


2. Have some other way to communicate "careful, ballooning won't work".
E.g., the guest detecting *itself* that it is running inside a PV
environment and not loading virtio-balloon until it properly
shares/unshares. Again, piggy-backing on IOMMU/VIRTIO_F_ACCESS_PLATFORM
somehow feels wrong.


E.g., once you would support inflation/deflation in virtio-balloon, free
page reporting could not be supported. So it's more than just a single
arch specific inflation/deflation callback.


And virtio-mem [1] will have similar issues once we want to use that on
s390x. But there, an arch-specific share/unshare callback should be
sufficient most probably. Still, there would have to be a way to block
it on s390x PV until implemented. Ideally it will be the same as for
virtio-balloon.

Again, being able to do that in the hypervisor instead of in the guest
would be much cleaner.

[1] https://lkml.kernel.org/r/20200311171422.10484-1-david@redhat.com

--=20
Thanks,

David / dhildenb


