Received: from eggs.gnu.org ([2001:4830:134:3::10]:34777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIIRm-0003qY-3J
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIIRl-0006i2-5O
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:39:14 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIIRl-0006hY-1P
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:39:13 -0400
Received: by mail-qt0-x243.google.com with SMTP id x58so17540406qtc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 10:39:12 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-2-git-send-email-cota@braap.org>
	<CAJhHMCDHLrU5NEuZGJqkVcJyQnXYsrdcYbNiNw4DAgiT=0R9pQ@mail.gmail.com>
	<20170606161152.GA6109@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8bc72799-f469-9728-fb4b-83b47b89a701@twiddle.net>
Date: Tue, 6 Jun 2017 10:39:08 -0700
MIME-Version: 1.0
In-Reply-To: <20170606161152.GA6109@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] compiler: define QEMU_CACHELINE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 06/06/2017 09:11 AM, Emilio G. Cota wrote:
> On Tue, Jun 06, 2017 at 01:39:45 -0400, Pranith Kumar wrote:
>> On Mon, Jun 5, 2017 at 6:49 PM, Emilio G. Cota <cota@braap.org> wrote:
>>> This is a constant used as a hint for padding structs to hopefully avoid
>>> false cache line sharing.
>>>
>>> The constant can be set at configure time by defining QEMU_CACHELINE_SIZE
>>> via --extra-cflags. If not set there, we try to obtain the value from
>>> the machine running the configure script. If we fail, we default to
>>> reasonable values, i.e. 128 bytes for ppc64 and 64 bytes for all others.
> (snip)
>> Is there any reason not to use sysconf(_SC_LEVEL1_DCACHE_LINESIZE)?
> 
> I tried using sysconf, but it doesn't work on the PowerPC machine I have
> access to (it returns 0). It might be a machine-specific thing though-I
> don't know. Here's the machine's `uname -a':
>    Linux gcc2-power8.osuosl.org 3.10.0-514.10.2.el7.ppc64le #1 SMP Fri Mar \
>      3 16:16:38 GMT 2017 ppc64le ppc64le ppc64le GNU/Linux

Well that's unfortunate.

Doing some digging, the kernel has provided the info to userland via elf auxv 
data since the beginning of time (aka initial git repository build), but glibc 
still does not export that information properly for ppc.

For ppc, you can get what we want from qemu_getauxval(AT_ICACHEBSIZE).  Indeed, 
we already have 4 different system dependent methods for determining the icache 
size in tcg/ppc/tcg-target.inc.c.

So what I think we ought to do is create a new util/cachesize.c like so:

unsigned qemu_icache_linesize = 64;
unsigned qemu_dcache_linesize = 64;

static void init_icache_data(void)
{
#ifdef _SC_LEVEL1_ICACHE_LINESIZE
     {
         long x = sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
         if (x > 0) {
             qemu_icache_linesize = x;
             return;
         }
     }
#endif
#ifdef AT_ICACHEBSIZE
     {
         unsigned long x = qemu_getauxval(AT_ICACHEBSIZE);
         if (x > 0) {
             qemu_icache_linesize = x;
             return;
         }
     }
#endif
     // Other system specific methods.
}

static void init_dcache_data(void)
{
     // Similarly.
}

static void __attribute__((constructor)) init_cache_data(void)
{
     init_icache_data();
     init_dcache_data();
}

In particular, I think you want to be padding to the icache linesize rather 
than the dcache linesize since what we're attempting is to avoid writable data 
in the icache.


r~
