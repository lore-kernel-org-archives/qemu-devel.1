Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AC4C34051
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BBA24670
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihNvwFNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BBA24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4KNb-0006Gx-Dn
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 03:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4KMq-0005fm-JV
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4KMo-0005lx-PZ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:05:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49291
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4KMo-0005l4-D7
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582099557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goXlGZ4hkwseuR5dIayjfLYnKcL273cWTEm9ZMhi8SY=;
 b=ihNvwFNrk8Zyk4nHt5lf7wjBk7YHpZ265GyLf4wMZ0XxLatzHm05RsVe+Zne5MFVWFDnzB
 Cl7ytvq58NTLoJUzVWPJUZs9E0RM4DHKQmBBWaz6+TjLpFI4MBsLehFwnDcAw76D+1+cjM
 q01Cs9r7tmDzvfHgrR+n61l4LwFy3SY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-gKjAZgyMPuu60_NmbTPBtQ-1; Wed, 19 Feb 2020 03:05:53 -0500
X-MC-Unique: gKjAZgyMPuu60_NmbTPBtQ-1
Received: by mail-wr1-f72.google.com with SMTP id d7so1799659wrx.9
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 00:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=UOYQDmNAANxyInzj44boMeqVUHtGhRO7pYhvY/W+/iY=;
 b=cZ4P3mWeWiflSxCQueDknwoXDTS6aWuVSjvmtVlCODXIzqfi+ZfET9FNJRZwyRYQ0F
 9ytvm8h2imexJcAWX9nkhzjZ3OORZ93q3oojRUzKl2OoqlT0G58TDGzING6dza00A1w+
 AwxF1FRC2ZsbPIdTDh0iwMDmgKG51hCOs2BY7IDcIAvTTuOXonhAA6I/5wA2CQEkg/cv
 YtGl2Ab0QbT2Eklm1EYxJjrJAobT0Jp6YzIgiXCWV3UXnX3HSc6S2SVKpV1LCRh1kkFD
 WOWDrbeG6Z/KBrL5qgfONr83h5zoUlDTWKevCB/HG72C/azUiw7Fc8wZNwdkmsPJX7tG
 urMg==
X-Gm-Message-State: APjAAAW/jI2NGK9J7QBDN6rv7L3ZJi3bdrhnw85ygAxpPZe/MkuVvVRN
 /4URzS1sxxlQv4VP2F8vLlnzeE520POYXNjGWtgAJrmfcS/j2meprYBppmSD/E+eq0S9SUATM15
 xrbYqMZCoWEw+6x8=
X-Received: by 2002:adf:cd91:: with SMTP id q17mr34760131wrj.306.1582099552026; 
 Wed, 19 Feb 2020 00:05:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6/kROJRsRNnetsGhSGnfV/+unI1ELTjGHZ1whuDWlVc0yu7EgDf7JlHpB2jSPxTKLtSg8eg==
X-Received: by 2002:adf:cd91:: with SMTP id q17mr34760096wrj.306.1582099551719; 
 Wed, 19 Feb 2020 00:05:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4?
 ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
 by smtp.gmail.com with ESMTPSA id 133sm2138853wmd.5.2020.02.19.00.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 00:05:50 -0800 (PST)
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
To: Olaf Hering <olaf@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
 <20200117140616.18cb8c45.olaf@aepfle.de>
 <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
 <20200127100951.0803d167.olaf@aepfle.de>
 <20200218182728.4b7f17b7.olaf@aepfle.de>
 <b1313071-0eae-0465-4b3f-85c49c77a256@redhat.com>
 <20200218204405.17047092.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49a2f35d-cc78-762b-39c3-0340bbebcf84@redhat.com>
Date: Wed, 19 Feb 2020 09:05:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200218204405.17047092.olaf@aepfle.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6wRqWXcjlNNAyQsDW8AxlDVYEPF3GRCWP"
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Paul Durrant <pdurrant@gmail.com>, Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6wRqWXcjlNNAyQsDW8AxlDVYEPF3GRCWP
Content-Type: multipart/mixed; boundary="L6EdwuEgPRmOF1IB4DB1sRoEDwBgqdd8B"

--L6EdwuEgPRmOF1IB4DB1sRoEDwBgqdd8B
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18/02/20 20:44, Olaf Hering wrote:
> Am Tue, 18 Feb 2020 18:37:09 +0100
> schrieb Paolo Bonzini <pbonzini@redhat.com>:
>=20
>> On 18/02/20 18:27, Olaf Hering wrote:
>>> The approach below (making 'xenfv' an alias of 'pc') does not work:
>>> xen_enabled() is false when pc_i440fx_3_1_machine_options runs. =20
>> Don't use an alias, copy the 3.1 code into the xenfv machine type and/or
>> call the 3.1 functions from the xenfv machine type.
>=20
> In the end it may look like this.
>=20
> Let me know about any preferences regarding the naming of configure optio=
ns and variables.

Has any version of Xen been released with a QEMU version above 3.1?

Paolo

>=20
> Olaf
>=20
> diff --git a/configure b/configure
> index 6f5d850949..65ca345fd6 100755
> --- a/configure
> +++ b/configure
> @@ -368,6 +368,7 @@ vnc_jpeg=3D""
>  vnc_png=3D""
>  xkbcommon=3D""
>  xen=3D""
> +xen_hvm_pc_i440fx_version_3_1=3D""
>  xen_ctrl_version=3D""
>  xen_pci_passthrough=3D""
>  linux_aio=3D""
> @@ -1162,6 +1163,10 @@ for opt do
>    ;;
>    --enable-xen-pci-passthrough) xen_pci_passthrough=3D"yes"
>    ;;
> +  --disable-xenfv-i440fx-version-3_1) xen_hvm_pc_i440fx_version_3_1=3D"n=
o"
> +  ;;
> +  --enable-xenfv-i440fx-version-3_1) xen_hvm_pc_i440fx_version_3_1=3D"ye=
s"
> +  ;;
>    --disable-brlapi) brlapi=3D"no"
>    ;;
>    --enable-brlapi) brlapi=3D"yes"
> @@ -7836,6 +7841,9 @@ if supported_xen_target $target; then
>      if test "$xen_pci_passthrough" =3D yes; then
>          echo "CONFIG_XEN_PCI_PASSTHROUGH=3Dy" >> "$config_target_mak"
>      fi
> +    if test "$xen_hvm_pc_i440fx_version_3_1" =3D yes; then
> +        echo "CONFIG_XEN_HVM_PC_I440FX_VERSION_3_1=3Dy" >> "$config_targ=
et_mak"
> +    fi
>  else
>      echo "$target/config-devices.mak: CONFIG_XEN=3Dn" >> $config_host_ma=
k
>  fi
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index fa12203079..83d1fcc0ba 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -949,6 +949,11 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
>  #ifdef CONFIG_XEN
>  static void xenfv_machine_options(MachineClass *m)
>  {
> +#ifdef CONFIG_XEN_HVM_PC_I440FX_VERSION_3_1
> +    pc_i440fx_3_1_machine_options(m);
> +#else
> +    pc_i440fx_4_2_machine_options(m);
> +#endif
>      m->desc =3D "Xen Fully-virtualized PC";
>      m->max_cpus =3D HVM_MAX_VCPUS;
>      m->default_machine_opts =3D "accel=3Dxen";
>=20



--L6EdwuEgPRmOF1IB4DB1sRoEDwBgqdd8B--

--6wRqWXcjlNNAyQsDW8AxlDVYEPF3GRCWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl5M7F0ACgkQv/vSX3jH
roPb4Af9FoLcfxjrZkhtwtFMOu59wFHd0UxpuOifEs7lvIfn4VoaleD+kBwzRlUm
id+a4M151kFH+8BpnJiahZyq2VcU3UKRzIQMxhZB3OzjRpUV6VbIWUIkL/5f6yOu
QSxzelyOi/V/PE7zYnv47d+6xgS5hKbImTk6buOe6Iin36afIZvYErqgtdA/bXJF
CO9NwEX2akmeLOyQQYfLsYbl5QuVB5XuRAUkUP1wBTv8TAqQ1T3GurSkQYcEMC1u
CCphEQ29wdGupXyYdwtGRS4O2X8HjPNaLz18+/QblrGW0xhLAKMOVCj9XezEmyTr
OFaVouesU3N8n+SuRm8shu7UhYXfmA==
=Nlox
-----END PGP SIGNATURE-----

--6wRqWXcjlNNAyQsDW8AxlDVYEPF3GRCWP--


