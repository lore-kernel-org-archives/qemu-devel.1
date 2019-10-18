Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49622CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1860220663
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg71yZOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1860220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLP96-0001BW-9s
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iLP88-0000QA-07
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iLP86-00058P-GM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:05:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iLP86-000587-6o
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:05:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id o15so5150529wru.5
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=doHzIrn7ThOeSoMQbOIYfqyXITXPZKqan6tlP2+KfHk=;
 b=Rg71yZOye0jXOicviISRhidAEEqBTSBT8NKI2r5egC88ZrmwV5p+BMnYcUcrbBDUhs
 PcMKhwVMftO0yXcj5Jux4Rr2vOqt0pZnxMDapfmVQiIlCQa8qgI5w0RdoH2yYZnyOfVB
 ci50y1w13kNzjIpPukl943w6Tzjeh4GfhbJwZoYz3lk1qGDfj4qwECyXAtpwlXLvkMDq
 E2P1BtHDkHiV7dr6R13SRRTeiAdcfwCMYNRoKIaj/r8AxAXq3/Pj7F+eAOKJlfNq/4nx
 iNy8e9cFlMifMRMf+5Z3h+P+1CJoId+mu0HBhm8EGRF/3j+x/GfDMQv93ud+Vv2WIJBa
 mgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=doHzIrn7ThOeSoMQbOIYfqyXITXPZKqan6tlP2+KfHk=;
 b=jBw5pDRkyykLuBblgo+R6h14RsFgHnJ8rz4ufXdMndTEnAVgZ8Xc3RCp+SSttvkSSQ
 xcIOi5HYBq/+jAuKZGR9Q7GgsnrKTLwjHC1yyxz1WiDm869eQKpB8yIJxmmwrWuSm6pj
 kgZEy323DuZtn7SoJiLPXc9BCWkb98H5vrwxnMFfO0xFNKnQNcZsW5BZYlUgQ+vJ+Eyk
 oWW+uw7eyN68S/OOLjs9x3qS0yX7nw2cKqFXKTtOasIsZmL6ND2glMuHIsR/EHFXOeP2
 LSu+D3zpRfZJ7C0k3E0bbVx3skOffFBJpMfRmwpkdFCgTrejmdC/5mtxQ2oRyHEVPLPh
 Xjfw==
X-Gm-Message-State: APjAAAXuRJQKgpqEm3YlFu5qQuLaxeVIdRKczOqpoUwys7ljyaHBm86O
 EIGYwzCykLz81MzLup5aTIM=
X-Google-Smtp-Source: APXvYqy9wHFamy7WPcZO6knwkk2u8MYI/DUDYv82ZSO5Wq0uayOa4Nvh9h8YjKbAsW22rwJYzYxfbA==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr7468171wrr.114.1571393104639; 
 Fri, 18 Oct 2019 03:05:04 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t16sm4444732wrq.52.2019.10.18.03.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 03:05:03 -0700 (PDT)
Date: Fri, 18 Oct 2019 11:05:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 7/7] libqos: add VIRTIO PCI 1.0 support
Message-ID: <20191018100501.GA9360@stefanha-x1.localdomain>
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-8-stefanha@redhat.com>
 <e7821640-de44-5e65-b9c1-2534dc676690@redhat.com>
 <20191017160735.GB1266@stefanha-x1.localdomain>
 <d803e58f-f0cc-b13b-6041-682497c6fe2f@redhat.com>
 <2545dd3e-f398-0e7a-0f82-fc340034a004@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <2545dd3e-f398-0e7a-0f82-fc340034a004@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 08:48:23AM +0200, Thomas Huth wrote:
> On 17/10/2019 18.18, Thomas Huth wrote:
> > On 17/10/2019 18.07, Stefan Hajnoczi wrote:
> >> On Thu, Oct 17, 2019 at 04:52:54PM +0200, Thomas Huth wrote:
> >>> On 11/10/2019 10.56, Stefan Hajnoczi wrote:
> >>>> Implement the VIRTIO 1.0 virtio-pci interface.  The main change here=
 is
> >>>> that the register layout is no longer a fixed layout in BAR 0.  Inst=
ead
> >>>> we have to iterate of PCI Capabilities to find descriptions of where
> >>>> various registers are located.  The vring registers are also more
> >>>> fine-grained, allowing for more flexible vring layouts, but we don't
> >>>> take advantage of that.
> >>>>
> >>>> Note that test cases do not negotiate VIRTIO_F_VERSION_1 yet and are
> >>>> therefore not running in VIRTIO 1.0 mode.
> >>>>
> >>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>>> ---
> >>>>  tests/Makefile.include           |   1 +
> >>>>  tests/libqos/virtio-pci-modern.h |  17 ++
> >>>>  tests/libqos/virtio-pci.h        |  10 +
> >>>>  tests/libqos/virtio-pci-modern.c | 412 ++++++++++++++++++++++++++++=
+++
> >>>>  tests/libqos/virtio-pci.c        |   6 +-
> >>>>  5 files changed, 445 insertions(+), 1 deletion(-)
> >>>>  create mode 100644 tests/libqos/virtio-pci-modern.h
> >>>>  create mode 100644 tests/libqos/virtio-pci-modern.c
> >>> [...]
> >>>> +static bool probe_device_type(QVirtioPCIDevice *dev)
> >>>> +{
> >>>> +    uint16_t vendor_id;
> >>>> +    uint16_t device_id;
> >>>> +
> >>>> +    /* "Drivers MUST match devices with the PCI Vendor ID 0x1AF4" */
> >>>> +    vendor_id =3D qpci_config_readw(dev->pdev, PCI_VENDOR_ID);
> >>>> +    if (vendor_id !=3D 0x1af4) {
> >>>> +        return false;
> >>>> +    }
> >>>> +
> >>>> +    /*
> >>>> +     * "Any PCI device with ... PCI Device ID 0x1000 through 0x107F=
 inclusive
> >>>> +     * is a virtio device"
> >>>> +     */
> >>>> +    device_id =3D qpci_config_readw(dev->pdev, PCI_DEVICE_ID);
> >>>> +    if (device_id < 0x1000 || device_id > 0x107f) {
> >>>> +        return false;
> >>>> +    }
> >>>> +
> >>>> +    /*
> >>>> +     * "Devices MAY utilize a Transitional PCI Device ID range, 0x1=
000 to
> >>>> +     * 0x103F depending on the device type"
> >>>> +     */
> >>>> +    if (device_id < 0x1040) {
> >>>> +        /*
> >>>> +         * "Transitional devices MUST have the PCI Subsystem Device=
 ID matching
> >>>> +         * the Virtio Device ID"
> >>>> +         */
> >>>> +        dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_=
SUBSYSTEM_ID);
> >>>
> >>> Shouldn't you return "false" here in case the device_type is 0 ? Which
> >>> likely means that it is a legacy or broken device ...?
> >>
> >> The real decision whether to use this PCI device or not happens in
> >> probe_device_layout().  If it's broken or a legacy device then that
> >> function will fail.
> >=20
> > Ok, fair.
> >=20
> > I've added the patches to my qtest-next branch:
> >=20
> > https://gitlab.com/huth/qemu/tree/qtest-next
>=20
>  Hi Stephan,
>=20
> looks like this is breaking the virtio-blk-test in certain configurations:
>=20
>  https://gitlab.com/huth/qemu/-/jobs/324085741
>=20
> and:
>=20
>  https://cirrus-ci.com/task/4511314474434560
>=20
> Could you please have a look?

On reading the VIRTIO specification again, I think my idea of supporting
the VIRTIO 1.0 PCI interface without actually negotiating the
VIRTIO_F_VERSION_1 feature bit is non-compliant:

  2.2.3 Legacy Interface: A Note on Feature Bits

  Transitional Drivers MUST detect Legacy Devices by detecting that the fea=
ture bit VIRTIO_F_VERSION_1 is not offered. [...]

  In this case device is used through the legacy interface.

Please drop this patch series for now.  Additional patches are required
to implement VIRTIO_F_VERSION_1 and then the endianness issue will go
away.  I will send a v2.

Stefan

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2pjk0ACgkQnKSrs4Gr
c8g25gf6AxPG/6B1qdwICbjk0G9icoLutxFjH1U5gr34Zy580QydUZXi86wXEpip
nw229+Bd61nSW6OBqCbtOyHbhxLpBLbjQ+8otqqC1FP6n1lLWIGfovbX4jQ6oV/H
1eG/EQtfmlQjPEhHbDo0cyCqZTS//l0VTBuppAvdOtQ6MfEDfT/ER8i2zbhKqQKW
OsP5a4G1fNbdXfZN/oSX/kgM02+o22w3YGcgypQ5G0JNQK41KnL4EExMjVkmon88
BHuhh1qrF5kVxGg8r0LyPl+UHM3OmX3S+HrExbt+zDxRLqxjGye7xEpnStpv4zcO
TjzO8QDUYHdDnPWwwWy3ka6PJXrMpg==
=k0aq
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

