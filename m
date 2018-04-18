Received: from eggs.gnu.org ([2001:4830:134:3::10]:32856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8lr2-0007zh-Js
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8lr1-0005Yg-O3
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:06:28 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:39315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8lr1-0005YE-Ir
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:06:27 -0400
Received: by mail-oi0-x230.google.com with SMTP id n65-v6so1325435oig.6
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 05:06:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
	<19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
	<CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Apr 2018 13:06:06 +0100
Message-ID: <CAFEAcA-2kTYvJYWwsBwYHv+45y32uPYj+2Ut9VnZhTQwsKyhDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 18 April 2018 at 11:36, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.c=
om> wrote:
> In  commit cd9526ab7c04f2c32c63340b04401f6ed25682b9
> Author: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Date:   Thu Mar 8 23:39:32 2018 +0100
>
>     hw/isa/superio: Factor out the serial code from pc87312.c
>
> You changed from:
>
> -            if (chr =3D=3D NULL) {
> -                snprintf(name, sizeof(name), "ser%d", i);
> -                chr =3D qemu_chr_new(name, "null");
> -            }
>
> to:
>
> +            if (chr =3D=3D NULL || chr->be) {
> +                name =3D g_strdup_printf("discarding-serial%d", i);
> +                chr =3D qemu_chr_new(name, "null");
> +            } else {
> +                name =3D g_strdup_printf("serial%d", i);
> +            }
>
> Why do you check if chr->be ?

After commit 12051d82f004024 none of this should be necessary --
the code should handle chr being NULL without needing to
create a fake null chardev to throw away output.

> In case of a mux chardev, it may already
> have an active frontend (yeah be is CharBackend which is the frontend,
> I still can't grasp that either, please Paolo change your mind! ;).

I agree with Marc-Andr=C3=A9 that the terminology for our chardev
code is hopelessly confusing. The things that are logically
backends (file, stdio, etc) are called "chardevs", and the
thing that is called the CharBackend is, well, I don't know
what it is. include/chardev/char.h has a helpful comment:
     /* character device */
     typedef struct CharBackend CharBackend;

The doc comments for functions like qemu_chr_new() that return
a Chardev* say they "create a new character backend".

And then there's ChardevBackend, which is something else again.

thanks
-- PMM
