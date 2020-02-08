Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED4C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D9021741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ofw1fYQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D9021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0QgP-00017o-A5
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 09:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j0Qfg-0000bV-3A
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j0Qfd-0001gO-Mr
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:01:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j0Qfd-0001d1-3J
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581170476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CkhUHqSDfzg8BXvadVBEQhUSFJT7WpEfFdu88HfXAs=;
 b=Ofw1fYQ44sx35SlvrtV2X/Xuu5KoXm+34V362/uv0ng/JdRucra5Z0W6MJi4UPVrfrcst4
 zTFXDBao2hpmnuVARWBuUfM6DKN/NbmxtfESzViIRJJH3zOTGA4i816M0aRtVwEpJUf7Ke
 ugoAH/AKy9Z+5U6JW6UKVhFdn7iPRjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-CQzk8OopPkqjONcu7k5rRw-1; Sat, 08 Feb 2020 09:01:11 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D7768018A2;
 Sat,  8 Feb 2020 14:01:09 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF73610021B2;
 Sat,  8 Feb 2020 14:00:57 +0000 (UTC)
Subject: Re: [PATCH v15 3/9] virtio-iommu: Implement attach/detach command
To: Peter Xu <peterx@redhat.com>
References: <20200208120022.1920-1-eric.auger@redhat.com>
 <20200208120022.1920-4-eric.auger@redhat.com> <20200208134154.GD823968@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <73abec19-86b2-099c-1a13-8725561d915f@redhat.com>
Date: Sat, 8 Feb 2020 15:00:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200208134154.GD823968@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: CQzk8OopPkqjONcu7k5rRw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/8/20 2:41 PM, Peter Xu wrote:
> On Sat, Feb 08, 2020 at 01:00:16PM +0100, Eric Auger wrote:
>> This patch implements the endpoint attach/detach to/from
>> a domain.
>>
>> Domain and endpoint internal datatypes are introduced.
>> Both are stored in RB trees. The domain owns a list of
>> endpoints attached to it. Also helpers to get/put
>> end points and domains are introduced.
>>
>> As for the IOMMU memory regions, a callback is called on
>> PCI bus enumeration that initializes for a given device
>> on the bus hierarchy an IOMMU memory region. The PCI bus
>> hierarchy is stored locally in IOMMUPciBus and IOMMUDevice
>> objects.
>>
>> At the time of the enumeration, the bus number may not be
>> computed yet.
>>
>> So operations that will need to retrieve the IOMMUdevice
>> and its IOMMU memory region from the bus number and devfn,
>> once the bus number is garanteed to be frozen, use an array
>> of IOMMUPciBus, lazily populated.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> (Hope this is the last one missing r-b besides patch 8, I'll leave
>  patch 8 for the others or Michael when merging)

Sure. Many thanks!

Best Regards

Eric
> 
> Thanks,
> 


