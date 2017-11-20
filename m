Received: from eggs.gnu.org ([2001:4830:134:3::10]:35067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eGmyb-00008D-Dg
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eGmyW-0001BU-E1
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:23:09 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eGmyW-0001B7-6w
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:23:04 -0500
Received: by mail-wr0-x244.google.com with SMTP id k18so3263174wre.1
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 06:23:04 -0800 (PST)
References: <8726068c-1112-eaea-5315-ec17ae37ae33@huawei.com>
	<878tf1xgff.fsf@linaro.org>
	<CAFEAcA9pg-yRfNJg5uFqU=pve9ypboisB5jo3piZ+ffLVy2xwQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA9pg-yRfNJg5uFqU=pve9ypboisB5jo3piZ+ffLVy2xwQ@mail.gmail.com>
Date: Mon, 20 Nov 2017 14:23:01 +0000
Message-ID: <877eulxc56.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [question] mask SIGBUS in qemu main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: gengdongjiu <gengdongjiu@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Wuquanming <wuquanming@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 20 November 2017 at 12:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> What exactly do you expect the main thread to do with a SIGBUS signal?
>
> For KVM, we (can) use SIGBUS for handling machine check exceptions:
> see qemu_init_sigbus() in cpus.c, where we use prctl(PR_MCE_KILL)
> to ask the host kernel to send us a SIGBUS if the memory used
> by the VM has memory corruption detected by the hardwar. This
> then lets us inform the guest (see kvm_mce_inject() in target/i386).
> (This will probably be coming to Arm KVM at some point, as part
> of the RAS extension support. See various threads in kvmarm list.)
>
> Because asynchronous signals are a pain to deal with, for the
> main thread we handle all our signals via signalfd(), which is
> why the main thread shows SIGBUS as blocked. The main thread
> will pick the signal up via the fd at some point. For KVM vcpu
> threads, the signal arrives asynchronously. See sigbus_handler()
> in cpus.c.

Well TIL ;-)

I wonder why the choice was made to re-use SIGBUS for this. I guess the
meaning is semantically the same (some hardware fault) but surprising
they are now asynchronously delivered. When it eventually arrives at the
vCPU it won't be directly tied to what tripped up the machine checking
logic to trigger? Maybe this was never always the case?

I was slightly confused seeing sigbus_handler() only mentioned once in a
sigaction call but grepping around I can now see sigfd_handler()
directly queries the sigaction for a signal before invoking the handler
which I guess makes sense.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
