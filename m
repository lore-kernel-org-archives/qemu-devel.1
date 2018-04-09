Received: from eggs.gnu.org ([2001:4830:134:3::10]:59083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5aJu-0001OX-Hn
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5aJt-0001J8-D8
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:11:06 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:40478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5aJt-0001I2-82
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:11:05 -0400
Received: by mail-oi0-x230.google.com with SMTP id x9-v6so8350866oig.7
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 10:11:05 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 18:10:43 +0100
Message-ID: <CAFEAcA8+gJg4O-ys-KjEVXSEsgd0CZaGXJ=o6nFx4Dv8ccNn0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qom-test on netbsd can be very slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

My NetBSD build system recently seems to have taken a nosedive
in how long it takes to finish "make check". This seems to be
because qom-test (and probably other things where the test interacts
with the QEMU process) can run very slowly.

netbsdvm# for i in 1 2 3 4 5 6 7 8 9 10; do
(QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 time
tests/qom-test -p /x86_64/qom/pc-i440fx-2.0); done
/x86_64/qom/pc-i440fx-2.0: OK
        8.49 real         1.18 user         7.34 sys
/x86_64/qom/pc-i440fx-2.0: OK
       10.41 real         1.32 user         9.09 sys
/x86_64/qom/pc-i440fx-2.0: OK
        8.45 real         1.24 user         7.24 sys
/x86_64/qom/pc-i440fx-2.0: OK
        9.88 real         1.10 user         8.31 sys
/x86_64/qom/pc-i440fx-2.0: OK
       11.60 real         1.47 user         9.90 sys
/x86_64/qom/pc-i440fx-2.0: OK
       10.94 real         1.28 user         9.68 sys
/x86_64/qom/pc-i440fx-2.0: OK
       10.06 real         1.32 user         8.76 sys
/x86_64/qom/pc-i440fx-2.0: OK
       13.38 real         1.37 user        12.04 sys
/x86_64/qom/pc-i440fx-2.0: OK
       16.19 real         1.46 user        14.29 sys
/x86_64/qom/pc-i440fx-2.0: OK
        9.70 real         1.17 user         8.51 sys

Admittedly this is running in a (KVM) VM, but still, there seems
something wrong with how long each of these is taking. On Linux
each run is less than a second, so there's an order-of-magnitude
slowdown here. Further, I've occasionally seen a run take 100 seconds!

Does anybody else see this, and any ideas why it might be running slow?
I'm not very familiar with debugging on netbsd; I had a look at
ktrace output, and the QEMU process seems to sometimes spend
quite a lot of time in a poll() loop not actually doing anything.
I couldn't figure out how to get the ktrace logs to annotate
which thread was making which syscall though, so they weren't
easy to interpret. If anybody's more experienced at debugging
things in the BSDs that would also be helpful.

On OpenBSD, for comparison, each test run seems to fairly reliably
take 5 seconds give-or-take, there's much less run-to-run
variation, though it's still much slower than Linux is.
The OpenBSD and FreeBSD build VMs seem to complete more
reasonably quickly than the NetBSD one.

One thing I noticed looking at ktrace output is that we do
all our reading of QMP input and output with a read syscall
per character. I don't think that's the cause of this slowness,
though.

thanks
-- PMM
