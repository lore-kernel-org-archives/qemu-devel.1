Received: from eggs.gnu.org ([209.51.188.92]:38133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr03E-0006hX-MP
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr03D-0007it-QY
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:42:08 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr03D-0007iX-Kg
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:42:07 -0500
Received: by mail-ot1-x342.google.com with SMTP id 81so5440152otj.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 04:42:07 -0800 (PST)
MIME-Version: 1.0
References: <20190204142638.27021-1-mst@redhat.com>
	<CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
	<20190204205105-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190204205105-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 12:41:55 +0000
Message-ID: <CAFEAcA_m8Ebz8NTKM19FV-APQCOJpXVwyWm48uHRdfdKsHu7Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] pci, pc, virtio: fixes, cleanups,
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 5 Feb 2019 at 01:52, Michael S. Tsirkin <mst@redhat.com> wrote:
> So I think I fixed the build errors. And who knows maybe
> that will fix the runtime ones somehow ..
> Could you try pls? Re-pushed to same tag.

these failures still remain:

unused variable for OSX and the BSDs:

tests/vhost-user-test.c:942:17: warning: unused variable 'hugefs'
[-Wunused-variable]
    const char *hugefs;
                ^

Assertion failure on sparc, s390x and PPC64 hosts:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
QTEST_QEMU_IMG=qemu-img tests/vhost-user-test -m=quick -k --tap <
/dev/null | ./scripts/tap-driver.pl --test-name="vhost-user-test"
qemu-system-i386: backend does not support LE vnet headers; falling
back on userspace virtio
qemu-system-i386: backend does not support LE vnet headers; falling
back on userspace virtio
**
ERROR:/home/pm215/qemu/tests/vhost-user-test.c:243:wait_for_fds:
assertion failed: (s->fds_num)
ERROR - too few tests run (expected 4, got 0)

Given the set of hosts affected this is almost certainly
a big-endian-host specific bug.

thanks
-- PMM
