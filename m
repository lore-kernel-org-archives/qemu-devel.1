Received: from eggs.gnu.org ([2001:4830:134:3::10]:44043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZIt1-0000nj-5x
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZIsw-0003H9-2r
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:05:55 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:36137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eZIsv-0003FR-O8
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:05:50 -0500
Date: Wed, 10 Jan 2018 17:05:33 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180110160533.vev76nkox3wkqaqv@var.youpi.perso.aquilenet.fr>
References: <20171228150038.16450-1-samuel.thibault@ens-lyon.org>
	<ae60a724-48bc-b39e-8082-c1ee618ed5da@vivier.eu>
	<a125dd5e-e1a4-348b-63fc-55ce34f4a944@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a125dd5e-e1a4-348b-63fc-55ce34f4a944@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add getcpu() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Laurent Vivier, on mer. 10 janv. 2018 16:53:47 +0100, wrote:
> Le 28/12/2017 à 18:39, Laurent Vivier a écrit :
> > Le 28/12/2017 à 16:00, Samuel Thibault a écrit :
> >> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> >> ---
> >>  linux-user/syscall.c | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> >> index 8ec7de96ce..bb8cb726f5 100644
> >> --- a/linux-user/syscall.c
> >> +++ b/linux-user/syscall.c
> >> @@ -296,6 +296,8 @@ _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
> >>  #define __NR_sys_sched_setaffinity __NR_sched_setaffinity
> >>  _syscall3(int, sys_sched_setaffinity, pid_t, pid, unsigned int, len,
> >>            unsigned long *, user_mask_ptr);
> >> +#define __NR_sys_getcpu __NR_getcpu
> >> +_syscall3(int, sys_getcpu, unsigned *, cpu, unsigned *, node, void *, tcache);
> >>  _syscall4(int, reboot, int, magic1, int, magic2, unsigned int, cmd,
> >>            void *, arg);
> >>  _syscall2(int, capget, struct __user_cap_header_struct *, header,
> >> @@ -10443,6 +10445,20 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
> >>              ret = get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
> >>          }
> >>          break> +    case TARGET_NR_getcpu:
> >> +        {
> >> +            unsigned cpu, node;
> >> +            ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL,
> >> +                                       arg2 ? &node : NULL,
> >> +                                       NULL));
> >> +            if (arg1) {
> >> +                put_user(cpu, arg1, abi_uint);
> >> +            }
> >> +            if (arg2) {
> >> +                put_user(node, arg2, abi_uint);
> >> +            }
> > 
> > You must check for EFAULT.
> > 
> >     if (arg1 && put_user_u32(cpu, arg1)) {
> >         goto efault;
> >     }
> > ...
> > 
> > I don't think you need to use the abi_uint type as we are using
> > put_user_u32() for all the other syscalls for unsigned int.
> 
> could you send an updated version of your patch?

Oops, I had missed that mail. Will work on it.

Samuel
