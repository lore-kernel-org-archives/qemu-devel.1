Received: from eggs.gnu.org ([2001:4830:134:3::10]:57338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dfSeU-0007Kt-8f
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dfSeQ-0003Kj-9a
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:12:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:51067)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dfSeQ-0003I3-0i
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:12:02 -0400
References: <150228860899.28168.1415083032613087245.stgit@bahia>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <2a4a537f-0f26-3f5a-eaae-2e73bcef4a99@msgid.tls.msk.ru>
Date: Wed, 9 Aug 2017 18:11:51 +0300
MIME-Version: 1.0
In-Reply-To: <150228860899.28168.1415083032613087245.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.10 PATCH v2] 9pfs: local: fix
 fchmodat_nofollow() limitations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: zhiyong.wu@ucloud.cn, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

09.08.2017 17:23, Greg Kurz wrote:
> This function has to ensure it doesn't follow a symlink that could be used
> to escape the virtfs directory. This could be easily achieved if fchmodat()
> on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, but
> it doesn't.
> 
> The current implementation covers most use-cases, but it notably fails if:
> - the target path has access rights equal to 0000 (openat() returns EPERM),
>   => once you've done chmod(0000) on a file, you can never chmod() again
> - the target path is UNIX domain socket (openat() returns ENXIO)
>   => bind() of UNIX domain sockets fails if the file is on 9pfs
> 
> The solution is to use O_PATH: openat() now succeeds in both cases, and we
> can ensure the path isn't a symlink with fstat(). The associated entry in
> "/proc/self/fd" can hence be safely passed to the regular chmod() syscall.

How we can ensure the path isn't a symlink using fstat() ?

As far as I understand, fstat NEVER, EVER will return S_ISLINK, because
we can't actually "open" a symlink itsef, only the target of the symlink.

/mjt
