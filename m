Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C10C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4E92073D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoRRu6bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4E92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifho1-0006jA-1O
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ifhn5-00068R-7V
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ifhn2-0003wK-39
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:03:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42830
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ifhn1-0003uM-Le
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576231394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azycGipua+/jyOaHF/EYGm8hN/wv19QybKjhz4VJCro=;
 b=QoRRu6bbjD2DQ9d1HuuLsvFSVonaKpP5nedc7KdadF2t/RYungd0WEgnhY03VmGfe5Vik8
 kcNqkY/YdsY1WGshymw0ZA//x+s7KqMRcPsjZAq2SyibnTWkyJolAyWJ6lmPX4hKx7Qa0e
 uXl3FhKRHStvQCigJbR7ovhZnEOr1uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-AUUT5R3MNaenh2LbWNgr2w-1; Fri, 13 Dec 2019 05:03:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1126800D4E;
 Fri, 13 Dec 2019 10:03:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CE185C1D4;
 Fri, 13 Dec 2019 10:03:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6F5F11386A7; Fri, 13 Dec 2019 11:03:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 12/20] qapi: Introduce DEFINE_PROP_INTERVAL
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-13-eric.auger@redhat.com>
 <87wob17n6j.fsf@dusky.pond.sub.org>
 <66ae0999-bdd8-6b54-f550-f036dafc982b@redhat.com>
Date: Fri, 13 Dec 2019 11:03:02 +0100
In-Reply-To: <66ae0999-bdd8-6b54-f550-f036dafc982b@redhat.com> (Auger Eric's
 message of "Thu, 12 Dec 2019 16:13:06 +0100")
Message-ID: <87y2vg4k6h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: AUUT5R3MNaenh2LbWNgr2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Auger Eric <eric.auger@redhat.com> writes:

> Hi Markus,
>
> On 12/12/19 1:17 PM, Markus Armbruster wrote:
>> Eric Auger <eric.auger@redhat.com> writes:
>>=20
>>> Introduce a new property defining a labelled interval:
>>> <low address>,<high address>,label.
>>>
>>> This will be used to encode reserved IOVA regions. The label
>>> is left undefined to ease reuse accross use cases.
>>=20
>> What does the last sentence mean?
> The dilemma was shall I specialize this property such as ReservedRegion
> or shall I leave it generic enough to serve somebody else use case. I
> first chose the latter but now I think I should rather call it something
> like ReservedRegion as in any case it has addresses and an integer label.
>>=20
>>> For instance, in virtio-iommu use case, reserved IOVA regions
>>> will be passed by the machine code to the virtio-iommu-pci
>>> device (an array of those). The label will match the
>>> virtio_iommu_probe_resv_mem subtype value:
>>> - VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)
>>> - VIRTIO_IOMMU_RESV_MEM_T_MSI (1)
>>>
>>> This is used to inform the virtio-iommu-pci device it should
>>> bypass the MSI region: 0xfee00000, 0xfeefffff, 1.
>>=20
>> So the "label" part of "<low address>,<high address>,label" is a number?
> yes it is.
>>=20
>> Is a number appropriate for your use case, or would an enum be better?
> I think a number is OK. There might be other types of reserved regions
> in the future. Also if we want to allow somebody else to reuse that
> property in another context, I would rather leave it open?

I'd prioritize the user interface over possible reuse (which might never
happen).  Mind, I'm not telling you using numbers is a bad user
interface.  In general, enums are nicer, but I don't know enough about
this particular case.

>>=20
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com> ---
[...]
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index e499dc215b..e238d1c352 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -57,6 +57,12 @@ struct MemoryRegionMmio {
>>>      CPUWriteMemoryFunc *write[3];
>>>  };
>>> =20
>>> +struct Interval {
>>> +    hwaddr low;
>>> +    hwaddr high;
>>> +    unsigned int type;
>>> +};
>>=20
>> This isn't an interval.  An interval consists of two values, not three.
>>=20
>> The third one is called "type" here, and "label" elsewhere.  Pick one
>> and stick to it.
>>=20
>> Then pick a name for the triple.  Elsewhere, you call it "labelled
>> interval".
> I would tend to use ReservedRegion now if nobody objects.

Sounds good to me.

> Thank you for the review!

You're welcome!


