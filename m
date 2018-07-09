Received: from eggs.gnu.org ([2001:4830:134:3::10]:52329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fcVC4-0004P8-At
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fcVC3-0005yU-AL
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:23:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fcVC3-0005yQ-38
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:23:03 -0400
Received: by mail-wr1-x442.google.com with SMTP id b15-v6so10778906wrv.10
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 05:23:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8WN1K-r0u6ZDBFRwRa1WZAMBf2MQhkhg-WDRazfVjQzw@mail.gmail.com>
References: <1528185295-14199-1-git-send-email-slp@redhat.com>
	<4e35ea24-147d-1b51-fa1b-0f1cc32966e0@redhat.com>
	<CAJ+F1CLjAXcdkUS2cj_6x2UnE1jTcFAfy88yDWfomp6+Mt7v+g@mail.gmail.com>
	<CAFEAcA8WN1K-r0u6ZDBFRwRa1WZAMBf2MQhkhg-WDRazfVjQzw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 9 Jul 2018 14:23:01 +0200
Message-ID: <CAJ+F1CKk=3amSNTSusbPj1MUM+ksTse2YVddLyTf5jqr6RDyFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/char/serial: Only retry if
 qemu_chr_fe_write returns 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Jul 9, 2018 at 2:11 PM, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On 9 July 2018 at 11:25, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.c=
om> wrote:
>> Shouldn't it rety if it returns -1 and the errno =3D=3D EAGAIN? I am not
>> sure when it would return 0 and a retry would make sense.
>
> This came up in previous discussion on an earlier version of this:
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg00171.html
>

Thanks, I lost that thread somehow

> qemu_chr_fe_write() should never return -1/EAGAIN, because then
> all of its callers need to deal with it. It should handle EAGAIN
> internally and report "try again later" by returning 0.

But that's not the case, unless qemu_chr_write() 'write_all' arg is true.

qemu_chr_fe_write() uses false.

I suppose the patch should also change qemu_chr_fe_write() to
qemu_chr_fe_write_all() to be complete and let the chardev handle
EAGAIN.



>
> The logic is that (a) EAGAIN is a pain to handle and we should
> avoid expanding the set of places in QEMU that has to care about
> it where we can and (b) this function already has a way to say
> 'try again later' (ie, returning 0), so it is confusing and
> complicates callsites to give it a second way to say the same
> thing (ie, returning -1/EINTR). Better to always report "try
> again" in the same way.
>
> thanks
> -- PMM



--=20
Marc-Andr=C3=A9 Lureau
