Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98193C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 06:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1EB20578
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 06:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1EB20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAT6U-0000rt-Eo
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 02:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iAT4R-0000DX-EF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 02:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iAT4O-0006GX-Te
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 02:04:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53012)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iAT4O-0006Fi-MV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 02:04:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1885B3167E57;
 Wed, 18 Sep 2019 06:04:03 +0000 (UTC)
Received: from [10.72.12.111] (ovpn-12-111.pek2.redhat.com [10.72.12.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B06E600C8;
 Wed, 18 Sep 2019 06:03:58 +0000 (UTC)
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <20190917085404.3b063e53@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57AFBA@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a82101bf-f8a7-5ddd-5abe-6060762d9abe@redhat.com>
Date: Wed, 18 Sep 2019 14:03:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D57AFBA@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 18 Sep 2019 06:04:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
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
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/9/18 =E4=B8=8A=E5=8D=889:31, Tian, Kevin wrote:
>> From: Alex Williamson [mailto:alex.williamson@redhat.com]
>> Sent: Tuesday, September 17, 2019 10:54 PM
>>
>> On Tue, 17 Sep 2019 08:48:36 +0000
>> "Tian, Kevin"<kevin.tian@intel.com>  wrote:
>>
>>>> From: Jason Wang [mailto:jasowang@redhat.com]
>>>> Sent: Monday, September 16, 2019 4:33 PM
>>>>
>>>>
>>>> On 2019/9/16 =E4=B8=8A=E5=8D=889:51, Tian, Kevin wrote:
>>>>> Hi, Jason
>>>>>
>>>>> We had a discussion about dirty page tracking in VFIO, when vIOMMU
>>>>> is enabled:
>>>>>
>>>>> https://lists.nongnu.org/archive/html/qemu-devel/2019-
>>>> 09/msg02690.html
>>>>> It's actually a similar model as vhost - Qemu cannot interpose the =
fast-
>>>> path
>>>>> DMAs thus relies on the kernel part to track and report dirty page
>>>> information.
>>>>> Currently Qemu tracks dirty pages in GFN level, thus demanding a
>>>> translation
>>>>> from IOVA to GPA. Then the open in our discussion is where this
>>>> translation
>>>>> should happen. Doing the translation in kernel implies a device iot=
lb
>>>> flavor,
>>>>> which is what vhost implements today. It requires potentially large
>>>> tracking
>>>>> structures in the host kernel, but leveraging the existing log_sync=
 flow
>> in
>>>> Qemu.
>>>>> On the other hand, Qemu may perform log_sync for every removal of
>>>> IOVA
>>>>> mapping and then do the translation itself, then avoiding the GPA
>>>> awareness
>>>>> in the kernel side. It needs some change to current Qemu log-sync
>> flow,
>>>> and
>>>>> may bring more overhead if IOVA is frequently unmapped.
>>>>>
>>>>> So we'd like to hear about your opinions, especially about how you
>> came
>>>>> down to the current iotlb approach for vhost.
>>>> We don't consider too much in the point when introducing vhost. And
>>>> before IOTLB, vhost has already know GPA through its mem table
>>>> (GPA->HVA). So it's nature and easier to track dirty pages at GPA le=
vel
>>>> then it won't any changes in the existing ABI.
>>> This is the same situation as VFIO.
>> It is?  VFIO doesn't know GPAs, it only knows HVA, HPA, and IOVA.  In
>> some cases IOVA is GPA, but not all.
> Well, I thought vhost has a similar design, that the index of its mem t=
able
> is GPA when vIOMMU is off and then becomes IOVA when vIOMMU is on.
> But I may be wrong here. Jason, can you help clarify? I saw two
> interfaces which poke the mem table: VHOST_SET_MEM_TABLE (for GPA)
> and VHOST_IOTLB_UPDATE (for IOVA). Are they used exclusively or togethe=
r?
>

Actually, vhost maintains two interval trees, mem table GPA->HVA, and=20
device IOTLB IOVA->HVA. Device IOTLB is only used when vIOMMU is=20
enabled, and in that case mem table is used only when vhost need to=20
track dirty pages (do reverse lookup of memtable to get HVA->GPA). So in=20
conclusion, for datapath, they are used exclusively, but they need=20
cowork for logging dirty pages when device IOTLB is enabled.

Thanks


