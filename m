Received: from eggs.gnu.org ([2001:4830:134:3::10]:34492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyy4T-0003no-TD
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyy4Q-0001ar-Lt
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:07:49 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eyy4Q-0001a0-BI
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:07:46 -0400
References: <20180123144807.5618-1-laurent@vivier.eu>
	<20180123144807.5618-13-laurent@vivier.eu>
	<758f54da-d733-6e95-57cf-cc8b25a81dd5@vivier.eu>
	<bf9d1394-f78d-b6ba-8893-d4c7fd592de3@vivier.eu>
	<CAFEAcA9==FswwaKG_eWncv7Eo-zF+OTOKmSC7N-mpTrSEzUJmg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2bc48c10-9347-3bb5-0f80-822bc240273a@vivier.eu>
Date: Thu, 22 Mar 2018 12:07:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9==FswwaKG_eWncv7Eo-zF+OTOKmSC7N-mpTrSEzUJmg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

Le 22/03/2018 à 12:05, Peter Maydell a écrit :
> On 22 March 2018 at 10:36, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 22/03/2018 à 02:52, Laurent Vivier a écrit :
>>> It seems this patch breaks something in linux-user mode emulation for
>>> m68k (32bit BE) on ppc (32bit BE).
>>>
>>> What I have:
>>>
>>>   ~/chroot$ sudo QEMU_CPU=m68040 chroot m68k/sid/
>>>   I have no name!@localhost:/# ls
>>>   bin   debootstrap  etc       lib   qemu-m68k  run   sys  usr
>>>   boot  dev      home  proc  root       sbin  tmp  var
>>>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>>>   ~/chroot$
>>>
>>> It seems "bash" crashes on "ls" exit.
>>>
>>> My chroot has been installed with:
>>>
>>>   ARCH=m68k
>>>   TARGET=sid
>>>   CHROOT=$HOME/chroot/m68k/sid/
>>>   REPOT=http://cdn-fastly.deb.debian.org/debian-ports/
>>>   debootstrap --arch=$ARCH --foreign --variant=minbase \
>>>               --no-check-gpg $TARGET $CHROOT $REPO
>>>
>>> I didn't investigate more.
>>
>> It goes wrong in this part:
>>
>> +     */
>> +    if (is_write && info->si_signo == SIGSEGV && info->si_code ==
>> SEGV_ACCERR &&
>> +        h2g_valid(address)) {
>>
>> Because, on ppc, si_code is SEGV_MAPERR and not SEGV_ACCERR
>> (on x86_64, si_code is SEGV_ACCERR as expected)
> 
> So on PPC if you have a page mapped, and you access it with
> the wrong permissions, you get SEGV_MAPERR? This seems like
> a host kernel bug to me.

Are we sure it is mapped? How to know?
otherwise yes, it sounds like a kernel bug.

Thanks,
Laurent
