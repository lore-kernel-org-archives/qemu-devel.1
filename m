Received: from eggs.gnu.org ([2001:4830:134:3::10]:56723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUuAL-0004M4-0Z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUuAG-0004Mh-9H
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:21:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUuAF-0004MB-Vi
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:21:16 -0400
References: <1499773645-120137-1-git-send-email-peng.hao2@zte.com.cn>
	<d97e3209-e1d0-1c00-ae8b-7bb22eb198e2@redhat.com>
	<20170711091506.GC7116@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4268aa00-6700-0554-10a2-451acb0baad6@redhat.com>
Date: Tue, 11 Jul 2017 14:21:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170711091506.GC7116@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2] chardev: fix parallel device can't be
 reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, wang.yechao255@zte.com.cn

On 11/07/2017 11:15, Daniel P. Berrange wrote:
> On Tue, Jul 11, 2017 at 10:30:14AM +0200, Paolo Bonzini wrote:
>> On 11/07/2017 13:47, Peng Hao wrote:
>>> Parallel device don't register be->chr_can_read function, but remote
>>> disconnect event is handled in chr_read.So connected parallel device
>>> can not detect remote disconnect event. The chardevs with chr_can_rea=
d=3DNULL
>>> has the same problem.
>>>
>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>>> Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
>>> ---
>>>  chardev/char-socket.c  | 11 +++++++++++
>>>  chardev/char.c         | 10 ++++++++++
>>>  include/chardev/char.h |  9 +++++++++
>>>  3 files changed, 30 insertions(+)
>>>
>>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>>> index ccc499c..aa44f8f 100644
>>> --- a/chardev/char-socket.c
>>> +++ b/chardev/char-socket.c
>>> @@ -139,6 +139,9 @@ static int tcp_chr_read_poll(void *opaque)
>>>          return 0;
>>>      }
>>>      s->max_size =3D qemu_chr_be_can_write(chr);
>>> +    if (qemu_chr_null_be_can_read(chr)) {
>>> +        return 1;
>>> +    }
>>>      return s->max_size;
>>>  }
>>> =20
>>> @@ -422,6 +425,14 @@ static gboolean tcp_chr_read(QIOChannel *chan, G=
IOCondition cond, void *opaque)
>>>      uint8_t buf[CHR_READ_BUF_LEN];
>>>      int len, size;
>>> =20
>>> +    if (qemu_chr_null_be_can_read(chr)) {
>>> +        size =3D tcp_chr_recv(chr, (void *)buf, CHR_READ_BUF_LEN);
>>
>> It would be better not to destroy data in the channel, because the
>> device could set handlers later.
>>
>> Daniel, maybe QIOChannel could have a function to check for hung-up
>> channels and return a bool?  For file descriptors it would poll the fi=
le
>> descriptor and check for POLLHUP, while other channels would have a mo=
re
>> or less obvious implementation.
>=20
> IMHO the chardev code all needs to switch over to using even driven I/O
> using the  qio_channel_add_watch() function.

This is a slightly different case; qio_channel_add_watch() is for the
write side, while in this case we're concerned with the read side.

The read-side watch is managed automatically by common chardev code.
I'll see if we can change that code to set up a G_IO_HUP watch in
addition to G_IO_IN.

Paolo

>   commit 6ab3fc32ea640026726bc5f9f4db622d0954fb8a
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Tue Sep 6 14:56:04 2016 +0100
>=20
>     hw: replace most use of qemu_chr_fe_write with qemu_chr_fe_write_al=
l
>=20
> Some places in the chardev code in fact alreadying use watches for a fe=
w
> actions, but then use sync i/o for other stuff. So using events will gi=
ve
> a consistent model. Once you're doing proper event driven I/O, then
> detecting hangup is also trivial.=20
>=20
> IOW, I don't think we need add anything to QIOChannel - just continue t=
o
> cleanup the chardev backends to better use the functionality that alrea=
dy
> exists.
>=20
> Regards,
> Daniel
>=20
