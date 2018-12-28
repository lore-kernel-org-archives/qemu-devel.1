Received: from eggs.gnu.org ([208.118.235.92]:49986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1gcqyw-00008i-3L
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 07:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1gcqhj-0001EN-NN
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 06:53:30 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:33289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <adhemerval.zanella@linaro.org>)
	id 1gcqhj-0001CZ-6n
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 06:53:27 -0500
Received: by mail-qt1-x843.google.com with SMTP id l11so23155423qtp.0
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 03:53:27 -0800 (PST)
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
	<957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org>
	<87pntmu9iw.fsf@mid.deneb.enyo.de>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <ae0530c9-5c46-5560-9734-1eacaf173b8d@linaro.org>
Date: Fri, 28 Dec 2018 09:53:21 -0200
MIME-Version: 1.0
In-Reply-To: <87pntmu9iw.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org, qemu-devel@nongnu.org, ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de



On 27/12/2018 16:09, Florian Weimer wrote:
> * Adhemerval Zanella:
> 
>> Also for glibc standpoint, although reverting it back to use getdents 
>> syscall for non-LFS mode might fix this issue for architectures that
>> provides non-LFS getdents syscall it won't be a fix for architectures 
>> that still provides off_t different than off64_t *and* only provides 
>> getdents64 syscall.
>>
>> Currently we only have nios2 and csky (unfortunately).  But since generic 
>> definition for off_t and off64_t still assumes non-LFS support, all new
>> 32-bits ports potentially might carry the issue.
> 
> For csky, we could still change the type of the non-standard d_off
> field to long long int.  This way, only telldir would have to fail
> when truncation is necessary, as mentioned below:

I think it makes no sense to continue making non-LFS as default for
newer 32 bits ports, the support will be emulated with LFS syscalls.
