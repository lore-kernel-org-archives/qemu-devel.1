Received: from eggs.gnu.org ([2001:4830:134:3::10]:42094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fhhJg-0002u0-1z
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fhhJe-0004gE-EL
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:23 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fhhJd-0004fE-OD
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id f1-v6so1150330pgq.12
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 13:20:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180723193530.20891-1-eblake@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <24cc7019-57e1-b868-b503-6e6b603f3cb5@twiddle.net>
Date: Mon, 23 Jul 2018 13:20:17 -0700
MIME-Version: 1.0
In-Reply-To: <20180723193530.20891-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-3.0] tests/libqtest: Improve
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
Cc: peter.maydell@linaro.org, mst@redhat.com, alex.bennee@linaro.org, f4bug@amsat.org

On 07/23/2018 12:35 PM, Eric Blake wrote:
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
> ---
> 
> I've taken the ideas from Peter's patch:
> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg04430.html
> as well as fixing a related issue brought up last time this was touched:
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05710.html
> 
>  tests/libqtest.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
