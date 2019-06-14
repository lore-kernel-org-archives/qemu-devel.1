Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48277C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149A32084E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEHjRC4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149A32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbikp-0002o3-Bd
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40605)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hbieP-0004gq-24
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hbiYZ-0000bH-PM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:31:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hbiYY-0000a9-By
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:31:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id s15so1579789wmj.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=q1x6DxGQc4adhebLDMSHhcVabBwjpRK3W7gxbhKIxYI=;
 b=DEHjRC4fp0mjJKiDJSgNNNwlq/WUvaijcPeyjEe5nVYQGgyLfTLgLaNqp4Dbrnta5d
 qtB64iBES117nqEAtQLcm2PABzrjPT4sDoHcrdRxCdhKJNP/Hv3bnT7GsbaViEN7I0fW
 hqCagNiC0onGByeHIitQs4E6Jf74m388R+Kh0dVmKHcZjmuQKZmgipyfUwAWnbfFcLk4
 uueSC0bWfcjIspSYuhGR2yvqJJ4XbSOJLFy1sDIs4TYZaIc7zIR1vmUtmNHQR2HsXuua
 xTcE2b2uHfDmrKc7G8qJDN87VkUU2Dt+vt6Tz04W0ks3EmqATwNmJIGVG85cluvkg0Qk
 Tmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=q1x6DxGQc4adhebLDMSHhcVabBwjpRK3W7gxbhKIxYI=;
 b=MsUA7dmpvQM05J5x5OYuj2FHGeUsdfg6ScOO+Ug+QumJuM3Ynhgvu1Hsc1DG4UW9Or
 yWEhpwywMV1NrZl85usC2A2smJc24DFSc1H0wI1u9yr4Roy3/B1yv/LcDNGcPZqetyzK
 pon3CYLFFpmZFIwYqOnk4QUaxpBqj9r23tpq7d6EHTl3CNZikInD2FLQxL0h/dRuDd3B
 Nt4hWLStqEOwbW6uQyyF0DhRgGR+IRQJFGlVr1BYU21Y5S2MNxQIofK482N0JcoYrxnm
 WXSj14HijjYKF2QtKMRmeIfMF+mLsEbOcMyjFC2HE47Bhy/yZfcHvK/8tMmg74xU9Z90
 qfTA==
X-Gm-Message-State: APjAAAWcCqbYoN2wrYMu8HobkGn5VdGcjxbwwxDeXomJu5HVKnCnOC44
 777AGYZdacjuhfQ5eIrVIQk=
X-Google-Smtp-Source: APXvYqyOuUU6aXPwMmG5VX0tPxkdRqx+8pXxf60gVRqYPeGU6og3cpJyupf3CSoMcyIbXA/P9h5M6A==
X-Received: by 2002:a1c:7604:: with SMTP id r4mr7266756wmc.89.1560504692095;
 Fri, 14 Jun 2019 02:31:32 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h23sm1987604wmb.25.2019.06.14.02.31.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 02:31:31 -0700 (PDT)
Date: Fri, 14 Jun 2019 10:31:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Rahul Govind <rgovind3@illinois.edu>
Message-ID: <20190614093124.GF10957@stefanha-x1.localdomain>
References: <CALP2uw1A6GiZm_-Pa4Yq2+HUpNbGbp1ioZd9-RK0HR_yTEEAhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <CALP2uw1A6GiZm_-Pa4Yq2+HUpNbGbp1ioZd9-RK0HR_yTEEAhg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] Virtual I2C adapter and I2C external simulator
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Ernest Esene <eroken1@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 10:53:16AM -0700, Rahul Govind wrote:
> Hi Everyone,
>=20
> I'm working on a project that involves building on top of existing QEMU
> work, and I'm trying to virtualize I2C devices that are shared between
> multiple VMs. I've been reading QEMU documentation and source code to get=
 a
> better idea of how to add something like this to QEMU (since it doesn't
> look like something similar is already present) but I'm not sure how to
> proceed. I do have a few ideas and I would be grateful if anyone could gi=
ve
> me feedback on them or suggestions for alternative solutions.
>=20
> More specifically, I wish to virtualize a couple of devices that sit on t=
he
> I2C bus. However, directly virtualizing the devices doesn't seem feasible
> since there are many other devices like multiplexers on the way to these
> devices. Also, what we need is to handle is just reads/write/ioctls on
> /dev/i2c-N.
>=20
> I was wondering if there is a way to create a device that
> - 1) Emulates an I2C adapter, say /dev/i2c-0.
> - 2) Handles any reads/writes/ioctls sent to /dev/i2c-0, reformats any
> ioctls as IO, and then sends this to a simulator on the host.
>=20
> This approach is just based on the ipmi interface and ipmi-bmc-extern
> device already present in QEMU, where ipmi-bmc-extern can communicate
> through a chardev with a simulator running on the host. Having a simulator
> on the host would be nice to have since it lets us write the simulator in=
 a
> higher level language, and as previously mentioned, we have a few cases
> where multiple VMs share the same I2C device. However, I'm not sure if th=
is
> even makes sense in the case of I2C.
>=20
> If this approach doesn't make sense, what method would you recommend to
> have virtual I2C devices which are shared between multiple VMs?
>=20
> Any suggestions or guidance is much appreciated!

Hi Rahul,
A good rule of thumb is that if it's possible in real hardware then it
can be emulated.  So in this case the question is whether an I2C device
can be accessed by multiple bus masters.  The answer seems to be yes:
https://www.i2c-bus.org/multimaster/

Ernest recently posted patches to add a chardev to QEMU that
reads/writes to a host /dev/i2c-0 device.  What you are describing is a
little different but related.

In theory it is possible to define an I2C-over-socket protocol (for
example a UNIX Domain Socket) so that an external process can simulate
an I2C device.  QEMU will emulate the I2C controller and forward bus
transactions to the external process.

If you want multi-master I2C then the external process needs to accept
multiple connections so that more than one QEMU can connect at
simultaneously.

Stefan

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0DaWwACgkQnKSrs4Gr
c8jENgf/d74uzD0Af1b4E39R2D1gBkGG+LMabD/5IcgZ0ofxg7fqP5tgcmUmGHrf
koSllvjLNS0FFjc4TjI6/ELroUerkugjYKTYERIPtV8Jez0kqbtNCuskVbeSr3Zu
w3miUXN5Nwyh/We6KK7+6doVrUepodVsoIX2ivQA8f62IBsYWMcWtY4FoThG+vlL
GYHaIuhoKUrebJ/ryYHm9G6GTu7pjxz6l5C0lhyjz2iAPYLf8PyF5KP9/7NbeUyJ
wWKRFOg/uPn01V+KXAKYg24eiMl+FKAUuXBZSh43r1cBfvzX/NzaX89ZXJJTJAkc
3fkYFprxJ/ME6m5pUv5CWFK9cvgZpg==
=dAJw
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--

