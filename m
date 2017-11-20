Received: from eggs.gnu.org ([2001:4830:134:3::10]:37422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGlgd-0001kS-0i
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGlgV-0004U9-B8
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:00:31 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGlgV-0004TF-4t
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:00:23 -0500
Received: by mail-wm0-x244.google.com with SMTP id r68so18615380wmr.1
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 05:00:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <878tf1xgff.fsf@linaro.org>
References: <8726068c-1112-eaea-5315-ec17ae37ae33@huawei.com>
	<878tf1xgff.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 13:00:01 +0000
Message-ID: <CAFEAcA9pg-yRfNJg5uFqU=pve9ypboisB5jo3piZ+ffLVy2xwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: gengdongjiu <gengdongjiu@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Wuquanming <wuquanming@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>

On 20 November 2017 at 12:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> What exactly do you expect the main thread to do with a SIGBUS signal?

For KVM, we (can) use SIGBUS for handling machine check exceptions:
see qemu_init_sigbus() in cpus.c, where we use prctl(PR_MCE_KILL)
to ask the host kernel to send us a SIGBUS if the memory used
by the VM has memory corruption detected by the hardwar. This
then lets us inform the guest (see kvm_mce_inject() in target/i386).
(This will probably be coming to Arm KVM at some point, as part
of the RAS extension support. See various threads in kvmarm list.)

Because asynchronous signals are a pain to deal with, for the
main thread we handle all our signals via signalfd(), which is
why the main thread shows SIGBUS as blocked. The main thread
will pick the signal up via the fd at some point. For KVM vcpu
threads, the signal arrives asynchronously. See sigbus_handler()
in cpus.c.

thanks
-- PMM
