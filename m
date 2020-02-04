Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F9C3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E3D21744
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIPQ/jIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E3D21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyy1a-0004XC-Ur
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iyy0o-00044L-AT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iyy0l-0003yn-VD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:13:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44184
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iyy0l-0003uW-3z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580821982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNn6TVx4UNbBWcYcTchfztwfmOjAEXy90xJfbN2sPWk=;
 b=IIPQ/jIyK3WLpgRWzwNQuwXurIIRTIu7wHGJgvNxrk6iKHRMaf3xlxDIwXa2/kdD0mEOa4
 VBVuzOTXJqanczbgN2QBE3DMeQEPJHWcx6I16xN0hhxDUh2Mw5lv6IRXLkfTM+uQ0aq5D9
 qXdAHADUDCb9DTZfhDc/xNJZKG+dT7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-fLOA-OvdNTiOYiaLH4lRFw-1; Tue, 04 Feb 2020 08:12:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A2988010F6;
 Tue,  4 Feb 2020 13:12:52 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F5881001B23;
 Tue,  4 Feb 2020 13:12:51 +0000 (UTC)
Subject: Re: [PATCH 13/17] qcow2: Add new autoclear feature for all zero image
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-14-eblake@redhat.com>
 <da530661-a976-35ca-d999-646074b72490@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <10684ac8-2d01-86f1-d383-3ea83e6450eb@redhat.com>
Date: Tue, 4 Feb 2020 07:12:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <da530661-a976-35ca-d999-646074b72490@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: fLOA-OvdNTiOYiaLH4lRFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 11:45 AM, Vladimir Sementsov-Ogievskiy wrote:
> 31.01.2020 20:44, Eric Blake wrote:
>> With the recent introduction of BDRV_ZERO_OPEN, we can optimize
>> various qemu-img operations if we know the destination starts life
>> with all zero content.=C2=A0 For an image with no cluster allocations an=
d
>> no backing file, this was already trivial with BDRV_ZERO_CREATE; but
>> for a fully preallocated image, it does not scale to crawl through the
>> entire L1/L2 tree to see if every cluster is currently marked as a
>> zero cluster.=C2=A0 But it is quite easy to add an autoclear bit to the
>> qcow2 file itself: the bit will be set after newly creating an image
>> or after qcow2_make_empty, and cleared on any other modification
>> (including by an older qemu that doesn't recognize the bit).
>>
>> This patch documents the new bit, independently of implementing the
>> places in code that should set it (which means that for bisection
>> purposes, it is safer to still mask the bit out when opening an image
>> with the bit set).
>>
>> A few iotests have updated output due to the larger number of named
>> header features.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> RFC: As defined in this patch, I defined the bit to be clear if any
>> cluster defers to a backing file. But the block layer would handle
>> things just fine if we instead allowed the bit to be set if all
>> clusters allocated in this image are zero, even if there are other
>> clusters not allocated.=C2=A0 Or maybe we want TWO bits: one if all
>> clusters allocated here are known zero, and a second if we know that
>> there are any clusters that defer to a backing image.

>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bits 2-63:=C2=A0 Reserved (se=
t to 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bit 2:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 All zero image bit
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If this bit is set, the entire i=
mage=20
>> reads
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as all zeroes. This can be usefu=
l for
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 detecting just-created images ev=
en when
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clusters are preallocated, which=
 in turn
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can be used to optimize image co=
pying.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This bit should not be set if an=
y=20
>> cluster
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in the image defers to a backing=
 file.
>=20
> Hmm. The term "defers to a backing file" not defined in the spec. And, as=
 I
> understand, can't be defined by design. Backing file may be=20
> added/removed/changed
> dynamically, and qcow2 driver will not know about it. So, the only way to
> be sure that clusters are not defer to backing file is to make them
> ZERO clusters (not UNALLOCATED). But this is inefficient, as we'll have t=
o
> allocated all L2 tables.
>=20
> So, I think better to define this flag as "all allocated clusters are=20
> zero".

That was precisely the topic of my RFC question.

I _do_ think it is simpler to report that 'all clusters where content=20
comes from _this_ image read as zero', leaving unallocated clusters as=20
zero only if 1. there is no backing image, or 2. the backing image also=20
reads as all zero (recursing as needed).  I'll spin v2 of these patches=20
along those lines, although I'm hoping for more review on the rest of=20
the series, first.

>=20
> Hmm interesting, in qcow2 spec "allocated" means allocated on disk and ha=
s
> offset. So, ZERO cluster is actually unallocated cluster, with bit 0 of
> L2 entry set to 1. On the other hand, qemu block layer considers ZERO
> clusters as "allocated" (in POV of backing-chain).

I really want the definition to be 'any cluster whose contents come from=20
this layer' (the qemu-io definition of allocated, not necessarily the=20
qcow2 definition of allocated), which picks up BOTH types of qcow2 zero=20
clusters (those preallocated but marked 0, where the contents of the=20
allocated area are indeterminate but never read, and those unallocated=20
but marked 0 which do not defer to the backing layer).  Whether or not=20
the cluster is allocated is less important than whether the image reads=20
as 0 at that cluster.

But I think that you are right that an alternative definition of 'all=20
allocated clusters are zero' will give the same results when crawling=20
through the backing chain to learn if the overall image reads as zero,=20
and that's all the more that we can expect out of this bit.

>=20
> So, if we define it as "all allocated clusters are zero", we are done:
> other clusters are either unallocated and MAY refer to backing, so we
> can say nothing about their read-as-zero status at the level of qcow2
> spec, or unallocated with zero-bit set, which are normal ZERO clusters.
>=20
> So, on the level of qcow2 driver I think it's better consider only this
> image. Still, we can implement generic bdrv_is_all_zeros, which will
> check or layers (or at least, check that bs->backing is NULL).

The earlier parts of this series which renamed bdrv_has_zero_init() into=20
bdrv_known_zeroes() does just that - it already handles recursion=20
through the backing chain, and insists that an image is all zeroes with=20
respect to BDRV_ZERO_OPEN only if all layers of the backing chain agree.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


