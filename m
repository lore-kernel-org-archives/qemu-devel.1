Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DC6C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA71220409
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="m0AH7r1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA71220409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEKiV-0002lj-1z
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 18:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <adilger@dilger.ca>) id 1jEKht-0002Mo-C1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <adilger@dilger.ca>) id 1jEKhp-0000XD-Uq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:29:03 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <adilger@dilger.ca>) id 1jEKhp-0000Jx-6z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:29:01 -0400
Received: by mail-pg1-x542.google.com with SMTP id t3so12503610pgn.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 15:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dilger-ca.20150623.gappssmtp.com; s=20150623;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=0lyGaEtpoR36zLPiwWYFHdQkK3uTz09qvDzxTC9qJgI=;
 b=m0AH7r1QajvnwJDiSCHD1obDuxlvXoWJoeZTuKDL4FhB6Q9YFWG7G5iQxs4s1nUlKC
 LHqxl0+/4Sxgym4e8EvZQP4y8fTIJQJrRLVbRS6imTF2VDjqOSmPsUtaMagUoBupXSOy
 ZYNM7tXTkwMz6FiqmmP3njcsHB7Y+uppZ4XnIpcTWDkSG38p6zfIE5sBTP+W4AtGc9hi
 65qvOTUveZKf1+TQm5zTAPcuPacMeahONbOQfFP/s7U5lLiiGd09HRpaiSnFs92bLa3R
 1dMlW2pZxf0EEI9rBIqhxz6iR2sUtMLhbIzLaq8zwu2QhW+bI7kVvyN/3+XXu3VpNMIx
 S7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=0lyGaEtpoR36zLPiwWYFHdQkK3uTz09qvDzxTC9qJgI=;
 b=H+lhh1z1SHtzz6oWl7OTQFgtxLWi62LYfhmtuOQ5lBRs1Etzc8qGXi7JKJF64/mmHO
 znZzp1LoX3h50omlRbdLkvHi39DqOLQXQ+kBdHjKKPGoBMO/Clb78OkDZZc3IsyF/rwU
 o/oV2se3sjri1LQnZeXkk4YBYDa6/+yEWaYFd8Tw005bglUCbdQBft8w+ro9a0q0nfRx
 iMR9ME8mVpAJBeEOJbXoY5YPbolm9HI1203c8VccmRdZ3gJ6QDPoa4JQQvlUH+Edimjt
 Wwh2JlnWeG9fUrH/AazVNGWLDxJF66pdvyI86wiby/+OFig0Qcz7FB07xJs1ZtgC+Jo3
 wqdQ==
X-Gm-Message-State: ANhLgQ203iRly59+ktqWq5JldbQEnxaiheedQqszHY0ad3KWjGGVR3rq
 BfKklgPqyQp41ceJzTSfBNYYGw==
X-Google-Smtp-Source: ADFU+vsp+4j6Fx+oPzHi/3kBAA+Q+4xgxKUsWM/GD5wIKIixyEDdMzG80DS72RAa77tlWbPEMffOYQ==
X-Received: by 2002:aa7:91c7:: with SMTP id z7mr994278pfa.237.1584484139442;
 Tue, 17 Mar 2020 15:28:59 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net.
 [70.77.216.213])
 by smtp.gmail.com with ESMTPSA id j19sm4037676pfe.102.2020.03.17.15.28.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Mar 2020 15:28:58 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <88FAA4EA-7DAF-478F-8DFE-747FAF4CF818@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6A2BBFD8-44C3-4E14-A14D-CC95C0572A09";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
Date: Tue, 17 Mar 2020 16:28:53 -0600
In-Reply-To: <20200317113153.7945-1-linus.walleij@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
References: <20200317113153.7945-1-linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Theodore Ts'o <tytso@mit.edu>,
 Linux API <linux-api@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 stable@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>,
 Andy Lutomirski <luto@kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_6A2BBFD8-44C3-4E14-A14D-CC95C0572A09
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 17, 2020, at 5:31 AM, Linus Walleij <linus.walleij@linaro.org> =
wrote:
>=20
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>=20
> The personality(2) system call supports to let processes
> indicate that they are 32 bit Linux to the kernel. This
> was suggested by Teo in the original thread, so I just wired
> it up and it solves the problem.
>=20
> Programs that need the 32 bit hash only need to issue the
> personality(PER_LINUX32) call and things start working.

I'm generally with with this from the ext4 point of view.

That said, I'd think it would be preferable for ease of use and
compatibility that applications didn't have to be modified
(e.g. have QEMU or glibc internally set PER_LINUX32 for this
process before the 32-bit syscall is called, given that it knows
whether it is emulating a 32-bit runtime or not).

The other way to handle this would be for ARM32 to check the
PER_LINUX32 flag via is_compat_task() so that there wouldn't
need to be any changes to the ext4 code at all?

Cheers, Andreas


> I made a test program like this:
>=20
>  #include <dirent.h>
>  #include <errno.h>
>  #include <stdio.h>
>  #include <string.h>
>  #include <sys/types.h>
>  #include <sys/personality.h>
>=20
>  int main(int argc, char** argv) {
>    DIR* dir;
>    personality(PER_LINUX32);
>    dir =3D opendir("/boot");
>    printf("dir=3D%p\n", dir);
>    printf("readdir(dir)=3D%p\n", readdir(dir));
>    printf("errno=3D%d: %s\n", errno, strerror(errno));
>    return 0;
>  }
>=20
> This was compiled with an ARM32 toolchain from Bootlin using
> glibc 2.28 and thus suffering from the bug.
>=20
> Before the patch:
>=20
>  $ ./readdir-bug
>  dir=3D0x86000
>  readdir(dir)=3D(nil)
>  errno=3D75: Value too large for defined data type
>=20
> After the patch:
>=20
>  $ ./readdir-bug
>  dir=3D0x86000
>  readdir(dir)=3D0x86020
>  errno=3D0: Success
>=20
> Problem solved.
>=20
> Cc: Florian Weimer <fw@deneb.enyo.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: stable@vger.kernel.org
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://bugs.launchpad.net/qemu/+bug/1805913
> Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D205957
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> fs/ext4/dir.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>=20
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 9aa1f75409b0..3faf9edf3e92 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -27,6 +27,7 @@
> #include <linux/slab.h>
> #include <linux/iversion.h>
> #include <linux/unicode.h>
> +#include <linux/personality.h>
> #include "ext4.h"
> #include "xattr.h"
>=20
> @@ -618,6 +619,14 @@ static int ext4_dx_readdir(struct file *file, =
struct dir_context *ctx)
>=20
> static int ext4_dir_open(struct inode * inode, struct file * filp)
> {
> +	/*
> +	 * If we are currently running e.g. a 32 bit emulator on
> +	 * a 64 bit machine, the emulator will indicate that it needs
> +	 * a 32 bit personality and thus 32 bit hashes from the file
> +	 * system.
> +	 */
> +	if (personality(current->personality) =3D=3D PER_LINUX32)
> +		filp->f_mode |=3D FMODE_32BITHASH;
> 	if (IS_ENCRYPTED(inode))
> 		return fscrypt_get_encryption_info(inode) ? -EACCES : 0;
> 	return 0;
> --
> 2.24.1
>=20


Cheers, Andreas






--Apple-Mail=_6A2BBFD8-44C3-4E14-A14D-CC95C0572A09
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5xTyUACgkQcqXauRfM
H+BC6xAAjbwtIJvDdEy/qp+tIiAxJRt5HMEaY8aVQErnLKlF3zKRTaC2bALhC47s
1WgXIIYz4EvfMXqDyhatd4suolut6wa+mvMStIAqKqck4gxNTW19jmw+1i3LVUuu
S/1SUX3A9y3W+SXXu2AHqKfNkOTad+/nSlsa/Ku6uABCdll7TcVGGLaVw2WVKY/v
wsznGmTsnq3qF0lDjoQCewsa1yUeCwmiIjauXMmn0KL35EfkSMyKoDKK4r5MKbSE
P6TV5eSOAvVJeBLeAQEuCcnUdob1M56hASvTuaS8twjQhzu29xTETGqx3Kb3g7hF
wBRpG4e9QxLhW+Dq8XjqSF+7e7RBQMROp/rIvPd3/d80ORBWBvl/dAe67m3GMvWI
ptyRcA23uJrZ5Dc8pKKQCcc/TREc+UbCtUfdE+S5CPKD/WK/0E8qTyzZg1EAnPEE
2LcObvno+JoA6tAa8bjdg2uVvHHMG2HeVgxSIMrbn9wQeCLhX35vbCZ+4kY1yDh1
1ui3ltzHUPZdAy8WYg2Bn1a42WkvEMfdz60uTSVFO35zzQXvLzaPVbmE06/rhh/5
nxIR/5+N+/MYvHL8h7tGDUnDoQumiM2NfKWoE+eupUjXGbjEuSb2TdUnj9Siczzy
vwRTSF9u+f7ZfDPXuenBALq47Qq4HvF8qa7weH8iXnj9UWk31D8=
=ak2k
-----END PGP SIGNATURE-----

--Apple-Mail=_6A2BBFD8-44C3-4E14-A14D-CC95C0572A09--

