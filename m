Received: from eggs.gnu.org ([2001:4830:134:3::10]:49726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patryk@fala.ehost.pl>) id 1fRJne-0004f4-0i
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patryk@fala.ehost.pl>) id 1fRJnb-0007Ou-L9
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:59:38 -0400
References: <20180607210818.12727-1-f4bug@amsat.org>
	<9abdaa17-d6d1-0c34-2a20-43078b487bef@redhat.com>
	<CAFEAcA-QYnWOo2Hqdr-3tKDDxWDnR+tF4snd15Y1P6md04CogA@mail.gmail.com>
From: Patryk Olszewski <patryk@fala.ehost.pl>
Message-ID: <2b3eb485-701e-21cd-f66c-897df470a4e4@fala.ehost.pl>
Date: Fri, 8 Jun 2018 17:58:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-QYnWOo2Hqdr-3tKDDxWDnR+tF4snd15Y1P6md04CogA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] chardev: Restore CR,LF on stdio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Desnogues <laurent.desnogues@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>

W dniu 08.06.2018 o 17:25, Peter Maydell pisze:
> On 8 June 2018 at 06:47, Thomas Huth <thuth@redhat.com> wrote:
>> On 07.06.2018 23:08, Philippe Mathieu-Daudé wrote:
>>> Remove the 'stair-step output' on stdio.
>>>
>>> This partially reverts commit 12fb0ac05, which was correct
>>> on the mailing list but got corrupted by the maintainer :p
>>>
>>> Introduced-by: 3b876140-c035-dd39-75d0-d54c48128fac@redhat.com
>>> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> Suggested-by: Thomas Huth <thuth@redhat.com>
>>> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>> See:
>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06202.html (bug)
>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg01309.html (report)
>>>
>>> Peter, Can this enters directly as bug-fix?
>>>
>>>  chardev/char-stdio.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
>>> index d83e60e787..96375f2ab8 100644
>>> --- a/chardev/char-stdio.c
>>> +++ b/chardev/char-stdio.c
>>> @@ -59,7 +59,7 @@ static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
>>>      if (!echo) {
>>>          tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>>>                           | INLCR | IGNCR | ICRNL | IXON);
>>> -        tty.c_oflag &= ~OPOST;
>>> +        tty.c_oflag |= OPOST;
>>>          tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN);
>>>          tty.c_cflag &= ~(CSIZE | PARENB);
>>>          tty.c_cflag |= CS8;
>>>
>> I think this is the right way to go.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Applied to master, thanks.
>
> -- PMM
>
I actually think it would be better to set c_oflag to (OPOST | ONLCR) to
avoid any problems in the future. At this point it is assumed that ONLCR
is set.
