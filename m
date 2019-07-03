Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39077C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2988218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpDJXztM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2988218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hic2m-0002sK-B8
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43622)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hic21-00029c-TH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hic20-0004Fe-Mx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:58:29 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hic20-0004Cq-Bi
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:58:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id a15so1527289wmj.5
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rW/fXSq7CHcBwrXrXRxa0JI9zQXBjJuLom0DVCSM5aU=;
 b=FpDJXztMr+rIR19Vbo7b7W5dkA97iH4mDU9MCQWZMy0osEHPQUlIlUQId5DbnfeIAN
 LNEUQXJrxoroC4f/8qMFeJWlQa8owegSTqo03wRWb/2aqTxFQlNYNo/ZPCGgeD90edMy
 N1CZ1B4hSmcSIdRlUfUFZJd14/Xdk6OwSDdlTjfF9LnaNq1lqTEZuGUMzyr5LyXZs7GT
 TrDTLSIcUlPTVCcAoZWCNAiJm++CZnfnDdghTMCQrxMVQaslMGQITP/tdBXXLCjgqEUp
 C+5TVpoettv65cXycatn9cRqkEeSFGFvOeI+SmZ5k6GvmKHxhj4hGIVxJIUy4ykLr2Oa
 7zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rW/fXSq7CHcBwrXrXRxa0JI9zQXBjJuLom0DVCSM5aU=;
 b=D0yU+TAB9j/RdbWhm6Srjn4sxlvn1A8sOdELXqMS3HUNjtzr2HBLZoMJGu8Vk+O6Kj
 I2x965YtH75WV8AGkR2qH3Owz1PyvBVeHVgCkKO9PhR2iR2ynt1qwFPg0GQKoEV+8Zgv
 O3whrbvbXAs4VI9rDhNWtr1lO5IAxsE/7+0Pv7XxYQsklLecutHfjqZJCkCJej95qjCJ
 h7Q8eWGs5bvGgqiE4ldJP94PB7cJ2bL6crw1DHpje7aBobRPhvWsjBIhEBSSOKu92KFg
 QJcopLiiTlzqLVAaZhmW0Y98hkjgV4+AU1AFb4FjG3I5bcJbBKruVgW1aWKwxWPGkJE3
 zbQw==
X-Gm-Message-State: APjAAAWoj9gJwIoDOSAxni6irr2acSpwHndAMRE3NagK0AbTOiVQsP38
 eSL0YRX0h4C7m1Sl4g7B7mQ=
X-Google-Smtp-Source: APXvYqyA8fnEElEl+zOVSRFUh6ER751931GwrXW3NVZ/aw7xEbXU6+5bcmkaOze65bFmAPwrcQFYIQ==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr7939236wmc.154.1562147907171; 
 Wed, 03 Jul 2019 02:58:27 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x6sm2139913wru.0.2019.07.03.02.58.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 02:58:26 -0700 (PDT)
Date: Wed, 3 Jul 2019 10:58:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190703095825.GE11844@stefanha-x1.localdomain>
References: <20190702121106.28374-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
In-Reply-To: <20190702121106.28374-1-slp@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 sgarzare@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2019 at 02:11:02PM +0200, Sergio Lopez wrote:
> Microvm is a machine type inspired by both NEMU and Firecracker, and
> constructed after the machine model implemented by the latter.
>=20
> It's main purpose is providing users a KVM-only machine type with fast
> boot times, minimal attack surface (measured as the number of IO ports
> and MMIO regions exposed to the Guest) and small footprint (specially
> when combined with the ongoing QEMU modularization effort).
>=20
> Normally, other than the device support provided by KVM itself,
> microvm only supports virtio-mmio devices. Microvm also includes a
> legacy mode, which adds an ISA bus with a 16550A serial port, useful
> for being able to see the early boot kernel messages.
>=20
> Microvm only supports booting PVH-enabled Linux ELF images. Booting
> other PVH-enabled kernels may be possible, but due to the lack of ACPI
> and firmware, we're relying on the command line for specifying the
> location of the virtio-mmio transports. If there's an interest on
> using this machine type with other kernels, we'll try to find some
> kind of middle ground solution.
>=20
> This is the list of the exposed IO ports and MMIO regions when running
> in non-legacy mode:
>=20
> address-space: memory
>     00000000d0000000-00000000d00001ff (prio 0, i/o): virtio-mmio
>     00000000d0000200-00000000d00003ff (prio 0, i/o): virtio-mmio
>     00000000d0000400-00000000d00005ff (prio 0, i/o): virtio-mmio
>     00000000d0000600-00000000d00007ff (prio 0, i/o): virtio-mmio
>     00000000d0000800-00000000d00009ff (prio 0, i/o): virtio-mmio
>     00000000d0000a00-00000000d0000bff (prio 0, i/o): virtio-mmio
>     00000000d0000c00-00000000d0000dff (prio 0, i/o): virtio-mmio
>     00000000d0000e00-00000000d0000fff (prio 0, i/o): virtio-mmio
>     00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>=20
> address-space: I/O
>   0000000000000000-000000000000ffff (prio 0, i/o): io
>     0000000000000020-0000000000000021 (prio 0, i/o): kvm-pic
>     0000000000000040-0000000000000043 (prio 0, i/o): kvm-pit
>     000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
>     00000000000000a0-00000000000000a1 (prio 0, i/o): kvm-pic
>     00000000000004d0-00000000000004d0 (prio 0, i/o): kvm-elcr
>     00000000000004d1-00000000000004d1 (prio 0, i/o): kvm-elcr
>=20
> A QEMU instance with the microvm machine type can be invoked this way:
>=20
>  - Normal mode:
>=20
> qemu-system-x86_64 -M microvm -m 512m -smp 2 \
>  -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
>  -nodefaults -no-user-config \
>  -chardev pty,id=3Dvirtiocon0,server \
>  -device virtio-serial-device \
>  -device virtconsole,chardev=3Dvirtiocon0 \
>  -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>  -device virtio-blk-device,drive=3Dtest \
>  -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
>  -device virtio-net-device,netdev=3Dtap0
>=20
>  - Legacy mode:
>=20
> qemu-system-x86_64 -M microvm,legacy -m 512m -smp 2 \
>  -kernel vmlinux -append "console=3DttyS0 root=3D/dev/vda" \
>  -nodefaults -no-user-config \
>  -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>  -device virtio-blk-device,drive=3Dtest \
>  -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
>  -device virtio-net-device,netdev=3Dtap0 \
>  -serial stdio

Please post metrics that compare this against a minimal Q35.

With qboot it was later found that SeaBIOS can achieve comparable boot
times, so it wasn't worth maintaining qboot.

Data is needed to show that microvm is really a significant improvement
over a minimal Q35.

Stefan

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0cfEEACgkQnKSrs4Gr
c8hZWwf/a+/b3RJvDJq3tae3jFbA5YsmnFoHQe3nJLMwF/Gv4RqPsx+HOm3qh8aj
jYRywd4ZeMAlQIsrBcYwDLpcs2u6EjQVFNuACcx/j+emAkcivmBWGjv9INpfzf0H
0W02V92C/sfNlh+aBdiQbJX5crEjRPTePxO8U/Eg7UsY5yPTTljh03zPd4heVVQ0
+4poMEPF/4ab7YxxB9Yjs4pwU/6aT+r4N0faP36X5N4MAEe6QGvZULmSwS91THFR
T0Nduoyz5Dt/stdTz3qe5yhcOdbBOsjCLpcZrhRiGPnVPxp+ZmLuBF4j4Qp11hmh
OiiafnaLCSBaG09I/znFmhqOS7lWBw==
=ANBz
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--

