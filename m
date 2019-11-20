Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63F6C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DA42071F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyxphT1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DA42071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTH8-0005hz-UP
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXTGU-0005EW-8p
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXTGQ-0006h2-CX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:55:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23423
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXTGQ-0006gY-8o
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574268933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqtaaO74CK+zqbOK7oGQYqfEMiBBoglIBLi6Rv7C+A0=;
 b=EyxphT1hi7NMAjlT2hkRiU4B3iTk464Jcf4iDWJ+jw723B8dreFl8TbW0uA58MFkBlY9BI
 mWWPFLV8GfNZa6smOkZ3K2yzK+E7+Jni3ROXOU5H8dByKpXIT53nAf9GiWbA+3xcQ2x0K3
 uN7DcUhGvZRYFPQmbPLndpyP8d0DJh8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-S7SlVGuDMFWpy2oEry_cvg-1; Wed, 20 Nov 2019 11:55:30 -0500
Received: by mail-wm1-f71.google.com with SMTP id l184so5641147wmf.6
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6CxAziAqJD7S4v9/BeQ9/E5WhLPUJV15g0msv/Efy5c=;
 b=uHGHGR4TX8gS/RIlBRAA/KeJpnVk0Czq7dnQX1iGzZRKK6/pUK9lDK7KlwI2Nx52C2
 v7LwaF4zQN5yLmJ4saNRPGdDmCVF8HfnFxd/Aw6P8GqQ5WWqDvP6W/je2NAKkyDGOfyi
 NhG5YE6nGcmyVtEBiFGizoz8i3H8zJvgnzQ2Hn0tHuMSM7BFaHbStg1bGdcpiVEOMr/N
 V422jTdO2aseD7SzF0s3GKGSYbsgcYFzIDq5j2Zyy+5KogVpYdMCdGRl1MUCVVZIWE2M
 tzI0aDVs/6L5wt7g1lhegsfX4cVSvvz6OCwPCuu6MNKVJdYkaRIldkUwg4B/iJlSKMrI
 YJnA==
X-Gm-Message-State: APjAAAWXnvaOCgF7qHRCFmozBu/4saq7eXW8zXa+zjsWI9i4yREVRvCH
 mq0SiTEnK6e8qeiSOAG16DZfEcdBc3E51j7Amzj7IskjIWbiwT+tvKTGjHY3NT7gLRGyXxslbkA
 IRAPKy93THcSxDHQ=
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr4345457wmh.45.1574268928812; 
 Wed, 20 Nov 2019 08:55:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTx3x1U8b8CS62vTjCVcYENQ83tGkE+SKgUtR0whvXqc9ehsucNvzbVFyRtcg3+7H/qC38Mg==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr4345431wmh.45.1574268928530; 
 Wed, 20 Nov 2019 08:55:28 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id j67sm7141471wmb.43.2019.11.20.08.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 08:55:27 -0800 (PST)
Subject: Re: [PATCH] RFC: CODING_STYLE: describe "self" variable convention
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20191120125444.31365-1-marcandre.lureau@redhat.com>
 <bb4b636d-99d0-4fbe-c4bb-ec3d5c480a03@redhat.com>
 <CAMxuvazJkTDX4Mwf1zUp7NXTa9ZoUSxwwBw1Q7zOS-+UspSxdw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7a18793-416a-21b0-eabd-ca868cca113e@redhat.com>
Date: Wed, 20 Nov 2019 17:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvazJkTDX4Mwf1zUp7NXTa9ZoUSxwwBw1Q7zOS-+UspSxdw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: S7SlVGuDMFWpy2oEry_cvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 5:35 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Nov 20, 2019 at 8:05 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> On 11/20/19 1:54 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> Following the discussion in thread "[PATCH v3 13/33] serial: start
>>> making SerialMM a sysbus device", I'd like to recommend the usage of
>>> "self" variable to reference to the OOP-style method instance, as
>>> commonly done in various languages and in GObject world.
>>>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    CODING_STYLE.rst | 38 ++++++++++++++++++++++++++++++++------
>>>    1 file changed, 32 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
>>> index 427699e0e4..cb6635af71 100644
>>> --- a/CODING_STYLE.rst
>>> +++ b/CODING_STYLE.rst
>>> @@ -102,12 +102,38 @@ Rationale:
>>>    Naming
>>>    =3D=3D=3D=3D=3D=3D
>>>
>>> -Variables are lower_case_with_underscores; easy to type and read.  Str=
uctured
>>> -type names are in CamelCase; harder to type but standing out.  Enum ty=
pe
>>> -names and function type names should also be in CamelCase.  Scalar typ=
e
>>> -names are lower_case_with_underscores_ending_with_a_t, like the POSIX
>>> -uint64_t and family.  Note that this last convention contradicts POSIX
>>> -and is therefore likely to be changed.
>>> +Variables are lower_case_with_underscores; easy to type and read.
>>> +
>>> +The most common naming for a variable is an abbreviation of the type
>>> +name.  Some common examples:
>>> +
>>> +.. code-block:: c
>>> +
>>> +    Object *obj;
>>> +    QVirtioSCSI *scsi;
>>> +    SerialMM *smm;
>>> +
>>> +When writing QOM/OOP-style function, a "self" variable allows to refer
>>> +without ambiguity to the instance of the method that is being
>>> +implemented (this is not very common in QEMU code base, but it is
>>> +often a good option to increase the readability and consistency,
>>> +making further refactoring easier as well).  Example:
>>> +
>>> +.. code-block:: c
>>> +
>>> +    serial_mm_flush(SerialMM *self);
>>> +
>>> +    serial_mm_instance_init(Object *o) {
>>> +        SerialMM *self =3D SERIAL_MM(o);
>>> +        ..
>>> +    }
>>> +
>>> +Structured type names are in CamelCase; harder to type but standing
>>> +out.  Enum type names and function type names should also be in
>>> +CamelCase.  Scalar type names are
>>> +lower_case_with_underscores_ending_with_a_t, like the POSIX uint64_t
>>> +and family.  Note that this last convention contradicts POSIX and is
>>> +therefore likely to be changed.
>>>
>>>    When wrapping standard library functions, use the prefix ``qemu_`` t=
o alert
>>>    readers that they are seeing a wrapped version; otherwise avoid this=
 prefix.
>>>
>>
>> So in this example:
>>
>> static void pci_unin_agp_init(Object *obj)
>> {
>>       UNINHostState *s =3D UNI_NORTH_AGP_HOST_BRIDGE(obj);
>>       SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>>       PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
>>
>>       /* Uninorth AGP bus */
>>       memory_region_init_io(&h->conf_mem, OBJECT(h),
>>                             &pci_host_conf_le_ops,
>>                             obj, "unin-agp-conf-idx", 0x1000);
>>       memory_region_init_io(&h->data_mem, OBJECT(h),
>>                             &pci_host_data_le_ops,
>>                             obj, "unin-agp-conf-data", 0x1000);
>>
>>       object_property_add_link(obj, "pic", TYPE_OPENPIC,
>>                                (Object **) &s->pic,
>>                                qdev_prop_allow_set_link_before_realize,
>>                                0, NULL);
>>
>>       sysbus_init_mmio(sbd, &h->conf_mem);
>>       sysbus_init_mmio(sbd, &h->data_mem);
>> }
>>
>> You would change 'Object *obj' -> 'Object *self'?
>=20
> static void pci_unin_agp_init(Object *obj)
> {
>    UNINHostState *self =3D UNI_NORTH_AGP_HOST_BRIDGE(obj);
>    ..
>=20
>=20
> When you override a parent method, you can create aliases for the
> parent types with the abbreviation rule if necessary. But often, there
> are less references to the parent types than the actual type you
> implement, so in many cases, PARENT(self) can be less confusing. Your
> example is a perhaps a bit more complicated than usual. Yet, having
> "self" for the type we are implementing is still more readable to me.

With your example I understand better "'self' for the instance type" you=20
say below, which is "'self' variable allows to refer without ambiguity=20
to the instance of the method that is being implemented" from the doc. OK.

>=20
>>
>> But here we want to keep 'klass', right?
>>
>> static void gpex_host_class_init(ObjectClass *klass, void *data)
>> {
>>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>>       PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
>>
>>       hc->root_bus_path =3D gpex_host_root_bus_path;
>>       dc->realize =3D gpex_host_realize;
>>       set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>>       dc->fw_name =3D "pci";
>> }
>=20
>=20
> If we follow a similar rule for class methods, I would suggest:
>=20
> static void gpex_host_class_init(ObjectClass *oc, void *data)
> {
>    GPEXClass *klass =3D GPEX_CLASS(oc);

Clean.

>=20
> But in general, class_init has more code dealing with various parent
> types, to override parent methods.

Yes, you are right.

>=20
>>
>> Maybe we should restrict 'self' as name of Object type only?
>> But your example is with SerialMM, so no?
>>
>=20
> "self" for the instance type, "klass" for the the class type.
>=20


