Received: from eggs.gnu.org ([2001:4830:134:3::10]:34586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rnsastry@imap.linux.ibm.com>) id 1ejgRj-0001Vo-4h
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 02:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rnsastry@imap.linux.ibm.com>) id 1ejgRf-0008QV-Tg
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 02:16:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43426
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rnsastry@imap.linux.ibm.com>)
	id 1ejgRf-0008Q4-Mc
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 02:16:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w185TE1I078668
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 00:33:38 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g0deqdnqa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 00:33:37 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <rnsastry@imap.linux.ibm.com>;
	Thu, 8 Feb 2018 05:33:36 -0000
From: Nageswara Sastry <rnsastry@imap.linux.ibm.com>
In-Reply-To: <381c5681-a194-6750-06ac-7afeda9173f7@vivier.eu>
Date: Thu, 8 Feb 2018 11:03:13 +0530
References: <151799695576.147.5866177190489987115@bdbb90650ae5>
	<381c5681-a194-6750-06ac-7afeda9173f7@vivier.eu>
Message-Id: <FFA2938F-36E4-4980-9DE0-7F8631C132EA@imap.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, rnsastry@linux.vnet.ibm.com, Peter Maydell <peter.maydell@linaro.org>

     On 07-Feb-2018, at 7:27 PM, Laurent Vivier <laurent@vivier.eu>
     wrote:
     Le 07/02/2018 Ã  10:49, no-reply@patchew.org a Ã©crit :

     Hi,
     This series failed build test on s390x host. Please find the details
     below.

     ...

     CC      aarch64_be-linux-user/linux-user/syscall.o
     In file included from
     /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/qemu.h:16:0,
                    from
     /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c:118:
     /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c: In
     function â€˜do_sendrecvmsg_lockedâ€™:
     /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall_defs.h:3
     08:61: error: â€˜tgt_lenâ€™ may be used uninitialized in this
     function [-Werror=maybe-uninitialized]
     #define TARGET_CMSG_LEN(len) (sizeof(struct target_cmsghdr) + (len))
                                                                ^
     /var/tmp/patchew-tester-tmp-ewjgn083/src/linux-user/syscall.c:1797:1
     3: note: â€˜tgt_lenâ€™ was declared here
            int tgt_len, tgt_space;
                ^~~~~~~

     it seems gcc disagrees with Coverity...
     I think this should fixed like:
     diff --git a/linux-user/syscall.c b/linux-user/syscall.c
     index 74378947f0..d7fbe334eb 100644
     --- a/linux-user/syscall.c
     +++ b/linux-user/syscall.c
     @@ -1824,8 +1824,10 @@ static inline abi_long
     host_to_target_cmsg(struct
     target_msghdr *target_msgh,
                    tgt_len = sizeof(struct target_timeval);
                    break;
                default:
     +                tgt_len = len;

   In my view this will result in assigning a wrong value to â€˜tgt_lenâ€™
   at this â€˜switch-caseâ€™ condition.
   Instead looking at the option of initializing â€˜tgt_len' to â€˜0â€™.
   @@ -1789,7 +1789,7 @@
           void *target_data = TARGET_CMSG_DATA(target_cmsg);
           int len = cmsg->cmsg_len - sizeof(struct cmsghdr);
   -        int tgt_len, tgt_space;
   +        int tgt_len = 0, tgt_space;
           /* We never copy a half-header but may copy half-data;
            * this is Linux's behaviour in put_cmsg(). Note that
   @@ -1821,6 +1821,7 @@
               default:
                   break;
               }
   +        break;
           default:
               tgt_len = len;
               break;

                    break;
                }
     +            break;
            default:
                tgt_len = len;
                break;
     Peter?
     Thanks,
     Laurent
