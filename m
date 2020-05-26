Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED057C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02EE20723
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L68bqoMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02EE20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdaoa-0002FM-Qm
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 10:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jdao1-0001nu-0S
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:43:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jdany-0003VX-Nb
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590504224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RUsbo4Ph0BszyGe//riS/THGOvzJXZxI/OeyY29DmYc=;
 b=L68bqoMSZaVEChlVTB2Hqpd5Y8i2X9L+Ew971sY96X2ZEhSEXJ3azx/nsnc7dmCeuRqtXS
 rX8MeYgxku2qMDepssGcjtf1rgaWK4DLn+2j6J35GZ5l4iRp/g2iDGOjbFvSp86n2AFpJw
 yRUytfMFT+f7YhEzHBYDFAaTKMZ6isA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-m2mL38nyOVipdzF5DvEtXw-1; Tue, 26 May 2020 10:43:42 -0400
X-MC-Unique: m2mL38nyOVipdzF5DvEtXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F7BA80183C;
 Tue, 26 May 2020 14:43:41 +0000 (UTC)
Received: from [10.36.114.130] (ovpn-114-130.ams2.redhat.com [10.36.114.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CDA96EA47;
 Tue, 26 May 2020 14:43:36 +0000 (UTC)
Subject: Re: [PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices on
 all buses
To: Vivek Goyal <vgoyal@redhat.com>
References: <20200525084511.51379-1-david@redhat.com>
 <20200526132840.GD108774@redhat.com>
 <dddadb61-b0af-a9c0-64f8-ac3c47d37566@redhat.com>
 <20200526142219.GE108774@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <32210631-5933-088c-52e5-9e9eb2d800e3@redhat.com>
Date: Tue, 26 May 2020 16:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526142219.GE108774@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26.05.20 16:22, Vivek Goyal wrote:
> On Tue, May 26, 2020 at 03:44:10PM +0200, David Hildenbrand wrote:
>> On 26.05.20 15:28, Vivek Goyal wrote:
>>> On Mon, May 25, 2020 at 10:45:11AM +0200, David Hildenbrand wrote:
>>>> E.g., with "pc-q35-4.2", trying to coldplug a virtio-pmem-pci devices
>>>> results in
>>>>     "virtio-pmem-pci not supported on this bus"
>>>>
>>>> Reasons is, that the bus does not support hotplug and, therefore, does
>>>> not have a hotplug handler. Let's allow coldplugging virtio-pmem devices
>>>> on such buses. The hotplug order is only relevant for virtio-pmem-pci
>>>> when the guest is already alive and the device is visible before
>>>> memory_device_plug() wired up the memory device bits.
>>>>
>>>> Hotplug attempts will still fail with:
>>>>     "Error: Bus 'pcie.0' does not support hotplugging"
>>>>
>>>> Hotunplug attempts will still fail with:
>>>>     "Error: Bus 'pcie.0' does not support hotplugging"
>>>>
>>>> Reported-by: Vivek Goyal <vgoyal@redhat.com>
>>>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Cc: Richard Henderson <rth@twiddle.net>
>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  hw/i386/pc.c | 18 ++++++++++--------
>>>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>>
>>> Thanks for the patch David. I still seem to face a different error though.
>>>
>>> 2020-05-26T13:26:05.720617Z qemu-system-x86_64: -device virtio-pmem-pci,memdev=pmem1,id=nv1: memory devices (e.g. for memory hotplug) are not enabled, please specify the maxmem option
>>>
>>> Following is my domain xml file.
>>>
>>> Vivek
>>
>> Hi Vivek,
>>
>> you have to declare the maxMemory option. Memory devices like
>> virtio-pmem-pci reside in RAM like a pc-dimm or a nvdimm. If your
>> virtio-pmem device will be 4GB, you have to add that to maxMemory.
>>
>>   <memory unit='GiB'>64</memory>
>>   <maxMemory unit='GiB'>68</maxMemory>
>>   <currentMemory unit='GiB'>64</currentMemory>
>>
>> (you might have to add "slots='0'" or "slots='1'" to maxMemory to make
>> libvirt happy)
> 
> Ok, tried that.
> 
> <maxMemory slots='1' unit='KiB'>134217728</maxMemory>
> 
> And now it complains about.
> 
> error: unsupported configuration: At least one numa node has to be configured when enabling memory hotplug
> 
> So ultimately it seems to be wanting me to somehow enable memory hotplug
> to be able to use virtio-pmem?

That's a libvirt error message. Maybe I am confused how libvirt maps
these parameters to QEMU ...

NVDIMMs under libvirt seem to be easy:

https://www.redhat.com/archives/libvir-list/2016-August/msg00055.html

Maybe the issue is that virtio-pmem has not been properly integrated
into libvirt yet:

https://www.redhat.com/archives/libvir-list/2019-August/msg00007.html

And you attempts to force virtio-pmem in via qemu args does not work
properly.

Maybe maxMemory in libvirt does not directly map to the QEMU variant to
define the maximum physical address space reserved also for any memory
devices (DIMMs, NVDIMMs, virtio-pmem, ...). Any libvirt experts that can
help?

@Pankaj, did you ever get it to run with libvirt?

> 
> Thanks
> Vivek


-- 
Thanks,

David / dhildenb


