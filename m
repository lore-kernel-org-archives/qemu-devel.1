Received: from eggs.gnu.org ([2001:4830:134:3::10]:50210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhg39-0005Ft-ON
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhg36-0005Lm-M1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:59:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhg36-0005L5-7A
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:59:12 -0400
References: <20180723184752.22150-1-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <763fe1d3-e2ac-a3e6-69e7-edee07f3c578@redhat.com>
Date: Mon, 23 Jul 2018 13:59:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180723184752.22150-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] tests/libqtest: Improve
 kill_qemu() assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, patches@linaro.org

On 07/23/2018 01:47 PM, Peter Maydell wrote:
> In kill_qemu() we have an assert that checks that the QEMU process
> didn't dump core:
>              assert(!WCOREDUMP(wstatus));
> 
> Unfortunately the WCOREDUMP macro here means the resulting message
> is not very easy to comprehend on at least some systems:
> 
> ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__ (((union { __typeof(wstatus) __in; int __i; }) { .__in = (wstatus) }).__i))) & 0x80)' failed.
> 
> and it doesn't identify what signal the process took.
> 
> Instead of using a raw assert, print the information in an
> easier to understand way:
> 
> /i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() tried to terminate QEMU process but it dumped core with signal 11 (Segmentation fault)
> Aborted (core dumped)
> 
> (Of course, the really useful information would be why the QEMU
> process dumped core in the first place, but we don't have that
> by the time the test program has picked up the exit status.)

Last time we bike-shedded this, I suggested that we fix things to call 
waitpid() in a loop, and that we just assert that exit status is 0:

https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05610.html

In other words, why are we special-casing death-by-coredump, when ALL 
non-zero exit status (whether or not a core dump was involved) is 
contrary to the assumptions of the testsuite?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
