Received: from eggs.gnu.org ([2001:4830:134:3::10]:52382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssIJ-0000RL-M8
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssII-0003TB-RH
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:17:11 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fssII-0003QP-JP
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:17:10 -0400
Received: by mail-oi0-x241.google.com with SMTP id m11-v6so10274255oic.2
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:17:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180823133540.12973-1-pbonzini@redhat.com>
References: <20180823133540.12973-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 17:16:49 +0100
Message-ID: <CAFEAcA_GidqNpjz+xV0Rix7YbZToZT8t+=dQ-+UxBLo3cbbfMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/69] Misc patches for 2018-08-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 August 2018 at 14:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 659b11e7a7239529cfdb4968418268ff9aa22d88:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-08-21 11:36:15 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f1d7650ffbcbbc3307b299d54a8c535023602175:
>
>   KVM: cleanup unnecessary #ifdef KVM_CAP_... (2018-08-23 13:32:50 +0200)
>
> Four more patches gone...

New compile warning on NetBSD:

tests/libqtest.c: In function 'qtest_is_old_versioned_machine':
tests/libqtest.c:1019:13: warning: array subscript has type 'char'
[-Wchar-subscripts]
             if (!isdigit(*chr) && *chr != '.') {
             ^

Code should be using qemu_isdigit(). We don't enforce -Werror
on NetBSD, though, so we could let this through and fix it up
later...

Test failure on x86-64 Linux (debug build):


MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
gtester -k --verbose -m=qui
ck tests/test-replication
TEST: tests/test-replication... (pid=6535)
  /replication/primary/read:                                           OK
  /replication/primary/write:                                          OK
  /replication/primary/start:                                          OK
  /replication/primary/stop:                                           OK
  /replication/primary/do_checkpoint:                                  OK
  /replication/primary/get_error_all:                                  OK
  /replication/secondary/read:                                         OK
  /replication/secondary/write:                                        OK
  /replication/secondary/start:                                        **
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-replication.c:120:test_blk_write:
assertion failed: (async_ret == 0)
FAIL
GTester: last random seed: R02Sb173bafaddab398fce3309452c295220
(pid=6688)
  /replication/secondary/stop:                                         OK
  /replication/secondary/do_checkpoint:                                OK
  /replication/secondary/get_error_all:                                OK
FAIL: tests/test-replication

I'm just checking whether that fails consistently or if it's a random/
intermittent.

thanks
-- PMM
