Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyzwa-0002i8-Eo
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyzwV-00033e-Ma
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:07:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyzwV-00033N-GG
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:07:43 -0400
References: <20180322034753.6301-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df8ac9bf-0239-ba4c-bbe4-d79d73c7ad50@redhat.com>
Date: Thu, 22 Mar 2018 08:07:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180322034753.6301-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: Fix ubuntu.i386 image initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 03/21/2018 10:47 PM, Fam Zheng wrote:
> The apt-get commands we run through ssh expect certain features of the
> tty, and refuses to work if /dev/null is used. It is ugly, but easy to
> satisfy.
> 
> Actually, there is no reason to hide the output. It just makes things
> harder to diagnose. We can always redirect in the Makefile, so don't do
> it conditionally here.
> 
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   tests/vm/basevm.py | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)


This got the .img initialization a lot further, although the log still 
shows that there is still a communication glitch early on:

...
Reading package lists...
Building dependency tree...
Reading state information...
The following NEW packages will be installed:
   cloud-initramfs-growroot
0 upgraded, 1 newly installed, 0 to remove and 25 not upgraded.
Need to get 5,570 B of archives.
After this operation, 23.6 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu xenial-updates/universe i386 
cloud-initramfs-growroot all 0.27ubuntu1.5 [5,570 B]
debconf: unable to initialize frontend: Dialog
debconf: (TERM is not set, so the dialog frontend is not usable.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (This frontend requires a controlling tty.)
debconf: falling back to frontend: Teletype
dpkg-preconfigure: unable to re-open stdin:
Fetched 5,570 B in 1s (4,554 B/s)
Selecting previously unselected package cloud-initramfs-growroot.
...
Building dependency tree...
Reading state information...
The following NEW packages will be installed:
   acpica-tools autotools-dev binutils build-essential cpp cpp-5 debhelper
   device-tree-compiler dh-strip-nondeterminism dpkg-dev g++ g++-5 gcc gcc-5
...


But despite that glitch, the subsequent package updates succeeded, and 
the VM eventually progressed to compiling qemu instead of dying early.  So

Tested-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
