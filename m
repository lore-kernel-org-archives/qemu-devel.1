Received: from eggs.gnu.org ([2001:4830:134:3::10]:56704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA60j-0004YU-E2
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 23:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA60g-0006K1-8G
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 23:17:41 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:56351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA60g-0006Ji-2S
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 23:17:38 -0400
Received: by mail-qk0-x243.google.com with SMTP id l194so5105391qke.13
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 20:17:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1509583771.git.pisa@cmp.felk.cvut.cz>
	<844921c2-2855-207a-2f9f-7c2ad28187e6@amsat.org>
	<201711020310.27240.pisa@cmp.felk.cvut.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2deeacb1-b2da-6e1d-3981-4e7d98778387@amsat.org>
Date: Thu, 2 Nov 2017 00:17:28 -0300
MIME-Version: 1.0
In-Reply-To: <201711020310.27240.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/5 v2] CAN bus support for QEMU (SJA1000
 PCI so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 11/01/2017 11:10 PM, Pavel Pisa wrote:
>>> Some page about the project
>>>
>>>   https://gitlab.fel.cvut.cz/canbus/qemu-canbus/wikis/home
>>>
>>> FEE CTU GitLab repository with can-pci branch for 2.3, 2.4, 2.7, 2.8 and
>>> 2.10 version if QEMU is available there
>>>
>>>   https://gitlab.fel.cvut.cz/canbus/qemu-canbus/tree/can-pci
>>
>> This GitLab seems to be restricted to your university :(
> 
> Thanks fort the report, I have moved work from GitHub to local GitLab
> for future continuous integration support.
> 
> Repository has been public from beginning, but I forgot
> to make wiki public. It should be OK now.

Indeed it is :) I was writing another mail asking for details about how
to test your series.

More useful than the wiki would be to have part of this info in
docs/can.txt (or docs/socketcan.txt).

> 
> Unfortunately, my attempt to follow suggestion to ensure
> that even conditionalized debug code is build always
> leads to patchew.org problem report because now exposed
> static function is not used in non Linux builds
> 
> /tmp/qemu-test/src/hw/can/can_core.c:153:13: error: 'can_display_msg' defined but not used [-Werror=unused-function]
>  static void can_display_msg(struct qemu_can_frame *msg)
>              ^~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

If you have Docker installed you can run:

$ make docker-image-debian-win32-cross
[...]

Then:

$ make docker-run TEST="test-quick" IMAGE="debian-win32-cross"
HEAD is now at b154b28678... WIP on canbus: 00a6a3d87f CAN bus MIOe-3680
PCI (dual SJA1000 channel) emulation added.
  COPY    RUNNER
    RUN test-quick in qemu:debian-win32-cross
[...]
C compiler        i686-w64-mingw32.shared-gcc
Host C compiler   cc
...
mingw32 support   yes
[...]
  CC      hw/bt/hci.o
  CC      hw/bt/hid.o
  CC      hw/bt/hci-csr.o
  CC      hw/can/can_core.o
/tmp/qemu-test/src/hw/can/can_core.c:153:13: error: 'can_display_msg'
defined but not used [-Werror=unused-function]
 static void can_display_msg(struct qemu_can_frame *msg)
             ^
cc1: all warnings being treated as errors
make: *** [hw/can/can_core.o] Error 1
/tmp/qemu-test/src/rules.mak:66: recipe for target 'hw/can/can_core.o'
failed
tests/docker/Makefile.include:126: recipe for target 'docker-run' failed
make: *** [docker-run] Error 1

> 
> It is used for connection to the host CAN bus interface
> and that is implemented only for SocketCAN on Linux.
> 
> So patches v3 series is necessary anyway.
> 
> I would be happy if I receive some review remarks
> for this reorganized series to lower iteration count.

I'm not sure my critical review made you happy ;)

You'll get review but since we are entering SoftFreeze I doubt your
series will enter in this release. But surely other will review.

Can you think of some test to add? The easiest test is to just start
QEMU with your device (i.e. tests/ne2000-test.c)
Ideally you'd use it like ping pong'ing frame with device in loopback
mode (see tests/e1000e-test.c).

Regards,

Phil.
