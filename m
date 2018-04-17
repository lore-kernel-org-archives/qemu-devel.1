Received: from eggs.gnu.org ([2001:4830:134:3::10]:37795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8VT7-0005Cc-5B
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8VT2-0006w4-Eo
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:36:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
Date: Tue, 17 Apr 2018 15:36:31 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi,

>>> On 16 April 2018 at 19:18, Marc-André Lureau
>>> <marcandre.lureau@redhat.com> wrote:
>>>> Commit fb5e19d2e1472e96d72d5e4d89c20033f8ab345c originally fixed the
>>>> regression, but was inadvertently broken again in merge commit
>>>> 2d6752d38d8acda.
>>>>
>>>> Fixes:
>>>> https://bugs.launchpad.net/qemu/+bug/1654137
>>>>
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>>  chardev/char-mux.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
>>>> index 1b925c8dec..6055e76293 100644
>>>> --- a/chardev/char-mux.c
>>>> +++ b/chardev/char-mux.c
>>>> @@ -304,6 +304,7 @@ void mux_set_focus(Chardev *chr, int focus)
>>>>      }
>>>>
>>>>      d->focus = focus;
>>>> +    chr->be = d->backends[focus];
>>>>      mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
>>>>  }
>>>>
>>>> --
>>>> 2.17.0.rc1.36.gcedb63ea2f
>>>
>>> Opinions welcome on whether this is a regression fix worth
>>> putting into rc4.
>>
>> It is a regression, but a long standing one - we've been broken for quite
>> a while since 2.9.0 or even before.
>>
>> If we're doing an rc4 anyway I'd suggest including it, but not the end of
>> the world if it has to go in via -stable given how long we've been broken
>> for.
>>
> 
> Thanks for the clarification; I've applied this to master.

Since this commit, the console on the Malta board stay black...

Before:
$ qemu-system-mips -M malta -m 512 \
  -kernel vmlinux-3.2.0-4-4kc-malta -append 'root=/dev/sda1' \
  -nographic
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-4-4kc-malta
(debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-14) )
#1 Debian 3.2.51-1
[    0.000000] Config serial console: console=ttyS0,38400n8r
[    0.000000] bootconsole [early0] enabled
...

After:
$ qemu-system-mips -M malta -m 512 \
  -kernel vmlinux-3.2.0-4-4kc-malta -append 'root=/dev/sda1' \
  -nographic
QEMU 2.11.92 monitor - type 'help' for more information
(qemu) QEMU 2.11.92 monitor - type 'help' for more information
(qemu) q

1b2503fcf7b5932c5a3779ca2ceb92bd403c4ee7 is the first bad commit
Author: Marc-André Lureau <marcandre.lureau@redhat.com>
Date:   Mon Apr 16 20:18:44 2018 +0200

    mux: fix ctrl-a b again

    Commit fb5e19d2e1472e96d72d5e4d89c20033f8ab345c originally fixed the
    regression, but was inadvertently broken again in merge commit
    2d6752d38d8acda.

    Fixes:
    https://bugs.launchpad.net/qemu/+bug/1654137
