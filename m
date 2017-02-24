Received: from eggs.gnu.org ([2001:4830:134:3::10]:60505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chG8l-0004Rm-3f
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chG8i-0000fo-01
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:42:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1chG8h-0000fL-Nx
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:42:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1486041504-23627-1-git-send-email-den@openvz.org>
	<CAJ+F1CL06FJvVrSmLE4-p208ocFoP7d-w_7mBkOmvnTrBxA5qQ@mail.gmail.com>
Date: Fri, 24 Feb 2017 14:42:24 +0100
In-Reply-To: <CAJ+F1CL06FJvVrSmLE4-p208ocFoP7d-w_7mBkOmvnTrBxA5qQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 24 Feb 2017
	12:59:03 +0000")
Message-ID: <871sunzovz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu-char: socket backend:
 disconnect on write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Feb 2, 2017 at 5:20 PM Denis V. Lunev <den@openvz.org> wrote:
>
>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>
>> Socket backend read handler should normally perform a disconnect, however
>> the read handler may not get a chance to run if the frontend is not ready
>> (qemu_chr_be_can_write() =3D=3D 0).
>>
>> This means that in virtio-serial frontend case if
>>  - the host has disconnected (giving EPIPE on socket write)
>>  - and the guest has disconnected (-> frontend not ready -> backend
>>    will not read)
>>  - and there is still data (frontend->backend) to flush (has to be a rea=
lly
>>    tricky timing but nevertheless, we have observed the case in producti=
on)
>>
>> This results in virtio-serial trying to flush this data continiously
>> forming
>> a busy loop.
>>
>> Solution: react on write error in the socket write handler.
>> errno is not reliable after qio_channel_writev_full(), so we may not get
>> the exact EPIPE, so disconnect on any error but QIO_CHANNEL_ERR_BLOCK wh=
ich
>> io_channel_send_full() converts to errno EAGAIN.
>> We must not disconnect right away though, there still may be data to read
>> (see 4bf1cb0).
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: Daniel P. Berrange <berrange@redhat.com>
>> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>> Changes from v1:
>> - we do not rely on EPIPE anynore. Socket should be closed on all errors
>>   except EAGAIN
>>
>>  chardev/char-socket.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index 4068dc5..e2137aa 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -97,6 +97,9 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
>>                                 GIOCondition cond,
>>                                 void *opaque);
>>
>> +static int tcp_chr_read_poll(void *opaque);
>> +static void tcp_chr_disconnect(CharDriverState *chr);
>> +
>>  /* Called with chr_write_lock held.  */
>>  static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
>>  {
>> @@ -114,6 +117,13 @@ static int tcp_chr_write(Chardev *chr, const uint8_t
>> *buf, int len)
>>              s->write_msgfds_num =3D 0;
>>          }
>>
>> +        if (ret < 0 && errno !=3D EAGAIN) {
>> +            if (tcp_chr_read_poll(chr) <=3D 0) {
>> +                tcp_chr_disconnect(chr);
>> +                return len;
>>
>
> This change breaks a number of assumption in vhost-user code. Until now, a
> vhost-user function assumed that dev->vhost_ops would remain as long as t=
he
> function is running, so it may call vhost_ops callbacks several time, whi=
ch
> may eventually fail to do io, but no crash would occur. The disconnection
> would be handled later with the HUP handler. Now, vhost_ops may be cleared
> during a write (chr_disconnect -> CHR_EVENT_CLOSED in
> net_vhost_user_event). This can be randomly reproduced with vhost-user-te=
st
> -p /x86_64/vhost-user/flags-mismatch/subprocess  (broken pipe, qemu crash=
es)

It hangs for me with annoying frequency.  I'm glad you found the culprit!

> I am trying to fix this, but it isn't simple (races, many code paths etc),
> so I just wanted to inform you about it.

Can we revert this patch until we have a fix?
