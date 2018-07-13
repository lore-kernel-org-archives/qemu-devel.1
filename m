Received: from eggs.gnu.org ([2001:4830:134:3::10]:34457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fdxKY-0003Fl-0i
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fdxKT-00046Z-2r
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:37:50 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fdxKS-000460-Mn
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:37:44 -0400
References: <153148521235.87746.14142430397318741182.stgit@lep8c.aus.stglabs.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9c423f84-8a79-c55f-8adf-f901cf3a613a@vivier.eu>
Date: Fri, 13 Jul 2018 14:37:29 +0200
MIME-Version: 1.0
In-Reply-To: <153148521235.87746.14142430397318741182.stgit@lep8c.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: ppc64: use the correct
 values for F_*LK64s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, riku.voipio@iki.fi
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Le 13/07/2018 à 14:34, Shivaprasad G Bhat a écrit :
> Qemu includes the glibc headers for the host defines and target headers are
> part of the qemu source themselves. The glibc has the F_GETLK64, F_SETLK64
> and F_SETLKW64 defined to 12, 13 and 14 for all archs in
> sysdeps/unix/sysv/linux/bits/fcntl-linux.h. The linux kernel generic
> definition for F_*LK is 5, 6 & 7 and F_*LK64* is 12,13, and 14 as seen in
> include/uapi/asm-generic/fcntl.h. On 64bit machine, by default the kernel
> assumes all F_*LK to 64bit calls and doesnt support use of F_*LK64* as
> can be seen in include/linux/fcntl.h in linux source.
> 
> On x86_64 host, the values for F_*LK64* are set to 5, 6 and 7
> explicitly in /usr/include/x86_64-linux-gnu/bits/fcntl.h by the glibc.
> Whereas, a PPC64 host doesn't have such a definition in
> /usr/include/powerpc64le-linux-gnu/bits/fcntl.h by the glibc. So,
> the sources on PPC64 host sees the default value of F_*LK64*
> as 12, 13 & 14(fcntl-linux.h).
> 
> Since the 64bit kernel doesnt support 12, 13 & 14; the glibc fcntl syscall
> implementation(__libc_fcntl*(), __fcntl64_nocancel) does the F_*LK64* value
> convertion back to F_*LK* values on PPC64 as seen in
> sysdeps/unix/sysv/linux/powerpc/powerpc64/sysdep.h with FCNTL_ADJUST_CMD()
> macro. Whereas on x86_64 host the values for F_*LK64* are set to 5, 6 and 7
> and no adjustments are needed.
> 
> Since qemu doesnt use the glibc fcntl, but makes the safe_syscall* on its
> own, the PPC64 qemu is calling the syscall with 12, 13, and 14(without
> adjustment) and they all fail. The fcntl calls to F_GETLK/F_SETLK|W all
> fail by all pplications run on PPC64 host user emulation.
> 
> The fix here could be to see why on PPC64 the glibc is still keeping
> F_*LK64* different from F_*LK and why adjusting them to 5, 6 and 7 before
> the syscall for PPC only. See if we can make the
> /usr/include/powerpc64le-linux-gnu/bits/fcntl.h to have the values
> 5, 6 & 7 just like x86_64 and remove the adjustment code in glibc. That
> way, qemu sources see the kernel supported values in glibc headers.
> 
> OR
> 
> On PPC64 host, qemu sources see both F_*LK & F_*LK64* as same and set to
> 12, 13 and 14 because __USE_FILE_OFFSET64 is defined in qemu
> sources(also refer sysdeps/unix/sysv/linux/bits/fcntl-linux.h).
> Do the value adjustment just like it is done by glibc source by using
> F_GETLK value of 5. That way, we make the syscalls with the actual
> supported values in Qemu. The patch is taking this approach.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
> ---
>  v3 - https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg02923.html
>  Changes from v3:
>     - Fixed the tabs for case statements
>     - Addressed the comments on v3 wrt to the variable initialisation
>       and break from default case.
>  v2 - https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg02920.html
>  Changes from v2:
>     - Fixed the braces, and indentation for comments.
>  v1 - https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg02567.html
>  Changes from v1:
>     - Changed the overwrite of F*LK64* with 5, 6 and 7 in using #define
>       instead using the adjustment code similar to glibc as suggested.
>     - Dropped __linux__ check for the adjustment code as suggested.
>     - Moved the adjustment code inside target_to_host_fcntl_cmd to address
>       all possible|future cases.
> 
>  linux-user/syscall.c |  126 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 80 insertions(+), 46 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
