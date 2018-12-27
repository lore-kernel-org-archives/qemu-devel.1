Received: from eggs.gnu.org ([208.118.235.92]:40513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fw@deneb.enyo.de>) id 1gca6B-0005qL-SC
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 13:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fw@deneb.enyo.de>) id 1gca67-0000WO-Tz
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 13:09:35 -0500
Received: from albireo.enyo.de ([5.158.152.32]:54960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fw@deneb.enyo.de>) id 1gca65-0008Uq-QR
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 13:09:30 -0500
From: Florian Weimer <fw@deneb.enyo.de>
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
	<957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org>
Date: Thu, 27 Dec 2018 19:09:11 +0100
In-Reply-To: <957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org> (Adhemerval
	Zanella's message of "Thu, 27 Dec 2018 15:58:47 -0200")
Message-ID: <87pntmu9iw.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org, qemu-devel@nongnu.org, ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de

* Adhemerval Zanella:

> Also for glibc standpoint, although reverting it back to use getdents 
> syscall for non-LFS mode might fix this issue for architectures that
> provides non-LFS getdents syscall it won't be a fix for architectures 
> that still provides off_t different than off64_t *and* only provides 
> getdents64 syscall.
>
> Currently we only have nios2 and csky (unfortunately).  But since generic 
> definition for off_t and off64_t still assumes non-LFS support, all new
> 32-bits ports potentially might carry the issue.

For csky, we could still change the type of the non-standard d_off
field to long long int.  This way, only telldir would have to fail
when truncation is necessary, as mentioned below:

>> There is another annoying aspect: The standards expose d_off through
>> the telldir function, and that returns long int on all architectures
>> (not off_t, so unchanged by _FILE_OFFSET_BITS).  That's mostly a
>> userspace issue and thus needing different steps to resolve (possibly
>> standards action).
