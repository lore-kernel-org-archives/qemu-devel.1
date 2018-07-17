Received: from eggs.gnu.org ([2001:4830:134:3::10]:43973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ffPqb-0006Rs-FS
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ffPqV-0004Ek-I6
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:16:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ffPqV-0004E4-9F
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:16:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id e7-v6so1230150wrs.9
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 06:16:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180717131134.GR18603@redhat.com>
References: <20180717125239.22517-1-marcandre.lureau@redhat.com>
	<20180717125239.22517-4-marcandre.lureau@redhat.com>
	<20180717130130.GQ18603@redhat.com>
	<CAJ+F1CKXhSmbushwJR1xwy0C5eGoN27ONH_+mEg1BopJOO-F5Q@mail.gmail.com>
	<20180717131134.GR18603@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Jul 2018 15:16:49 +0200
Message-ID: <CAJ+F1C+Nz+MfgEfg_bZAc-=xKUydHA+VDp8r3AgeW=skrAJK+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] char-socket: delay setting fd-pass
 feature until connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Jul 17, 2018 at 3:11 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> On Tue, Jul 17, 2018 at 03:07:01PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Tue, Jul 17, 2018 at 3:01 PM, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
>> > On Tue, Jul 17, 2018 at 02:52:39PM +0200, Marc-Andr=C3=A9 Lureau wrote=
:
>> >> Wait for QIO channel connection completion, and check the feature set
>> >> by QIO. This fixes setting fd-pass chardev feature on
>> >> SOCKET_ADDRESS_FD where fd has AF_UNIX.
>> >>
>> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> ---
>> >>  chardev/char-socket.c | 8 ++++----
>> >>  1 file changed, 4 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> >> index 6daa8d003a..7387e632d4 100644
>> >> --- a/chardev/char-socket.c
>> >> +++ b/chardev/char-socket.c
>> >> @@ -789,6 +789,9 @@ static int tcp_chr_new_client(Chardev *chr, QIOCh=
annelSocket *sioc)
>> >>
>> >>      qio_channel_set_blocking(s->ioc, false, NULL);
>> >>
>> >> +    if (qio_channel_has_feature(s->ioc, QIO_CHANNEL_FEATURE_FD_PASS)=
) {
>> >> +        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
>> >> +    }
>> >
>> > I really don't like this approach as it has unpleasant async/race pron=
e
>> > semantics or the external users of the chardev.
>> >
>> > With the current approach they know that once the chardev is created,
>> > the features have been initialized.
>> >
>> > With this approach, the features are only initialized once the client
>> > connection has been completed, or once the server has started listenin=
g,
>> > which may or may not be the case once the chardev constructor complete=
s.
>>
>> Ok, what about augmenting the feature set then?:
>>
>> keep the current qemu_chr_set_feature() in contructor for
>> ADDRESS_TYPE_UNIX, and add the feature in new_client() for
>> ADDRESS_TYPE_FD?
>
> IMHO that makes the behaviour even more non-deterministic for callers.
>
> How about we just delete the entire feature concept from chardevs and rem=
ove
> the check from the vhostuser network backend too.
>
> We have lots of users of chardevs in QEMU and vhostuser is the only one
> that has tried to do this sanity check for the "correct" chardev backend.
> The other users just assume the user / mgmt app will configure a suitable
> chardev backend.  The vhostuser sanity checks have just caused more probl=
ems
> then they've solved.

It sounds less optimal than what I proposed, but I don't mind.

What do you think of the first 2 patches?


--=20
Marc-Andr=C3=A9 Lureau
