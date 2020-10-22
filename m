Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FDFC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06256223FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTWzrNKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06256223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVaBR-0001w6-Uf
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 08:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kVaAP-0001RB-Jp
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 08:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kVaAM-0008Ej-Kl
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 08:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603371481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rnFwiBjaaVlYoZLAPNhtJgVfJQSMRQpIjTqX0JC2Di8=;
 b=gTWzrNKoIqEfSMfAsImvAXkJN3Lkzs9DZZSU61eP3zLE5cIAvVE/ppkx0U+SER8N9Y3m3+
 W/G6DHexIP4kFnOcLaQxJS/GEAATqGgY3R20acO5yhhMZK/SkOZiZCln7uVmfnls8fyepH
 GFq3wAzFnqbFkZGXCy3mixQMbD2logo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-kP9xSqHjNjey5IBcIui4eA-1; Thu, 22 Oct 2020 08:56:43 -0400
X-MC-Unique: kP9xSqHjNjey5IBcIui4eA-1
Received: by mail-pj1-f72.google.com with SMTP id 21so1003614pje.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=rnFwiBjaaVlYoZLAPNhtJgVfJQSMRQpIjTqX0JC2Di8=;
 b=b8udW0p12fooY1iHGk/zo4moxOP/IB2cImMLQ8asLCSSa6aWxMxyr8lC73kX1EuFR0
 TFkNd2fVdkxuA0SFy2H/+lDv3+zswzNNfkH0ZjIeDm9Zv5hSDLdfYNSB4jfkAmXXUBU7
 eePoyKIxac2P1f29+eFjve0G+rAWS1QnBeC1uCLACfKz/R8pYH45GRU97K8aOVFANDBF
 Lid11ZEmBxSzeUuEI/4q0OFfanID//vt/OA42Z5laXMQ5Lzgl793o/EFLcj+YjsMUKE3
 XzJk/vQrgp16Ss2Tm0qmn9sYDLYc0dzrYboZNnoHY5g3kITuQs4YeXMxWhmV95irqr71
 itUA==
X-Gm-Message-State: AOAM531eU560UoJMSWzgjcEsx4tm4+4yD74eJ9ETr1wuG/aghvHSBiV4
 Mt5g7vuaT2xSjHrcZNTdF5a4vZ3SOA/Yvfd7MqrnHrFLqXjtas5dUvHl35qSQR3VRO5Jn1o8wW+
 1tEcGMeKGTI3K1HI=
X-Received: by 2002:a62:7609:0:b029:152:b31e:6aed with SMTP id
 r9-20020a6276090000b0290152b31e6aedmr2438168pfc.10.1603371402389; 
 Thu, 22 Oct 2020 05:56:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9zEr3kx6JkbyK3eEI3os/ni8SUtxB0Z7fM+NzojPslvoZZtVzj4JmE0KeqtXsG5OO4nIBdQ==
X-Received: by 2002:a62:7609:0:b029:152:b31e:6aed with SMTP id
 r9-20020a6276090000b0290152b31e6aedmr2438140pfc.10.1603371402004; 
 Thu, 22 Oct 2020 05:56:42 -0700 (PDT)
Received: from yekko.fritz.box ([2001:4479:e200:1100:3c24:4d96:ea81:be55])
 by smtp.gmail.com with ESMTPSA id q14sm2206860pjp.43.2020.10.22.05.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 05:56:41 -0700 (PDT)
Date: Thu, 22 Oct 2020 23:56:32 +1100
From: David Gibson <dgibson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201022235632.7f69ddc9@yekko.fritz.box>
In-Reply-To: <20201022080354-mutt-send-email-mst@kernel.org>
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgibson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/=gSePKt+auwNee_V5sngHSA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jusual@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/=gSePKt+auwNee_V5sngHSA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Oct 2020 08:06:55 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Oct 22, 2020 at 02:40:26PM +0300, Marcel Apfelbaum wrote:
> > From: Marcel Apfelbaum <marcel@redhat.com>
> >=20
> > During PCIe Root Port's transition from Power-Off to Power-ON (or vice-=
versa)
> > the "Slot Control Register" has the "Power Indicator Control"
> > set to "Blinking" expressing a "power transition" mode.
> >=20
> > Any hotplug operation during the "power transition" mode is not permitt=
ed
> > or at least not expected by the Guest OS leading to strange failures.
> >=20
> > Detect and refuse hotplug operations in such case.
> >=20
> > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > ---
> >  hw/pci/pcie.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index 5b48bae0f6..2fe5c1473f 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -410,6 +410,7 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
> >      PCIDevice *hotplug_pdev =3D PCI_DEVICE(hotplug_dev);
> >      uint8_t *exp_cap =3D hotplug_pdev->config + hotplug_pdev->exp.exp_=
cap;
> >      uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> > +    uint32_t sltctl =3D pci_get_word(exp_cap + PCI_EXP_SLTCTL);
> > =20
> >      /* Check if hot-plug is disabled on the slot */
> >      if (dev->hotplugged && (sltcap & PCI_EXP_SLTCAP_HPC) =3D=3D 0) {
> > @@ -418,6 +419,12 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler *hot=
plug_dev, DeviceState *dev,
> >          return;
> >      }
> > =20
> > +    if ((sltctl & PCI_EXP_SLTCTL_PIC) =3D=3D PCI_EXP_SLTCTL_PWR_IND_BL=
INK) {
> > +        error_setg(errp, "Hot-plug failed: %s is in Power Transition",
> > +                   DEVICE(hotplug_pdev)->id);
> > +        return;
> > +    }
> > +
> >      pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
> >  } =20
>=20
> Probably the only way to handle for existing machine types.
> For new ones, can't we queue it in host memory somewhere?

I'm not actually convinced we can't do that even for existing machine
types.  So I'm a bit hesitant to suggest going ahead with this without
looking a bit closer at whether we can implement a wait-for-ready in
qemu, rather than forcing every user of qemu (human or machine) to do
so.


--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/=gSePKt+auwNee_V5sngHSA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+RgYAACgkQbDjKyiDZ
s5Li2xAAiMBMK8k3xMO45SPh7jclMiaCzM6pFglFICX3hGtaYa7bJUoIeyw2fpVf
YroJXfBsLJus2rZfMvCmY94+pTVE0EL+a1cpsuoM3iGAYCQGsTnCtTVYPdSQ60Df
PoOWPObk3z3bHIoiW9WYjMzU9GrgRxchC+PEUhZjNIxEod0SBuEHSlsbroiaoPbK
4GMeokGzMNHZKCc3Z2JJsxvxVJgwLElwm15KGGtkRkvu+u4pATdRUxy4UYrjVCBD
qnCkmBIqnoHpN1nMPNHnHMK+HIB5imyvWHO5oFfwR9QCDPH/U1B3E+pqlYhToL3M
wnArIezQC2z0gTD0JAfgx3ZxsQzQhAUD8ApuOLQ+iCTQNYohbiAc9BmG3Y7CFmLj
Xmk6OxbmmEBth3un3RL8M4bWUeouIhsGZHVnyWM+kpCSgqM+PfZ0/vgeuDQshIAk
/V/bt4k+D9WX/uQD7RGIxh2Ppx0dQGt1hFtXG0xU0kZwJAMSnF+rrQT/BnnDiNs1
Q7YB/GrNWdgOuSD43hzQnIw6wVUn1Jv3Mch0cjsd1BefPnKBdgo+BEautN53y9Ja
UejpyX3lIiPIBWRrtrJKvdcJj09he/ckFzBuoKi/gISzPkFP5+ruWdMJG9NiGIQ+
1/y9h8PGAdHI4HmHkRMqSbfJ/RrH4530ISuD6rjpi71AWgJMmBo=
=zqzf
-----END PGP SIGNATURE-----

--Sig_/=gSePKt+auwNee_V5sngHSA--


