Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F654CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA6F21872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlkRj/de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA6F21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhps-00037o-U0
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laine@redhat.com>) id 1iNhNM-0003NP-RJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laine@redhat.com>) id 1iNhNK-0001OT-Lh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:58:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40986
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laine@redhat.com>) id 1iNhNI-0001Mr-OU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571939893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+vvEM3T7cug6j6ihL8OwFmYB35S+GtiHAy6pvmEyYQ=;
 b=HlkRj/desmRO3c3Jne9oyDSl2h4J0s6FxGMgMJ5nlY+uhaqTnFa+bXXEwZQBAcG8OevHaM
 f7olrieCQ38sn8c0sSrWTYK9eUV2aCCLJdNeXOaOnSELt5qB67SLXR00z/80/Aqu0G07BT
 9yPGeWGuDLQuNGprzRX8Iw4kNEG8Sow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-K1TkIK9_Oj-LWvkXLFoNNw-1; Thu, 24 Oct 2019 13:58:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A550D107AD31;
 Thu, 24 Oct 2019 17:58:09 +0000 (UTC)
Received: from [10.10.123.191] (ovpn-123-191.rdu2.redhat.com [10.10.123.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4B6017F85;
 Thu, 24 Oct 2019 17:57:56 +0000 (UTC)
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
To: qemu-devel@nongnu.org
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <20191023120648.57e50ae1@x1.home>
 <20191023193035.tlcumzmgjw242hgw@jenstp.localdomain>
 <20191023140211.4ada7ff3@x1.home>
 <20191023203137.meh3edoudxulecys@jenstp.localdomain>
 <20191023151500.547d200a@x1.home>
From: Laine Stump <laine@redhat.com>
Message-ID: <5b7e1e51-12fa-4b1d-6d59-1b76873ddda3@redhat.com>
Date: Thu, 24 Oct 2019 13:57:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023151500.547d200a@x1.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: K1TkIK9_Oj-LWvkXLFoNNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 5:15 PM, Alex Williamson wrote:
> On Wed, 23 Oct 2019 22:31:37 +0200
> Jens Freimann <jfreimann@redhat.com> wrote:
>=20
>> On Wed, Oct 23, 2019 at 02:02:11PM -0600, Alex Williamson wrote:
>>> On Wed, 23 Oct 2019 21:30:35 +0200
>>> Jens Freimann <jfreimann@redhat.com> wrote:
>>>  =20
>>>> On Wed, Oct 23, 2019 at 12:06:48PM -0600, Alex Williamson wrote:
>>>>> On Wed, 23 Oct 2019 10:27:02 +0200
>>>>> Jens Freimann <jfreimann@redhat.com> wrote:
>> [...]
>>>>> Are there also multi-function considerations that
>>>>> should be prevented or documented?  For example, if a user tries to
>>>>> configure both the primary and failover NICs in the same slot, I assu=
me
>>>>> bad things will happen.
>>>>
>>>>    I would have expected that this is already checked in pci code, but
>>>> it is not. I tried it and when I put both devices into the same slot
>>>> they are both unplugged from the guest during boot but nothing else
>>>> happens. I don't know what triggers that unplug of the devices.
>>>>
>>>> I'm not aware of any other problems regarding multi-function, which
>>>> doesn't mean there aren't any.
>>>
>>> Hmm, was the hidden device at function #0?  The guest won't find any
>>> functions if function #0 isn't present, but I don't know what would
>>> trigger the hotplug.  The angle I'm thinking is that we only have slot
>>> level granularity for hotplug, so any sort of automatic hotplug of a
>>> slot should probably think about bystander devices within the slot.
>>
>> Yes that would be a problem, but isn't it the same in the non-failover c=
ase
>> where a user configures it wrong? The slot where the device is plugged i=
s not
>> chosen automatically it's configured by the user, no? I might be mixing =
something
>> up here.  I have no idea yet how to check if a slot is already populated=
, but
>> I'll think about it.
>=20
> I don't think libvirt will automatically make use of multifunction
> endpoints, except maybe for some built-in devices, so yes it probably
> would be up to the user to explicitly create a multifunction device.

Correct. The only place libvirt will ever assign devices anywhere except=20
function 0 is when we are adding pcie-root-ports - those are combined=20
8-per-slot in order to conserve space on pcie.0 (this permits us to have=20
up to 240 PCIe devices without needing to resort to upstream/downstream=20
switches).


> But are there other scenarios that generate an automatic hot-unplug?
> If a user creates a multifunction slot and then triggers a hot-unplug
> themselves, it's easy to place the blame on the user if the result is
> unexpected, but is it so obviously a user configuration error if the
> hotplug occurs as an automatic response to a migration?  I'm not as
> sure about that.

I guess that's all a matter of opinion. If the user never enters in any=20
PCI address info and it's all handled by someone else, then I wouldn't=20
expect them to know exactly where the devices were (and only vaguely=20
understand that their hostdev network interface is going to be unplugged=20
during migration). In that case (as long as it's libvirt assigning the=20
PCI addresses) the situation we're considering would never ever happen,=20
so it's a non-issue.

If, on the other hand, the user wants to mess around assigning PCI=20
addresses themselves, then they get to pick up all the pieces. It might=20
be nice if they could be given a clue about why it broke though.

>=20
> As indicated, I don't know whether this should just be documented or if
> we should spend time preventing it, but someone, somewhere will
> probably think it's a good idea to put their primary and failover NIC
> in the same slot and be confused that the underlying mechanisms cannot
> support it.  It doesn't appear that it would be too difficult to test
> QEMU_PCI_CAP_MULTIFUNCTION (not set) and PCI_FUNC (is 0) for the
> primary, but maybe I'm just being paranoid.  Thanks,

If, as you claim, it's not difficult, then I guess why not?


