Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3268C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA5520715
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="peFyEVuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA5520715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSpr-0002yj-Oq
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXSmq-0008CB-6R
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXSmo-0003kR-GW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:24:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXSmo-0003k6-7u
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:24:58 -0500
Received: by mail-wm1-x343.google.com with SMTP id q70so238454wme.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+4TVRGp4SHHLp9u5QDmtdvvixLjJO1dkEfdf96ZmQJY=;
 b=peFyEVuH8LsTp+u99vePYzTDKoJ6KNuQEQPIaK5o1d9cDgFpPcj2khCS78ENilPqIb
 drDMlavQu3o7ShxAIQvXD21nGU4DhdLoZt1PnzqkBvj6OTNnlUuCa/RGRVf4NtyqtkTy
 ImiFKoQRF22krYkxlqh/baV1fn7bcXkylJ9d4oJQXXQJMe9uj5d74yt3EFLQRfKorFxh
 75AtsxJqEds8GLCHlPTnh5BzLEKnTUJTdiBsU61EQ9vfokkJ47UbJP+u6KkKxRdhZNWq
 SVCsDGI4SVJ63QGs0iotD0nWVv0uGXk/29l7IjEhgrsi258DxT7VNZ60hkzu0OwP1KaW
 urww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+4TVRGp4SHHLp9u5QDmtdvvixLjJO1dkEfdf96ZmQJY=;
 b=jImmuCQlUolxb1k+N2W/DfCncjEW/i800zGpZrC5qnfNGR0eVwgB69Zh8lkrzZ1FC1
 3bJDjfCV2vZ456aCtFSrBG4Y+FbKVoSPSV/+DjKcLBhpMm0V7x3hPcm5Fh5RjW1t7k/k
 OW6/kPEwumABLuvlVs+vyhezm7+u32U7nxrsh5ZVOBN73075LdmhlGb+rY52g4Ev2Ifc
 qJdiT0dIKrhK3Lid1XnwhMQEuX8BsgLUp+3CQaXNQPbrdLDDtMwWPMVFxH2J1qXQ8DjV
 y8zooRzvLe/wHsseP5JbiWESdQmFYPQlG19sEDByk/i1OIQTP7CJRXiMTzv49xeMl5Ou
 YPNA==
X-Gm-Message-State: APjAAAVpTmeZvy65IISM15Qh+C4RGrFpxPg1JFnKOtPRyJB8P3Qip285
 8pDxYrRpPn/3CBTJlZ3pA2u6wg==
X-Google-Smtp-Source: APXvYqwgk4zKwijHkxMe/674mxOYJJF5ESLi/ffZnQeVr/0DxeXv8wcD5Kk9C+/AS/hU5JkR9XUipg==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr4179429wma.1.1574267096614;
 Wed, 20 Nov 2019 08:24:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u203sm7269454wme.34.2019.11.20.08.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 08:24:55 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2E7761FF87;
 Wed, 20 Nov 2019 16:24:54 +0000 (GMT)
References: <20191120125444.31365-1-marcandre.lureau@redhat.com>
 <bb4b636d-99d0-4fbe-c4bb-ec3d5c480a03@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] RFC: CODING_STYLE: describe "self" variable convention
In-reply-to: <bb4b636d-99d0-4fbe-c4bb-ec3d5c480a03@redhat.com>
Date: Wed, 20 Nov 2019 16:24:54 +0000
Message-ID: <87pnhmfrc9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 11/20/19 1:54 PM, Marc-Andr=C3=A9 Lureau wrote:
>> Following the discussion in thread "[PATCH v3 13/33] serial: start
>> making SerialMM a sysbus device", I'd like to recommend the usage of
>> "self" variable to reference to the OOP-style method instance, as
>> commonly done in various languages and in GObject world.
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   CODING_STYLE.rst | 38 ++++++++++++++++++++++++++++++++------
>>   1 file changed, 32 insertions(+), 6 deletions(-)
>> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
>> index 427699e0e4..cb6635af71 100644
>> --- a/CODING_STYLE.rst
>> +++ b/CODING_STYLE.rst
>> @@ -102,12 +102,38 @@ Rationale:
>>   Naming
>>   =3D=3D=3D=3D=3D=3D
>>   -Variables are lower_case_with_underscores; easy to type and read.
>> Structured
>> -type names are in CamelCase; harder to type but standing out.  Enum type
>> -names and function type names should also be in CamelCase.  Scalar type
>> -names are lower_case_with_underscores_ending_with_a_t, like the POSIX
>> -uint64_t and family.  Note that this last convention contradicts POSIX
>> -and is therefore likely to be changed.
>> +Variables are lower_case_with_underscores; easy to type and read.
>> +
>> +The most common naming for a variable is an abbreviation of the type
>> +name.  Some common examples:
>> +
>> +.. code-block:: c
>> +
>> +    Object *obj;
>> +    QVirtioSCSI *scsi;
>> +    SerialMM *smm;
>> +
>> +When writing QOM/OOP-style function, a "self" variable allows to refer
>> +without ambiguity to the instance of the method that is being
>> +implemented (this is not very common in QEMU code base, but it is
>> +often a good option to increase the readability and consistency,
>> +making further refactoring easier as well).  Example:
>> +
>> +.. code-block:: c
>> +
>> +    serial_mm_flush(SerialMM *self);
>> +
>> +    serial_mm_instance_init(Object *o) {
>> +        SerialMM *self =3D SERIAL_MM(o);
>> +        ..
>> +    }
>> +
>> +Structured type names are in CamelCase; harder to type but standing
>> +out.  Enum type names and function type names should also be in
>> +CamelCase.  Scalar type names are
>> +lower_case_with_underscores_ending_with_a_t, like the POSIX uint64_t
>> +and family.  Note that this last convention contradicts POSIX and is
>> +therefore likely to be changed.
>>     When wrapping standard library functions, use the prefix
>> ``qemu_`` to alert
>>   readers that they are seeing a wrapped version; otherwise avoid this p=
refix.
>>
>
> So in this example:
>
> static void pci_unin_agp_init(Object *obj)
> {
>     UNINHostState *s =3D UNI_NORTH_AGP_HOST_BRIDGE(obj);

Using *s for the contextually appropriate state holding structure is
certainly common enough in the code base. Maybe we should should
document that too?

>     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>     PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
>
>     /* Uninorth AGP bus */
>     memory_region_init_io(&h->conf_mem, OBJECT(h),
>                           &pci_host_conf_le_ops,
>                           obj, "unin-agp-conf-idx", 0x1000);
>     memory_region_init_io(&h->data_mem, OBJECT(h),
>                           &pci_host_data_le_ops,
>                           obj, "unin-agp-conf-data", 0x1000);
>
>     object_property_add_link(obj, "pic", TYPE_OPENPIC,
>                              (Object **) &s->pic,
>                              qdev_prop_allow_set_link_before_realize,
>                              0, NULL);
>
>     sysbus_init_mmio(sbd, &h->conf_mem);
>     sysbus_init_mmio(sbd, &h->data_mem);
> }
>
> You would change 'Object *obj' -> 'Object *self'?

I would have read it as:

  SysBusDevice *self =3D SYS_BUS_DEVICE(obj);

as the only device object in the example. But perhaps this is a complex
example?

>
> But here we want to keep 'klass', right?
>
> static void gpex_host_class_init(ObjectClass *klass, void *data)
> {
>     DeviceClass *dc =3D DEVICE_CLASS(klass);
>     PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
>
>     hc->root_bus_path =3D gpex_host_root_bus_path;
>     dc->realize =3D gpex_host_realize;
>     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>     dc->fw_name =3D "pci";
> }
>
> Maybe we should restrict 'self' as name of Object type only?
> But your example is with SerialMM, so no?


--
Alex Benn=C3=A9e

