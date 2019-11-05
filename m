Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B5C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96120214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPmwE+Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96120214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1Ny-0004St-QO
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iS1Mx-0003xa-1G
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iS1Mv-0000Ys-OT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:07:46 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iS1Mv-0000XF-Hw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:07:45 -0500
Received: by mail-wm1-x341.google.com with SMTP id 11so21661295wmk.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 08:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nyPqoVIMdsi6f+uAruVsBj/upZkyERnt76AwukdeTU8=;
 b=bPmwE+VblxhhG/93fNK6SoqaanZOipvTjdofq4TSUPu9rAN1IFOtfeBNs+V3mdFmdQ
 Q9bmvrDL+4x8fcAcXVUBorcnPLO3l5hdFYzAkoMs6CTd/7zj7f/qbB2Rl+gVDHPdE1dw
 NhdD8n/r6iuvwxkA1bYjzytKhWRP8wI312d7VWj6WkSBa9/Ef3WzhepIY+1xWO6S4921
 0Oq1hr+NGFmMHs8yD9TGcx6zAnsJMtvxLAmdhgHylx2AHXW/DeDO2uQVX76WqNI3uXZt
 xFAgRZr6ejsYv8RbZtHkTl68dJYXA0yTYwTnN56XHHcTVBMz0tJvXP3NaBIy9cnw0//3
 7ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nyPqoVIMdsi6f+uAruVsBj/upZkyERnt76AwukdeTU8=;
 b=HYL4OatpG33fglnuDJuDJfEEvlDJ+rRfPqr2BVAZlDXjKY8D8Lfoe2DoQmweRaN7dR
 ZPmErxNKEcUMnyEFFHi4GjURBHqo8I7Tsb4Xh6JnsGJWCIYdoCxDWdLfAP9g0lllsETS
 hrCM+Ojbt9V8KD4/XOfACSdqqLINIEsygqytRbWrCOQdKN5uZZlAoghwJA8ErMbnsPFU
 XZ+OlKWrYAflvhFSANBDGOz3rPSHAv18U/MxhhSMvUmpskPZjnb360chHIWKavMR1VQQ
 mekWlOfa2S6U+qkobaVufifsLDSTV7M4xK7c+M64jNXG6yt6r9Xij/1NSeHMgjsPLPaT
 i4vQ==
X-Gm-Message-State: APjAAAXxgbI8bmkgdUQBua1mBWgv7ZorGjd78eC760EaG9eFmpjgsMhp
 NZY9edCInZ5SF4D8N3ks4Co=
X-Google-Smtp-Source: APXvYqyzsddZHI9Oc+9vUDaHOAqzp++6FR5oLRaf7s94yB8H3YHE8HMoQl6+8sDqTLK61pkjQqt/zQ==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr4783641wma.166.1572970063995; 
 Tue, 05 Nov 2019 08:07:43 -0800 (PST)
Received: from localhost (91.141.1.3.wireless.dyn.drei.com. [91.141.1.3])
 by smtp.gmail.com with ESMTPSA id m3sm22308990wrb.67.2019.11.05.08.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 08:07:42 -0800 (PST)
Date: Tue, 5 Nov 2019 17:07:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: Failure of troublesome vhost-user/flags-mismatch test can't be
 reproduced
Message-ID: <20191105160740.GH166646@stefanha-x1.localdomain>
References: <CAJAkqrUo+8qJGAMprEY2ZxqL-3meHo-56PYc_M1oxXNy5SVvow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kHRd/tpU31Zn62xO"
Content-Disposition: inline
In-Reply-To: <CAJAkqrUo+8qJGAMprEY2ZxqL-3meHo-56PYc_M1oxXNy5SVvow@mail.gmail.com>
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kHRd/tpU31Zn62xO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2019 at 10:57:09AM +0800, Coiby Xu wrote:
> Hi,
>=20
> Can anyone reproduce the failure of one troublesome test
> vhost-user/flags-mismatch (https://wiki.qemu.org/Testing/CI/TroublesomeTe=
sts)
> which has been disabled since Aug 15 2017 (
> https://patchwork.kernel.org/patch/9939431/)?

CCing Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>, who added
QTEST_VHOST_USER_FIXME.

> Last month I downloaded QEMU
> source code (commit ID: 3483534ec3) and this version also failed this tes=
t.
> After debugging this issue, I thought I have fixed this issue by saving
> acknowledged features after vhost backend disconnect with the client
> (qemu). But later I reviewed the commit history of net/vhost-user.c and
> found out this test failed on my machines because of  a newly introduced
> bug from a recent commit (https://patchwork.kernel.org/patch/11054781/) on
> July 29 2019 and this new bug has already been fixed by a more recent
> commit (
> https://lists.sr.ht/~philmd/qemu/%3C20190924162044.11414-1-amorenoz%40red=
hat.com%3E).
> After more investigation, it surprised me both 3.1.0 and 2.9.1could pass
> vhost-user/flags-mismatch test. According to the comments on the commit
> https://patchwork.kernel.org/patch/9939431/ which disabled the
> vhost-user/flags-mismatch and other two tests, it seems the tests are only
> broken on travis. Maybe we should re-investigate this issue to re-enable
> the test so similar bugs like
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1738768 could be prevented =
in
> the first place.
>=20
> Btw we can excluisvely check this test on latest QEMU by given TESTPATH a=
nd
> setting QTEST_VHOST_USER_FIXME environment variable,
>     QTEST_VHOST_USER_FIXME=3D1
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qos-test -p
> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pci/virtio-net/vi=
rtio-net-tests/vhost-user/flags-mismatch
>=20
>=20
> --=20
> *Best regards,*
> *Coiby*

--kHRd/tpU31Zn62xO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3BnkwACgkQnKSrs4Gr
c8hoBAgAhkmFNX8r2O+3jSLkETHir45345K4PwVV/lirbA9CVD37YwYz9/IUqHg3
X553pGA4OsDMW1JuWbyR017SOQpBH8sy7uVDCPjnlPxNKMEpGjWLgrtFy0aiuSNM
y2XqbiifhCKywpqs2oXlUy7abp/5n6Ms2R0xWbqCm+WS/ulzA+CZ4M/MSxozCCEv
qxvKiXkbKhAB1ZPq0RHjpnY8JscNntPWcFTHu7b5SvqK2wnOtTC7bdXlwd4q01ld
47Klr+qrW2d4j/n58ONQeIr1k4r61O7vRrb2ogEMe8RMVHip4f0vHL+hUSPYFAXK
zA2dgeOExUeZJ7ThCOTJd54rMWQeZQ==
=5f2d
-----END PGP SIGNATURE-----

--kHRd/tpU31Zn62xO--

