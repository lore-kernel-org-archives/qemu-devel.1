Received: from eggs.gnu.org ([2001:4830:134:3::10]:34043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fj5rC-0004JH-Qu
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fj5r9-0001GG-0X
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:44:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fj5r8-0001FS-OA
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:44:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id e7-v6so5663811wrs.9
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 09:44:42 -0700 (PDT)
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121701.12867.49392.stgit@pasha-VirtualBox>
	<87zhyerotn.fsf@linaro.org> <000301d42565$aeeb2e40$0cc18ac0$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <000301d42565$aeeb2e40$0cc18ac0$@ru>
Date: Fri, 27 Jul 2018 17:44:40 +0100
Message-ID: <87sh44sk5j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 23/24] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> > Replay is capable of recording normal BH events, but sometimes
>> > there are single use callbacks scheduled with aio_bh_schedule_oneshot
>> > function. This patch enables recording and replaying such callbacks.
>> > Block layer uses these events for calling the completion function.
>> > Replaying these calls makes the execution deterministic.
>> >
>> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>
>> I'm not sure what about this commit causes the compile breakage I'm
>> seeing:
>>
>>   LINK    aarch64-linux-user/qemu-aarch64
>> ../libqemuutil.a(cpu-get-icount.o):(.bss+0x0): multiple definition of `u=
se_icount'
>> exec.o:(.bss+0x58): first defined here
>> collect2: error: ld returned 1 exit status
>> Makefile:199: recipe for target 'qemu-aarch64' failed
>> make[1]: *** [qemu-aarch64] Error 1
>> Makefile:481: recipe for target 'subdir-aarch64-linux-user' failed
>> make: *** [subdir-aarch64-linux-user] Error 2
>>
>> It only occurs on a make clean && make -j on that commit though. It's
>> hidden if you do incremental builds.
>
> make distclean works for me in such cases.

Hmmm

make distclean
./configure
make

And I get:

LINK    aarch64-linux-user/qemu-aarch64
../libqemuutil.a(cpu-get-icount.o):(.bss+0x0): multiple definition of `use_=
icount'
exec.o:(.bss+0x58): first defined here
collect2: error: ld returned 1 exit status
Makefile:199: recipe for target 'qemu-aarch64' failed
make[1]: *** [qemu-aarch64] Error 1
Makefile:481: recipe for target 'subdir-aarch64-linux-user' failed
make: *** [subdir-aarch64-linux-user] Error 2

The CI builds all look pretty broken too:

  https://travis-ci.org/stsquad/qemu/builds/408537385
  https://app.shippable.com/github/stsquad/qemu/runs/538/summary/console


>
> Pavel Dovgalyuk


--
Alex Benn=C3=A9e
