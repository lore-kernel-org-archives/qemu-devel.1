Received: from eggs.gnu.org ([2001:4830:134:3::10]:42790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balrogg@gmail.com>) id 1dEwVv-0004jH-95
	for qemu-devel@nongnu.org; Sun, 28 May 2017 07:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balrogg@gmail.com>) id 1dEwVu-0005cU-8t
	for qemu-devel@nongnu.org; Sun, 28 May 2017 07:37:39 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <balrogg@gmail.com>) id 1dEwVu-0005cG-3v
	for qemu-devel@nongnu.org; Sun, 28 May 2017 07:37:38 -0400
Received: by mail-it0-x243.google.com with SMTP id l145so5125185ita.0
	for <qemu-devel@nongnu.org>; Sun, 28 May 2017 04:37:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+0TczwOVnfaO8jPVKWeiFXJNa4SiKp4yn662u3Evko0A@mail.gmail.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-9-marcandre.lureau@redhat.com>
	<CAJ+F1C+0TczwOVnfaO8jPVKWeiFXJNa4SiKp4yn662u3Evko0A@mail.gmail.com>
From: andrzej zaborowski <balrogg@gmail.com>
Date: Sun, 28 May 2017 13:37:36 +0200
Message-ID: <CAOq732LK0xhoYVOc22+zwBW+-mBKD_BU4GVjOvGach66cKT0HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/13] be-hci: use backend functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 26 May 2017 at 14:20, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com=
> wrote:
> On Tue, May 9, 2017 at 3:42 PM Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@redhat.com> wrote:
>> Avoid accessing CharBackend directly, use qemu_chr_be_* methods instead.
>>
>> be->chr_read should exists if qemu_chr_be_can_write() is true.
>>
>> (use qemu_chr_be_write(), _impl() bypasses replay)
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  hw/bt/hci-csr.c | 9 +++------
>>
>
> No maintainer for this file. Andrzej, as author of the file, can you
> review?

This looks correct.
Reviewed-by: Andrzej Zaborowski <balrogg@gmail.com>

>
>
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
>> index 0f2021086d..d13192b9b5 100644
>> --- a/hw/bt/hci-csr.c
>> +++ b/hw/bt/hci-csr.c
>> @@ -82,17 +82,14 @@ enum {
>>
>>  static inline void csrhci_fifo_wake(struct csrhci_s *s)
>>  {
>> -    Chardev *chr =3D (Chardev *)s;
>> -    CharBackend *be =3D chr->be;
>> +    Chardev *chr =3D CHARDEV(s);
>>
>>      if (!s->enable || !s->out_len)
>>          return;
>>
>>      /* XXX: Should wait for s->modem_state & CHR_TIOCM_RTS? */
>> -    if (be && be->chr_can_read && be->chr_can_read(be->opaque) &&
>> -        be->chr_read) {
>> -        be->chr_read(be->opaque,
>> -                     s->outfifo + s->out_start++, 1);
>> +    if (qemu_chr_be_can_write(chr)) {
>> +        qemu_chr_be_write(chr, s->outfifo + s->out_start++, 1);
>>          s->out_len--;
>>          if (s->out_start >=3D s->out_size) {
>>              s->out_start =3D 0;
>> --
>> 2.13.0.rc1.16.gd80b50c3f
>>
>>
>> --
> Marc-Andr=C3=A9 Lureau
