Received: from eggs.gnu.org ([2001:4830:134:3::10]:37530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDiQt-0004r0-TL
	for qemu-devel@nongnu.org; Tue, 01 May 2018 23:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDiQq-0006fs-O2
	for qemu-devel@nongnu.org; Tue, 01 May 2018 23:27:55 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:44797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDiQq-0006eg-Bi
	for qemu-devel@nongnu.org; Tue, 01 May 2018 23:27:52 -0400
Received: by mail-pg0-x241.google.com with SMTP id 82-v6so9589800pge.11
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 20:27:52 -0700 (PDT)
References: <20180501235332.31245-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <573362f2-a00c-0bf6-59e2-6dd4aa143e16@linaro.org>
Date: Tue, 1 May 2018 20:27:46 -0700
MIME-Version: 1.0
In-Reply-To: <20180501235332.31245-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: remove useless padding in
 flock64 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 05/01/2018 04:53 PM, Laurent Vivier wrote:
> Since commit 8efb2ed5ec ("linux-user: Correct signedness of
> target_flock l_start and l_len fields"), flock64 structure uses
> abi_llong for l_start and l_len in place of "unsigned long long"
> this should force them to be aligned accordingly to the target
> rules. So we can remove the padding field and the QEMU_PACKED
> attribute.
> 
> I have compared the result of the following program before and
> after the change:
> 
>     cat -> flock64_dump  <<EOF
>     p/d sizeof(struct target_flock64)
>     p/d &((struct target_flock64 *)0)->l_type
>     p/d &((struct target_flock64 *)0)->l_whence
>     p/d &((struct target_flock64 *)0)->l_start
>     p/d &((struct target_flock64 *)0)->l_len
>     p/d &((struct target_flock64 *)0)->l_pid
>     quit
>     EOF
> 
>     for file in build/all/*-linux-user/qemu-* ; do
>     echo $file
>     gdb -batch -nx -x flock64_dump $file 2> /dev/null
>     done
> 
> The sizeof() changes because we remove the QEMU_PACKED.
> The new size is 32 (except for i386 and m68k) and this is
> the real size of "struct flock64" on the target architecture.
> 
> The following architectures differ:
> aarch64_be, aarch64, alpha, armeb, arm, cris, hppa, nios2, or1k,
> riscv32, riscv64, s390x.
> 
> For a subset of these architectures, I have checked with the following
> program the new structure is the correct one:
> 
>   #include <stdio.h>
>   #define __USE_LARGEFILE64
>   #include <fcntl.h>
> 
>   int main(void)
>   {
> 	  printf("struct flock64 %d\n", sizeof(struct flock64));
> 	  printf("l_type %d\n", &((struct flock64 *)0)->l_type);
> 	  printf("l_whence %d\n", &((struct flock64 *)0)->l_whence);
> 	  printf("l_start %d\n", &((struct flock64 *)0)->l_start);
> 	  printf("l_len %d\n", &((struct flock64 *)0)->l_len);
> 	  printf("l_pid %d\n", &((struct flock64 *)0)->l_pid);
>   }
> 
> [I have checked aarch64, alpha, arm, s390x]
> 
> I have also fixed the alignment value for sh4 (to align llong on 4 bytes)
> (see c2e3dee6e0 "linux-user: Define target alignment size")

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
