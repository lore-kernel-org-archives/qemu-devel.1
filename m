Received: from eggs.gnu.org ([2001:4830:134:3::10]:44944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXk5v-0000wy-DJ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXk5u-0007QR-4h
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:49:19 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXk5t-0007Oa-9P
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:49:17 -0500
Received: by mail-ot1-x342.google.com with SMTP id a11so4802908otr.10
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 01:49:16 -0800 (PST)
MIME-Version: 1.0
References: <1544701071-2922-1-git-send-email-liq3ea@gmail.com>
	<154471686589.17726.17792356837247129570@02a1dbf831e2>
	<CAKXe6SLLrFDCaqBW8B_qBmcrYm6HM9jzv5C2VNyph+218sMeWA@mail.gmail.com>
	<CAKXe6S+S4dsKkk-FGQeaXQgT6p=ijMojtMiHHNd9ss54etg03Q@mail.gmail.com>
In-Reply-To: <CAKXe6S+S4dsKkk-FGQeaXQgT6p=ijMojtMiHHNd9ss54etg03Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 09:49:04 +0000
Message-ID: <CAFEAcA_JgwHSkMwC9LDpDuPEb5VTWpfR+71Hj+UNKS1Qn5x4nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] util: check the return value of fcntl
 in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, fam@euphon.net, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

On Fri, 14 Dec 2018 at 09:16, Li Qiang <liq3ea@gmail.com> wrote:
> First of all I want to know does the following error means?
> doesn't it mean "the x86 qtest is ok and aarch64 is not ok"?
>
>
>   GTESTER check-qtest-x86_64
>   GTESTER check-qtest-aarch64
> vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245: qemu_set_nonblock: Assertion `f != -1' failed.
> Broken pipe
> GTester: last random seed: R02S61a1e35369394d7efb0a0e96d8af615d
>   GTESTER tests/test-qht-par
> vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245: qemu_set_nonblock: Assertion `f != -1' failed.
> Broken pipe
> GTester: last random seed: R02Sbf8c21ef5f216840e073ff3e487dedbc
> vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245: qemu_set_nonblock: Assertion `f != -1' failed.
> Broken pipe
> GTester: last random seed: R02Sfe8cd276fddf3a92891cf274bf88e888
> vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245: qemu_set_nonblock: Assertion `f != -1' failed.
> Broken pipe
> GTester: last random seed: R02S7487fc065e22541ba4c78c0db6c61d3c
> Could not access KVM kernel module: No such file or directory

I think maybe the make output is confusing you here, because it's
running both qtests in parallel. We don't ever run the
vhost-user-test for arm guests: tests/Makefile adds it only
to check-qtest-i386 and check-qtest-x86_64. So I think all
the warnings/errors here are coming from the x86 test.

> the 'ioeventfd_enabled()' returns 0 and 'kvm_eventfds_allowed' is 0 which means the
> kernel doesn't support eventfd.

> After I look at the kernel, the arm platform seems doesn't support eventfd.
>
> So if my understanding is correct in the first, '"the x86 qtest is ok and aarch64 is not ok".
> This can be explainable. But if not, there maybe another issue.

It looks to me from the investigation you did that the
vhost-user-test is assuming that we are using KVM
and ioeventfds, and is misbehaving when that is not true.
We should fix the test so that either it works in that
configuration, or correctly skips doing the test if it
is not applicable in a different config.

thanks
-- PMM
