Received: from eggs.gnu.org ([2001:4830:134:3::10]:41393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ffPh2-0001bk-Tp
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ffPh1-00048R-OM
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:07:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ffPh1-00047e-H5
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:07:03 -0400
Received: by mail-wr1-x442.google.com with SMTP id v14-v6so1206452wro.5
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 06:07:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180717130130.GQ18603@redhat.com>
References: <20180717125239.22517-1-marcandre.lureau@redhat.com>
	<20180717125239.22517-4-marcandre.lureau@redhat.com>
	<20180717130130.GQ18603@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Jul 2018 15:07:01 +0200
Message-ID: <CAJ+F1CKXhSmbushwJR1xwy0C5eGoN27ONH_+mEg1BopJOO-F5Q@mail.gmail.com>
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

On Tue, Jul 17, 2018 at 3:01 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> On Tue, Jul 17, 2018 at 02:52:39PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Wait for QIO channel connection completion, and check the feature set
>> by QIO. This fixes setting fd-pass chardev feature on
>> SOCKET_ADDRESS_FD where fd has AF_UNIX.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  chardev/char-socket.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index 6daa8d003a..7387e632d4 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -789,6 +789,9 @@ static int tcp_chr_new_client(Chardev *chr, QIOChann=
elSocket *sioc)
>>
>>      qio_channel_set_blocking(s->ioc, false, NULL);
>>
>> +    if (qio_channel_has_feature(s->ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
>> +        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
>> +    }
>
> I really don't like this approach as it has unpleasant async/race prone
> semantics or the external users of the chardev.
>
> With the current approach they know that once the chardev is created,
> the features have been initialized.
>
> With this approach, the features are only initialized once the client
> connection has been completed, or once the server has started listening,
> which may or may not be the case once the chardev constructor completes.

Ok, what about augmenting the feature set then?:

keep the current qemu_chr_set_feature() in contructor for
ADDRESS_TYPE_UNIX, and add the feature in new_client() for
ADDRESS_TYPE_FD?

>
>>      /* be isn't opened until we get a connection */
>>      *be_opened =3D false;
>> --
>> 2.18.0.129.ge3331758f1
>>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>



--=20
Marc-Andr=C3=A9 Lureau
