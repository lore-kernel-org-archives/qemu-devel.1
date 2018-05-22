Received: from eggs.gnu.org ([2001:4830:134:3::10]:47045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL71F-0004ik-2U
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL71A-0000bq-Sv
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:08:01 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL71A-0000bc-N7
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:07:56 -0400
Received: by mail-oi0-x244.google.com with SMTP id l1-v6so16132237oii.1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 06:07:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9h7q53u.fsf@dusky.pond.sub.org>
References: <1526752108-21204-1-git-send-email-patryk@fala.ehost.pl>
	<87o9h7q53u.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 14:07:35 +0100
Message-ID: <CAFEAcA-ce=r3izLyizhEo+a4Fkg5dQ-NnDgHRJ4GsomnqQsqRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Remove unwanted crlf conversion in serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Patryk Olszewski <patryk@fala.ehost.pl>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 22 May 2018 at 12:53, Markus Armbruster <armbru@redhat.com> wrote:
> Patryk Olszewski <patryk@fala.ehost.pl> writes:
>
>> Signed-off-by: Patryk Olszewski <patryk@fala.ehost.pl>
>> ---
>>  chardev/char-serial.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
>> index feb52e5..ae548d2 100644
>> --- a/chardev/char-serial.c
>> +++ b/chardev/char-serial.c
>> @@ -139,7 +139,7 @@ static void tty_serial_init(int fd, int speed,
>>
>>      tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>>                       | INLCR | IGNCR | ICRNL | IXON);
>> -    tty.c_oflag |= OPOST;
>> +    tty.c_oflag &= ~OPOST;
>>      tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);
>>      tty.c_cflag &= ~(CSIZE | PARENB | PARODD | CRTSCTS | CSTOPB);
>>      switch (data_bits) {
>
> This change may well make sense, but your commit message needs to
> explain *why*.
>
> For what it's worth, POSIX documents OPOST as "Post-process output", and
> the Linux manual page as "Enable implementation-defined output
> processing."

We've set OPOST on our terminals since forever, right back to
commit 0824d6fc674 in 2003. Not setting it seems like the right thing,
though, since we're generally otherwise setting the thing up to be a
raw mode tty (and if we're connecting this to a guest then raw seems
like what we want).

I wonder whether connecting, say, the HMP monitor to a 'serial'
chardev (a) works now (b) ends up with stair-step output after
this change (c) is something we care about...

thanks
-- PMM
