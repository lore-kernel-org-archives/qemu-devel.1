Received: from eggs.gnu.org ([2001:4830:134:3::10]:43224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fuyrN-00027w-HB
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fuykD-00058J-VY
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:34:45 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fuykD-00055O-Qc
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:34:41 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so7171446ite.0
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 04:34:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180829095035.GI31005@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180829095035.GI31005@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Aug 2018 13:34:40 +0200
Message-ID: <CAMxuvayUDC+dZegONEwto36qTqaJFUEF9UrvNiY+1HJ_6nrzYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/29] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, David Airlie <airlied@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>

Hi

On Wed, Aug 29, 2018 at 11:50 AM, Daniel P. Berrang=C3=A9
<berrange@redhat.com> wrote:
> On Fri, Jul 13, 2018 at 03:08:47PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Hi,
>>
>> vhost-user allows to drive a virtio device in a seperate
>> process. After vhost-user-net, we have seen
>> vhost-user-{scsi,blk,crypto} added more recently.
>>
>> This series, initially proposed 2 years ago
>> (https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
>> contributes with vhost-user-input and vhost-user-gpu.
>>
>> Additionally, to factor out common code and ease the usage, a
>> vhost-user-backend is introduced as an intermediary object between the
>> backend and the qemu device.
>>
>> You may start a vhost-user-gpu with virgl rendering in a separate
>> process like this:
>>
>> $ ./vhost-user-gpu --virgl -s vgpu.sock &
>> $ qemu...
>>   -chardev socket,id=3Dchr,path=3Dvgpu.sock
>>   -object vhost-user-backend,id=3Dvug,chardev=3Dchr
>>   -device vhost-user-vga,vhost-user=3Dvug
>>
>> You may also specify the backend command and the arguments as part of
>> vhost-user-backend qemu arguments. For example, to start a
>> vhost-user-input backend on input device /dev/input/event19:
>>
>> -object vhost-user-backend,id=3Dvuid,cmd=3D"vhost-user-input /dev/input/=
event19"
>> -device virtio-input-host-pci,vhost-user=3Dvuid
>>
>> The vhost-user-gpu backend requires virgl from git.
>>
>> The libvirt support is on-going work:
>> https://github.com/elmarco/libvirt/commits/vhost-user-gpu
>>
>> The GPU benchmarks are encouraging, giving up to x5 performance on
>> Unigine Heaven 4.0.
>
> What is the main driving motivation behind this featureset ? Is it aimed
> at providing performance, or security, or allowing arbitrary out of tree
> backends, or all three ?

Mainly security/stability & performance. Allowing arbitrary out of
tree backends is a bonus for me, I don't care much if we don't allow
it.

> Although we've got a number of vhost-user backends I'm pretty concerned
> about the direction this is taking QEMU overall.
>
> Managing QEMU is non-trivial for a number of reasons. We've done a lot of
> work to provide standardized modelling of CLI args, guest ABI stability
> via association with machine types, migration data stream stability,
> QEMU feature capabilities detection and so on.
>
> The move to outsource backends to external binaries is discarding some
> or all of these items, rewinding alot of progress we've made in the
> managability of QEMU. Each external binary has to now reinvent the
> things that are already solved in QEMU, and you can be sure each impl
> will reinvent the concepts differently.
>
> I can't help feeling that we are shooting ourselves in the foot here
> long term.

I have a bit of the same feeling. For ex, I was a bit reluctant having
the TPM emulator as an external process (new protocol, external
binaries, with various management work, "opaque" migration). But in
the end, the integration with libvirt makes thing quite easy for the
user. So I changed a bit my mind, and I think this is one task that
libvirt can be really good at.

>
> We've always rejected the idea of having loadable modules in QEMU, but
> as a result we've end up with outsourcing the backend entirely via the
> vhost-user framework, so the end result is even more opaque than if we
> had loadable modules, and is unable to take advantage of our standardized
> modelling frameworks & capabilities :-(

I agree, that's one of the reason I put together libvhostuser in the
first place. If qemu ships its own backend, there is no reason we
don't share modelling & code etc.

For ex, I hope more vhost-users will use the -object
vhost-user-backend to do basic connection and virtio setup. (in the
series, -gpu and -input, I didn't really investigate -crypto, -net,
-blk etc)

> If we just look at performance & security, and ignore 3rd party impls
> for a minute, I really don't like that to gain perf + security  we have
> to change from:
>
>  $ qemu...
>    -device virtio-vga
>
> To
>
>  $ ./vhost-user-gpu --virgl -s vgpu.sock &
>  $ qemu...
>    -chardev socket,id=3Dchr,path=3Dvgpu.sock
>    -object vhost-user-backend,id=3Dvug,chardev=3Dchr
>    -device vhost-user-vga,vhost-user=3Dvug
>

That's a bit incovenient for qemu command line users. But who runs
qemu this way but some developers? (others have higher-level scripts /
tools or libvirt)

> Once we have the ability to run the backend via an external process,
> to gain performance & security benefits, assuming feature parity is
> achieved, I question why anyone would want to continue with the old
> in-process approach ? IOW the goal should be that the original args
>
>  $ qemu...
>    -device virtio-vga
>
> should "do the right thing" to launch the external process when you
> have upgraded to a new enough QEMU, so that everyone immediately
> benefits from the more secure & performant architecture.


That's not incompatible with having the lengthy version. But this
comes with some downside atm, since migration is not implemented for
ex (for 2d, virgl doesn't have migration).

And seccomp spawn rule disable forking.

And libvirt will probably want to manage the external process for
security/resource/tweaking reasons.

thanks for the feedback!
