Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2382C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BECB20659
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX4PNcwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BECB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZELD-0001m4-JI
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iZECn-0004Nd-Bb
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iZECk-0002ya-UI
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:15:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35900
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iZECi-0002wV-Ud
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574687695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRWuMLeGzCMUskZLTKN0weGeFC9AcDT2It3tBZMeekc=;
 b=BX4PNcwFXSXkF+vo804XJsJgUkp4a+jiGgoLRXsuchPkyPjAk1LXgYyoZScmPoBQMRZxFk
 LqGhLjxyIKl2Rax5pG3jlCwa+h7BkGvWbLL+KrKZ+Mqm34r9agKSDe2Fu11yH3wTVHpsdh
 laVfmPuE/ml6+muBuyW+GnW4MjmTV2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-N6daUUm6M2-8NIivTWpaLQ-1; Mon, 25 Nov 2019 08:14:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01375800580;
 Mon, 25 Nov 2019 13:14:53 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0F0A5C1D4;
 Mon, 25 Nov 2019 13:14:40 +0000 (UTC)
Subject: Re: [PATCH for-4.2 v10 06/15] virtio-iommu: Endpoint and domains
 structs and helpers
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-7-eric.auger@redhat.com>
 <20191104183131.GA3540585@lophozonia>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <274cfd7e-7aae-5754-31d5-f0434fb8a5c8@redhat.com>
Date: Mon, 25 Nov 2019 14:14:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191104183131.GA3540585@lophozonia>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: N6daUUm6M2-8NIivTWpaLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, peterx@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,
On 11/4/19 7:31 PM, Jean-Philippe Brucker wrote:
> Hi Eric,
> 
> On Tue, Jul 30, 2019 at 07:21:28PM +0200, Eric Auger wrote:
>>  static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
>>  {
>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
>> +
>> +    g_tree_destroy(s->domains);
>> +    g_tree_destroy(s->endpoints);
> 
> virtio_iommu_device_reset() must completely clear the internal state as
> well (noticed while testing modprobe/rmmod).
I just noticed I forgot to take into account this comment in v11.

I will fix that shortly.

Thanks

Eric
> 
> Thanks,
> Jean
> 


