Received: from eggs.gnu.org ([2001:4830:134:3::10]:43573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJ0WK-00049W-Rh
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJ0WI-0004c1-6U
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:42:52 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:36437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJ0WI-0004aI-28
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:42:50 -0400
Received: by mail-qt0-x231.google.com with SMTP id u19so48119709qta.3
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 09:42:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170607155536.1193-1-rth@twiddle.net>
	<20170607155536.1193-2-rth@twiddle.net>
	<20170607221156.GA25936@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fb95dc63-97cd-7778-0634-7ad15965adef@twiddle.net>
Date: Thu, 8 Jun 2017 09:42:42 -0700
MIME-Version: 1.0
In-Reply-To: <20170607221156.GA25936@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/7] util: add cacheinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 06/07/2017 03:11 PM, Emilio G. Cota wrote:
> On Wed, Jun 07, 2017 at 08:55:30 -0700, Richard Henderson wrote:
> (snip)
>> +#elif defined(__APPLE__) \
>> +      || defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
>> +# include <sys/sysctl.h>
>> +# if defined(__APPLE__)
>> +#  define SYSCTL_CACHELINE_NAME "hw.cachelinesize"
>> +# else
>> +#  define SYSCTL_CACHELINE_NAME "machdep.cacheline_size"
>> +# endif
>> +
>> +static void sys_cache_info(void)
>> +{
>> +    /* There's only a single sysctl for both I/D cache line sizes.  */
>> +    size_t len = sizeof(qemu_icache_linesize);
>> +    if (!sysctlbyname(SYSCTL_CACHELINE_NAME, &qemu_icache_linesize,
>> +                      &len, NULL, 0)) {
>> +        qemu_dcache_linesize = qemu_icache_linesize;
>> +    }
>> +}
> 
> This doesn't work on the MacOS (Darwin 16.6.0) I have access to.
> 
> If we do
> 	long size; // <-- type here matters!
> 	size_t len = sizeof(size);
> 	sysctlbyname(..., &size, &len, ...);
> then size == 64.
> 
> However, if instead of 'long size' we have 'int size' (as in the patch),
> then  'size == 1' yet sysctlbyname still returns 0. (!)
> This is why I was using an intermediate long in my previous patch,
> although obviously a comment there would have been appropriate.
> 
> FWIW, if we query what length sysctlbyname expects for this param (by
> calling sysctlbyname(NAME, NULL, &size, NULL, 0), we get len == 8;
> I presume on both 32 and 64-bit systems passing a long will work
> OK here.

Thanks, missed that.  I also have to fix up the _WIN32 case, for which I missed 
a default: while rearranging things.

r~
