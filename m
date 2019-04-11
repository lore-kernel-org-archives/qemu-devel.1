Received: from eggs.gnu.org ([209.51.188.92]:47541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hEY5X-0002eW-68
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hEY5V-0001b8-59
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:41:51 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1hEY5S-0001aM-Q3
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:41:48 -0400
Received: by mail-wr1-f47.google.com with SMTP id p10so6937870wrq.1
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 04:41:46 -0700 (PDT)
References: <87zhpxmkg9.fsf@redhat.com>
	<20190315150036.GA11173@stefanha-x1.localdomain>
	<87a7hwm9t4.fsf@redhat.com> <20190315155010.GG5368@linux.fritz.box>
From: Sergio Lopez <slp@redhat.com>
In-reply-to: <20190315155010.GG5368@linux.fritz.box>
Date: Thu, 11 Apr 2019 13:41:42 +0200
Message-ID: <87pnps3h1l.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] Combining synchronous and asynchronous IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "mreitz@redhat.com" <mreitz@redhat.com>, "fam@euphon.net" <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, jusual@mail.ru

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Kevin Wolf <kwolf@redhat.com> writes:

> Am 15.03.2019 um 16:33 hat Sergio Lopez geschrieben:
>>=20
>> Stefan Hajnoczi writes:
>>=20
>> > On Thu, Mar 14, 2019 at 06:31:34PM +0100, Sergio Lopez wrote:
>> >> Our current AIO path does a great job at unloading the work from the =
VM,
>> >> and combined with IOThreads provides a good performance in most
>> >> scenarios. But it also comes with its costs, in both a longer executi=
on
>> >> path and the need of the intervention of the scheduler at various
>> >> points.
>> >>=20
>> >> There's one particular workload that suffers from this cost, and that=
's
>> >> when you have just 1 or 2 cores on the Guest issuing synchronous
>> >> requests. This happens to be a pretty common workload for some DBs an=
d,
>> >> in a general sense, on small VMs.
>> >>=20
>> >> I did a quick'n'dirty implementation on top of virtio-blk to get some
>> >> numbers. This comes from a VM with 4 CPUs running on an idle server,
>> >> with a secondary virtio-blk disk backed by a null_blk device with a
>> >> simulated latency of 30us.
>> >
>> > Can you describe the implementation in more detail?  Does "synchronous"
>> > mean that hw/block/virtio_blk.c makes a blocking preadv()/pwritev() ca=
ll
>> > instead of calling blk_aio_preadv/pwritev()?  If so, then you are also
>> > bypassing the QEMU block layer (coroutines, request tracking, etc) and
>> > that might explain some of the latency.
>>=20
>> The first implementation, the one I've used for getting these numbers,
>> it's just preadv/pwrite from virtio_blk.c, as you correctly guessed. I
>> know it's unfair, but I wanted to take a look at the best possible
>> scenario, and then measure the cost of the other layers.
>>=20
>> I'm working now on writing non-coroutine counterparts for
>> blk_co_[preadv|pwrite], so we have SIO without bypassing the block layer.
>
> Maybe try to keep the change local to file-posix.c? I think you would
> only have to modify raw_thread_pool_submit() so that it doesn't go
> through the thread pool, but just calls func directly.
>
> I don't think avoiding coroutines is possible without bypassing the block
> layer altogether because everything is really expecting to be run in
> coroutine context.

Turns out what I initially thought was a cost induced by the AIO nature
of our block layer, it's actually a bug in which polling mode works
against aio=3Dthreads, delaying the execution of the request completions.

This has been fixed by Paolo's "aio-posix: ensure poll mode is left when
aio_notify is called":

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01426.html

So we can throw away the idea of combining synchronous and asynchronous
requests, as it doesn't provide a significant improvement that would
justify the added complexity.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAlyvJ/YACgkQ9GknjS8M
AjV7LA//aqoMbyfpVzzOJsXo8BOj7Z2L/xjyY23HNLcc/5uHKHr0k/vMiGWix5HA
7yGXo8GEzmdlUzw0zggDPNXBRJVMhcift70lws4OAzcN32VGCjzvWJT/Dguicdkw
eOad12domVPpEREvJK6ffO1CAToVOWaOPcTJ22tHoKD7ASeeh+GA90ev7xVNhBRK
6nAU8BPNN9nIawKCoQi7cRjbK13qERskmQ3jD/8L0u4o0YW/2XX9ZlzxcfVvB3NR
+T0A6LGIFlQyXMBTzhY+jo9rsmiIQfyjP90QpXfk3YXxyecH86sQEXwJeO/lX7Ip
O8s8NeKkcaDf9OgMntA3vkEaQ48+fypjvmUU5iQvuFecQlMIvLUk4UbmyYsf/qfm
kLg1/1ZNa2t/lWBRNwb6H/9xHpnEHBXP12FdZNA7yzGZqqGldJJo34KJFbyVp8sc
QKBb6nPg3/JzjmXQFMSCq/FsnFuTT8KohZkKVf3SB0IsMoYsiCYn3G8+UZjy4gdw
JdZ/vA1f1nPBDXmGa7JHNvcEC+UfI7z/Eny37IuF1nyE4D+hAx6a2DivdIdEcY+k
4UWY4VFJdGo2Ms2KoXbXfB8RqDAmV81NGR1tIjHIA2jc6iOBU3+MT8X6cVUvYzTh
UoiLeN856WP3gxZlVZQN+Id26J1PZfRnV7A+4nVa7wXqFnWv8t0=
=1cZj
-----END PGP SIGNATURE-----
--=-=-=--
