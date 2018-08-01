Received: from eggs.gnu.org ([2001:4830:134:3::10]:50506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fkm3G-0000M8-Gi
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 04:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fkm3A-0003QC-LN
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 04:00:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fkm3A-0003Q2-Fc
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 04:00:04 -0400
Reply-To: thuth@redhat.com
References: <20180730220831.390182-1-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7f16fdba-63d7-881a-4127-25eb9f231a26@redhat.com>
Date: Wed, 1 Aug 2018 09:59:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180730220831.390182-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-3.0] tests/libqtest: Improve
 kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, mst@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org, f4bug@amsat.org, rth@twiddle.net

On 07/31/2018 12:08 AM, Eric Blake wrote:
> In kill_qemu() we have an assert that checks that the QEMU process
> didn't dump core:
>             assert(!WCOREDUMP(wstatus));
> 
> Unfortunately the WCOREDUMP macro here means the resulting message
> is not very easy to comprehend on at least some systems:
> 
> ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__ (((union { __typeof(wstatus) __in; int __i; }) { .__in = (wstatus) }).__i))) & 0x80)' failed.
> 
> and it doesn't identify what signal the process took.
> 
> Furthermore, we are NOT detecting EINTR (while EINTR shouldn't be
> happening if we didn't install signal handlers, it's still better
> to always be robust), and also want to log unexpected non-zero status
> that was not accompanied by a core dump.
> 
> Instead of using a raw assert, print the information in an
> easier to understand way:
> 
> /i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() detected QEMU death with core dump from signal 11 (Segmentation fault)
> Aborted (core dumped)
> 
> (Of course, the really useful information would be why the QEMU
> process dumped core in the first place, but we don't have that
> by the time the test program has picked up the exit status.)
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
