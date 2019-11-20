Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A1CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F4020878
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccosGFLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F4020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSxf-0001Z5-UO
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iXSwv-000101-4F
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iXSwt-0006ia-NK
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:35:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31081)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iXSwt-0006iE-JD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574267721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7hbPeIhjZGbU9jKWvivF69m252j6TojN2FefP7sesA=;
 b=ccosGFLJlmQfGD+XhIKuoCDJ1RfZINHtu0sveVvZWE3Ry/B/2dXG/wOd27S4dE/vzjsCr+
 jUQFDXH9RfunwJvbeBJPmoQ4u9d4nj9KHjTcWfvPNoMQpnZsFYt4a1m2egmY+mVDId1Nzj
 P/s6DEpiTFN5RpZ9aDC53F51s6U69FY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-x80TujBlPdWzDLmxKn_LaA-1; Wed, 20 Nov 2019 11:35:19 -0500
Received: by mail-oi1-f197.google.com with SMTP id z143so120886oia.20
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C7hbPeIhjZGbU9jKWvivF69m252j6TojN2FefP7sesA=;
 b=ZShTIPiJe7WKr7bDFU19pknfhj/LC5Ukuj9jEBfpehtZEEf4XiJ0dRVbZ6bwqKP/Dp
 /COiGFCvIiehYpcHvspjpOka7JVkRnRGlqA4qERJJ6TXkNI25H4onMHRqpyRWnxZzwIB
 ITwrrJd90XXjNz6U9LRcVeQ+xP3Up/n9uyCjGKCU8AsYNxs+XkPcpwdLWJaSnxS/OwMM
 luU0FJ7JChSxSBG4igS5MNl9ks89vJ5na0I11BtfGPnE/NRmLWoF5KrVjtFPa2mfa70f
 CpTKKfUNcgcd3n4JLWwXBkY4McDIsx6GNkaHpHNaOd0xAdPjtvVXmDvM3316mJMU5+3m
 FChA==
X-Gm-Message-State: APjAAAUHYPJaU0e48SeJtmsLmCPDJLG99+RGbeeaoisPs+B+cq/HSCNr
 0O951QWdM1TvMsvGbhy0ItmjFac3y4Leayw5x8LD1dPhBVneMMyPS0T+oe3yPbKam3/Gg6IbCpv
 P471/3OgQCSnvFeXHN/6A9olHpQaENMc=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr2626677otg.368.1574267718655; 
 Wed, 20 Nov 2019 08:35:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHoNSv2KzutgqaA1l3xrgXe4ORJL75MAMZGTcH1f4ePs32J+EnNyfOiPyOqguc0396Q+EY/MUbICJjLfKQj8U=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr2626613otg.368.1574267717478; 
 Wed, 20 Nov 2019 08:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20191120125444.31365-1-marcandre.lureau@redhat.com>
 <bb4b636d-99d0-4fbe-c4bb-ec3d5c480a03@redhat.com>
In-Reply-To: <bb4b636d-99d0-4fbe-c4bb-ec3d5c480a03@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Nov 2019 20:35:06 +0400
Message-ID: <CAMxuvazJkTDX4Mwf1zUp7NXTa9ZoUSxwwBw1Q7zOS-+UspSxdw@mail.gmail.com>
Subject: Re: [PATCH] RFC: CODING_STYLE: describe "self" variable convention
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: x80TujBlPdWzDLmxKn_LaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 20, 2019 at 8:05 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 11/20/19 1:54 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Following the discussion in thread "[PATCH v3 13/33] serial: start
> > making SerialMM a sysbus device", I'd like to recommend the usage of
> > "self" variable to reference to the OOP-style method instance, as
> > commonly done in various languages and in GObject world.
> >
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   CODING_STYLE.rst | 38 ++++++++++++++++++++++++++++++++------
> >   1 file changed, 32 insertions(+), 6 deletions(-)
> >
> > diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> > index 427699e0e4..cb6635af71 100644
> > --- a/CODING_STYLE.rst
> > +++ b/CODING_STYLE.rst
> > @@ -102,12 +102,38 @@ Rationale:
> >   Naming
> >   =3D=3D=3D=3D=3D=3D
> >
> > -Variables are lower_case_with_underscores; easy to type and read.  Str=
uctured
> > -type names are in CamelCase; harder to type but standing out.  Enum ty=
pe
> > -names and function type names should also be in CamelCase.  Scalar typ=
e
> > -names are lower_case_with_underscores_ending_with_a_t, like the POSIX
> > -uint64_t and family.  Note that this last convention contradicts POSIX
> > -and is therefore likely to be changed.
> > +Variables are lower_case_with_underscores; easy to type and read.
> > +
> > +The most common naming for a variable is an abbreviation of the type
> > +name.  Some common examples:
> > +
> > +.. code-block:: c
> > +
> > +    Object *obj;
> > +    QVirtioSCSI *scsi;
> > +    SerialMM *smm;
> > +
> > +When writing QOM/OOP-style function, a "self" variable allows to refer
> > +without ambiguity to the instance of the method that is being
> > +implemented (this is not very common in QEMU code base, but it is
> > +often a good option to increase the readability and consistency,
> > +making further refactoring easier as well).  Example:
> > +
> > +.. code-block:: c
> > +
> > +    serial_mm_flush(SerialMM *self);
> > +
> > +    serial_mm_instance_init(Object *o) {
> > +        SerialMM *self =3D SERIAL_MM(o);
> > +        ..
> > +    }
> > +
> > +Structured type names are in CamelCase; harder to type but standing
> > +out.  Enum type names and function type names should also be in
> > +CamelCase.  Scalar type names are
> > +lower_case_with_underscores_ending_with_a_t, like the POSIX uint64_t
> > +and family.  Note that this last convention contradicts POSIX and is
> > +therefore likely to be changed.
> >
> >   When wrapping standard library functions, use the prefix ``qemu_`` to=
 alert
> >   readers that they are seeing a wrapped version; otherwise avoid this =
prefix.
> >
>
> So in this example:
>
> static void pci_unin_agp_init(Object *obj)
> {
>      UNINHostState *s =3D UNI_NORTH_AGP_HOST_BRIDGE(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>      PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
>
>      /* Uninorth AGP bus */
>      memory_region_init_io(&h->conf_mem, OBJECT(h),
>                            &pci_host_conf_le_ops,
>                            obj, "unin-agp-conf-idx", 0x1000);
>      memory_region_init_io(&h->data_mem, OBJECT(h),
>                            &pci_host_data_le_ops,
>                            obj, "unin-agp-conf-data", 0x1000);
>
>      object_property_add_link(obj, "pic", TYPE_OPENPIC,
>                               (Object **) &s->pic,
>                               qdev_prop_allow_set_link_before_realize,
>                               0, NULL);
>
>      sysbus_init_mmio(sbd, &h->conf_mem);
>      sysbus_init_mmio(sbd, &h->data_mem);
> }
>
> You would change 'Object *obj' -> 'Object *self'?

static void pci_unin_agp_init(Object *obj)
{
  UNINHostState *self =3D UNI_NORTH_AGP_HOST_BRIDGE(obj);
  ..


When you override a parent method, you can create aliases for the
parent types with the abbreviation rule if necessary. But often, there
are less references to the parent types than the actual type you
implement, so in many cases, PARENT(self) can be less confusing. Your
example is a perhaps a bit more complicated than usual. Yet, having
"self" for the type we are implementing is still more readable to me.

>
> But here we want to keep 'klass', right?
>
> static void gpex_host_class_init(ObjectClass *klass, void *data)
> {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
>
>      hc->root_bus_path =3D gpex_host_root_bus_path;
>      dc->realize =3D gpex_host_realize;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name =3D "pci";
> }


If we follow a similar rule for class methods, I would suggest:

static void gpex_host_class_init(ObjectClass *oc, void *data)
{
  GPEXClass *klass =3D GPEX_CLASS(oc);

But in general, class_init has more code dealing with various parent
types, to override parent methods.

>
> Maybe we should restrict 'self' as name of Object type only?
> But your example is with SerialMM, so no?
>

"self" for the instance type, "klass" for the the class type.


