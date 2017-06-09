Received: from eggs.gnu.org ([2001:4830:134:3::10]:58503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dJNHD-00056y-Pe
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dJNHA-0004i7-PA
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:00:47 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dJNHA-0004hy-Ih
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:00:44 -0400
Received: by mail-wr0-x231.google.com with SMTP id g76so39239932wrd.1
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 10:00:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Jun 2017 18:00:57 +0100
Message-Id: <20170609170100.3599-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC DEBUG PATCH 0/3] debug patch for lookup-ptr hang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

These are debug patches only but represent how much I have narrowed
down the problem so far. I've included Thomas' patch to fix the
thread=single|multi option as that is currently broken upstream. So
far it seems though the problem is unrelated to multi-threading.

As discussed in the other thread I found not returning to a
tb_htable_lookup but adding it to the tb_jmp_cache made the problem go
away. I also tried various printfs but they also seemed to un-wedge
the hang I was seeing. It is not really a hang rather than a busy-spin
that will eventually given enough time unwind.

So added a new TB flag (is_magic) which if set would skip returning
the code ptr and default to exiting the loop via the epilogue and set
it for all DISAS_JUMP/DISAS_UPDATE paths that trigger
lookup_and_goto_ptr. After selectively commenting them out I found the
RET instruction is responsible for my particular fail case.

I find this confusing because BL and BLR basically do the same thing
and they seem to work fine.

I have an uneasy feeling there is some subtle black magic in the
interaction between cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags),
addr and the TCGv cpu_pc but I haven't nailed it down. I'm posting
this for those that still have some Friday left in case it prompts any
thoughts.

Over to you, hopefully inspiration will strike before I return to the
fray on Monday ;-)

Cheers,

Alex Bennée (2):
  tcg-runtime: light re-factor of lookup_tb_ptr
  translate-a64: fix lookup_tb_ptr hang (DEBUG!)

Thomas Huth (1):
  vl: Fix broken thread=xxx option of the --accel parameter

 include/exec/exec-all.h    |  2 ++
 target/arm/translate-a64.c | 21 +++++++++++++++++----
 target/arm/translate.h     |  2 ++
 tcg-runtime.c              | 37 +++++++++++++++++++++----------------
 vl.c                       | 13 +++++--------
 5 files changed, 47 insertions(+), 28 deletions(-)

-- 
2.13.0
