Received: from eggs.gnu.org ([2001:4830:134:3::10]:51224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyxaI-0001PU-5k
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyxaD-0004eA-8Q
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:36:38 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eyxaC-0004dW-Tp
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:36:33 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
	<20180123144807.5618-13-laurent@vivier.eu>
	<758f54da-d733-6e95-57cf-cc8b25a81dd5@vivier.eu>
Message-ID: <bf9d1394-f78d-b6ba-8893-d4c7fd592de3@vivier.eu>
Date: Thu, 22 Mar 2018 11:36:28 +0100
MIME-Version: 1.0
In-Reply-To: <758f54da-d733-6e95-57cf-cc8b25a81dd5@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 12/13] page_unprotect(): handle calls to
 pages that are PAGE_WRITE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Le 22/03/2018 à 02:52, Laurent Vivier a écrit :
> Le 23/01/2018 à 15:48, Laurent Vivier a écrit :
>> From: Peter Maydell <peter.maydell@linaro.org>
>>
>> If multiple guest threads in user-mode emulation write to a
>> page which QEMU has marked read-only because of cached TCG
>> translations, the threads can race in page_unprotect:
>>
>>  * threads A & B both try to do a write to a page with code in it at
>>    the same time (ie which we've made non-writeable, so SEGV)
>>  * they race into the signal handler with this faulting address
>>  * thread A happens to get to page_unprotect() first and takes the
>>    mmap lock, so thread B sits waiting for it to be done
>>  * A then finds the page, marks it PAGE_WRITE and mprotect()s it writable
>>  * A can then continue OK (returns from signal handler to retry the
>>    memory access)
>>  * ...but when B gets the mmap lock it finds that the page is already
>>    PAGE_WRITE, and so it exits page_unprotect() via the "not due to
>>    protected translation" code path, and wrongly delivers the signal
>>    to the guest rather than just retrying the access
>>
>> In particular, this meant that trying to run 'javac' in user-mode
>> emulation would fail with a spurious guest SIGSEGV.
>>
>> Handle this by making page_unprotect() assume that a call for a page
>> which is already PAGE_WRITE is due to a race of this sort and return
>> a "fault handled" indication.
>>
>> Since this would cause an infinite loop if we ever called
>> page_unprotect() for some other kind of fault than "write failed due
>> to bad access permissions", tighten the condition in
>> handle_cpu_signal() to check the signal number and si_code, and add a
>> comment so that if somebody does ever find themselves debugging an
>> infinite loop of faults they have some clue about why.
>>
>> (The trick for identifying the correct setting for
>> current_tb_invalidated for thread B (needed to handle the precise-SMC
>> case) is due to Richard Henderson.  Paolo Bonzini suggested just
>> relying on si_code rather than trying anything more complicated.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Message-Id: <1511879725-9576-3-git-send-email-peter.maydell@linaro.org>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  accel/tcg/translate-all.c | 50 +++++++++++++++++++++++++++++------------------
>>  accel/tcg/user-exec.c     | 13 +++++++++++-
>>  2 files changed, 43 insertions(+), 20 deletions(-)
>>
> 
> It seems this patch breaks something in linux-user mode emulation for
> m68k (32bit BE) on ppc (32bit BE).
> 
> What I have:
> 
>   ~/chroot$ sudo QEMU_CPU=m68040 chroot m68k/sid/
>   I have no name!@localhost:/# ls
>   bin   debootstrap  etc	 lib   qemu-m68k  run	sys  usr
>   boot  dev	   home  proc  root	  sbin	tmp  var
>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>   ~/chroot$
> 
> It seems "bash" crashes on "ls" exit.
> 
> My chroot has been installed with:
> 
>   ARCH=m68k
>   TARGET=sid
>   CHROOT=$HOME/chroot/m68k/sid/
>   REPOT=http://cdn-fastly.deb.debian.org/debian-ports/
>   debootstrap --arch=$ARCH --foreign --variant=minbase \
>               --no-check-gpg $TARGET $CHROOT $REPO
> 
> I didn't investigate more.

It goes wrong in this part:

+     */
+    if (is_write && info->si_signo == SIGSEGV && info->si_code ==
SEGV_ACCERR &&
+        h2g_valid(address)) {

Because, on ppc, si_code is SEGV_MAPERR and not SEGV_ACCERR
(on x86_64, si_code is SEGV_ACCERR as expected)

Any idea?

Thanks,
Laurent
