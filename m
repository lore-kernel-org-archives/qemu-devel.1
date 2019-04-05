Received: from eggs.gnu.org ([209.51.188.92]:50864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hCRjk-0003di-Bl
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hCRjf-0008Cd-15
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:30:38 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1hCRjS-0007dD-A0
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:30:29 -0400
Received: by mail-wm1-f48.google.com with SMTP id z24so7905316wmi.5
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:29:54 -0700 (PDT)
References: <20190326131822.GD15011@stefanha-x1.localdomain>
From: Sergio Lopez <slp@redhat.com>
In-reply-to: <20190326131822.GD15011@stefanha-x1.localdomain>
Date: Fri, 05 Apr 2019 18:29:49 +0200
Message-ID: <878swomn42.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] QEMU event loop optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

--=-=-=
Content-Type: text/plain


Stefan Hajnoczi writes:

> Hi Sergio,
> Here are the forgotten event loop optimizations I mentioned:
>
>   https://github.com/stefanha/qemu/commits/event-loop-optimizations
>
> The goal was to eliminate or reorder syscalls so that useful work (like
> executing BHs) occurs as soon as possible after an event is detected.
>
> I remember that these optimizations only shave off a handful of
> microseconds, so they aren't a huge win.  They do become attractive on
> fast SSDs with <10us read/write latency.
>
> These optimizations are aggressive and there is a possibility of
> introducing regressions.
>
> If you have time to pick up this work, try benchmarking each commit
> individually so performance changes are attributed individually.
> There's no need to send them together in a single patch series, the
> changes are quite independent.

It took me a while to find a way to get meaningful numbers to evaluate
those optimizations. The problem is that here (Xeon E5-2640 v3 and EPYC
7351P) the cost of event_notifier_set() is just ~0.4us when the code
path is hot, and it's hard differentiating it from the noise.

To do so, I've used a patched kernel with a naive io_poll implementation
for virtio_blk [1], an also patched QEMU with poll-inflight [2] (just to
be sure we're polling) and ran the test on semi-isolated cores
(nohz_full + rcu_nocbs + systemd_isolation) with idle siblings. The
storage is simulated by null_blk with "completion_nsec=0 no_sched=1
irqmode=0".

# fio --time_based --runtime=30 --rw=randread --name=randread \
 --filename=/dev/vdb --direct=1 --ioengine=pvsync2 --iodepth=1 --hipri=1

| avg_lat (us) | master | qbsn* |
|   run1       | 11.32  | 10.96 |
|   run2       | 11.37  | 10.79 |
|   run3       | 11.42  | 10.67 |
|   run4       | 11.32  | 11.06 |
|   run5       | 11.42  | 11.19 |
|   run6       | 11.42  | 10.91 |
 * patched with aio: add optimized qemu_bh_schedule_nested() API

Even though there's still some variance in the numbers, the 0.4us
improvement can be clearly appreciated.

I haven't tested the other 3 patches, as their optimizations only have
effect when the event loop is not running in polling mode. Without
polling, we get an additional overhead of, at least, 10us, in addition
to a lot of noise, due to both direct costs (ppoll()...) and indirect
ones (re-scheduling and TLB/cache pollution), so I don't think we can
reliable benchmark them. Probably their impact won't be significant
either, due to the costs I've just mentioned.

Sergio.

[1] https://github.com/slp/linux/commit/d369b37db3e298933e8bb88c6eeacff07f39bc13
[2] https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg00447.html

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAlyngn0ACgkQ9GknjS8M
AjX5ThAAhdU6dwvSXtqoXMYKjKLVAVCCVY13UNyuEtddfJuLwgn0ghk/KGRIlgum
ZWJmlimkWSFzypOL9XGoA5byMmh78uI6RsYLYtArBdFxeRHk9Ie1Xmjx5hRgz049
Now7hu7qlQv7Bv3hrC6FY0/Mx6uTdTKB0+hoXqRjGI2Sr4x8ZYCDgWdUnX5fJ3DL
4fUJcyX8Mt9HjaMCH2Y/NUElTVKHVNAH9CL1UuA6Gfaj0B5Ly0KUqb6NMB+fZeIk
P4JEkiMkiqM/0FV27R2Sm3C7JmqfwxplVCVZXUT1kPEtZBk4P7YK5MIpBxbLCMJ7
T2vwDNCTrnoK8/mQGictdVPq/S1e1m63I2LIbA8BAcDPhMazWNmS4ChOZGw0H32e
N9U6Qhp60idcjYDrG05Sg8pBohW4vw6AnN3n6shbIW1ao7DQjLD8VDNqN/ZdCSEm
7Oanv8EmrSRiDI29Kpj0y8KbDQVP8zYTYFwlLaQYYqfbiZsGER52CUGXzY77feeZ
kB7vsrjNz13a4hYS6mOcQkJJeku0bCChfNGXKkpQX5dMd8Ghs3NxSSCY79G1maUF
RtPuALcHBHKr16eeMycCDQIVji24s14MLe9eJzKQQkIoHnc9ThU48oj+YZ51HxoE
t++RwIpruCMLxJfuUi0ybXXpc9iOJFcY4LYKbnQ4nTZhj0Ctu7o=
=h9Wc
-----END PGP SIGNATURE-----
--=-=-=--
