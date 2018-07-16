Received: from eggs.gnu.org ([2001:4830:134:3::10]:44727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ff88s-0006vB-0u
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 14:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ff88r-0005SM-2R
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 14:22:37 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ff88q-0005S1-R7
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 14:22:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id j5-v6so26336833wrr.8
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 11:22:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180716170303.GC5616@redhat.com>
References: <20180704111118.7241-1-berrange@redhat.com>
	<f56b799f-7f30-391f-c2d8-15f95524758c@redhat.com>
	<20180704120826.GD32267@redhat.com>
	<CAJ+F1CK+eywam7LSvOCW2YcHO9S4GL5n7+9yta9_t3j+9hN-cQ@mail.gmail.com>
	<20180716170303.GC5616@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Jul 2018 20:22:34 +0200
Message-ID: <CAJ+F1CJwnzswq5EPp8HWJfKvuH_S2mz1n5+3KewDTvLkBnrvyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: unconditionally set FD_PASS
 feature for socket type=fd
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

On Mon, Jul 16, 2018 at 7:03 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> On Mon, Jul 16, 2018 at 06:57:48PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Wed, Jul 4, 2018 at 2:08 PM, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
>> > On Wed, Jul 04, 2018 at 01:53:03PM +0200, Paolo Bonzini wrote:
>> >> On 04/07/2018 13:11, Daniel P. Berrang=C3=A9 wrote:
>> >> > The vhostuser network backend requires the chardev it is using to h=
ave
>> >> > the FD passing feature. It checks this upfront when initializing th=
e
>> >> > network backend and reports an error if not set.
>> >> >
>> >> > The socket chardev has to set the FD_PASS feature during early
>> >> > initialization to satisfy the vhostuser backend, and at this point
>> >> > the socket has not been initialized. It is thus unable to do a live
>> >> > check on the socket to see if it supports FD passing (aka is a UNIX
>> >> > socket). As a result it has to blindly set FD_PASS feature based
>> >> > solely on info in the SocketAddress struct, such as address type.
>> >> >
>> >> > Unfortunately libvirt wishes to use FD passing to provide the UNIX
>> >> > domain socket listener, and as a result the FD_PASS feature is no
>> >> > longer set, which breaks vhostuser's checks, despite the fact that
>> >> > FD passing will in fact work later.
>> >> >
>> >> > This unconditionally sets FD_PASS feature for any socket address
>> >> > which has type=3D=3Dfd. Thus will be wrong if the passed in FD was =
not
>> >> > a UNIX socket, but if an attempt is later made to use FD passing
>> >> > we'll still get an error reported by the QIOChannelSocket class.
>> >> > So the effective of setting the chardev FD_PASS feature early
>> >> > is merely to delay error reporting.
>> >>
>> >> Could you query with getsockopt or getsockname in tcp_chr_connect?
>> >
>> > That potentially executes asynchronously in the backend and vhostuser
>> > checks it when it first resolves the chardev ID. IOW the point where
>> > vhostuser checks, all we have is the SocketAddress struct - in some
>> > case we might be lucky & have connected, but we can't assume it :-(
>>
>> In which case is it executed asynchronously?
>>
>> Chardev creation is happening before vhost-user net,
>> qemu_chardev_new() and qemu_char_open() calls
>> qio_channel_socket_connect_sync().
>
> The qmp_chardev_open_socket() method is not guaranteed to complete
> synchronously. If the "reconnect" property is set everything happens
> asynchronously, so we're not able to set the feature flag by the time
> qemu_char_open() returns.

Shouldn't reconnect=3D and fd=3D arguments be incompatible? Does it make
sense to try a reconnect on the same fd?




--=20
Marc-Andr=C3=A9 Lureau
