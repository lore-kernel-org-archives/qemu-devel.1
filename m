Received: from eggs.gnu.org ([2001:4830:134:3::10]:46420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8kSI-0008S5-11
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8kSG-00061O-Pl
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:36:50 -0400
MIME-Version: 1.0
In-Reply-To: <19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
	<19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 18 Apr 2018 12:36:43 +0200
Message-ID: <CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Tue, Apr 17, 2018 at 8:36 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi,
>
>>>> On 16 April 2018 at 19:18, Marc-Andr=C3=A9 Lureau
>>>> <marcandre.lureau@redhat.com> wrote:
>>>>> Commit fb5e19d2e1472e96d72d5e4d89c20033f8ab345c originally fixed the
>>>>> regression, but was inadvertently broken again in merge commit
>>>>> 2d6752d38d8acda.
>>>>>
>>>>> Fixes:
>>>>> https://bugs.launchpad.net/qemu/+bug/1654137
>>>>>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>>> ---
>>>>>  chardev/char-mux.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
>>>>> index 1b925c8dec..6055e76293 100644
>>>>> --- a/chardev/char-mux.c
>>>>> +++ b/chardev/char-mux.c
>>>>> @@ -304,6 +304,7 @@ void mux_set_focus(Chardev *chr, int focus)
>>>>>      }
>>>>>
>>>>>      d->focus =3D focus;
>>>>> +    chr->be =3D d->backends[focus];
>>>>>      mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
>>>>>  }
>>>>>
>>>>> --
>>>>> 2.17.0.rc1.36.gcedb63ea2f
>>>>
>>>> Opinions welcome on whether this is a regression fix worth
>>>> putting into rc4.
>>>
>>> It is a regression, but a long standing one - we've been broken for qui=
te
>>> a while since 2.9.0 or even before.
>>>
>>> If we're doing an rc4 anyway I'd suggest including it, but not the end =
of
>>> the world if it has to go in via -stable given how long we've been brok=
en
>>> for.
>>>
>>
>> Thanks for the clarification; I've applied this to master.
>
> Since this commit, the console on the Malta board stay black...
>
> Before:
> $ qemu-system-mips -M malta -m 512 \
>   -kernel vmlinux-3.2.0-4-4kc-malta -append 'root=3D/dev/sda1' \
>   -nographic
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.2.0-4-4kc-malta
> (debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-14) )
> #1 Debian 3.2.51-1
> [    0.000000] Config serial console: console=3DttyS0,38400n8r
> [    0.000000] bootconsole [early0] enabled
> ...
>
> After:
> $ qemu-system-mips -M malta -m 512 \
>   -kernel vmlinux-3.2.0-4-4kc-malta -append 'root=3D/dev/sda1' \
>   -nographic
> QEMU 2.11.92 monitor - type 'help' for more information
> (qemu) QEMU 2.11.92 monitor - type 'help' for more information
> (qemu) q
>

In  commit cd9526ab7c04f2c32c63340b04401f6ed25682b9
Author: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Date:   Thu Mar 8 23:39:32 2018 +0100

    hw/isa/superio: Factor out the serial code from pc87312.c

You changed from:

-            if (chr =3D=3D NULL) {
-                snprintf(name, sizeof(name), "ser%d", i);
-                chr =3D qemu_chr_new(name, "null");
-            }

to:

+            if (chr =3D=3D NULL || chr->be) {
+                name =3D g_strdup_printf("discarding-serial%d", i);
+                chr =3D qemu_chr_new(name, "null");
+            } else {
+                name =3D g_strdup_printf("serial%d", i);
+            }

Why do you check if chr->be ? In case of a mux chardev, it may already
have an active frontend (yeah be is CharBackend which is the frontend,
I still can't grasp that either, please Paolo change your mind! ;).
And this is the job for a mux chardev, handling several frontends.

Furthermore, there is a better API for checking the limit of a
chardev: qemu_chr_is_busy(). Accessing char/fe internal structure
should warn you something could be done better.

> 1b2503fcf7b5932c5a3779ca2ceb92bd403c4ee7 is the first bad commit
> Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Date:   Mon Apr 16 20:18:44 2018 +0200
>
>     mux: fix ctrl-a b again
>
>     Commit fb5e19d2e1472e96d72d5e4d89c20033f8ab345c originally fixed the
>     regression, but was inadvertently broken again in merge commit
>     2d6752d38d8acda.
>
>     Fixes:
>     https://bugs.launchpad.net/qemu/+bug/1654137
>



--=20
Marc-Andr=C3=A9 Lureau
