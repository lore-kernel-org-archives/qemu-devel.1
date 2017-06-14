Received: from eggs.gnu.org ([2001:4830:134:3::10]:33269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLCqw-0002xS-1u
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLCqs-0005Dq-Pb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:17:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLCqs-0005DU-Ji
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:17:10 -0400
From: Thomas Huth <thuth@redhat.com>
Message-ID: <51910ce7-0ef0-0d98-01be-277206776c7f@redhat.com>
Date: Wed, 14 Jun 2017 20:17:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] tlb_flush() in qom/cpu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

 Hi Alex,

I'm currently trying to poison some more target-specific defines and
noticed something fishy:

In commit  1f5c00cfdb8114c ("move tlb_flush to cpu_common_reset") you
moved the call to tlb_flush() to qom/cpu.c and guarded it with a #ifdef
CONFIG_SOFTMMU. However, qom/cpu.c is common code (common-obj-y in the
Makefile), so CONFIG_SOFTMMU is *never* defined here, i.e. the
tlb_flush() is never called anymore! (this is also quite obvious since
you've changed the prototype of tlb_flush() in d10eb08f5d83 later
without adapting qom/cpu.c).

Not sure how to fix this in a nice way, though ... shall we move the
tlb_flush() back to the target-specific reset handlers?

 Thomas
