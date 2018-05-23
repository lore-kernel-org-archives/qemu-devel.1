Received: from eggs.gnu.org ([2001:4830:134:3::10]:49425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patryk@fala.ehost.pl>) id 1fLTKw-0007nC-IU
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patryk@fala.ehost.pl>) id 1fLTKs-0001oJ-Fu
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:57:50 -0400
Received: from s16.ehost.pl ([193.143.77.16]:37946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <patryk@fala.ehost.pl>)
	id 1fLTKr-0001Vi-2U
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:57:46 -0400
References: <1526752108-21204-1-git-send-email-patryk@fala.ehost.pl>
	<87o9h7q53u.fsf@dusky.pond.sub.org>
	<CAFEAcA-ce=r3izLyizhEo+a4Fkg5dQ-NnDgHRJ4GsomnqQsqRw@mail.gmail.com>
From: Patryk <patryk@fala.ehost.pl>
Message-ID: <187f5c5b-6ce3-a9d0-3431-4e0109292888@fala.ehost.pl>
Date: Wed, 23 May 2018 14:57:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ce=r3izLyizhEo+a4Fkg5dQ-NnDgHRJ4GsomnqQsqRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] Remove unwanted crlf conversion in serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

W dniu 22.05.2018 o 15:07, Peter Maydell pisze:
> On 22 May 2018 at 12:53, Markus Armbruster <armbru@redhat.com> wrote:
>> Patryk Olszewski <patryk@fala.ehost.pl> writes:
>>
>>> Signed-off-by: Patryk Olszewski <patryk@fala.ehost.pl>
>>> ---
>>>  chardev/char-serial.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
>>> index feb52e5..ae548d2 100644
>>> --- a/chardev/char-serial.c
>>> +++ b/chardev/char-serial.c
>>> @@ -139,7 +139,7 @@ static void tty_serial_init(int fd, int speed,
>>>
>>>      tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>>>                       | INLCR | IGNCR | ICRNL | IXON);
>>> -    tty.c_oflag |= OPOST;
>>> +    tty.c_oflag &= ~OPOST;
>>>      tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);
>>>      tty.c_cflag &= ~(CSIZE | PARENB | PARODD | CRTSCTS | CSTOPB);
>>>      switch (data_bits) {
>> This change may well make sense, but your commit message needs to
>> explain *why*.
>>
>> For what it's worth, POSIX documents OPOST as "Post-process output", and
>> the Linux manual page as "Enable implementation-defined output
>> processing."
> We've set OPOST on our terminals since forever, right back to
> commit 0824d6fc674 in 2003. Not setting it seems like the right thing,
> though, since we're generally otherwise setting the thing up to be a
> raw mode tty (and if we're connecting this to a guest then raw seems
> like what we want).
>
> I wonder whether connecting, say, the HMP monitor to a 'serial'
> chardev (a) works now (b) ends up with stair-step output after
> this change (c) is something we care about...
>
> thanks
> -- PMM
>
This patch is here to help fix years old bug of lf being replaced with
crlf in serial, which is super problematic in binary transmissions,
making communication with devices through serial from guest almost
impossible.

Setting OPOST flag in c_oflag enables the output processing, in other
words it makes any other flag set in c_oflag come into action. From my
quick experiment on serial devices on Linux I found out that by default
c_oflag has enabled ONLCR flag, which is the one responsible for the
crlf conversion. Unsetting OPOST disables it.

Bug reports related to that:

https://bugs.launchpad.net/qemu/+bug/1772086

https://bugs.launchpad.net/qemu/+bug/1407813

https://bugs.launchpad.net/qemu/+bug/1715296

also

https://lists.nongnu.org/archive/html/qemu-devel/2006-06/msg00196.html
