Received: from eggs.gnu.org ([2001:4830:134:3::10]:52797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dezPV-0001NJ-Ri
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dezPS-0003Mm-RY
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:58:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:34627)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dezPS-0003Jz-Ig
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:58:38 -0400
References: <149735886140.10189.12243168169281704231.reportbug@dawn124>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <fced5512-4fb1-00ba-0984-f011c0aebd09@msgid.tls.msk.ru>
Date: Tue, 8 Aug 2017 10:58:29 +0300
MIME-Version: 1.0
In-Reply-To: <149735886140.10189.12243168169281704231.reportbug@dawn124>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Bug#864718: fsdev emulation security_model=none
 not handling mode 000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sjoerd Simons <sjoerd@debian.org>, 864718@bugs.debian.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

I'm forwarding this upstream.
It looks like the same issue is present in 2.10-tobe.

13.06.2017 16:01, Sjoerd Simons wrote:
> Package: qemu-system
> Version: 1:2.8+dfsg-6
> Severity: normal
> 
> Hey,
> 
> For $reasons i'm exposing /boot over a filesystem share with the host system,
> fsdev is setup as followed on the qemu command line:
>   -fsdev local,security_model=none,id=fsdev-fs0,path=/srv/mp30-ar1-cbg-0-armhf-0-boot
> 
> Unfortunately trying to install a kernel shows dpkg getting unhappy:
> 
> [pid 26686] open("/boot/System.map-4.9.0-3-armmp-lpae.dpkg-new",
>   O_WRONLY|O_CREAT|O_EXCL|O_LARGEFILE, 000) = -1 EACCES (Permission denied)
> 
> I suspect mode 000 is confusing everything here. A similarish issue can be seen
> when changing a file to mode 000 by hand:
> 
> # touch badger
> # ls -l badger
> -rw-r--r-- 1 64055 64055 0 Jun 13 13:58 badger
> # chmod 600 badger
> # chmod 700 badger
> # chmod 000 badger
> # chmod 700 badger
> chmod: changing permissions of 'badger': Permission denied
> 
> Iotw as soon as the mode is 000 any later permission changes fail.
> 
> -- System Information:
> Debian Release: 9.0
>   APT prefers unstable-debug
>   APT policy: (500, 'unstable-debug'), (500, 'unstable'), (500, 'testing'), (500, 'stable'), (1, 'experimental')
> Architecture: amd64 (x86_64)
> Foreign Architectures: i386, armhf, arm64
> 
> Kernel: Linux 4.9.0-3-amd64 (SMP w/4 CPU cores)
> Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8), LANGUAGE=en_US:en (charmap=UTF-8)
> Shell: /bin/sh linked to /usr/bin/dash
> Init: systemd (via /run/systemd/system)
> 
> Versions of packages qemu-system depends on:
> ii  qemu-system-arm    1:2.8+dfsg-6
> ii  qemu-system-mips   1:2.8+dfsg-6
> ii  qemu-system-misc   1:2.8+dfsg-6
> ii  qemu-system-ppc    1:2.8+dfsg-6
> ii  qemu-system-sparc  1:2.8+dfsg-6
> ii  qemu-system-x86    1:2.8+dfsg-6
> 
> qemu-system recommends no packages.
> 
> qemu-system suggests no packages.
> 
> -- no debconf information
> 
