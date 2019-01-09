Received: from eggs.gnu.org ([209.51.188.92]:54812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAVA-0005wp-JT
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 04:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAV9-0004dk-NH
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 04:50:20 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:54967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ghAV8-0004c9-44
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 04:50:19 -0500
References: <20181219042113.7364-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <97e3e369-a3f4-11a0-a678-adf9d18b1502@vivier.eu>
Date: Wed, 9 Jan 2019 10:50:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181219042113.7364-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/8] linux-user: Split do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 19/12/2018 05:21, Richard Henderson wrote:
> Version 4 was back in August:
> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03745.html
> 
> Version 5 continues the file split via inclusion.  This incorporates
> Laurent's suggestion to have a "def" file that is included twice to
> generate both SyscallDef structures and fill in syscall_table's switch.
> 
> Again, this just converts a few syscalls as proof of concept.

This series breaks on all targets LTP tests: getgroups01, pwritev02,
pwritev02_64, and fixes: semop02.

It also breaks more tests only with arm target.

I will bisect and review...

Thanks,
Laurent

> 
> 
> r~
> 
> 
> Richard Henderson (8):
>   linux-user: Setup split syscall infrastructure
>   linux-user: Split out some simple file syscalls
>   linux-user: Reduce regpairs_aligned & target_offset64 ifdefs
>   linux-user: Split out preadv, pwritev, readv, writev, pread64,
>     pwrite64
>   linux-user: Split out name_to_handle_at, open_by_handle_at
>   linux-user: Split out ipc syscalls
>   linux-user: Split out memory syscalls
>   linux-user: Split out some process syscalls
> 
>  linux-user/syscall-defs.h     |  231 +++
>  linux-user/syscall.h          |   93 ++
>  linux-user/strace.c           |  567 ++++----
>  linux-user/syscall-file.inc.c |  638 +++++++++
>  linux-user/syscall-ipc.inc.c  | 1086 ++++++++++++++
>  linux-user/syscall-mem.inc.c  |  154 ++
>  linux-user/syscall-proc.inc.c |  861 ++++++++++++
>  linux-user/syscall.c          | 2500 ++-------------------------------
>  linux-user/strace.list        |  243 ----
>  9 files changed, 3499 insertions(+), 2874 deletions(-)
>  create mode 100644 linux-user/syscall-defs.h
>  create mode 100644 linux-user/syscall.h
>  create mode 100644 linux-user/syscall-file.inc.c
>  create mode 100644 linux-user/syscall-ipc.inc.c
>  create mode 100644 linux-user/syscall-mem.inc.c
>  create mode 100644 linux-user/syscall-proc.inc.c
> 
