Received: from eggs.gnu.org ([2001:4830:134:3::10]:56452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehDwz-0004yr-Ta
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehDwy-0001zS-SL
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:26:45 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:35733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ehDwy-0001z6-Kl
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:26:44 -0500
Received: by mail-oi0-x234.google.com with SMTP id e15so3100885oiy.2
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 04:26:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <75114832.1210415.1517487560355@mail.yahoo.com>
References: <1972503886.3523325.1517308471375.ref@mail.yahoo.com>
	<1972503886.3523325.1517308471375@mail.yahoo.com>
	<20180130115510.GA13988@xz-mi>
	<75114832.1210415.1517487560355@mail.yahoo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2018 12:26:23 +0000
Message-ID: <CAFEAcA-OSN4MVVr6hbMVwiFs-tYVFH8hW5QvF3KvyXZPsEZpKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Savevm and loadvm not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sridhar kulkarni <sridhar_kulk@yahoo.com>
Cc: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 1 February 2018 at 12:19, sridhar kulkarni via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> I thought that RAM contents are not saved because of return value RAM_SAV=
E_CONTROL_NOT_SUPP. Now that you clarified about this, I debugged this furt=
her. After doing loadvm operation, I am getting following error,qemu-system=
-arm: error while loading state for instance 0x0 of device 'cpu'
> qemu-system-arm: Error -1 while loading VM state
> I figured out that, this error is because of following function returning=
 FALSE. "write_raw_cp_reg" writes a value and "read_raw_cp_reg" reads the v=
alue back. There is mismatch between what we write and what is being read b=
ack, and hence function returns FALSE.
> Between I want to mention that, I am trying the snapshot on a VM which ru=
ns ARM 7 core. I am not sure if this snapshot feature is fully function for=
 ARM targets.

It is supposed to work for ARM, and it does for
the CPUs I've tested it with. Which exact CPU
model are you using? (Do you really mean "ARM 7"?
We don't support that. We have ARMv7 architecture
CPUs like the cortex-a9 -- did you mean one of those?)

Are you using an unmodified upstream QEMU? We don't
have an "arm-machine" board model which is what your
command line is using with "-M arm-machine", so if
you're using a modified QEMU it's possible those
modifications haven't been written to support VM
state saving.

The next step in debugging would be to run QEMU under
gdb or add tracing printfs so that you can identify
which emulated system register it is that is causing the
failure.

thanks
-- PMM
