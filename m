Received: from eggs.gnu.org ([2001:4830:134:3::10]:57301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ez3NU-0006ZG-Vn
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ez3NR-0003kq-4K
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:47:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ez3NQ-0003kX-Q0
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:47:45 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
	<20180123144807.5618-13-laurent@vivier.eu>
	<758f54da-d733-6e95-57cf-cc8b25a81dd5@vivier.eu>
	<bf9d1394-f78d-b6ba-8893-d4c7fd592de3@vivier.eu>
	<CAFEAcA9==FswwaKG_eWncv7Eo-zF+OTOKmSC7N-mpTrSEzUJmg@mail.gmail.com>
	<CAFEAcA9ZAxkvc-Rn=oP5Bgksk6zo8PYNkhP8SC1+aaWN_vQduw@mail.gmail.com>
	<5e841941-8517-fec8-69b2-be0961b3ff0d@vivier.eu>
Message-ID: <8062ee1c-5b4d-da63-b3fa-7a0b0a6d3a36@vivier.eu>
Date: Thu, 22 Mar 2018 17:47:40 +0100
MIME-Version: 1.0
In-Reply-To: <5e841941-8517-fec8-69b2-be0961b3ff0d@vivier.eu>
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

Le 22/03/2018 à 12:13, Laurent Vivier a écrit :
> Le 22/03/2018 à 12:07, Peter Maydell a écrit :
>> On 22 March 2018 at 11:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 22 March 2018 at 10:36, Laurent Vivier <laurent@vivier.eu> wrote:
>>>> It goes wrong in this part:
>>>>
>>>> +     */
>>>> +    if (is_write && info->si_signo == SIGSEGV && info->si_code ==
>>>> SEGV_ACCERR &&
>>>> +        h2g_valid(address)) {
>>>>
>>>> Because, on ppc, si_code is SEGV_MAPERR and not SEGV_ACCERR
>>>> (on x86_64, si_code is SEGV_ACCERR as expected)
>>>
>>> So on PPC if you have a page mapped, and you access it with
>>> the wrong permissions, you get SEGV_MAPERR? This seems like
>>> a host kernel bug to me.
>>
>> ...in particular, kernel commit ecb101aed86156e (dated Dec 2017)
>> fixes a regression introduced in commit c3350602e876 that broke
>> the ppc kernels so they started returning SEGV_MAPERR here
>> instead of SEGV_ACCERR. Presumably your host kernel is missing
>> this fix.
> 
> Yes, you're right, my kernel is 4.14-rc1 (6e80ecd) with
> c3350602e876 but without ecb101aed86156e.
> 
> I'm going to update it.

Re-tested with 4.16-rc6 on ppc32 and it works fine.

Thanks,
Laurent
