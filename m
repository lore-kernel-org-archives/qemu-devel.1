Received: from eggs.gnu.org ([2001:4830:134:3::10]:44536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4VrF-0007hJ-DO
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4VrE-0002Fw-9E
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:13:05 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4VrE-0002Ei-3Y
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:13:04 -0400
Received: by mail-oi0-x242.google.com with SMTP id 71-v6so1857908oie.12
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 11:13:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309172622.4277-11-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
	<20180309172622.4277-11-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 19:12:42 +0100
Message-ID: <CAFEAcA-aVoyMGegYLrzZAaQgs2nebRZ1+wCBEXw2iHE7FSeZRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 10/25] aarch64-linux-user: Add support for
 SVE signal frame records
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Richard Henwood <richard.henwood@arm.com>

On 9 March 2018 at 17:26, Peter Maydell <peter.maydell@linaro.org> wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Depending on the currently selected size of the SVE vector registers,
> we can either store the data within the "standard" allocation, or we
> may beedn to allocate additional space with an EXTRA record.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20180303143823.27055-6-richard.henderson@linaro.org
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/signal.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 192 insertions(+), 18 deletions(-)

I did a 'git bisect' looking for when we introduced the segv
bug described in https://bugs.launchpad.net/qemu/+bug/1761535,
and git bisect thinks this commit is it.

At least for me, with a xenial aarch64 chroot, with this
patch if I chroot in and run 'ls' then we get a spurious
segfault (I think in the guest bash):

e104462:xenial:chroot$ sudo chroot xenial-aarch64
root@e104462:/# ls
Deadlock.class    bin   home                  hotspot_pid17113.log
mnt   root   srv  var
Deadlock.java     boot  hotspot_pid14759.log  hotspot_pid19407.log
opt   run    sys
HelloWorld.class  dev   hotspot_pid16542.log  lib
proc  sbin   tmp
HelloWorld.java   etc   hotspot_pid16895.log  media
risu  sdbg9  usr
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault (core dumped)

Reverting f914baef8e39f7 on master fixes the segfault.

Richard (Henderson): I'll have a closer look at this on Monday if you don't
get to it first...

thanks
-- PMM
