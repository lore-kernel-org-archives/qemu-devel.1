Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E95C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60417206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUbBU/V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60417206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1u95-0003BJ-Dk
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 10:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j1u8X-0002jT-Hq
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j1u8W-0007sO-F7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:41:13 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j1u8W-0007ro-7P
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:41:12 -0500
Received: by mail-wm1-x343.google.com with SMTP id a6so3035536wme.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 07:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zzoBL0KcU+Oo2XN4BAUfUaOA+FyUG8KoHnBPxv9srCY=;
 b=IUbBU/V/O0ulSDz/hpyF7sEQUHuMVdmmrioFlYf0ExhCyEz9HSZRc7XCziL5aDauu/
 XzSIUQWidmxfG1LLTVSRlV394/paBStAVugYinszs/YiaMINA1AfdjBtSxqJaRqqrL+9
 ulTVP7HcQEBU6diRT945xz7ZRucVDKvQee6ofbjZU5xGqWcdj9qP4aim6IFSYpx2SeJm
 kqti+3w2iHkdUoVps99nGowwJNwsGuM78EMmK0RKsdCUQNaz+sj+8HA35NLYyDCCkur8
 Tj2KnbzCFdVPWhgBd2asVT58Gc/Rn30L6/JKyav/Qt8GL9epBrFbYyaVw4X3KKLGqjiJ
 FQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zzoBL0KcU+Oo2XN4BAUfUaOA+FyUG8KoHnBPxv9srCY=;
 b=k9s7LXnlLfIvHPxkaGTAs7Zwulg+11wYMU8iZlx+U7Pl9NatDhmJwEzQCOOdpxG6wy
 jeOyi3hkQF2B9QURr+nGuSB1hpgDdTU4Bec3NrH/UKnKDTURdg+a4JwNzKR/kolglcQ9
 wLLkTD/oRBZbLcwLKCkVPbhJUMAeSyUWKJUnjYplPVATyk5ngxw1rq6AeqQXpz8t/dgp
 OkBVYyN9RGJuB3VEvKM4VTtqEl9y/aRBZysmJu5WjDSxiM5qz9YnYWcd8xNQ/9jKwDR+
 fsSSYN/feFP7J+3NpZwprJ+Jmg5dMBsyOdLyK3L7xJMveHEonfgRROwOgj67uE0v4mmx
 bkHA==
X-Gm-Message-State: APjAAAXBPlxt8pD5jPsHoTPJn3eW05zu6/EWiSQmAVc90L5213XgrIg+
 UxU43z6in5bGQXF5P7MppnM=
X-Google-Smtp-Source: APXvYqxGetl3mNuUQS4DESwirIshLRc4p/WEh9pExoqliQAoyx+NA/ymI3F5xNwSfHR/oqZDXAGbOA==
X-Received: by 2002:a05:600c:21c5:: with SMTP id
 x5mr13722139wmj.72.1581522070876; 
 Wed, 12 Feb 2020 07:41:10 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x21sm1101922wmi.30.2020.02.12.07.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 07:41:09 -0800 (PST)
Date: Wed, 12 Feb 2020 15:41:07 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH] pc: remove erroneous seg_max_adjust setting for
 vhost-blk-device
Message-ID: <20200212154107.GF432724@stefanha-x1.localdomain>
References: <20200211140758.11627-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <20200211140758.11627-1-dplotnikov@virtuozzo.com>
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2020 at 05:07:58PM +0300, Denis Plotnikov wrote:
> vhost-blk-device isn't a part of qemu.git
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/core/machine.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5EHJMACgkQnKSrs4Gr
c8hI+gf+LQ8GYD0Jo3ybPcIv6Q1gIZtdv02uZU3ehnkI0klCRi6tNAOUHlHYmMqs
8qvLkeIIIlaE7ATNg+qlRAjeqO90ZO30/YsT+hNndBakdGWVZsUXYdYZ4pHu0lOg
sZS34IqpD3I+ZSM6z+jBfMamEmZAxxkiS/GTgyFahHA78rIOYNSwZmD9e4BGWCpw
yI/fZDP8vsg6l+SdpSnMwzH7d2oTsuzL4POdlh7NOos2FgiHV2SCYGBtcInI/rdr
LpZKP2byVo7k2gmGUz8gCLv+ynYOTx7l42RxwYHnAyssmnd+NhAqDghrpoIbciEO
oHTy3rJOI9A70hke8U5+ayW1XWq+5A==
=ZaQ/
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--

