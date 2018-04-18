Received: from eggs.gnu.org ([2001:4830:134:3::10]:48296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8o8g-0001E8-Ez
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8o8f-0005lA-Io
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:32:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
	<19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
	<CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d6ab2b72-2694-6c78-d44d-edc3110d0a93@amsat.org>
Date: Wed, 18 Apr 2018 11:32:36 -0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi Marc-André,

On 04/18/2018 07:36 AM, Marc-André Lureau wrote:
> In  commit cd9526ab7c04f2c32c63340b04401f6ed25682b9
> Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Date:   Thu Mar 8 23:39:32 2018 +0100
> 
>     hw/isa/superio: Factor out the serial code from pc87312.c
> 
> You changed from:
> 
> -            if (chr == NULL) {
> -                snprintf(name, sizeof(name), "ser%d", i);
> -                chr = qemu_chr_new(name, "null");
> -            }
> 
> to:
> 
> +            if (chr == NULL || chr->be) {
> +                name = g_strdup_printf("discarding-serial%d", i);
> +                chr = qemu_chr_new(name, "null");
> +            } else {
> +                name = g_strdup_printf("serial%d", i);
> +            }
> 
> Why do you check if chr->be ? In case of a mux chardev, it may already
> have an active frontend (yeah be is CharBackend which is the frontend,
> I still can't grasp that either, please Paolo change your mind! ;).
> And this is the job for a mux chardev, handling several frontends.

I was afraid this refactor could be related.

IIRC I had troubles running "qemu-system-alpha -append console=srm" but
I tried again with/without the chr->be check and it works fine...

Anyway the new code is buggy, this is wrong (simplified):

 if (chr->be) chr = qemu_chr_new(name, "null");

> 
> Furthermore, there is a better API for checking the limit of a
> chardev: qemu_chr_is_busy(). Accessing char/fe internal structure
> should warn you something could be done better.

This method is static (unexposed).
