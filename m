Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A08C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B71206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKhk69E+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B71206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVe31-0001xs-So
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVdqw-0004q7-PI
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:21:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51386
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVdqr-0002Ir-8j
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588609311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ofivu/rWjmknTFuw8Nli670UpcYUwi1z7tVuD6CxAFQ=;
 b=eKhk69E+TLjIVMUXp7pPcjSfm/TKHP5+UDFlVsI3A68Sw3/ycXLWN37R6UW1wZ3TCB0Qzy
 0eOzMvnQM428di11eGYHDnQ0/8ENRNB96notOcSt1V61JTze4sN1cGT7joRpELewJgJgN5
 tJt4tL05JeKTtmPgoPXmo/1UWSmmjKo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-9gFuU33PNdmxehLC5MdiIg-1; Mon, 04 May 2020 12:21:49 -0400
X-MC-Unique: 9gFuU33PNdmxehLC5MdiIg-1
Received: by mail-wr1-f71.google.com with SMTP id m5so11028380wru.15
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 09:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pUXPgn1Sb0MkD1TzeIdrOKynPChb8LBhEDyhbAJWCyM=;
 b=nsNYCONk3hriZqenNzaF9SNPlsyWWZrfUmoZuNsYpTFibGRGpEMXuu6X72yH6DVBzx
 VIvrUOPBJ510XRBmC078iIVnSLVopgd1GRWnRt9jWic26RTlvB2WKARuVzlhLfKMExWU
 Rpvn+4BuvnKJFTJVY4B5IF89Uqy5Zk4MXMYKrZ50lUSRCsuq2vVxlI1zedjoevyjO26+
 KMQkcp2dQ1kLurQhrKW3PrN5B4K4Lyk4zHgrK60SGRK9M3AGDuKoeGZoTCSHd3gu/N6j
 sWj207hvqM+WaRUI+qvku482GxkaviaNrKJy4Ug0VPk0RsPiLmoDMaAL8ojkxJawmRHG
 2vFw==
X-Gm-Message-State: AGi0PuZZ1u8c6QUMxZ2Z60XWtlEQjyFPtf9joKBW+h6eBJsFghBshUmX
 qHQBo0O9NE/YzHMEOklt+kHqmvKKLxS++mmmO2AMh5QndUvKKwjUAhVYltLL/6cdCJkwdMvszjU
 RwcYZc+uW0BIQkMk=
X-Received: by 2002:a1c:5403:: with SMTP id i3mr16643078wmb.10.1588609308318; 
 Mon, 04 May 2020 09:21:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKB8Bzkkr24p67YfTFMkre8NbsMfChLwxhCJFfLpUXWUPt/z79t8wDSOHk1k0+suSzd5v4uqA==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr16643058wmb.10.1588609308062; 
 Mon, 04 May 2020 09:21:48 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n18sm10934847wrw.90.2020.05.04.09.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 09:21:47 -0700 (PDT)
Subject: Re: [PATCH 09/17] hw/isa/superio: Make the components QOM children
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-10-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <82086712-2652-30e8-7818-1ee26fd36822@redhat.com>
Date: Mon, 4 May 2020 18:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-10-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 6:34 PM, Markus Armbruster wrote:
> isa_superio_realize() attempts to make isa-parallel and isa-serial QOM
> children, but this does not work, because it calls
> object_property_add_child() after realizing with qdev_init_nofail().
> Realizing a device without a parent gives it one: it gets put into the
> "/machine/unattached/" orphanage.  The extra
> object_property_add_child() fails, and isa_superio_realize() ignores
> the error.
>=20
> Move the object_property_add_child() before qdev_init_nofail(), and
> pass &error_abort.
>=20
> For the other components, isa_superio_realize() doesn't even try.  Add
> object_property_add_child() there.
>=20
> This affects machines 40p, clipper and fulong2e.
>=20
> For instance, fulong2e has its vt82c686b-superio (which is an
> isa-superio) at /machine/unattached/device[9].  Before the patch, its
> components are at /machine/unattached/device[10] .. [14].  Afterwards,
> they are at
> /machine/unattached/device[9]/{parallel0,serial0,serial1,isa-fdc,i8042}.
>=20
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/isa/isa-superio.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index 180a8b9625..0d9d848280 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -62,6 +62,8 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
>                   qdev_prop_set_uint32(d, "irq", k->parallel.get_irq(sio,=
 i));
>               }
>               qdev_prop_set_chr(d, "chardev", chr);
> +            object_property_add_child(OBJECT(sio), name, OBJECT(isa),
> +                                      &error_abort);

I have a WiP series where I resolved that by adding an 'Object *parent'=20
to isa_create*() (and pci equiv), but the conversion touch many things=20
and not trivial to order for bisectability. I suppose rebasing won't be=20
a problem, so meanwhile:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>               qdev_init_nofail(d);
>               sio->parallel[i] =3D isa;
>               trace_superio_create_parallel(i,
> @@ -69,8 +71,6 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
>                                             k->parallel.get_iobase(sio, i=
) : -1,
>                                             k->parallel.get_irq ?
>                                             k->parallel.get_irq(sio, i) :=
 -1);
> -            object_property_add_child(OBJECT(dev), name,
> -                                      OBJECT(sio->parallel[i]), NULL);
>               g_free(name);
>           }
>       }
> @@ -102,6 +102,8 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
>                   qdev_prop_set_uint32(d, "irq", k->serial.get_irq(sio, i=
));
>               }
>               qdev_prop_set_chr(d, "chardev", chr);
> +            object_property_add_child(OBJECT(sio), name, OBJECT(isa),
> +                                      &error_abort);
>               qdev_init_nofail(d);
>               sio->serial[i] =3D isa;
>               trace_superio_create_serial(i,
> @@ -109,8 +111,6 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
>                                           k->serial.get_iobase(sio, i) : =
-1,
>                                           k->serial.get_irq ?
>                                           k->serial.get_irq(sio, i) : -1)=
;
> -            object_property_add_child(OBJECT(dev), name,
> -                                      OBJECT(sio->serial[0]), NULL);
>               g_free(name);
>           }
>       }
> @@ -137,6 +137,8 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
>               qdev_prop_set_drive(d, "driveB", blk_by_legacy_dinfo(drive)=
,
>                                   &error_fatal);
>           }
> +        object_property_add_child(OBJECT(sio), "isa-fdc", OBJECT(isa),
> +                                  &error_abort);
>           qdev_init_nofail(d);
>           sio->floppy =3D isa;
>           trace_superio_create_floppy(0,
> @@ -147,7 +149,11 @@ static void isa_superio_realize(DeviceState *dev, Er=
ror **errp)
>       }
>  =20
>       /* Keyboard, mouse */
> -    sio->kbc =3D isa_create_simple(bus, TYPE_I8042);
> +    isa =3D isa_create(bus, TYPE_I8042);
> +    object_property_add_child(OBJECT(sio), TYPE_I8042, OBJECT(isa),
> +                              &error_abort);
> +    qdev_init_nofail(DEVICE(isa));
> +    sio->kbc =3D isa;
>  =20
>       /* IDE */
>       if (k->ide.count && (!k->ide.is_enabled || k->ide.is_enabled(sio, 0=
))) {
> @@ -163,6 +169,8 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
>               qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
>           }
>           qdev_init_nofail(d);
> +        object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa),
> +                                  &error_abort);
>           sio->ide =3D isa;
>           trace_superio_create_ide(0,
>                                    k->ide.get_iobase ?
>=20


