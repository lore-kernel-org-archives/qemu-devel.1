Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52898C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B928205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSRBdd+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B928205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcv7-0002YG-45
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBcu5-0001X2-8F
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBcu4-0007Yq-2C
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:18:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41312
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBcu3-0007VX-Tf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583839107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/MbgztF1qboFW543imYKlGNMkiqPF7dVW5hFwGbU1g=;
 b=eSRBdd+kztcmKccBSMsjC1jku9b4x5nHb8KbAKvYHXktL78SlK0ZiBWymzGX4buPHEWGds
 MzUaWx5ZXzFS75/MU5geuLCgDggiggUQPRMtFeEzSEz1MKKOlv6SVSBoiISpkVIXp4mO/9
 xfjjy7zADSl8LBf/WF9YmmX/jipqY3I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-inLcZza2PaW7yRn9x3q0PA-1; Tue, 10 Mar 2020 07:18:23 -0400
X-MC-Unique: inLcZza2PaW7yRn9x3q0PA-1
Received: by mail-qv1-f71.google.com with SMTP id v4so2610353qvt.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1EbK8ZnjapSMn1XYZtDjCdzJ4BSltCU/4ND1p1Vno6U=;
 b=GObsS2CAWBj1FMEG+3sL0b5uHmiit5LnjK65WMkyDxtROJF5EJkjK3Gd2DAVopyZWF
 +c74urBtdU/1ZS1b8+JjCV89qqh6Ww91Ma5yZWwTbP/1gRnToQP9Xv4DxZ2b6yb1NLTm
 kq7b05IKM2srs1Bf1JK6YGSa2307t4W94msSf6wviECwoDNruCoT6AdP68IF01yfZ/On
 K5zFbSyvleOYj21WGNcYPxH74DZE7/+rO3UXR9o7gBw2j/FoN87ycGrDHAv0XueozZEL
 8uVJbSJoLU+WsycTaF6CKU9dA5WdKrb6AUEGE5wEwaY9UMtE7lpHd7cwS2XlY42CEQAz
 IgZA==
X-Gm-Message-State: ANhLgQ0AmFzyfhyHefKA5fgFQdYEDYydBB028ztHNxQ6OVjxupBFdsPy
 r3NPxfx7RUATJhXy6zW8DaYoq+RHpLu5ScVDbZD0jK24ONWjUaMQFTunv4g0Gd1m3Cct0phk1tl
 WNs4H5hbldW76SGQ=
X-Received: by 2002:ad4:5011:: with SMTP id s17mr14207072qvo.182.1583839103181; 
 Tue, 10 Mar 2020 04:18:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtZMAB8LzCru1dGaVRXPOMaV6t01eRB5MidTmO8Y0D3uyToE3NoTKoTD2wDCYRXWTPNzzHzDA==
X-Received: by 2002:ad4:5011:: with SMTP id s17mr14207049qvo.182.1583839102891; 
 Tue, 10 Mar 2020 04:18:22 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id v19sm8038138qtb.67.2020.03.10.04.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:18:22 -0700 (PDT)
Date: Tue, 10 Mar 2020 07:18:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 04/14] hw/i386/vmport: Introduce vmx-version property
Message-ID: <20200310071453-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-5-liran.alon@oracle.com>
 <20200310053210-mutt-send-email-mst@kernel.org>
 <0dd22d9c-e1d2-db1e-372e-5009be705dab@oracle.com>
MIME-Version: 1.0
In-Reply-To: <0dd22d9c-e1d2-db1e-372e-5009be705dab@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 01:05:02PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 11:32, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 01:54:01AM +0200, Liran Alon wrote:
> > > Instead of hard-coding the VMX version, make it a VMPORT object prope=
rty.
> > > This would allow user to control it's value via "-global vmport.vmx-v=
ersion=3DX".
> > >=20
> > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > More detail on why this is useful?
> It's more useful than returning a hard-coded "6" as the vmx-version...


Maybe default should be 6 (a bit of explanation why 6 could be nice).


> We have used it to preserve compatibility for some VMware guests that we =
run
> as-is on top of QEMU/KVM which expects specific vmx-version or else they
> fail to run properly.
>=20
> -Liran

Any detail on which guest it is?
Pretending to be a very advanced version has its pitfalls if we
then don't behave the way vmware does, right?
Figuring out the version number is I suspect a bit much to ask of users.


> >=20
> > > ---
> > >   hw/i386/vmport.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> > > index 7c21e56081b0..a2c8ff4b59cf 100644
> > > --- a/hw/i386/vmport.c
> > > +++ b/hw/i386/vmport.c
> > > @@ -44,6 +44,8 @@ typedef struct VMPortState {
> > >       MemoryRegion io;
> > >       VMPortReadFunc *func[VMPORT_ENTRIES];
> > >       void *opaque[VMPORT_ENTRIES];
> > > +
> > > +    uint32_t vmx_version;
> > >   } VMPortState;
> > >   static VMPortState *port_state;
> > > @@ -112,7 +114,7 @@ static uint32_t vmport_cmd_get_version(void *opaq=
ue, uint32_t addr)
> > >       X86CPU *cpu =3D X86_CPU(current_cpu);
> > >       cpu->env.regs[R_EBX] =3D VMPORT_MAGIC;
> > > -    return 6;
> > > +    return port_state->vmx_version;
> > >   }
> > >   static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
> > > @@ -169,6 +171,8 @@ static void vmport_realizefn(DeviceState *dev, Er=
ror **errp)
> > >   }
> > >   static Property vmport_properties[] =3D {
> > > +    /* Default value taken from open-vm-tools code VERSION_MAGIC def=
inition */
> > > +    DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version, 6),
> > >       DEFINE_PROP_END_OF_LIST(),
> > >   };
> > > --=20
> > > 2.20.1


