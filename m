Received: from eggs.gnu.org ([2001:4830:134:3::10]:54517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ef8uQ-00075T-Ve
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ef8uQ-00076U-4z
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:39:31 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:33974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ef8uP-00075Q-Sb
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:39:30 -0500
Date: Fri, 26 Jan 2018 19:33:56 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180126183356.oqpisqgce5zmrhno@var.youpi.perso.aquilenet.fr>
References: <20180123144807.5618-1-laurent@vivier.eu>
	<20180123144807.5618-8-laurent@vivier.eu>
	<CAFEAcA-fs-gez_6atAue58z9V2y_DCqMVsWZR0cOyL+Nio49YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-fs-gez_6atAue58z9V2y_DCqMVsWZR0cOyL+Nio49YA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 07/13] linux-user: Fix sched_get/setaffinity
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell, on ven. 26 janv. 2018 18:23:02 +0000, wrote:
> On 23 January 2018 at 14:48, Laurent Vivier <laurent@vivier.eu> wrote:
> > From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> >
> > sched_get/setaffinity linux-user syscalls were missing conversions for
> > little/big endian, which is hairy since longs may not be the same size
> > either.
> >
> > For simplicity, this just introduces loops to convert bit by bit like is
> > done for select.
> >
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> > Message-Id: <20180109201643.1479-1-samuel.thibault@ens-lyon.org>
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > ---
> 
> > @@ -10395,9 +10463,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
> >                      ret = arg2;
> >                  }
> >
> > -                if (copy_to_user(arg3, mask, ret)) {
> > -                    goto efault;
> > -                }
> > +                ret = host_to_target_cpu_mask(mask, mask_size, arg3, arg2);
> >              }
> >          }
> >          break;
> 
> Hi -- Coverity spots that in this change, we now have a case
> where we set "ret = arg2;" which then immediately is replaced
> by "ret = host_to_target_cpu_mask(mask, mask_size, arg3, arg2);",
> making the first assignment pointless.
> 
> It looks like we're now ignoring the host filled buffer size
> that is returned by sys_sched_getaffinity() and then adjusted
> by this bit of code. Shouldn't we be using that value in this
> new host_to_target_cpu_mask() code?

Indeed, will send a patch against this.

Samuel
