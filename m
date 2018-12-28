Received: from eggs.gnu.org ([208.118.235.92]:53019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1gcrKs-0005El-9W
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 07:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1gcr8X-0007EQ-V3
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 07:21:14 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:45304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <adhemerval.zanella@linaro.org>)
	id 1gcr8X-0007Cx-LJ
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 07:21:09 -0500
Received: by mail-qk1-x744.google.com with SMTP id y78so12437447qka.12
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 04:21:09 -0800 (PST)
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
	<957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org>
	<87pntmu9iw.fsf@mid.deneb.enyo.de>
	<ae0530c9-5c46-5560-9734-1eacaf173b8d@linaro.org>
	<87k1jtvp8u.fsf@mid.deneb.enyo.de> <87ftuhvp08.fsf@mid.deneb.enyo.de>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <4ee7419d-6537-8683-bf40-175cbdc6b484@linaro.org>
Date: Fri, 28 Dec 2018 10:21:03 -0200
MIME-Version: 1.0
In-Reply-To: <87ftuhvp08.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org, qemu-devel@nongnu.org, ericvh@gmail.com, lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de



On 28/12/2018 10:01, Florian Weimer wrote:
> * Florian Weimer:
> 
>> * Adhemerval Zanella:
>>
>>> On 27/12/2018 16:09, Florian Weimer wrote:
>>>> * Adhemerval Zanella:
>>>>
>>>>> Also for glibc standpoint, although reverting it back to use getdents 
>>>>> syscall for non-LFS mode might fix this issue for architectures that
>>>>> provides non-LFS getdents syscall it won't be a fix for architectures 
>>>>> that still provides off_t different than off64_t *and* only provides 
>>>>> getdents64 syscall.
>>>>>
>>>>> Currently we only have nios2 and csky (unfortunately).  But since generic 
>>>>> definition for off_t and off64_t still assumes non-LFS support, all new
>>>>> 32-bits ports potentially might carry the issue.
>>>>
>>>> For csky, we could still change the type of the non-standard d_off
>>>> field to long long int.  This way, only telldir would have to fail
>>>> when truncation is necessary, as mentioned below:
>>>
>>> I think it makes no sense to continue making non-LFS as default for
>>> newer 32 bits ports, the support will be emulated with LFS syscalls.
>>
>> Sorry, I don't see how this matters.  seekdir and telldir are NOT
>> affected by LFS.
> 
> Ah, right.  If struct dirent is 64-bit only, then the d_off member
> will be 64 bits as well.  But it is unclear whether you can use that
> with lseek (probably yes, in its 64-bit variant), and it's unlikely
> it's going to work with seekdir because of the POSIX-required long int
> type.
> 

I was referring to all other API that uses off_t as well (pread for
instance), where new ports will have non-LFS variants that will call
only LFS variants.
