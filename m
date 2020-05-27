Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F8DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5F820776
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLNFVp5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5F820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyL3-0001oH-NH
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdyJs-0000x9-6B
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:50:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdyJr-0004mX-Ey
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:50:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so3558438wmj.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yB1MWuN+qieW54gwVd8OuJcTwIyxJRmEIjl4kW/rH/I=;
 b=kLNFVp5Ih63MveD+hs60wO+AGNN+esJUJLR+qQSDDk1vppOhSkXol1AJHlUxLG+FnP
 xxh2eh5V+my7p/A8qdRZGk7nkqPwF/8dGGJwjUWIOPsYSWBNTIKFX96TFlbSYXdkF5jP
 ILjm+YKtONtgetHapz5fLYHRDGbRTSHVWWyaO08Aw7XGI6efFJFM+F0rZkK0DLMM8k8T
 Q/r+M8IeI8+Mx0SSgiSrPL6MXqNpUsTH8yrSfDMX7Vc76lcjNvqrj8CrWL6JkM3tnT45
 tA1nnBv3cY+DyIWYGsxNzDsEe2eF+p5dwTG9htHkzAsE9huNNHr84eKYLjnd02m7B+1q
 HX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yB1MWuN+qieW54gwVd8OuJcTwIyxJRmEIjl4kW/rH/I=;
 b=gwaD0MQVvPBRvwWRzVQRqYR9gxI+GQGYsiHN6Zt2WfkRri8I9IBjha6alRBC1QH2mx
 4SmCgRs1r8dw72404P6psLpqkHOAmmwHGlB7pYnKJqhfCA7wzAH9a29gx7/PW0ljECH+
 wF7SodZnFNZzxJZUPevK7rTUPQCMKL5vrUd1R0ub+obYhUZ400RnXdSSgc1Sp8QetvLl
 jnU40ce6SULrCcEP8KX25TINuJKdFaPUAQBKKZh6eYV+6dGR9rKShOyGDHKcuqIlikwZ
 Y2GhwfBzFW5VoSi3B4Bw+DWvWcUC6dGDDES6mWFj0vvFebEPlUWREHPaesXP5Z/nKh+C
 0t6A==
X-Gm-Message-State: AOAM531uizWypfJmvL2w63YqvnkwaL/Zt+0S43ZWDFtN6G/JsE6qsHW+
 fKvI8iNpMelcCDgR746BnGM=
X-Google-Smtp-Source: ABdhPJwkP0WYe6x+eV3/8pEkyDlV55+UMTJJjRcKNrq4CmnWAePxFB972xHSrheyblzh7x8PCzAqTQ==
X-Received: by 2002:a1c:7703:: with SMTP id t3mr4626531wmi.113.1590594613039; 
 Wed, 27 May 2020 08:50:13 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x5sm3288394wro.12.2020.05.27.08.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 08:50:12 -0700 (PDT)
Date: Wed, 27 May 2020 16:50:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 7/7] virtio-scsi: use scsi_device_get
Message-ID: <20200527155010.GM29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-8-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hnsKUeImFCk/igEn"
Content-Disposition: inline
In-Reply-To: <20200511160951.8733-8-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hnsKUeImFCk/igEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 07:09:51PM +0300, Maxim Levitsky wrote:
> This will help us to avoid the scsi device disappearing
> after we took a reference to it.
>=20
> It doesn't by itself forbid case when we try to access
> an unrealized device
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

I'm not very familiar with the SCSI emulation code, but this looks
correct. My understanding of what this patch does:

This patch keeps SCSIDevice alive between scsi_device_find() and
scsi_req_new(). Previously no SCSIDevice ref was taken so the device
could have been freed before scsi_req_new() had a chance to take a ref.

The TMF case is similar: the SCSIDevice ref must be held during
virtio_scsi_do_tmf(). We don't need to worry about the async cancel
notifiers because the request being canceled already holds a ref.

--hnsKUeImFCk/igEn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OjDIACgkQnKSrs4Gr
c8g+3wf/bDt16k0j0Cz10q+FvN2pWo79kgXFixkdCPwDINRDQ4aJ+n3EgC8o7V1M
OrwVDsT6tF3662zv8oB10H9Ork3+zlWdkuuZPu9UNB17HNJ091eFApn4MHuZgm7K
4gLnU3UT0Gu8QxtiqLIApUM0nnCEQ0KjZi3q4dXRSHrB1Qbb3SAmjp+Rb56GKlSz
uI4ACNVXcYSk3ZIWuu0PUipDT81xqpzDBBgmBTvYwSu5a8Q41d0zJmcGxWyhlksC
VI+b7nRdkpPdu+zDB6i/PRgJ7/FjXwxwashi/jZpR0BHtgZ4aHHhgamGNCflrNhj
+teMCwefLJ1tA25QvnyRR8ogFL2ASA==
=KcwU
-----END PGP SIGNATURE-----

--hnsKUeImFCk/igEn--

