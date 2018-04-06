Received: from eggs.gnu.org ([2001:4830:134:3::10]:45729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4VtD-0000vw-8M
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4VtC-0005BR-3k
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:15:07 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4VtB-0005BH-UK
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:15:06 -0400
Received: by mail-ot0-x241.google.com with SMTP id m7-v6so2141470otd.1
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 11:15:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-aVoyMGegYLrzZAaQgs2nebRZ1+wCBEXw2iHE7FSeZRg@mail.gmail.com>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
	<20180309172622.4277-11-peter.maydell@linaro.org>
	<CAFEAcA-aVoyMGegYLrzZAaQgs2nebRZ1+wCBEXw2iHE7FSeZRg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 19:14:44 +0100
Message-ID: <CAFEAcA_xNAWOOC26PT=5BC6onaqtPd+9pLq67awE2owuZZm42A@mail.gmail.com>
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

On 6 April 2018 at 19:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 9 March 2018 at 17:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> Depending on the currently selected size of the SVE vector registers,
>> we can either store the data within the "standard" allocation, or we
>> may beedn to allocate additional space with an EXTRA record.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-id: 20180303143823.27055-6-richard.henderson@linaro.org
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  linux-user/signal.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 192 insertions(+), 18 deletions(-)
>
> I did a 'git bisect' looking for when we introduced the segv
> bug described in https://bugs.launchpad.net/qemu/+bug/1761535,
> and git bisect thinks this commit is it.
>
> At least for me, with a xenial aarch64 chroot, with this
> patch if I chroot in and run 'ls' then we get a spurious
> segfault (I think in the guest bash):
>
> e104462:xenial:chroot$ sudo chroot xenial-aarch64
> root@e104462:/# ls
> Deadlock.class    bin   home                  hotspot_pid17113.log
> mnt   root   srv  var
> Deadlock.java     boot  hotspot_pid14759.log  hotspot_pid19407.log
> opt   run    sys
> HelloWorld.class  dev   hotspot_pid16542.log  lib
> proc  sbin   tmp
> HelloWorld.java   etc   hotspot_pid16895.log  media
> risu  sdbg9  usr
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault (core dumped)
>
> Reverting f914baef8e39f7 on master fixes the segfault.

Er, I mean "reverting 8c5931de0ac77388096d79c". Accidentally quoted
the git hash of the local revert-commit I was testing rather than
of the commit it's reverting...

thanks
-- PMM
