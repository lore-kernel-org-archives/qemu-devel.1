Received: from eggs.gnu.org ([2001:4830:134:3::10]:33854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyy2I-0002j6-0H
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyy2B-0008Ao-Ju
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:05:33 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyy2B-0008AY-Ex
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:05:27 -0400
Received: by mail-ot0-x244.google.com with SMTP id t2-v6so8982921otj.4
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 04:05:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bf9d1394-f78d-b6ba-8893-d4c7fd592de3@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
	<20180123144807.5618-13-laurent@vivier.eu>
	<758f54da-d733-6e95-57cf-cc8b25a81dd5@vivier.eu>
	<bf9d1394-f78d-b6ba-8893-d4c7fd592de3@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 11:05:06 +0000
Message-ID: <CAFEAcA9==FswwaKG_eWncv7Eo-zF+OTOKmSC7N-mpTrSEzUJmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 12/13] page_unprotect(): handle calls to
 pages that are PAGE_WRITE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 March 2018 at 10:36, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 22/03/2018 =C3=A0 02:52, Laurent Vivier a =C3=A9crit :
>> It seems this patch breaks something in linux-user mode emulation for
>> m68k (32bit BE) on ppc (32bit BE).
>>
>> What I have:
>>
>>   ~/chroot$ sudo QEMU_CPU=3Dm68040 chroot m68k/sid/
>>   I have no name!@localhost:/# ls
>>   bin   debootstrap  etc       lib   qemu-m68k  run   sys  usr
>>   boot  dev      home  proc  root       sbin  tmp  var
>>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>>   ~/chroot$
>>
>> It seems "bash" crashes on "ls" exit.
>>
>> My chroot has been installed with:
>>
>>   ARCH=3Dm68k
>>   TARGET=3Dsid
>>   CHROOT=3D$HOME/chroot/m68k/sid/
>>   REPOT=3Dhttp://cdn-fastly.deb.debian.org/debian-ports/
>>   debootstrap --arch=3D$ARCH --foreign --variant=3Dminbase \
>>               --no-check-gpg $TARGET $CHROOT $REPO
>>
>> I didn't investigate more.
>
> It goes wrong in this part:
>
> +     */
> +    if (is_write && info->si_signo =3D=3D SIGSEGV && info->si_code =3D=
=3D
> SEGV_ACCERR &&
> +        h2g_valid(address)) {
>
> Because, on ppc, si_code is SEGV_MAPERR and not SEGV_ACCERR
> (on x86_64, si_code is SEGV_ACCERR as expected)

So on PPC if you have a page mapped, and you access it with
the wrong permissions, you get SEGV_MAPERR? This seems like
a host kernel bug to me.

thanks
-- PMM
