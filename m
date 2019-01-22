Received: from eggs.gnu.org ([209.51.188.92]:45100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1glp4E-0006e6-NR
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1glopP-0003zM-Dl
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:42:29 -0500
Received: from isrv.corpit.ru ([86.62.121.231]:56395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjt@tls.msk.ru>) id 1glopL-0003hV-Ij
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:42:26 -0500
References: <154809778688.10764.12505763850198799463.reportbug@deadeye.wl.decadent.org.uk>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <16ee5e20-e61b-7242-7d80-39a06fb8fd4f@msgid.tls.msk.ru>
Date: Tue, 22 Jan 2019 08:42:13 +0300
MIME-Version: 1.0
In-Reply-To: <154809778688.10764.12505763850198799463.reportbug@deadeye.wl.decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Bug#920032: qemu-user uses wrong struct timeval on
 sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, 920032@bugs.debian.org

Forwarding to qemu-devel@.
http://bugs.debian.org/920032

Thanks!

21.01.2019 22:09, Ben Hutchings wrote:
> Package: qemu-user
> Version: 1:3.1+dfsg-2
> Severity: important
> Tags: patch
> 
> On sparc (only) Linux defines timeval::tv_usec with type int, not
> long.  However qemu-user's definition of struct target_timeval uses
> abi_long unconditionally.  This results in the syscall translation
> layer effectively multiplying tv_usec by 2**32.  All sparc syscalls
> passing non-zero values for this field fail with -EINVAL.  The
> following patch seems to fix this.
> 
> Ben.
> 
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -210,7 +210,11 @@ struct target_linger {
>   
>   struct target_timeval {
>       abi_long tv_sec;
> +#if defined (TARGET_SPARC)
> +    abi_int tv_usec;
> +#else
>       abi_long tv_usec;
> +#endif
>   };
>   
>   struct target_timespec {
> --- END ---
> 
> -- System Information:
> Debian Release: buster/sid
>    APT prefers unstable-debug
>    APT policy: (500, 'unstable-debug'), (500, 'stable-updates'), (500, 'unstable'), (500, 'testing'), (500, 'stable'), (1, 'experimental')
> Architecture: amd64 (x86_64)
> Foreign Architectures: i386
> 
> Kernel: Linux 4.19.0-1-amd64 (SMP w/4 CPU cores)
> Locale: LANG=en_GB.UTF-8, LC_CTYPE=en_GB.UTF-8 (charmap=UTF-8), LANGUAGE=en_GB.UTF-8 (charmap=UTF-8)
> Shell: /bin/sh linked to /bin/dash
> Init: systemd (via /run/systemd/system)
> LSM: AppArmor: enabled
> 
> Versions of packages qemu-user depends on:
> ii  libc6         2.28-3
> ii  libcapstone3  3.0.5-3
> ii  libgcc1       1:8.2.0-13
> ii  libglib2.0-0  2.58.1-2
> ii  libstdc++6    8.2.0-13
> ii  zlib1g        1:1.2.11.dfsg-1
> 
> Versions of packages qemu-user recommends:
> ii  qemu-user-static [qemu-user-binfmt]  1:3.1+dfsg-2
> 
> Versions of packages qemu-user suggests:
> ii  sudo  1.8.26-2
> 
> -- no debconf information
> 
