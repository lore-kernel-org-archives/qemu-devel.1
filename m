Received: from eggs.gnu.org ([2001:4830:134:3::10]:32924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbZ1B-0007Zr-6s
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 15:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbZ18-0001vy-26
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 15:39:09 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbZ17-0001vo-St
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 15:39:06 -0500
Received: by mail-it0-x241.google.com with SMTP id o185so51425itb.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 12:39:04 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
	<39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
	<20170126131229.GB16014@lianli.shorne-pla.net>
	<ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
	<20170201100423.GE21641@lianli.shorne-pla.net>
	<d3dac109-ad39-8bb9-2012-f7a6824139eb@twiddle.net>
	<20170208140120.GI32144@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4482270c-66f0-3338-0fa0-ed292f80a508@twiddle.net>
Date: Wed, 8 Feb 2017 12:38:56 -0800
MIME-Version: 1.0
In-Reply-To: <20170208140120.GI32144@lianli.shorne-pla.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org, Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org

On 02/08/2017 06:01 AM, Stafford Horne wrote:
> On Mon, Feb 06, 2017 at 09:53:26PM -0800, Richard Henderson wrote:
>> On 02/01/2017 02:04 AM, Stafford Horne wrote:
>>> For kernel builds I have created toolchain binaries here:
>>>
>>>   http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/
>>>
>>> These should work.
>>
>> This gdb crashes on the first "stepi" that I issue.  To reproduce,
>>
>> $ cat z.c
>> int main() { return 0; }
>> $ or1k-musl-linux-gcc -g z.c
>> $ qemu-or32 -g 10001 ./a.out
>>
>> // another window
>>
>> $ or1k-musl-linux-gdb ./a.out
>> (gdb) target remote localhost:10001
>> // should see that the pc is at _start
>> (gdb) stepi
>> // crash
>>
>> I won't be able to debug this myself until I can build my own gdb.
>
> Hello,
>
> The gdb branch I use is the following, it is tracking very close to
> upsstream:
>
>   git@github.com:stffrdhrn/binutils-gdb.git or1k-upstream
>
> I have sent this for review to the gdb list and currently waiting on
> comments for version 4.  Most of the code is the same as in openrisc
> github. However, I have just rebased and cleaned up for upstreaming.

Thanks.  I can confirm that I have no problems building this branch.

> However, when debugging I ran into a few errors.
>
>   1. qemu aborts the program and sends SIGILL to gdb, this is caused by
>      the openrisc loop in linux-user missing handlers for EXCP_INTERRUPT
>      and EXCP_DEBUG, I patched that see below:

Yes, I fixed that on my or1k branch Monday.


r~
