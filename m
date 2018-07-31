Received: from eggs.gnu.org ([2001:4830:134:3::10]:57158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkRtb-0001Ha-AW
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkRtX-0007G5-At
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:28:51 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkRtX-0007Fw-0b
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:28:47 -0400
Received: by mail-ua0-x243.google.com with SMTP id r10-v6so9913340uao.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 03:28:46 -0700 (PDT)
References: <20180730220831.390182-1-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4c563a59-8e26-90ca-5bfb-30e8604ad865@linaro.org>
Date: Tue, 31 Jul 2018 06:28:41 -0400
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
Cc: thuth@redhat.com, armbru@redhat.com, mst@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org, f4bug@amsat.org

On 07/30/2018 06:08 PM, Eric Blake wrote:
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
> 
> ---
> v3: use TFR() instead of open-coding the retry loop [Thomas]
> ---
>  tests/libqtest.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
