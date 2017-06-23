Received: from eggs.gnu.org ([2001:4830:134:3::10]:37429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOTEJ-00050F-LP
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOTEG-00014e-GB
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:22:51 -0400
Received: from mail-qk0-x22d.google.com ([2607:f8b0:400d:c09::22d]:35410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOTEG-00014X-Bq
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:22:48 -0400
Received: by mail-qk0-x22d.google.com with SMTP id 16so42035500qkg.2
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 11:22:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170616161334.7492-1-f4bug@amsat.org>
	<20170616161334.7492-6-f4bug@amsat.org> <874lvcutv9.fsf@linaro.org>
	<CAFEAcA-GKYXrA1uEkS-kav_H_B4e2nfoVZLNMz_mjhfrJNjOSQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <64c09e7a-1aa6-f8c5-0152-80bbf5b0153c@amsat.org>
Date: Fri, 23 Jun 2017 15:22:44 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-GKYXrA1uEkS-kav_H_B4e2nfoVZLNMz_mjhfrJNjOSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/11] travis: build tests objects in
 parallel, then run tests sequentially
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 06/19/2017 08:12 AM, Peter Maydell wrote:

> What is perhaps a problem is that I'm not sure our tests all support
> being run in parallel with each other without tripping each other up by
> using the same temporary file / TCP port / etc at once. To the
> extent that this doesn't work it's a bug, but we should start
> by doing a solid soak test of the test suite to make sure -j<bignum>
> works reliably.

I might have caught one:

$ gcc --version
gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4

$ export MAKEFLAGS="-j ${PARALLEL_JOBS}"

$ echo "Using ${PARALLEL_JOBS} parallel jobs"
Using 3 parallel jobs

$ ${TEST_CMD}
[...]
   GTESTER check-qtest-unicore32
   GTESTER check-qtest-x86_64
   GTESTER check-qtest-xtensa
   GTESTER check-qtest-xtensaeb
   GTESTER tests/test-qobject-output-visitor
   GTESTER tests/test-clone-visitor
   GTESTER tests/test-qobject-input-visitor
   GTESTER tests/test-qmp-commands
   GTESTER tests/test-string-input-visitor
   GTESTER tests/test-string-output-visitor
   GTESTER tests/test-qmp-event
   GTESTER tests/test-opts-visitor
   GTESTER tests/test-qht-par
Could not access KVM kernel module: No such file or directory
failed to initialize KVM: No such file or directory
Back to tcg accelerator.
**
ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process 
(/x86_64/vhost-user/connect-fail/subprocess [2642]) failed unexpectedly
qemu-system-x86_64: Failed to set msg fds.
qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Resource 
temporarily unavailable (11)
qemu-system-x86_64: Failed to set msg fds.
qemu-system-x86_64: vhost VQ 1 ring restore failed: -1: Resource 
temporarily unavailable (11)
GTester: last random seed: R02S8c0c7c003144320339c3c86cfa72ba62
make: *** [check-qtest-x86_64] Error 1

(build: https://travis-ci.org/philmd/qemu/jobs/246199793)
