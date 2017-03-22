Received: from eggs.gnu.org ([2001:4830:134:3::10]:58758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqe7g-0004pl-Ou
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqe7f-0004Qa-Rc
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:08:12 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqe7f-0004QQ-KF
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:08:11 -0400
Received: by mail-wr0-x236.google.com with SMTP id g10so127774030wrg.2
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 04:08:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1322109813.6444955.1490172025040.JavaMail.zimbra@redhat.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAFEAcA_etsFstPtUzs0AZjWD35MhMLhwru0ibJzS_upgE-nsng@mail.gmail.com>
	<CAJy91CZmqEUXLKjRJ0JdUEf83E3FwE_24qmej-4C8uAGQkTPWA@mail.gmail.com>
	<CAFEAcA-mzO7vniDEaZeueVFQ7+MVBB7pnzHhahv2Yk_f3q0mJw@mail.gmail.com>
	<CAJy91CZ4Ed-HGHLkzEc1dqQbo32d-eTE1S1ovO_ZwkDdTpkQXQ@mail.gmail.com>
	<CAJy91CaCV40FgSP55qWZeZgkQ=2+E8Cr7xdbu9pn5HLEo+6JJQ@mail.gmail.com>
	<CAJy91CYEwOVT7oEdYY=21__c2kcLTyxyjAaq7Zx4VnQdeLdQQQ@mail.gmail.com>
	<CAFEAcA_t9iLude4Vu3Zc=_wcXMTtFb4Q4oJ8O+zLAJ9isAPqHQ@mail.gmail.com>
	<1322109813.6444955.1490172025040.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Mar 2017 11:07:49 +0000
Message-ID: <CAFEAcA9zd_gXZjY2fnHdK-7XbKFTj-UDtpWq6A9h6ApERysu=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest application reading from pl011 without
 device driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jiahuan Zhang <jiahuanzhang90@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 22 March 2017 at 08:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> > I am using a windows named pipe to get the data from a window
>> > host program, which uses ReadFile () in char_win.c
>>
>> OK, bugs in the windows-specific char backend would be
>> unsurprising.
>>
>> I'm not entirely sure how the chardev layer works, but
>> at the pl011 end if we return 0 from our can_receive
>> function then the chardev layer should decide it has
>> nothing to do until the pl011 later calls
>> qemu_chr_fe_accept_input(), I think.
>>
>> I've cc'd Paolo and Marc-Andr=C3=A9 Lureau as the chardev
>> maintainers.
>
> Windows named pipes do not support the equivalent of "select",
> so it's possible that they cause a busy wait.

That's not the end that's a problem. Here we know we have
data available from the Windows end to read, we just
can't feed it to the QEMU UART model yet because the
UART model is saying "my FIFO is full, try later".
We should be able to handle that. (I couldn't figure
out how it works for the socket code either.)

thanks
-- PMM
