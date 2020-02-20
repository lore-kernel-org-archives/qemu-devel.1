Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D79C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C659D206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgxgbI7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C659D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lpn-00047z-VL
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4loG-0001dd-Fd
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4loE-0003vC-Md
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:24:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4loE-0003us-JK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582205046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OimKndY8Wc6V5KKVZusL/KwxwNRq09ftVTZGs3QdCTA=;
 b=QgxgbI7uYY4hplwqMVay8EnpBGv7xhQ1bPsUGdKy8gtZ5Tk4sh5cwTTcpIBpO970lDejnu
 nI1HWk2SqXuvbmOx577t0FdDWJDSikpmJFbwRWjDLJBTzok2r2uL+vx6o7HOmf7spoRmcG
 dClPXFroOWqrpifLz7G11enV8H2UzAI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-ueyZa2KJO6ycaM1m90ZiOg-1; Thu, 20 Feb 2020 08:24:04 -0500
X-MC-Unique: ueyZa2KJO6ycaM1m90ZiOg-1
Received: by mail-ed1-f71.google.com with SMTP id g11so2679074edu.10
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MHg/5UrUaWqOGPMbBFxMDVDMQH9eo1mTFc5tISJLXMw=;
 b=hy+kQeqTHcJ1aN96/cqiWOensZlCxoUBfH4k44qTL4UBrvatFHcKwVMBE8Q0jQAL1E
 WnzpgMnk2G1ObMHZ8q2Go/a1OFcdgjpkYcfDvE1rpqpxzgDX5S1bqhNeK8+3r6htLayb
 9tx1gJxLuinzq9T4hJrZBWvtPGH+GyPwfR9FNM6Kb2dmq7AZcg4pHrEN4vkvrbqPclMV
 N4OxMJrEtDQ5GKwJB2FHLGNhuUdImwkOWSGmfc9g/CNOEkh4fTRZcJ98VuelXKLouKgW
 xEKopo5089nQ8wYg2Nb0jhFEKBYAL5piwuzIOqYVl376lCiqeUnFEJ+qS5AQDQCLU51N
 9mEQ==
X-Gm-Message-State: APjAAAVkg/P6151+JcuG2/NatsxXtXC96cpSrTIDUK0tv9nRFx7rxE0N
 c9ulEfMiZycUZSGqoCDuULWvhAhv9biLTVNIPPeoNHI2jTtNL090SQ9YU2pB1TEoe+PMGFgEVn7
 xO/KnMEzMR//+OOo=
X-Received: by 2002:a50:fc05:: with SMTP id i5mr29170818edr.343.1582205042961; 
 Thu, 20 Feb 2020 05:24:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqznBcBibxmOR37VsiYJJjL+jelcdk8lkiHN5SpgVrHqzRKo/B7Z+Qf6ZCdlOSA+ufQfA3o7ew==
X-Received: by 2002:a50:fc05:: with SMTP id i5mr29170765edr.343.1582205042706; 
 Thu, 20 Feb 2020 05:24:02 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l11sm99933edi.28.2020.02.20.05.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 05:24:02 -0800 (PST)
Subject: Re: [PATCH v3 03/20] exec: Let qemu_ram_*() functions take a const
 pointer argument
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200220130548.29974-1-philmd@redhat.com>
 <20200220130548.29974-4-philmd@redhat.com>
 <fce0956e-e542-e8a5-bd02-a7941a9db627@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <34fc1b00-4e95-6235-3e82-294b572a209b@redhat.com>
Date: Thu, 20 Feb 2020 14:23:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fce0956e-e542-e8a5-bd02-a7941a9db627@redhat.com>
Content-Language: en-US
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 2:21 PM, Paolo Bonzini wrote:
> On 20/02/20 14:05, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   include/exec/cpu-common.h     | 6 +++---
>>   include/sysemu/xen-mapcache.h | 4 ++--
>>   exec.c                        | 8 ++++----
>>   hw/i386/xen/xen-mapcache.c    | 2 +-
>>   4 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 81753bbb34..05ac1a5d69 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -48,11 +48,11 @@ typedef uint32_t CPUReadMemoryFunc(void *opaque, hwa=
ddr addr);
>>  =20
>>   void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
>>   /* This should not be used by devices.  */
>> -ram_addr_t qemu_ram_addr_from_host(void *ptr);
>> +ram_addr_t qemu_ram_addr_from_host(const void *ptr);
>=20
> This is a bit ugly, because the pointer _can_ be modified via
> qemu_map_ram_ptr.

OK.

> Is this needed for the rest of the series to apply?

No!

> Paolo
>=20
>>   RAMBlock *qemu_ram_block_by_name(const char *name);
>> -RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>> +RAMBlock *qemu_ram_block_from_host(const void *ptr, bool round_offset,
>>                                      ram_addr_t *offset);
>> -ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
>> +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, const void *host);
>>   void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState=
 *dev);
>>   void qemu_ram_unset_idstr(RAMBlock *block);
>>   const char *qemu_ram_get_idstr(RAMBlock *rb);
>> diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache=
.h
>> index c8e7c2f6cf..81e9aa2fa6 100644
>> --- a/include/sysemu/xen-mapcache.h
>> +++ b/include/sysemu/xen-mapcache.h
>> @@ -19,7 +19,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f,
>>                           void *opaque);
>>   uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
>>                          uint8_t lock, bool dma);
>> -ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
>> +ram_addr_t xen_ram_addr_from_mapcache(const void *ptr);
>>   void xen_invalidate_map_cache_entry(uint8_t *buffer);
>>   void xen_invalidate_map_cache(void);
>>   uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
>> @@ -40,7 +40,7 @@ static inline uint8_t *xen_map_cache(hwaddr phys_addr,
>>       abort();
>>   }
>>  =20
>> -static inline ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>> +static inline ram_addr_t xen_ram_addr_from_mapcache(const void *ptr)
>>   {
>>       abort();
>>   }
>> diff --git a/exec.c b/exec.c
>> index 8e9cc3b47c..02b4e6ea41 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -2614,7 +2614,7 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_blo=
ck, ram_addr_t addr,
>>   }
>>  =20
>>   /* Return the offset of a hostpointer within a ramblock */
>> -ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
>> +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, const void *host)
>>   {
>>       ram_addr_t res =3D (uint8_t *)host - (uint8_t *)rb->host;
>>       assert((uintptr_t)host >=3D (uintptr_t)rb->host);
>> @@ -2640,11 +2640,11 @@ ram_addr_t qemu_ram_block_host_offset(RAMBlock *=
rb, void *host)
>>    * pointer, such as a reference to the region that includes the incomi=
ng
>>    * ram_addr_t.
>>    */
>> -RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>> +RAMBlock *qemu_ram_block_from_host(const void *ptr, bool round_offset,
>>                                      ram_addr_t *offset)
>>   {
>>       RAMBlock *block;
>> -    uint8_t *host =3D ptr;
>> +    const uint8_t *host =3D ptr;
>>  =20
>>       if (xen_enabled()) {
>>           ram_addr_t ram_addr;
>> @@ -2705,7 +2705,7 @@ RAMBlock *qemu_ram_block_by_name(const char *name)
>>  =20
>>   /* Some of the softmmu routines need to translate from a host pointer
>>      (typically a TLB entry) back to a ram offset.  */
>> -ram_addr_t qemu_ram_addr_from_host(void *ptr)
>> +ram_addr_t qemu_ram_addr_from_host(const void *ptr)
>>   {
>>       RAMBlock *block;
>>       ram_addr_t offset;
>> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
>> index 5b120ed44b..432ad3354d 100644
>> --- a/hw/i386/xen/xen-mapcache.c
>> +++ b/hw/i386/xen/xen-mapcache.c
>> @@ -363,7 +363,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size=
,
>>       return p;
>>   }
>>  =20
>> -ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>> +ram_addr_t xen_ram_addr_from_mapcache(const void *ptr)
>>   {
>>       MapCacheEntry *entry =3D NULL;
>>       MapCacheRev *reventry;
>>
>=20


