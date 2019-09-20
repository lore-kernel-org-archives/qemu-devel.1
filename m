Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E293BC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD43B2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+Ua6KTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD43B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEdA-00052X-QS
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iBEb7-0003hC-8O
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iBEb5-0001ds-CY
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:49:01 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iBEb3-0001c9-NY
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:48:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id 5so1511608wmg.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6vF7PAOQFGbiEwK5/YHJ4+86Htoi7VUCxkBvACUAiL8=;
 b=q+Ua6KTODc0Vr9to7OK1DkQqtBMPJrSo6JUBhcnXRuz7dufEmsAFr4Tf0FIqEc3zPX
 eCNooZlW65qiH3d7QoMCvWiTrb+C7NsmQ+QoF/HMZh+a/m29K2TswbEDlKaGMtJxXx9r
 Ige9vkmKEEMKodALjLdu/aw7Uthfowmgsb3a8JDCZpUkwu+msZ1YM92SwNxnGMWCeJlF
 bMaV1cUYw860GJKHb4AeTjgr344CjygMEBkALZ4wDodvEFYY0LNMbCMXde6sPsC5BD5N
 etj34381KDobnIoRalG7EzmesPgJwDpJWGOs2LLGtU/H+Aq3gvL+Ldp1hUY6gvSVVngF
 iG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6vF7PAOQFGbiEwK5/YHJ4+86Htoi7VUCxkBvACUAiL8=;
 b=C6RSE3Ecq1slHdqqZGz/eW5PNAW+277uswfIElnCSkIyeJ74kPXIemT6BXdL7fcQ8u
 T6/A4ctjHON/TGKyD0wdMhciESXSY6ph+3tZwc2nJfgt6GcjK3AVGanXKoF7I6BawoPp
 8ZBGFbB6g144lGAsyaSswvzHf5qgUqdhORUJsV7xze3fWhHjjGVcangmqB5GlnQy2AfK
 qJgDqvL/911Lk1kaJhTN0yUfq2946/3kOiD9bR6Qxl+ELUMktYQGbMfxFvpR4ZcdPhmG
 rGHmyjqn+NMHGvQ64EN9e9H2QytItALtrXDbxbVe9GDuCAQKC3thStptxyVi5w1OVuFm
 kv5w==
X-Gm-Message-State: APjAAAUAxd/EskJF7phs1RfaRKau7Gc2Icxgk2j6+WKmarIsDul1uQEL
 SygIL70jZv9wOeBixsuj3G8=
X-Google-Smtp-Source: APXvYqxZoww6e1GecGqqlOR/wtAnACZH3pBgYXXAqquu7IvVRo19yYZ651FQROcr1NCbp1/15DJ/5w==
X-Received: by 2002:a1c:4945:: with SMTP id w66mr2466522wma.40.1568969332886; 
 Fri, 20 Sep 2019 01:48:52 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l11sm1017833wmh.34.2019.09.20.01.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 01:48:51 -0700 (PDT)
Date: Fri, 20 Sep 2019 09:48:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [Qemu-devel] [PATCH 1/2] docs: vhost-user: add in-band kick/call
 messages
Message-ID: <20190920084850.GD14365@stefanha-x1.localdomain>
References: <20190917122625.15614-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20190917122625.15614-1-johannes@sipsolutions.net>
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
Cc: qemu-devel@nongnu.org, Johannes Berg <johannes.berg@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 02:26:24PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> For good reason, vhost-user is currently built asynchronously, that
> way better performance can be obtained. However, for certain use
> cases such as simulation, this is problematic.
>=20
> Consider an event-based simulation in which both the device and CPU
> have scheduled according to a simulation "calendar". Now, consider
> the CPU sending I/O to the device, over a vring in the vhost-user
> protocol. In this case, the CPU must wait for the vring interrupt
> to have been processed by the device, so that the device is able to
> put an entry onto the simulation calendar to obtain time to handle
> the interrupt. Note that this doesn't mean the I/O is actually done
> at this time, it just means that the handling of it is scheduled
> before the CPU can continue running.
>=20
> This cannot be done with the asynchronous eventfd based vring kick
> and call design.
>=20
> Extend the protocol slightly, so that a message can be used for kick
> and call instead, if VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS is
> negotiated. This in itself doesn't guarantee synchronisation, but both
> sides can also negotiate VHOST_USER_PROTOCOL_F_REPLY_ACK and thus get
> a reply to this message by setting the need_reply flag, and ensure
> synchronisation this way.
>=20
> To really use it in both directions, VHOST_USER_PROTOCOL_F_SLAVE_REQ
> is also needed.
>=20
> Since it is used for simulation purposes and too many messages on
> the socket can lock up the virtual machine, document that this should
> only be used together with the mentioned features.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  docs/interop/vhost-user.rst | 120 +++++++++++++++++++++++++++++++-----
>  1 file changed, 103 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2EknIACgkQnKSrs4Gr
c8inJQgAtgDFKg3DktBbUQckuHSKQ1lafityxGqFKQqYpP8a/LPz0g7DCvFpAWvy
dp+tlhlMccx5YlmOxhJNDGrUfpFZfbQPpxUxtZvibf8dO388Hxn9VXSCJAozyqX7
qm3YPddUjSx0+wfWBqrBuBLF4cVcQbyB3/2bkdL5NHy7WsZGIX1JNwL9+AuYomCp
cjZ6aYyeDgjABV7c/03jURRnSZy2oj/SK/6/HtWZT8ZzwGRpqv4REc16w4T2EPka
rtf9idUMGm2ZaRx1kwjlCALOKV4k0JjSw4TPHFkSkEA4LMMJuVclNY0BN/RWStwK
7l5KCmyO5c+o2mehuF/bqKzrXwjBRQ==
=9hW8
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--

