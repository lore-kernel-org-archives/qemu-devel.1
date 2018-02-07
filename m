Received: from eggs.gnu.org ([2001:4830:134:3::10]:49667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ejQDo-0007d7-EM
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ejQDl-0008NB-DH
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:57:12 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:57590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ejQDl-0008Lg-3I
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:57:09 -0500
References: <151799695576.147.5866177190489987115@bdbb90650ae5>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <381c5681-a194-6750-06ac-7afeda9173f7@vivier.eu>
Date: Wed, 7 Feb 2018 14:57:02 +0100
MIME-Version: 1.0
In-Reply-To: <151799695576.147.5866177190489987115@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [patch] linux-user/syscall.c: Fix missing break
 for host_to_target_cmsg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, rnsastry@linux.vnet.ibm.com, Peter Maydell <peter.maydell@linaro.org>

Le 07/02/2018 à 10:49, no-reply@patchew.org a écrit :
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
...
>   CC      aarch64_be-linux-user/linux-user/syscall.o
> In file included from /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/qemu.h:16:0,
>                  from /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c:118:
> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c: In function ‘do_sendrecvmsg_locked’:
> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall_defs.h:308:61: error: ‘tgt_len’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>  #define TARGET_CMSG_LEN(len) (sizeof(struct target_cmsghdr) + (len))
>                                                              ^
> /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c:1797:13: note: ‘tgt_len’ was declared here
>          int tgt_len, tgt_space;
>              ^~~~~~~

it seems gcc disagrees with Coverity...

I think this should fixed like:

 diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 74378947f0..d7fbe334eb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1824,8 +1824,10 @@ static inline abi_long host_to_target_cmsg(struct
target_msghdr *target_msgh,
                 tgt_len = sizeof(struct target_timeval);
                 break;
             default:
+                tgt_len = len;
                 break;
             }
+            break;
         default:
             tgt_len = len;
             break;

Peter?

Thanks,
Laurent
