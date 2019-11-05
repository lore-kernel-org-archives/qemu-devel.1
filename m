Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7F9C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8460421882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDlQS3Ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8460421882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1t8-0006oB-Lz
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iS1s9-0006Hx-FE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iS1s7-0007oy-RK
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:40:01 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iS1s5-0007oC-UV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:39:58 -0500
Received: by mail-wm1-x343.google.com with SMTP id c17so14403885wmk.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 08:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bES6xcSkdUjHUStQW650vYnm/AEy5c7YuJERNgz0r+8=;
 b=kDlQS3OxF3siMTlwwv0um7V8/dkZ/820GTlw/WWjUOsejwZ09ZSylLcAd8tMo00VBo
 Wu6Ybvo/SN/mPbkhyffrrEaBEfk5ZjK4Md6JZymWhgsxx3/qGpWQX5eySbVIQCzTuKBc
 8+MCGt3bi5YkgR9QiKgB3mC0qIbNFugGa/e4V2u9lv3pXonZijdSdCc5SAZao3iXyAkW
 lFJ/sBQ8RJGpdLZ1RMgSfju9tzCFN5vXA4hzGJZYx1lSoEMVqBYJH1ENO0j5H9hbRfEQ
 hzWHSt/s1biK2krCMhsOgmVx8jm5PxovhowY5WExucoTeOR20A8Ycb3dhaqGaWvjybAw
 eNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bES6xcSkdUjHUStQW650vYnm/AEy5c7YuJERNgz0r+8=;
 b=ApGvB7b3zRDxtmFp0VHLgmhpl924WGXJLoyJ3qQvTCYtgZ3rFSqkwikfzak4Ad0XIO
 ZWLUSXPGO4Q3S1H+qEkb8haUFLAW7nrxA060CHjl4zcz/N0CHjUV+k0jD0k2HPqEtAIV
 vZhBYwkXR8/YTTBEdvPIHsHbPvHHgoZZrmtvDiVSAViaf6sRFIKw8Kaak+4+Yx3MT0EN
 sUMSWCYdlDTZUvRpXAK6IHqReomBhjYFbBY8cnmFjCCObd5StbO1xa6q/XpbZ5noZ7ls
 W+l/MIGG9mMhwtiKjBeDWHFWxLe4l94abqQTOYBeEs9ng+rNxgbAg226rKwNVgA0BB0b
 IF3g==
X-Gm-Message-State: APjAAAVWJje1GP9Yq3MlRUtHK92oV5+8S7yiUtubDa4oy/Qjzpn8xJYR
 RhDKwj3svPbbeM3WQcRS124=
X-Google-Smtp-Source: APXvYqykW0PCu6LixXLCsLp7EXU0FXaxy/U9TDMGY1WqQmZByHTrnuJFVjfGAxTPhmC+FYuvIgqhCg==
X-Received: by 2002:a1c:41c2:: with SMTP id o185mr4700787wma.34.1572971996165; 
 Tue, 05 Nov 2019 08:39:56 -0800 (PST)
Received: from localhost (91.141.1.3.wireless.dyn.drei.com. [91.141.1.3])
 by smtp.gmail.com with ESMTPSA id w132sm17534465wma.6.2019.11.05.08.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 08:39:55 -0800 (PST)
Date: Tue, 5 Nov 2019 17:39:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dinah A Baum <dinahbaum@utexas.edu>
Subject: Re: Feature Recommendations?
Message-ID: <20191105163952.GI166646@stefanha-x1.localdomain>
References: <CAOyzTAivEpv1VXzPXVH3Za9Zcz1URFjnpFCZQrRB4K=Z-oy1Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Content-Disposition: inline
In-Reply-To: <CAOyzTAivEpv1VXzPXVH3Za9Zcz1URFjnpFCZQrRB4K=Z-oy1Dw@mail.gmail.com>
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 03, 2019 at 04:59:31AM -0600, Dinah A Baum wrote:
> I am a university student whose Virtualization course has tasked me with
> contributing to an open source, virtualization related project. I have a
> little more than a month to complete this. I was wondering if you could
> recommend a feature you'd like added that could be done in this time frame.

Hi Dinah,
The SeaBIOS firmware used by x86 guests currently requires 2 vmexits per
PCI Configuration Space access.  It is possible to reduce the number of
vmexits and speed up boot time by doing this.

SeaBIOS uses the standard 0xcf8/0xcfc PIO registers to access PCI
configuration space in src/hw/pci.c.  See pci_config_writel(),
pci_config_readl(), and related functions.

There is code in SeaBIOS that actually already knows about the more
modern MMConfig (also known as ACPI MCFG) mechanism for accessing PCI
Configuration Space.  But this code currently only places this
information into the MCFG ACPI table that operating systems running
after SeaBIOS will use.  See src/fw/pciinit.c:mch_mmconfig_setup() and
src/fw/acpi.c:build_mcfg_q35().

The goal of this project is to modify src/hw/pci.c to use MMConfig when
available.  This will reduce the number of vmexits when a virtual
machine is started and therefore speed up boot.

General information on PCI Configuration Space access:
http://developer.amd.com/wordpress/media/2012/10/pci%20-%20pci%20express%20configuration%20space%20access.pdf
https://wiki.osdev.org/PCI_Express#Enhanced_Configuration_Mechanism

QEMU MCFG emulation code:
hw/pci/pcie_host.c:pcie_host_mmcfg_map(), pcie_mmcfg_data_write(), and
pcie_mmcfg_data_read()

SeaBIOS source code:
https://git.seabios.org/cgit/seabios.git

QEMU source code:
https://git.qemu.org/?p=qemu.git;a=summary

To test a modified SeaBIOS in QEMU:

  $ git clone https://git.qemu.org/qemu.git
  $ cd qemu
  $ git submodule update --init roms/seabios
  $ ./configure --target-list=x86_64-softmmu && make -j$(nproc)
  $ cd roms/seabios
  $ ...modify the SeaBIOS code...
  $ cd ..
  $ make bios # this will build SeaBIOS
  $ cd ..
  $ x86_64-softmmu/qemu-system-x86_64 -M accel=kvm -m 1G -drive if=virtio,file=test.img,format=raw

This will launch a QEMU guest with 1 GB of RAM and a virtio-blk-pci
device.  Your SeaBIOS changes will be used when the firmware attempts to
boot from the virtio-blk-pci device.

Stefan

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3BpdgACgkQnKSrs4Gr
c8jbkwf/a3rCehYZ2Q30lH82g3mc8qk+TZ/+msX/2cqBauVWeqDuOWL/5zNTxc7H
jU9dVkUDAQokKXjHSTHA5JzFzU3hDApAxZEFTzdS+MY6n5yrTbKMhCyE5Umlaiby
PJOUD3WIlFHpMT/JFgaKgQ9DVte4WcQW7RUa/kAgd+9irkj/FEhaWpOw9TjMQhTn
XCBkOYlnFgiCb8rH0tm88V17EAZyxEkSImg8/eXt0RJr1uQRnr2rzMtpa7zSFhxi
j8hakT/7q40ljrqI9Ec4GwyMYuzR1efSC4aFyP8ILccPc270errUnPXFM1eGS0yH
m2viUTKoFgLDgco3vtYOO2Lm6mzf1Q==
=T/9Y
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--

