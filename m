Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205C3C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E329C20754
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtLxQSSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E329C20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFFyB-0004Oc-4m
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFFxc-000407-DF
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFFxb-0008BW-4Z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:37:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36923)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFFxa-0008Aq-RP
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584704225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcucKL/sKKC1qStSl0zhu9bjtXtTUlf2/bCQHkp0jxE=;
 b=FtLxQSSfaSNRaEgJthim/LZ5BNYJfkcGodCfoq8jeXhQYPDRSw3yrBx7VylaMOj18Og3v/
 9miHJBxuXewClTAAcRwYRZvCqIXY5nS1Iv6hT0kwCt4JmduCJJoXaQ18lY+5KofWdU03m0
 5b2fRwHfTvo7NQqjKQI9vEJflF/hlLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-d8dJqfZdOw2YUGcuYocETQ-1; Fri, 20 Mar 2020 07:37:04 -0400
X-MC-Unique: d8dJqfZdOw2YUGcuYocETQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 460378010EA
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 11:37:03 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26A69BBBCA;
 Fri, 20 Mar 2020 11:36:56 +0000 (UTC)
Subject: Re: [PATCH] virtio-iommu: depend on PCI
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200320104147.643941-1-pbonzini@redhat.com>
 <c4aa30a7-6dca-c3da-9343-45cc6a9b8272@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5330f90d-6732-5c55-93e7-d436b3c054ff@redhat.com>
Date: Fri, 20 Mar 2020 12:36:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c4aa30a7-6dca-c3da-9343-45cc6a9b8272@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 3/20/20 12:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/20/20 11:41 AM, Paolo Bonzini wrote:
>> The virtio-iommu device attaches itself to a PCI bus, so it makes
>> no sense to include it unless PCI is supported---and in fact
>> compilation fails without this change.
>>
>> Reported-by: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> =C2=A0 hw/virtio/Kconfig | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
>> index d29525b36f..83122424fa 100644
>> --- a/hw/virtio/Kconfig
>> +++ b/hw/virtio/Kconfig
>> @@ -12,7 +12,7 @@ config VIRTIO_RNG
>> =C2=A0 config VIRTIO_IOMMU
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
>> -=C2=A0=C2=A0=C2=A0 depends on VIRTIO
>> +=C2=A0=C2=A0=C2=A0 depends on PCI && VIRTIO
>> =C2=A0 =C2=A0 config VIRTIO_PCI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> I see hw/virtio/virtio-iommu-pci.c apart, what is the difference?
That's the virtio-iommu pci proxy whereas TYPE_VIRTIO_IOMMU inherits
from TYPE_VIRTIO_DEVICE.

The virtio-iommu device could also be instantiated directly as a
TYPE_VIRTIO_IOMMU device but that's not the choice eventually made for
machvirt.

Thanks

Eric

>=20


