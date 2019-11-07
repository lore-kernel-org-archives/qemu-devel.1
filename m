Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC24FC6195
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8BA214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4gBxspM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8BA214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSiNw-0006bd-9I
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSiMr-00063f-Jw
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSiMk-00053I-Jh
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:02:33 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSiMk-00051M-DE
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:02:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id q70so2620536wme.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9QOHXp3rlTE2VS/zti5aN/hBO4n0Zgp2Fc+LAAOfUqE=;
 b=a4gBxspMsvnADT9okWm18coedAnC8MHH6jIKfACNQ/63DL6K6uR/6IAw+69M/MxxUs
 Y36TxK3Acsxz4YYzSyfUbt7+y1QTh7z3zFCv2+U8AC8Cr2rtKlUUu/3TH0fpM5Qv/DyQ
 BqmJxIQcXRzFGoMKoJdiKmI8rmnmZ/B8X2qHJvZutSESL57XoQNXvtxmPBvWGHkfvspz
 Ay4QrKjaNzerptYXVzcceCAk8wKoIpPKgmhnMzxuKDD8I7cbk2DGeu/8iLj6YG0DytDR
 Mfu5/UniYLoi9ZsMFFBe3XhpckLokzGEtO4mZH3+3dmaZsgaBgbZAr5HIsDs6iZ2GJCl
 C8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9QOHXp3rlTE2VS/zti5aN/hBO4n0Zgp2Fc+LAAOfUqE=;
 b=HxZ79I7jSC7pxIMX6gczi8ddEepjqCUN10qLJHIYVHfGdd+nPgn2lPIDfN4mhWceBP
 SVTxjn01ZoMhetVeUEloVENpTcji9dEhauZW0yQB9haRQ/FPFNho/43NRG0OJINyZy+g
 gXbKWEq1L30gFaM5DjdGFSi+n4Eo7v5vkKKtsa/6G2ivhRC1DIeuPa8cdHUY7ZwSfWSd
 aZit8eVzbanKR+RDdUpdOzTHBIq6Uiu0ErfaDeIFh6xeRYv0+4s1gb+eotZG2mtSk51/
 yZ7x/03mSKoe/nIA2VcmdQXYqJ+NarORhow+G+p3zIltVKXN8xqcqtY7rOyTQND8uhxV
 HImw==
X-Gm-Message-State: APjAAAVwMQ38qTJb9TsQRTB4wZbevfCCQ2JS9i22medenCcnPcdC63g1
 xeBmigZs7Avrd0MWLVS2UxI=
X-Google-Smtp-Source: APXvYqy2jziMmOWVqhsRTV0RSkQkJU4Sc6V5ZM/fFi679qK3HzC5rgvEOKFNjBnBqOPbPH6hmTbcwA==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr3001694wma.62.1573135345042;
 Thu, 07 Nov 2019 06:02:25 -0800 (PST)
Received: from localhost (77.119.131.75.wireless.dyn.drei.com. [77.119.131.75])
 by smtp.gmail.com with ESMTPSA id w12sm2195906wmi.17.2019.11.07.06.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 06:02:23 -0800 (PST)
Date: Thu, 7 Nov 2019 15:02:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 49/49] multi-process: add configure and usage
 information
Message-ID: <20191107140220.GI365089@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <2736d12f29d2c9051966864b5d865ab0f392b8d1.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
Content-Disposition: inline
In-Reply-To: <2736d12f29d2c9051966864b5d865ab0f392b8d1.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:09:30AM -0400, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  docs/qemu-multiprocess.txt | 86 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 docs/qemu-multiprocess.txt
>=20
> diff --git a/docs/qemu-multiprocess.txt b/docs/qemu-multiprocess.txt
> new file mode 100644
> index 0000000..c29f4df
> --- /dev/null
> +++ b/docs/qemu-multiprocess.txt
> @@ -0,0 +1,86 @@
> +Multi-process QEMU
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document describes how to configure and use multi-process qemu.
> +For the design document refer to docs/devel/qemu-multiprocess.
> +
> +1) Configuration
> +----------------
> +
> +To enable support for multi-process add --enable-mpqemu
> +to the list of options for the "configure" script.
> +
> +
> +2) Usage
> +--------
> +
> +To start qemu with devices intended to run in a separate emulation
> +process without libvirtd support, the following should be used on QEMU
> +command line. As of now, we only support the emulation of lsi53c895a
> +in a separate process
> +
> +* Since parts of the RAM are shared between QEMU & remote process, a
> +  memory-backend-file is required to facilitate this, as follows:
> +
> +  -object memory-backend-file,id=3Dmem,mem-path=3D/dev/shm/,size=3D4096M=
,share=3Don
> +
> +* The devices to be emulated in the separate process are defined as
> +  before with addition of "rid" suboption that serves as a remote group
> +  identificator.
> +
> +  -device <device options>,rid=3D"remote process id"
> +
> +  For exmaple, for non multi-process qemu:

s/exmaple/example/

> +    -device lsi53c895a,id=3Dscsi0 device
> +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0
> +    -drive id=3Ddrive0,file=3Ddata-disk.img
> +
> +  and for multi-process qemu and no libvirt
> +  support (i.e. QEMU forks child processes):
> +    -device lsi53c895a,id=3Dscsi0,rid=3D0
> +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0,rid=3D"0"
> +
> +* The command-line options for the remote process is added to the "comma=
nd"

s/is added/are added/

> +  suboption of the newly added "-remote" option.=20
> +
> +   -remote [socket],rid=3D,command=3D"..."
> +
> +  The drives to be emulated by the remote process are specified as part =
of
> +  this command sub-option. The device to be used to connect to the monit=
or
> +  is also specified as part of this suboption.
> +
> +  For example, the following option adds a drive and monitor to the remo=
te
> +  process:
> +  -remote rid=3D0,command=3D"-drive id=3Ddrive0,,file=3Ddata-disk.img -m=
onitor unix:/home/qmp-sock,,server,,nowait"
> +
> +  Note: There's an issue with this "command" subtion which we are in the

s/subtion/sub-option/

> +  process of fixing. To work around this issue, it requires additional
> +  "comma" characters as illustrated above, and in the example below.
> +
> +* Example QEMU command-line to launch lsi53c895a in a remote process
> +
> +  #/bin/sh
> +  qemu-system-x86_64 \
> +  -name "OL7.4" \
> +  -machine q35,accel=3Dkvm \
> +  -smp sockets=3D1,cores=3D1,threads=3D1 \
> +  -cpu host \
> +  -m 2048 \
> +  -object memory-backend-file,id=3Dmem,mem-path=3D/dev/shm/,size=3D2G,sh=
are=3Don \
> +  -numa node,memdev=3Dmem \
> +  -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0 \
> +  -drive id=3Ddrive_image1,if=3Dnone,format=3Draw,file=3D/root/ol7.qcow2=
 \
> +  -device scsi-hd,id=3Dimage1,drive=3Ddrive_image1,bus=3Dvirtio_scsi_pci=
0.0 \
> +  -boot d \
> +  -monitor stdio \
> +  -vnc :0 \
> +  -device lsi53c895a,id=3Dlsi0,remote,rid=3D8,command=3D"qemu-scsi-dev" \
> +  -device scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,bus=3Dlsi0.0,scsi-id=
=3D0,remote,rid=3D8,command=3D"qemu-scsi-dev"\
> +  -remote rid=3D8,command=3D"-drive id=3Ddrive_image2,,file=3D/root/remo=
te-process-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
> +
> +  We could connect to the monitor using the following command:
> +  socat /home/qmp-sock stdio
> +
> +  After hotplugging disks to the remote process, please execute the
> +  following command in the guest to refresh the list of storage devices:
> +  rescan_scsi_bus.sh -a

This documentation suggests that QEMU spawns the remote processes.  How
do this work with unprivileged QEMU?  Is there an additional step where
QEMU drops privileges after having spawned remote processes?

Remote processes require accesses to resources that the main QEMU
process does not need access to, so I'm wondering how this process model
ensures that each process has only the privileges it needs.

Stefan

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3EI+sACgkQnKSrs4Gr
c8g78wgAgUZkX3pxPTmUiqua4o5o82tJ3aSZYq9vvuc+x99fIF4dLfCVLM9jXSRs
CE/uBKZ1HTilU00ArA1JS0FbxtNxwHTOuFm2d2fViidTAFEJvlzb4rAHbAJnoXnx
oEjCKOGgfieWMoYtdgZgnwRxbyMp0XlmD6GpD8sFpDwZqyO1/Ss20tICG/Spc8Sn
CSxH2/H/zRWROB8vRopcedLjI7ECuf1DDv+8aRet8v6cU4G7uIEmi55LfrIUdAs1
zIB0WIv9n26D6k/O8ahRVb/rnp6f2RVnckECcptaLJ7G6gkJE1c2VMnUDOxCL3ZW
YsUStCcylEwgQOHhUGVcKialznc5sA==
=6J3T
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--

