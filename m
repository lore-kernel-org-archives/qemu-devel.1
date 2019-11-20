Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B79C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A5A2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKO5BFjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A5A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXT1O-0005wT-Mw
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iXT0i-0005PH-Ii
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iXT0g-0007pZ-ET
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:39:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iXT0g-0007pO-Ae
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574267957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1yxd9uTm2kXjS9tn/eewks21onqIR5DZuqQ1HAoP8I=;
 b=WKO5BFjz7Yov/2fpT7qxDSSJwCHLG6KT+pmeRr0kbl80SzB8OkOW+tgbLBVYhA6qhsdNqJ
 xtRgnKKo5/wbhP7OZuKXmRC9uifNegcI3qRMi5ID2PaPu38Tk7qV0/GD20Uvjl1k8tvzpk
 TBzTWzXaeew0546HuJXI2GBuFAcSmMo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-indogHz8MFuYAfKCXCpaMA-1; Wed, 20 Nov 2019 11:39:14 -0500
Received: by mail-ot1-f70.google.com with SMTP id z39so20133ota.7
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=K1yxd9uTm2kXjS9tn/eewks21onqIR5DZuqQ1HAoP8I=;
 b=XeWuRSMtuvtBI7lgajSrAHay+h4gnDQ9JulhLIKuHj+lziNhLdGaIiO2Wv21tg72UO
 VBn6wosIUKIWJneFj1fhgDLQEyF9gHN/lhtcqxsrSwIjcQT8LpbhzhIJAx3K9ET0OUq1
 4jyJK0zBN6wDt1BUbL/j58RjQYm6GRA0M3j0yuZJmRXJ8V9syr7h0zVVBFhJZhFEHYHT
 u0O23GIXtpz/O7JNXIN9BYnSmEMv5aLNua4//hlUc4Tv/He4MbxDFP+VAy6f5gRrAw5s
 VSFcqxJgxtjJQw/aKpVEc/T4cbgsBncsz9CzuzNKoaFNMIO5qkr2GrBCslTAFazCqVEV
 S8xA==
X-Gm-Message-State: APjAAAXICXywHzg2LLYdbVdQDmywujuLbDuAx7v0sRRERtSvtsdRTGOh
 A2TpDrQB4FurTmGw2znSlRB0wU28I6fvIQKuFC0srUxRtW4zfpqTHMhL586kOmBrVAn0U7WoC5U
 koQ+hfWw2K1e8nUjaxoIhpkvU3cLICsg=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr2638787otg.368.1574267953284; 
 Wed, 20 Nov 2019 08:39:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzR9CKWhjNvzRkd8kfqpkXcgr1FjH8IH5I1RmFaBrCqKplx4X08QKEzK5KDJk5b1nkv1Pc3VyheAPPJJZ3Da7A=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr2638768otg.368.1574267952921; 
 Wed, 20 Nov 2019 08:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20191120125444.31365-1-marcandre.lureau@redhat.com>
 <bb4b636d-99d0-4fbe-c4bb-ec3d5c480a03@redhat.com> <87pnhmfrc9.fsf@linaro.org>
In-Reply-To: <87pnhmfrc9.fsf@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Nov 2019 20:39:01 +0400
Message-ID: <CAMxuvaw9AVC9dG=oz8uAoUg52oyM248cF7M8ZZ+zJRgU3xJVcQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: CODING_STYLE: describe "self" variable convention
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-MC-Unique: indogHz8MFuYAfKCXCpaMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 20, 2019 at 8:25 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > On 11/20/19 1:54 PM, Marc-Andr=C3=A9 Lureau wrote:
> >> Following the discussion in thread "[PATCH v3 13/33] serial: start
> >> making SerialMM a sysbus device", I'd like to recommend the usage of
> >> "self" variable to reference to the OOP-style method instance, as
> >> commonly done in various languages and in GObject world.
> >> Cc: Peter Maydell <peter.maydell@linaro.org>
> >> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>   CODING_STYLE.rst | 38 ++++++++++++++++++++++++++++++++------
> >>   1 file changed, 32 insertions(+), 6 deletions(-)
> >> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> >> index 427699e0e4..cb6635af71 100644
> >> --- a/CODING_STYLE.rst
> >> +++ b/CODING_STYLE.rst
> >> @@ -102,12 +102,38 @@ Rationale:
> >>   Naming
> >>   =3D=3D=3D=3D=3D=3D
> >>   -Variables are lower_case_with_underscores; easy to type and read.
> >> Structured
> >> -type names are in CamelCase; harder to type but standing out.  Enum t=
ype
> >> -names and function type names should also be in CamelCase.  Scalar ty=
pe
> >> -names are lower_case_with_underscores_ending_with_a_t, like the POSIX
> >> -uint64_t and family.  Note that this last convention contradicts POSI=
X
> >> -and is therefore likely to be changed.
> >> +Variables are lower_case_with_underscores; easy to type and read.
> >> +
> >> +The most common naming for a variable is an abbreviation of the type
> >> +name.  Some common examples:
> >> +
> >> +.. code-block:: c
> >> +
> >> +    Object *obj;
> >> +    QVirtioSCSI *scsi;
> >> +    SerialMM *smm;
> >> +
> >> +When writing QOM/OOP-style function, a "self" variable allows to refe=
r
> >> +without ambiguity to the instance of the method that is being
> >> +implemented (this is not very common in QEMU code base, but it is
> >> +often a good option to increase the readability and consistency,
> >> +making further refactoring easier as well).  Example:
> >> +
> >> +.. code-block:: c
> >> +
> >> +    serial_mm_flush(SerialMM *self);
> >> +
> >> +    serial_mm_instance_init(Object *o) {
> >> +        SerialMM *self =3D SERIAL_MM(o);
> >> +        ..
> >> +    }
> >> +
> >> +Structured type names are in CamelCase; harder to type but standing
> >> +out.  Enum type names and function type names should also be in
> >> +CamelCase.  Scalar type names are
> >> +lower_case_with_underscores_ending_with_a_t, like the POSIX uint64_t
> >> +and family.  Note that this last convention contradicts POSIX and is
> >> +therefore likely to be changed.
> >>     When wrapping standard library functions, use the prefix
> >> ``qemu_`` to alert
> >>   readers that they are seeing a wrapped version; otherwise avoid this=
 prefix.
> >>
> >
> > So in this example:
> >
> > static void pci_unin_agp_init(Object *obj)
> > {
> >     UNINHostState *s =3D UNI_NORTH_AGP_HOST_BRIDGE(obj);
>
> Using *s for the contextually appropriate state holding structure is
> certainly common enough in the code base. Maybe we should should
> document that too?

Yes, "s" is very common in qemu. Yet, it's ambiguous to me, as it is
used in other cases, while "self" is explicit for OOP-style, to refer
to the instance type being implemented.

>
> >     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> >     PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
> >
> >     /* Uninorth AGP bus */
> >     memory_region_init_io(&h->conf_mem, OBJECT(h),
> >                           &pci_host_conf_le_ops,
> >                           obj, "unin-agp-conf-idx", 0x1000);
> >     memory_region_init_io(&h->data_mem, OBJECT(h),
> >                           &pci_host_data_le_ops,
> >                           obj, "unin-agp-conf-data", 0x1000);
> >
> >     object_property_add_link(obj, "pic", TYPE_OPENPIC,
> >                              (Object **) &s->pic,
> >                              qdev_prop_allow_set_link_before_realize,
> >                              0, NULL);
> >
> >     sysbus_init_mmio(sbd, &h->conf_mem);
> >     sysbus_init_mmio(sbd, &h->data_mem);
> > }
> >
> > You would change 'Object *obj' -> 'Object *self'?
>
> I would have read it as:
>
>   SysBusDevice *self =3D SYS_BUS_DEVICE(obj);
>
> as the only device object in the example. But perhaps this is a complex
> example?
>
> >
> > But here we want to keep 'klass', right?
> >
> > static void gpex_host_class_init(ObjectClass *klass, void *data)
> > {
> >     DeviceClass *dc =3D DEVICE_CLASS(klass);
> >     PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
> >
> >     hc->root_bus_path =3D gpex_host_root_bus_path;
> >     dc->realize =3D gpex_host_realize;
> >     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> >     dc->fw_name =3D "pci";
> > }
> >
> > Maybe we should restrict 'self' as name of Object type only?
> > But your example is with SerialMM, so no?
>
>
> --
> Alex Benn=C3=A9e
>

thanks


