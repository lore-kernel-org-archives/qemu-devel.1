Received: from eggs.gnu.org ([2001:4830:134:3::10]:51859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gLsLj-0004sO-Er
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 11:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gLsLX-0007Em-QQ
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 11:12:32 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:41239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gLsLM-00077S-Ok
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 11:12:16 -0500
Received: by mail-vs1-f54.google.com with SMTP id t17so3753460vsc.8
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 08:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20181107121319.GC14842@redhat.com>
	<20181107143628.GG8125@redhat.com>
	<CAMRbyyuFGVtNWF9LKoi0n6_r5Gr4j8LetbAMd0L_5cKMif9LjQ@mail.gmail.com>
	<20181107172737.GB4721@linux.fritz.box>
	<CAMRbyys2XVgjPx9HteGP8c6R5rPM=n86m30kfEG6a0+c-jLZ4g@mail.gmail.com>
In-Reply-To: <CAMRbyys2XVgjPx9HteGP8c6R5rPM=n86m30kfEG6a0+c-jLZ4g@mail.gmail.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sun, 11 Nov 2018 18:11:49 +0200
Message-ID: <CAMRbyytm2qY6ucuaMSAXaw=BhjG9BGoyU_6Xi_YC+fzBaP754Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] Change in qemu 2.12 causes qemu-img
 convert to NBD to write more data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>

On Wed, Nov 7, 2018 at 7:55 PM Nir Soffer <nsoffer@redhat.com> wrote:

> On Wed, Nov 7, 2018 at 7:27 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
>> Am 07.11.2018 um 15:56 hat Nir Soffer geschrieben:
>> > Wed, Nov 7, 2018 at 4:36 PM Richard W.M. Jones <rjones@redhat.com>
>> wrote:
>> >
>> > > Another thing I tried was to change the NBD server (nbdkit) so that it
>> > > doesn't advertise zero support to the client:
>> > >
>> > >   $ nbdkit --filter=log --filter=nozero memory size=6G
>> logfile=/tmp/log \
>> > >       --run './qemu-img convert ./fedora-28.img -n $nbd'
>> > >   $ grep '\.\.\.$' /tmp/log | sed 's/.*\([A-Z][a-z]*\).*/\1/' | uniq
>> -c
>> > >    2154 Write
>> > >
>> > > Not surprisingly no zero commands are issued.  The size of the write
>> > > commands is very uneven -- it appears to be send one command per block
>> > > of zeroes or data.
>> > >
>> > > Nir: If we could get information from imageio about whether zeroing is
>> > > implemented efficiently or not by the backend, we could change
>> > > virt-v2v / nbdkit to advertise this back to qemu.
>> >
>> > There is no way to detect the capability, ioctl(BLKZEROOUT) always
>> > succeeds, falling back to manual zeroing in the kernel silently
>> >
>> > Even if we could, sending zero on the wire from qemu may be even
>> > slower, and it looks like qemu send even more requests in this case
>> > (2154 vs ~1300).
>> >
>> > Looks like this optimization in qemu side leads to worse performance,
>> > so it should not be enabled by default.
>>
>> Well, that's overgeneralising your case a bit. If the backend does
>> support efficient zero writes (which file systems, the most common case,
>> generally do), doing one big write_zeroes request at the start can
>> improve performance quite a bit.
>>
>> It seems the problem is that we can't really know whether the operation
>> will be efficient because the backends generally don't tell us. Maybe
>> NBD could introduce a flag for this, but in the general case it appears
>> to me that we'll have to have a command line option.
>>
>> However, I'm curious what your exact use case and the backend used in it
>> is? Can something be improved there to actually get efficient zero
>> writes and get even better performance than by just disabling the big
>> zero write?
>
>
> The backend is some NetApp storage connected via FC. I don't have
> more info on this. We get zero rate of about 1G/s on this storage, which
> is quite slow compared with other storage we tested.
>
> One option we check now is if this is the kernel silent fallback to manual
> zeroing when the server advertise wrong value of write_same_max_bytes.
>

We eliminated this using blkdiscard. This is what we get on with this
storage
zeroing 100G LV:

for i in 1 2 4 8 16 32; do time blkdiscard -z -p ${i}m
/dev/6e1d84f9-f939-46e9-b108-0427a08c280c/2d5c06ce-6536-4b3c-a7b6-13c6d8e55ade;
done

real 4m50.851s
user 0m0.065s
sys 0m1.482s

real 4m30.504s
user 0m0.047s
sys 0m0.870s

real 4m19.443s
user 0m0.029s
sys 0m0.508s

real 4m13.016s
user 0m0.020s
sys 0m0.284s

real 2m45.888s
user 0m0.011s
sys 0m0.162s

real 2m10.153s
user 0m0.003s
sys 0m0.100s

We are investigating why we get low throughput on this server, and also
will check
several other servers.

Having a command line option to control this behavior sounds good. I don't
> have enough data to tell what should be the default, but I think the safe
> way would be to keep old behavior.
>

We file this bug:
https://bugzilla.redhat.com/1648622

Nir
