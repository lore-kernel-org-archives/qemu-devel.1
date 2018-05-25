Received: from eggs.gnu.org ([2001:4830:134:3::10]:47817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM8e3-0003YZ-N6
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM8e2-00070q-Oo
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:04:19 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:44404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fM8e2-00070g-K4
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:04:18 -0400
Received: by mail-oi0-x243.google.com with SMTP id e80-v6so3957076oig.11
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 02:04:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180524164857.3014670-1-stefanb@linux.vnet.ibm.com>
References: <20180524164857.3014670-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 10:03:57 +0100
Message-ID: <CAFEAcA_ZkFNJTjWsi3ssB_VwJ9kDcK72UuFx6RB3riVcx+QsiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 0/4] Merge tpm 2018/05/23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 24 May 2018 at 17:48, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> This series of patches adds TPM emulator state migration support and a
> test case for testing (local) migration.
>
>    Stefan
>
>
> The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd466d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-05-22 09:43:58 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-05-23-3
>
> for you to fetch changes up to 37fa382f327405b6516e9983c1aa1ca32c726892:
>
>   test: Add test cases that use the external swtpm with CRB interface (2018-05-24 12:07:04 -0400)
>
> ----------------------------------------------------------------
> Merge tpm 2018/05/23 v3
>
> ----------------------------------------------------------------
> Stefan Berger (4):
>       tpm: extend TPM emulator with state migration support
>       tpm: extend TPM TIS with state migration support
>       docs: tpm: add VM save/restore example and troubleshooting guide
>       test: Add test cases that use the external swtpm with CRB interface

I still see compile failures on OpenBSD, I'm afraid:

In file included from /home/qemu/include/qemu/osdep.h:68:0,
                 from /home/qemu/tests/tpm-util.c:15:
/home/qemu/tests/tpm-util.c: In function 'tpm_util_swtpm_has_tpm2':
/home/qemu/tests/tpm-util.c:101:10: error: expected identifier or '('
before '&' token
     gint stdout;
          ^
/home/qemu/tests/tpm-util.c:112:43: error: lvalue required as unary '&' operand
                                     NULL, &stdout, NULL, NULL);
                                           ^
/home/qemu/tests/tpm-util.c:117:14: warning: passing argument 1 of
'read' makes integer from pointer without a cast
     n = read(stdout, buffer, sizeof(buffer) - 1);
              ^
In file included from /home/qemu/include/qemu/osdep.h:75:0,
                 from /home/qemu/tests/tpm-util.c:15:
/usr/include/unistd.h:372:10: note: expected 'int' but argument is of
type 'struct FILE *'
 ssize_t  read(int, void *, size_t)
          ^
gmake: *** [/home/qemu/rules.mak:66: tests/tpm-util.o] Error 1
gmake: Leaving directory '/home/qemu/build/all'


"stdout" is a FILE* global provided by the system headers -- you can't
reuse it for a local variable name.

thanks
-- PMM
