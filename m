Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D890C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17849218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+0ifgXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17849218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWcM-00005A-1y
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iAWZx-0006Ug-6h
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iAWZw-0003rQ-9z
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:48:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iAWZw-0003r4-3I
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:48:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id q17so6149544wrx.10
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6JvTmJKz6xx6o5InZbIyS1miQU9pZnk/2FuA53lgZ7M=;
 b=Z+0ifgXhJIOqjWsXwVquhA8eNbNGV0sdLzZfGox9gjpX4zYZrJ8ghqBbaTYY2ZM+0t
 5Irks8NOB7IQu6w6/2YT2urvhh2Mc+8hz2+lXIXkaO+1+SEYcZby2VcUHKHT2EBejHF8
 UG/Aeci7PYwr7fXFo/d2+mO11WPFEbWQhmN3ceVMYkq1TedQaMsMkI2hM56+T3lfaORe
 rx9s/zP/wobixmDYhkfqq3sB8Isvn5jYQ8VovUKRJq/bgCvcYBQnVfg/UBkrT1HBaULQ
 pus/oOPgOuw6TSeycJT22mfV5TtIjEmMNlzONbt59UP1Zq/hI3rImHIxuMDgucTxtqzA
 2ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6JvTmJKz6xx6o5InZbIyS1miQU9pZnk/2FuA53lgZ7M=;
 b=heBaDLeGegzovsaXkhq3qa8fsVojshmLMkCUatnAxwGY1GtowVNnIrCQt07s8qd/Nb
 bDA92p1lsmVGerW6NSdJWiOVOQQLhLhcv8LPaMKq+EMubl6OBLlmXT2tnm/F2FYFL8qp
 ABLtGZc/1EaO7pk7AFKwhpxTbmFh/39mV38/oUcl/G0QroYLY163J0tUrOZNcaIaDMQa
 UFnZaNHW0k2zdpSPBJQ22w94uouJWyYHZqyGQBdQ3nE+mI7E4vvUDa7Xo3no2sM8P204
 SarVxVwdm+IuQfl2V3QEHmsbL2AyLsFOtbxbxIY8HC+O3Jti7rKotRhZZthrMq7CVqVC
 PhGA==
X-Gm-Message-State: APjAAAVgLA5sF2lUGIspTQlCNHCxvw6TQ4ObJ1N8uvtnPfjsl1HFpvJb
 J+gkehdGas+ZoDBqUCJdN08=
X-Google-Smtp-Source: APXvYqylbsOu4oJ/KfMmzzi3FIa9U6T6JEFiXkRUs8S1wo3068L5WmGqs1wP9XGPou1vAt3J16zc3Q==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr2182788wrv.350.1568800130977; 
 Wed, 18 Sep 2019 02:48:50 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a18sm11542871wrh.25.2019.09.18.02.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 02:48:50 -0700 (PDT)
Date: Wed, 18 Sep 2019 10:48:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Message-ID: <20190918094848.GE26027@stefanha-x1.localdomain>
References: <20190911145818.18962-1-stefanha@redhat.com>
 <20190911145818.18962-3-stefanha@redhat.com>
 <9b2c9131-41d1-aee2-c40d-0f448c83b497@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline
In-Reply-To: <9b2c9131-41d1-aee2-c40d-0f448c83b497@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 2/2] audio: add -audiodev pa,
 in|out.latency= to documentation
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 09:47:11PM +0200, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3=
 wrote:
> On 2019-09-11 16:58, Stefan Hajnoczi wrote:
> > The "latency" parameter wasn't covered by the documentation.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 <DirtY.iCE.hu@gmail.com>
> > ---
> > How is this parameter related to buffer-length?
>=20
> Pulseaudio being a client-server architecture is a bit different than the
> other backends, plus it also has to mix multiple streams. buffer-length
> corresponds to the buffer inside qemu, while latency corresponds to
> pulseaudio.  For playback, the latency should be "maximum latency that the
> application can deal with", if a different client request a lower latency,
> our latency will decrease too.  It's up to the server to figure out an
> optimal buffer size on the server side of the things.
> For recording it's the size of the buffer we will read at a time from
> pulseaudio.

Thanks for explaining.  I will expand the help text in v2.

Stefan

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2B/YAACgkQnKSrs4Gr
c8g6wQf9GzNgY2H5UTuDPwbv1zUwZSgH9A6IGuVOgszvNnGCth5B2bLixm/1BAQx
+8WA3p7a3RMJdrsBJnC4eAP6aajJi8HvVOfSPHxOCWWz/ZDIpjbG4TaQSSd+hURK
l1+UmBl82hHn3zT4QOz13TqnQctXBXUTVZrHKBbu2QtqYBkbxwNz3GBHvGf7T6uW
Ma0rSrPqGrIxn8I2rJIFL/8b7f8uThEwC8Y9YGHQWOFpOiu/4CA1VkDwYcRTns19
eDSe4inQnxXHWemHVMe5qjaoXydGHigObQOp9WXO8pONIO90hUmhtjDQd1u3LD6T
eOBH2gsRfwaU/OKg3t0LUd35rTEozw==
=Z2F8
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--

