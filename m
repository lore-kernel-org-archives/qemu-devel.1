Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E8FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0273A207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYGgWVdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0273A207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxZG-0004n4-5g
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdxYB-0003sl-2N
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:00:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdxY9-0004rv-Rk
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:00:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id u12so3362145wmd.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ka3kKkJ5twquOq3WDD17Avta4VnskIRjLkWGz9898Lk=;
 b=RYGgWVdg6cs5EcLZSE4KB99x9dAMVYYTEuj3xNgya5CziZM3eRXM65+Clcn89vbLch
 aQOo4VJa6L8f1rCm3rpXaNARiS+O/VpATeIVEkMSpKLTSuR8owOFw9zuLGPPhE2Q/Chy
 E9JvFvv9jCXnBuruSqiBAqygAppmj4hD/JFH2ScPidZS/Y+XDxI+wFSwsooM7W5uywGO
 scW9BDYJvHAdtj6yQYSwWb2NDwRin8iOLN8Kguse0tLFD2brJuz4BVEfxsLe1aPEYFqA
 K5tFOxfXOZB8x3mL/kVTa8hbXHBnICivFFMzorcXp+Pn977KCsXZo4S2XU86hT1Q+zMY
 XRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ka3kKkJ5twquOq3WDD17Avta4VnskIRjLkWGz9898Lk=;
 b=sETRopcoNkaZhA0adMVWOtlnrzF6c7GIINP/IeB+3j11sXe4+BfDna9UT/dABj1h7E
 tzlmD6twqbjtkaUQRxEDHje3wTTXbDFNYdJ3EWJlQLo2yb7g98aXNnLNR2iLJvJFI+68
 qMOvYsF04waQGC5d1fmCPEIRaJoP1PyVKA4bIMbGmVTvia0aNA5JUo0cFIfBwlpza7IO
 +UnbY3rP8JyH0I2U2IOr+WwgMS9pcxWd0WjeuC8rlsQz+U7m1l3l49U8jZMapIItQ3IW
 /GmJLTMZL6Ycb1L5BhFu6/6sqRKTsYyDBYhru+PpVpyO0Z7nAXzQNCUEMvYaqdHK/sm/
 ALpQ==
X-Gm-Message-State: AOAM533qdY4PtJvqdYjE/r3QS8rLdJyNwjslByRfqvOwS7NGUYvhDh+q
 mdgcHxePT0jxxbl1vuX9Blc=
X-Google-Smtp-Source: ABdhPJwswsqgUsICdaj0/z/nuuJlNm8jGYayyVpBz22t+icFiN/b/Mh/dEXvBffZNls4XBTXibh0Ag==
X-Received: by 2002:a05:600c:4146:: with SMTP id
 h6mr4872680wmm.170.1590591656119; 
 Wed, 27 May 2020 08:00:56 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y80sm3340674wmc.34.2020.05.27.08.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 08:00:54 -0700 (PDT)
Date: Wed, 27 May 2020 16:00:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 4/7] device-core: use atomic_set on .realized property
Message-ID: <20200527150053.GJ29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-5-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2fjX3cMESU3XgGmZ"
Content-Disposition: inline
In-Reply-To: <20200511160951.8733-5-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
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


--2fjX3cMESU3XgGmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 07:09:48PM +0300, Maxim Levitsky wrote:
> Some code might race with placement of new devices on a bus.
> We currently first place a (unrealized) device on the bus
> and then realize it.
>=20
> As a workaround, users that scan the child device list, can
> check the realized property to see if it is safe to access such a device.
> Use an atomic write here too to aid with this.
>=20
> A separate discussion is what to do with devices that are unrealized:
> It looks like for this case we only call the hotplug handler's unplug
> callback and its up to it to unrealize the device.
> An atomic operation doesn't cause harm for this code path though.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/core/qdev.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Please add a comment to struct DeviceState saying the realized field
must be accessed with atomic_load_acquire() when used outside the QEMU
global mutex.

> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 732789e2b7..d530c5922f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -964,7 +964,20 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
>              }
>         }
> =20
> +       atomic_store_release(&dev->realized, value);
> +
>      } else if (!value && dev->realized) {
> +
> +        /*
> +         * Change the value so that any concurrent users are aware
> +         * that the device is going to be unrealized
> +         *
> +         * TODO: change .realized property to enum that states
> +         * each phase of the device realization/unrealization
> +         */
> +
> +        atomic_store_release(&dev->realized, value);

I'm not sure if atomic_store_release() is strong enough in the true ->
false case:

  Operations coming after ``atomic_store_release()`` can still be
  reordered before it.

A reader may already seen changes made to unrealize the DeviceState even
though realized still appears to be true. A full write memory barrier
seems safer here.

--2fjX3cMESU3XgGmZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OgKUACgkQnKSrs4Gr
c8hTrggAjoSb/eiGywtM+dpgf01M3sji2W2PLba4pu4i+Zt0hqASXgZwyQ6w9OSh
Uigvfg7SHg1FSCfmaD+rUntIz2c/IO64X4y6MT9cbK5+g1HWdqBE9VnfwOr4VX2n
9+2DQ99lJ85dYmobQmM6WwpT+2cj+2V53OaFNxIC02ik/fvkIHoeDTrAZcHuzFtL
2qFE7LtMsj470yuq7r1TnCkYN69YQpFxusKt2RpFI6L8+Iuy0GdX2P3GWWECwID4
nPrzOUcVHWZZWtBvD+CMeExaychyG13TuDTbhqq3ImYZrW7RnNZiVgGOpwHsFSEK
WrW8ewHXK8VAtBCpjaTaDfQKxNkhEw==
=3YVY
-----END PGP SIGNATURE-----

--2fjX3cMESU3XgGmZ--

