Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D0C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 02:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50A020724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 02:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgoNNKGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50A020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEO74-0003N0-TX
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 22:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jEO6F-0002lL-UC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jEO6E-0006Id-28
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:06:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jEO6D-0006Bp-S6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584497185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLOFuo89Uh9yZ5HRef4Gqf26z9hOxh+13iUsI2C+jb4=;
 b=fgoNNKGo7rnLlpHGZdUesYE9PpDrCYSI3xzVkTzqbpl3ARxU7XKNcU/5gRVoJRufVeocmt
 hHEJfFSyBnBWQXtieH9vAE4R+uz3b4VupNlZjqJrwFU0QlCW/0mxmTKMChclC6P/pzMW6h
 yI16AsljpTyTTFUkdYOQ15HO6pwXfk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312--B_xp1FOMg-x_6V4Q2COrg-1; Tue, 17 Mar 2020 22:06:21 -0400
X-MC-Unique: -B_xp1FOMg-x_6V4Q2COrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65CCF800D50;
 Wed, 18 Mar 2020 02:06:20 +0000 (UTC)
Received: from [10.72.13.166] (ovpn-13-166.pek2.redhat.com [10.72.13.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3B7919C58;
 Wed, 18 Mar 2020 02:06:09 +0000 (UTC)
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
To: Peter Xu <peterx@redhat.com>
References: <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
 <20200313112902-mutt-send-email-mst@kernel.org>
 <20200313163122.GB95517@xz-x1>
 <20200316131723-mutt-send-email-mst@kernel.org>
 <20200316181405.GB184827@xz-x1>
 <158fbd3b-1285-e18d-b535-a1e7a9802f1f@redhat.com>
 <20200317141316.GA199571@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d3958775-a67c-d6c7-e85b-7e012a2a8c5d@redhat.com>
Date: Wed, 18 Mar 2020 10:06:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200317141316.GA199571@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/17 =E4=B8=8B=E5=8D=8810:13, Peter Xu wrote:
> On Tue, Mar 17, 2020 at 11:04:26AM +0800, Jason Wang wrote:
>> On 2020/3/17 =E4=B8=8A=E5=8D=882:14, Peter Xu wrote:
>>> On Mon, Mar 16, 2020 at 01:19:54PM -0400, Michael S. Tsirkin wrote:
>>>> On Fri, Mar 13, 2020 at 12:31:22PM -0400, Peter Xu wrote:
>>>>> On Fri, Mar 13, 2020 at 11:29:59AM -0400, Michael S. Tsirkin wrote:
>>>>>> On Fri, Mar 13, 2020 at 01:44:46PM +0100, Halil Pasic wrote:
>>>>>>> [..]
>>>>>>>>> CCing Tom. @Tom does vhost-vsock work for you with SEV and curren=
t qemu?
>>>>>>>>>
>>>>>>>>> Also, one can specify iommu_platform=3Don on a device that ain't =
a part of
>>>>>>>>> a secure-capable VM, just for the fun of it. And that breaks
>>>>>>>>> vhost-vsock. Or is setting iommu_platform=3Don only valid if
>>>>>>>>> qemu-system-s390x is protected virtualization capable?
>>>>>>>>>
>>>>>>>>> BTW, I don't have a strong opinion on the fixes tag. We currently=
 do not
>>>>>>>>> recommend setting iommu_platform, and thus I don't think we care =
too
>>>>>>>>> much about past qemus having problems with it.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Halil
>>>>>>>> Let's just say if we do have a Fixes: tag we want to set it correc=
tly to
>>>>>>>> the commit that needs this fix.
>>>>>>>>
>>>>>>> I finally did some digging regarding the performance degradation. F=
or
>>>>>>> s390x the performance degradation on vhost-net was introduced by co=
mmit
>>>>>>> 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). Before
>>>>>>> IOMMUTLBEntry.addr_mask used to be based on plen, which in turn was
>>>>>>> calculated as the rest of the memory regions size (from address), a=
nd
>>>>>>> covered most of the guest address space. That is we didn't have a w=
hole
>>>>>>> lot of IOTLB API overhead.
>>>>>>>
>>>>>>> With commit 076a93d797 I see IOMMUTLBEntry.addr_mask =3D=3D 0xfff w=
hich comes
>>>>>>> as ~TARGET_PAGE_MASK from flatview_do_translate(). To have things w=
orking
>>>>>>> properly I applied 75e5b70e6, b021d1c044, and d542800d1e on the lev=
el of
>>>>>>> 076a93d797 and 076a93d797~1.
>>>>>> Peter, what's your take on this one?
>>>>> Commit 076a93d797 was one of the patchset where we want to provide
>>>>> sensible IOTLB entries and also that should start to work with huge
>>>>> pages.
>>>> So the issue bundamentally is that it
>>>> never produces entries larger than page size.
>>>>
>>>> Wasteful even just with huge pages, all the more
>>>> so which passthrough which could have giga-byte
>>>> entries.
>>>>
>>>> Want to try fixing that?
>>> Yes we can fix that, but I'm still not sure whether changing the
>>> interface of address_space_get_iotlb_entry() to cover adhoc regions is
>>> a good idea, because I think it's still a memory core API and imho it
>>> would still be good to have IOTLBs returned to be what the hardware
>>> will be using (always page aligned IOTLBs).  Also it would still be
>>> not ideal because vhost backend will still need to send the MISSING
>>> messages and block for each of the continuous guest memory ranges
>>> registered, so there will still be misterious delay.  Not to say
>>> logically all the caches can be invalidated too so in that sense I
>>> think it's as hacky as the vhost speedup patch mentioned below..
>>>
>>> Ideally I think vhost should be able to know when PT is enabled or
>>> disabled for the device, so the vhost backend (kernel or userspace)
>>> should be able to directly use GPA for DMA.  That might need some new
>>> vhost interface.
>> Yes but I think we don't need another API since we can send GPA->HVA map=
ping
>> via device IOTLB API when we find there's no DMA translation at all (eit=
her
>> PT or no vIOMMU).
> Jason,
>
> Do you mean what we've worked on before?
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00574.html
>
> (I just read the previous discussion on that patch, it seems to be
>   exactly what we've discussed again...)
>
> Thanks,


Right, something like that. But it's not urgent now consider this patch=20
has been merged.

Thanks


>


