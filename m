Received: from eggs.gnu.org ([2001:4830:134:3::10]:60815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dUuQ2-0002jC-1h
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dUuQ1-0002vf-2t
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:37:34 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dUuQ0-0002mw-NU
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:37:33 -0400
Received: by mail-lf0-x244.google.com with SMTP id z78so14298126lff.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 05:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <1499773645-120137-1-git-send-email-peng.hao2@zte.com.cn>
	<d97e3209-e1d0-1c00-ae8b-7bb22eb198e2@redhat.com>
	<20170711091506.GC7116@redhat.com>
	<4268aa00-6700-0554-10a2-451acb0baad6@redhat.com>
In-Reply-To: <4268aa00-6700-0554-10a2-451acb0baad6@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 11 Jul 2017 12:36:58 +0000
Message-ID: <CAJ+F1CKazJTBJO-1S+w9VCfz+M+SEOnm3xoypq8=4kGsrMp37w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, wang.yechao255@zte.com.cn, qemu-devel@nongnu.org

Hi

On Tue, Jul 11, 2017 at 2:21 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/07/2017 11:15, Daniel P. Berrange wrote:
> > On Tue, Jul 11, 2017 at 10:30:14AM +0200, Paolo Bonzini wrote:
> >> On 11/07/2017 13:47, Peng Hao wrote:
> >>> Parallel device don't register be->chr_can_read function, but remote
> >>> disconnect event is handled in chr_read.So connected parallel device
> >>> can not detect remote disconnect event. The chardevs with
> chr_can_read=3DNULL
> >>> has the same problem.
> >>>
> >>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> >>> Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
> >>> ---
> >>>  chardev/char-socket.c  | 11 +++++++++++
> >>>  chardev/char.c         | 10 ++++++++++
> >>>  include/chardev/char.h |  9 +++++++++
> >>>  3 files changed, 30 insertions(+)
> >>>
> >>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> >>> index ccc499c..aa44f8f 100644
> >>> --- a/chardev/char-socket.c
> >>> +++ b/chardev/char-socket.c
> >>> @@ -139,6 +139,9 @@ static int tcp_chr_read_poll(void *opaque)
> >>>          return 0;
> >>>      }
> >>>      s->max_size =3D qemu_chr_be_can_write(chr);
> >>> +    if (qemu_chr_null_be_can_read(chr)) {
> >>> +        return 1;
> >>> +    }
> >>>      return s->max_size;
> >>>  }
> >>>
> >>> @@ -422,6 +425,14 @@ static gboolean tcp_chr_read(QIOChannel *chan,
> GIOCondition cond, void *opaque)
> >>>      uint8_t buf[CHR_READ_BUF_LEN];
> >>>      int len, size;
> >>>
> >>> +    if (qemu_chr_null_be_can_read(chr)) {
> >>> +        size =3D tcp_chr_recv(chr, (void *)buf, CHR_READ_BUF_LEN);
> >>
> >> It would be better not to destroy data in the channel, because the
> >> device could set handlers later.
> >>
> >> Daniel, maybe QIOChannel could have a function to check for hung-up
> >> channels and return a bool?  For file descriptors it would poll the fi=
le
> >> descriptor and check for POLLHUP, while other channels would have a mo=
re
> >> or less obvious implementation.
> >
> > IMHO the chardev code all needs to switch over to using even driven I/O
> > using the  qio_channel_add_watch() function.
>
> This is a slightly different case; qio_channel_add_watch() is for the
> write side, while in this case we're concerned with the read side.
>
> The read-side watch is managed automatically by common chardev code.
> I'll see if we can change that code to set up a G_IO_HUP watch in
> addition to G_IO_IN.
>

fwiw,  we have some code handling HUP in interesting ways, see
a6553598be42e3be899acdb153fd615cd6c3eab8
--=20
Marc-Andr=C3=A9 Lureau
