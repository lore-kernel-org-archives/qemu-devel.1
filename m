Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8FDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B418820718
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uz2EVgvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B418820718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSUh-0004LT-TU
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXSTz-0003gM-3j
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXSTw-0006da-BP
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:05:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60834
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXSTw-0006dL-7o
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574265926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbjC/8kzuW+t1MZjE5K8IpwBs6aXrvuIdQS1dNpp9ic=;
 b=Uz2EVgvVHrZ+lEU8bCyui60qjduSEtyqmFs6GwKcNCgUOQbrs2E9S9+kJeWfpQ96THyrGy
 LuK/e/PQP4MPyvzpJqDsECjdG1VwZVarOgYzoBtIFPoGm1M4+tjTVE+17CvMwda+8uhne/
 y+q3Vs3Ruee5l4eW8LTufyXdZa/ApNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-VzfmeAW-PlmefP2roxjS3A-1; Wed, 20 Nov 2019 11:05:24 -0500
Received: by mail-wm1-f72.google.com with SMTP id g14so5468936wmk.9
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EMHqO6ztwGThtlRhL8/byVxtL8K08TnzEfVKA/bvlHc=;
 b=EpEdL0CLppMu9DMKU6VKCaPTWSJHMtcH72IUUzEt8nHbpwUwiPUXAii+w/yFBeagDn
 xy9suI0b2RMcxxqdcbIvON/2YUGLtQoLP8mxGfwqoYFLFyh136H5LirRAqETZL8VOmYS
 5EzP7Aph7Ej6X4wI6z2Kl0rMgFZkVFn4N2YxSQPFhoL+5Yv3AfryVadfBXYXmCJkTI8r
 r1vwwSgcIB9XXbsjIa2TiHzEt43rAXEcdi4iyqHop+MbCl5phQ9lQj2iE+6QrjKRiIP6
 2BPQ1Ytyr2TXYwhOIu4+kx1zPybGqRF/HF3TUMamEMTWVsDdymWW5pVHPrVNZf3tjNyc
 Fifg==
X-Gm-Message-State: APjAAAW/yPZeETSfSB0D+BGI1m5YfpLttVFY+7XJx/YVKvN/98T4NfA3
 9owxc3R/Lkbq+d1Wbb/ehWlLyyzzQwNhfIOl9u6Vu98iQiUifH1MnL+cE9kVPe/EwqG5aibj1xx
 ISZ4ooGqQeDFec4M=
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr3955880wma.119.1574265923665; 
 Wed, 20 Nov 2019 08:05:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXkDLnX//Uv34j/faDVB6aTgC8hOn5PIGODrxQ9XitDJiw1tUNAnHhn4TA7Y5I7bkUBUG5Zw==
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr3955845wma.119.1574265923341; 
 Wed, 20 Nov 2019 08:05:23 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id n1sm32435772wrr.24.2019.11.20.08.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 08:05:22 -0800 (PST)
Subject: Re: [PATCH] RFC: CODING_STYLE: describe "self" variable convention
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120125444.31365-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bb4b636d-99d0-4fbe-c4bb-ec3d5c480a03@redhat.com>
Date: Wed, 20 Nov 2019 17:05:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120125444.31365-1-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: VzfmeAW-PlmefP2roxjS3A-1
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
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 1:54 PM, Marc-Andr=C3=A9 Lureau wrote:
> Following the discussion in thread "[PATCH v3 13/33] serial: start
> making SerialMM a sysbus device", I'd like to recommend the usage of
> "self" variable to reference to the OOP-style method instance, as
> commonly done in various languages and in GObject world.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   CODING_STYLE.rst | 38 ++++++++++++++++++++++++++++++++------
>   1 file changed, 32 insertions(+), 6 deletions(-)
>=20
> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> index 427699e0e4..cb6635af71 100644
> --- a/CODING_STYLE.rst
> +++ b/CODING_STYLE.rst
> @@ -102,12 +102,38 @@ Rationale:
>   Naming
>   =3D=3D=3D=3D=3D=3D
>  =20
> -Variables are lower_case_with_underscores; easy to type and read.  Struc=
tured
> -type names are in CamelCase; harder to type but standing out.  Enum type
> -names and function type names should also be in CamelCase.  Scalar type
> -names are lower_case_with_underscores_ending_with_a_t, like the POSIX
> -uint64_t and family.  Note that this last convention contradicts POSIX
> -and is therefore likely to be changed.
> +Variables are lower_case_with_underscores; easy to type and read.
> +
> +The most common naming for a variable is an abbreviation of the type
> +name.  Some common examples:
> +
> +.. code-block:: c
> +
> +    Object *obj;
> +    QVirtioSCSI *scsi;
> +    SerialMM *smm;
> +
> +When writing QOM/OOP-style function, a "self" variable allows to refer
> +without ambiguity to the instance of the method that is being
> +implemented (this is not very common in QEMU code base, but it is
> +often a good option to increase the readability and consistency,
> +making further refactoring easier as well).  Example:
> +
> +.. code-block:: c
> +
> +    serial_mm_flush(SerialMM *self);
> +
> +    serial_mm_instance_init(Object *o) {
> +        SerialMM *self =3D SERIAL_MM(o);
> +        ..
> +    }
> +
> +Structured type names are in CamelCase; harder to type but standing
> +out.  Enum type names and function type names should also be in
> +CamelCase.  Scalar type names are
> +lower_case_with_underscores_ending_with_a_t, like the POSIX uint64_t
> +and family.  Note that this last convention contradicts POSIX and is
> +therefore likely to be changed.
>  =20
>   When wrapping standard library functions, use the prefix ``qemu_`` to a=
lert
>   readers that they are seeing a wrapped version; otherwise avoid this pr=
efix.
>=20

So in this example:

static void pci_unin_agp_init(Object *obj)
{
     UNINHostState *s =3D UNI_NORTH_AGP_HOST_BRIDGE(obj);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
     PCIHostState *h =3D PCI_HOST_BRIDGE(obj);

     /* Uninorth AGP bus */
     memory_region_init_io(&h->conf_mem, OBJECT(h),
                           &pci_host_conf_le_ops,
                           obj, "unin-agp-conf-idx", 0x1000);
     memory_region_init_io(&h->data_mem, OBJECT(h),
                           &pci_host_data_le_ops,
                           obj, "unin-agp-conf-data", 0x1000);

     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
                              0, NULL);

     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
}

You would change 'Object *obj' -> 'Object *self'?

But here we want to keep 'klass', right?

static void gpex_host_class_init(ObjectClass *klass, void *data)
{
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);

     hc->root_bus_path =3D gpex_host_root_bus_path;
     dc->realize =3D gpex_host_realize;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name =3D "pci";
}

Maybe we should restrict 'self' as name of Object type only?
But your example is with SerialMM, so no?


