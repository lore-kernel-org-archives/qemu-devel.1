Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E962C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC13D20801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ab0l92Of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC13D20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70ia-0001pr-4j
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j70ho-00013f-Q7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:42:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j70hn-0005kn-Ob
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:42:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j70hn-0005iv-Ki
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582738963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7vlve06xJUYKViIfIetyL+xd4OQb6eg8G10/jwSB78=;
 b=Ab0l92OfunGf6NISMsJeN8UHPZKGT+JMKcde7Wo6njw6kuKSJrtGHhKd5CLSfklpDd3aCF
 dr7tIFN6Zj64/ubmPaqAVOMbYPGMQIPA5XR8dsG7mXWVz86TvwAo0N5vkHE/sNhXdaTQgu
 A5bQEyqNuowT0fehxsCWB/jg6yKIX3I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-H3UN4L9aP1y_r51KpJ0Tvw-1; Wed, 26 Feb 2020 12:42:41 -0500
X-MC-Unique: H3UN4L9aP1y_r51KpJ0Tvw-1
Received: by mail-wm1-f72.google.com with SMTP id m4so1191168wmi.5
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 09:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j/IpPYrRgI6zE/eaofYXVxetlw0aFn3xDxEy6HlGXfE=;
 b=Vm4XA1RWFbEe5DWI8uxAzxViFQrFxccdKVwK9OsbvFj+aKxZUopXthbsdJhVELiDv2
 NRPjYzcg2xcwMBV+hLP4MEIMKlyMjmYWHudN8t48CKiAciZpXLucEy2kHo3GpbaEI+1c
 ZRY77edydjtU3tl7WNgCblhdgk1M/dWoHqCYFYA79NqOetxAMBi77Dfi7L+1iC+DyGH5
 gtkRHTc0DVQ/8SyFZFQ6JJGD2fHqlBEA3zmEIPKDRVsASxgtWZbbG6/d0ucu+SZbJxk5
 0LkPyVeYYw0O279V2yykukOip05+f3h3KYzWx7+7Wd9K5TgceA4ZqX4+Zhkx+2HjeRb7
 wa3Q==
X-Gm-Message-State: APjAAAUpy0ghQ9v2nR2JBLFLPsD9s0GzmRMFrAP0FpxyA7qLnIYf6Skb
 tHAoaxaDHX4b29ZBM3saMlAC1sncXdPs+BQkzYkMu15eBSOIfaSV+twVgKYiEqJa/nyyMGxoKk/
 HTyMZ5R6pVvgOLDA=
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr2988wmj.27.1582738958038;
 Wed, 26 Feb 2020 09:42:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUD9xDRVnpCGiz1xi7dgHfQLSAHLTEwEGbBeEJD5b+0lkQhPWE0RFIEHXBe7we3+vo6qDHIQ==
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr2916wmj.27.1582738956906;
 Wed, 26 Feb 2020 09:42:36 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id x6sm4129174wrr.6.2020.02.26.09.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 09:42:36 -0800 (PST)
Subject: Re: [PATCH] hw/arm/smmu-common: a fix to smmu_find_smmu_pcibus
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 peterx@redhat.com
References: <20200226172628.17449-1-eric.auger@redhat.com>
 <6f82ec7a-fb74-a47a-100b-325d5de36a7d@redhat.com>
Message-ID: <039d7268-9884-8a29-890b-8e06dd2a0994@redhat.com>
Date: Wed, 26 Feb 2020 18:42:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6f82ec7a-fb74-a47a-100b-325d5de36a7d@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 6:37 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eric,
>=20
> On 2/26/20 6:26 PM, Eric Auger wrote:
>> Make sure a null SMMUPciBus is returned in case we were
>> not able to identify a pci bus matching the @bus_num.
>>
>> This matches the fix done on intel iommu in commit:
>> a2e1cd41ccfe796529abfd1b6aeb1dd4393762a2
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> =C2=A0 hw/arm/smmu-common.c | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 0f2573f004..67d7b2d0fd 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -301,6 +301,7 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s,=20
>> uint8_t bus_num)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return smmu_pci_bus;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmu_pci_bus =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return smmu_pci_bus;
>> =C2=A0 }
>>
>=20
> Patch is easy to review but code not. By inverting the if() statement I=
=20
> find the code easier to review. The patch isn't however:

I used 'git-diff -W' instead of 'git-diff -w'. -w works better:

-- >8 --
@@ -290,10 +290,12 @@ inline int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t=20
iova, IOMMUAccessFlags perm,
  SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
  {
      SMMUPciBus *smmu_pci_bus =3D s->smmu_pcibus_by_bus_num[bus_num];
-
-    if (!smmu_pci_bus) {
      GHashTableIter iter;

+    if (smmu_pci_bus) {
+        return smmu_pci_bus;
+    }
+
      g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
      while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
          if (pci_bus_num(smmu_pci_bus->bus) =3D=3D bus_num) {
@@ -301,8 +303,8 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s,=20
uint8_t bus_num)
              return smmu_pci_bus;
          }
      }
-    }
-    return smmu_pci_bus;
+
+    return NULL;
  }

---

>=20
> The code is easier although:
>=20
> SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
> {
>  =C2=A0=C2=A0=C2=A0 SMMUPciBus *smmu_pci_bus =3D s->smmu_pcibus_by_bus_nu=
m[bus_num];
>  =C2=A0=C2=A0=C2=A0 GHashTableIter iter;
>=20
>  =C2=A0=C2=A0=C2=A0 if (smmu_pci_bus) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return smmu_pci_bus;
>  =C2=A0=C2=A0=C2=A0 }
>=20
>  =C2=A0=C2=A0=C2=A0 g_hash_table_iter_init(&iter, s->smmu_pcibus_by_buspt=
r);
>  =C2=A0=C2=A0=C2=A0 while (g_hash_table_iter_next(&iter, NULL, (void **)&=
smmu_pci_bus)) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pci_bus_num(smmu_pci_bus-=
>bus) =3D=3D bus_num) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->sm=
mu_pcibus_by_bus_num[bus_num] =3D smmu_pci_bus;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n smmu_pci_bus;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0 }
>=20
>  =C2=A0=C2=A0=C2=A0 return NULL;
> }
>=20
> What do you think?


