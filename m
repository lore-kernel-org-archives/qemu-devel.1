Received: from eggs.gnu.org ([2001:4830:134:3::10]:48983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTjEU-0006BT-EV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTjEQ-0003Yj-Gt
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:33:18 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36403
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fTjEQ-0003YD-9U
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:33:14 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Jun 2018 08:33:02 +0100
Message-Id: <20180615073303.502-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [RFC PATCH v4 0/1] SPARC64: add icount support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com, richard.henderson@linaro.org, cota@braap.org

This is a patch I've had in an earlier form for a while but never really developed
due to experiencing random hangs when writing to the SPARC64 CPU timers.

Fortunately it seems the recent icount timer fixes have resolved the underlying
issues and with this patch I am able to boot all my qemu-system-sparc64 OpenBIOS
test images.

I've marked this as an RFC for two reasons: firstly I'm not sure I've fully covered
all the cases where we need to exit the TB in order to allow the timer interrupt to
fire, and secondly I do occasionally see messages booting Milax in the form of
"WARNING: Time of Day clock error: reason [Jumped by 0x134]".

Hopefully more sets of eyes will be able to point me in the right direction related
to the Time of Day (m48t59) error and the TB exits in order to get this ready for
commit.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v4:
- Convert sparc_tr_tb_stop() to use switch for DisasJumpType as suggested by Richard

v3:
- Implement feedback from Richard: use tb_cflags() for icount flag access,
  unconditionally exit the TB when setting the timer registers, introduce DISAS_EXIT
  to avoid repeating TB exit code pattern

v2:
- Rebase onto master

Mark Cave-Ayland (1):
  SPARC64: add icount support

 target/sparc/translate.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

-- 
2.11.0
