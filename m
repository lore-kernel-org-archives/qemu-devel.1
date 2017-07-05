Received: from eggs.gnu.org ([2001:4830:134:3::10]:47536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSmjP-0000Z4-Of
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSmjK-00021z-PL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:00:47 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSmjK-0001y0-9q
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:00:42 -0400
Received: by mail-wm0-x230.google.com with SMTP id f67so117787228wmh.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 09:00:40 -0700 (PDT)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 05 Jul 2017 17:01:38 +0100
Message-ID: <8737aaeuu5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] qemu_system_reset_request() broken w.r.t BQL locking
 regime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, maciej.borzecki@open-rnd.pl


Hi,

An interesting bug was reported on #qemu today. It was bisected to
8d04fb55 (drop global lock for TCG) and only occurred when QEMU was run
with taskset -c 0. Originally the fingers where pointed at mttcg but it
occurs in both single and multi-threaded modes.

I think the problem is qemu_system_reset_request() is certainly racy
when resetting a running CPU. AFAICT:

  - Guest resets board, writing to some hw address (e.g.
    arm_sysctl_write)
  - This triggers qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET)
  - We exit iowrite and drop the BQL
  - vl.c schedules qemu_system_reset->qemu_devices_reset...arm_cpu_reset
  - we start writing new values to CPU env while still in TCG code
  - CHAOS!

The general solution for this is to ensure these sort of tasks are done
with safe work in the CPUs context when we know nothing else is running.
It seems this is probably best done by modifying
qemu_system_reset_request to queue work up on current_cpu and execute it
as safe work - I don't think the vl.c thread should ever be messing
about with calling cpu_reset directly.

Looking at the calls most of these are made by device code but I see KVM
also does it. I just wanted to check this was a reasonable approach and
wouldn't upset anything else.

Any thoughts?

--
Alex Bennée
