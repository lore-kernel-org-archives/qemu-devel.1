Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13397C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D151C20714
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6wz3ila"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D151C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXjrB-0007Nx-3L
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 05:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXjqX-0006tx-02
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXjqV-0001Eg-SI
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:37:56 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXjqV-0001EJ-Jl
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:37:55 -0500
Received: by mail-wm1-x343.google.com with SMTP id f129so1732553wmf.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 02:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JbAt7kz+BD/xpBsHdhJBjVNvuk01T+RVO2Lc4gG0Uvg=;
 b=Q6wz3ila/3O0Qg+19Zy5yHxzTpReM1LEvESQTBO9jdbPfISZOHcuJKyVlF9JlrGDbz
 /6d3uXnvKR+LsmOB/Mu+qX9c0xYpdgAJIHt0UKKFJW0WZPYYrqG2MLwkmrtUNbgxYcTd
 ttLvzs4vscCeaVgqpB7TEklFhwpkMIBHqjCVd6QwQJDlyaoP1wqTtrLYtjUl22WrVv/f
 nKOVA6To1zQp6Ecu0jJZh5XD/QXGu25gp4V4tkQNbM7MpFqLh15b/Ly/bDKYBYJWfgvu
 LaHMbMJqIOmZgQ1PZur4h93tTvSyuuOXp9WfxjmN+m33uRBidPuRzXFPT3+8faBOcRpM
 /66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JbAt7kz+BD/xpBsHdhJBjVNvuk01T+RVO2Lc4gG0Uvg=;
 b=VasD3ythHuuWT3dySh7yq44RvK4B/715yFsInRgQ9aqxeQl2c6hIJRCLkKJQGFHpAE
 wdrXAcOt6jHVXgzoMicGNEX+Ba8gwZn5w2+uH4I82jokwCKQPaYgcZ37X0s2x6cyHUZO
 3zsUXzvsbZQxvlGgUsbNSoqohzWLpgSyKAWFGsoFSDGVczHmmTRoqs4jY0KNOmacisRc
 zV5XEKvcRokpQutHh85ii1eF9szCXeAdjF5Qg7YlcJFR6MKDuWyaVSFzDFY1Yu1EYhfl
 V7zHdyYBhS+Ya0o/cOzB78+TXDlLO6OAaNw0rIXC79hlk65I+CEEog6ox+zQHVuDfmY3
 7pUg==
X-Gm-Message-State: APjAAAVGMp7H5b+OKVMNRYTga0LBlEBoyvAoB9P2yqgqvhZYjqYZCdnt
 lXpjAtpudnxF3d2ywqA90dY=
X-Google-Smtp-Source: APXvYqxt7zgFRci+D7FUfCuojkTZCt306BH6LZCiqI0irY9ko6XvptwBHVQ6xN0EunaEGmUOAZJ/OQ==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr9011463wmi.141.1574332674443; 
 Thu, 21 Nov 2019 02:37:54 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z7sm1224475wma.46.2019.11.21.02.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 02:37:53 -0800 (PST)
Date: Thu, 21 Nov 2019 10:37:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 09/49] multi-process: setup PCI host bridge for
 remote device
Message-ID: <20191121103752.GG439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <21b8d0f06279f177f2daca8779ced48af14139ee.1571905346.git.jag.raman@oracle.com>
 <20191113160737.GD563983@stefanha-x1.localdomain>
 <e6e01c0c-ffd3-21f6-bf2c-db46258121af@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Content-Disposition: inline
In-Reply-To: <e6e01c0c-ffd3-21f6-bf2c-db46258121af@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 10:25:59AM -0500, Jag Raman wrote:
> On 11/13/2019 11:07 AM, Stefan Hajnoczi wrote:
> > On Thu, Oct 24, 2019 at 05:08:50AM -0400, Jagannathan Raman wrote:
> > > +static void remote_host_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);
> > > +    RemPCIHost *s =3D REMOTE_HOST_DEVICE(dev);
> > > +
> > > +    /*
> > > +     * TODO: the name of the bus would be provided by QEMU. Use
> > > +     * "pcie.0" for now.
> > > +     */
> > > +    pci->bus =3D pci_root_bus_new(DEVICE(s), "pcie.0",
> > > +                                s->mr_pci_mem, s->mr_sys_io,
> > > +                                0, TYPE_PCIE_BUS);
> >=20
> > The PCI bus name could be a property and then whatever instantiates
> > RemPCIHost could set it.
> >=20
> > Machine types usually hardcode the name because they assume there is
> > only one machine instance.  In the case of mpqemu this is an okay
> > starting point, but maybe multiple busses will become necessary if the
> > device emulation process handles multiple device instances - especially
> > if they are served to multiple guests like in a software-defined network
> > switch use case.
>=20
> Are you referring to a case where a single remote process will emulate
> devices from multiple guests?
>=20
> We haven't thought about that application. But we will certainly add the
> ability to specify the name of the bus as a parameter.

Sooner or later someone will want to run multiple devices in one device
emulation process, but it's not critical to support it in this patch
series.  I think it can be implemented later without breaking any stable
interfaces.

Stefan

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WaP8ACgkQnKSrs4Gr
c8hd6Qf9E0QG4f+xHbgSvoU7PH/tfuiuH6UdqxS7HXrhkFrKJ93/0Ivv549Ka0Pr
0AJvLU40cyakoyLf66a5Jc/ZTz4DgNxpsdDBPKp6km24Auh/A5iWyaLlNvC68hOu
FJNjifCZTSQdeovLoPlgGo47AlFTj2o/0CgN3iShRF/cQL6aQyEcvk+mNfqn/8BN
L0KdJ62/aTK68TqUYgzMCQZ4SBBCoZ5UFtsnP2mb9EJmJlDd0JrFlN1EiE76ASpR
L7uxymHpuYKaF9ZY/Kc+Dh0qok0LeQkxxCy0hosA1fz3i1UzqzVEe7W8H7AL5KMo
iHXCLDF90AeucOwV/a2TFMM/sZV2+A==
=Gc2S
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--

