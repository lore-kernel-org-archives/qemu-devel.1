Received: from eggs.gnu.org ([209.51.188.92]:37320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGRpZ-0004W3-QL
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGRpY-0007jX-Q3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:25:13 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hGRpY-0007hx-GA
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:25:12 -0400
Received: by mail-wr1-f42.google.com with SMTP id q1so28236751wrp.0
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:25:11 -0700 (PDT)
References: <20190416083150.19649-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e16e0501-fe91-9cf6-efd8-eb5696fb26fb@redhat.com>
Date: Tue, 16 Apr 2019 19:25:09 +0200
MIME-Version: 1.0
In-Reply-To: <20190416083150.19649-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg: Fix launchpad 1824853
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 1824853@bugs.launchpad.net

On 4/16/19 10:31 AM, Richard Henderson wrote:
> This is a case where we generate more than 64k code for a mere 231
> guest instructions.  This hits some assertions within TCG that we're
> not overflowing the uint16_t that we use for representing our
> unwind info.
> 
> Fix this by returning an error indication, rather than asserting.
> This lets us try again from tb_gen_code with a lower max_insns.
> 
> This should resolve the problem for x86 as a host.  There are other
> failure modes wrt out-of-range relocations that might affect the
> RISC hosts.  I'm going to leave those for a different patch set.

Very clean way to solve this. Nice cleanup in patch #1 (interesting
Nios2 case), Simple fix in patch #2. It would be fun to trigger the
assert(max_insns > 1) =)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Richard Henderson (2):
>   tcg: Hoist max_insns computation to tb_gen_code
>   tcg: Restart after TB code generation overflow
> 
>  include/exec/exec-all.h       |  4 +--
>  include/exec/translator.h     |  3 +-
>  accel/tcg/translate-all.c     | 54 +++++++++++++++++++++++++++++------
>  accel/tcg/translator.c        | 15 ++--------
>  target/alpha/translate.c      |  4 +--
>  target/arm/translate.c        |  4 +--
>  target/cris/translate.c       | 10 +------
>  target/hppa/translate.c       |  5 ++--
>  target/i386/translate.c       |  4 +--
>  target/lm32/translate.c       | 10 +------
>  target/m68k/translate.c       |  4 +--
>  target/microblaze/translate.c | 10 +------
>  target/mips/translate.c       |  4 +--
>  target/moxie/translate.c      | 11 ++-----
>  target/nios2/translate.c      | 14 ++-------
>  target/openrisc/translate.c   |  4 +--
>  target/ppc/translate.c        |  4 +--
>  target/riscv/translate.c      |  4 +--
>  target/s390x/translate.c      |  4 +--
>  target/sh4/translate.c        |  4 +--
>  target/sparc/translate.c      |  4 +--
>  target/tilegx/translate.c     | 12 +-------
>  target/tricore/translate.c    | 16 ++---------
>  target/unicore32/translate.c  | 10 +------
>  target/xtensa/translate.c     |  4 +--
>  tcg/tcg.c                     |  4 +++
>  26 files changed, 93 insertions(+), 133 deletions(-)
> 
