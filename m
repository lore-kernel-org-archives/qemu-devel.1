Received: from eggs.gnu.org ([2001:4830:134:3::10]:44812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPrbQ-0003Ji-1V
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPrbP-0008CN-04
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:41:00 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPrbO-0008Bf-IK
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:40:58 -0400
Received: by mail-oi0-x241.google.com with SMTP id c128-v6so19578530oig.11
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:40:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604084903.8163-1-kraxel@redhat.com>
References: <20180604084903.8163-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 16:40:37 +0100
Message-ID: <CAFEAcA9AMA3BdCs-MJ5Vg9KJdkn4yBRzCxQ-Rq2E-O-+Bbc+hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Vga 20180604 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 4 June 2018 at 09:49, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 392fba9f583223786f844dce9b2e7f9a0ce0147a:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-010618-1' into staging (2018-06-01 17:32:30 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20180604-pull-request
>
> for you to fetch changes up to 6bc2fd57e1fc2d1957d1ff952793c53764130218:
>
>   vga: cleanup surface handling (2018-06-04 09:44:10 +0200)
>
> ----------------------------------------------------------------
> Two little vga fixes.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (2):
>   bochs-display: add missing break
>   vga: cleanup surface handling
>
>  hw/display/bochs-display.c |  1 +
>  hw/display/vga.c           | 36 +++++++++++++++++++-----------------
>  2 files changed, 20 insertions(+), 17 deletions(-)

I got a failure in the migration tests with this applied:

  /i386/ahci/migrate/sanity:
/home/petmay01/linaro/qemu-for-merges/migration/
qemu-file.c:119:15: runtime error: member access within misaligned
address 0x101010101010101 for type 'QEMUFile' (aka '
struct QEMUFile'), which requires 8 byte alignment
0x101010101010101: note: pointer points here
<memory cannot be printed>
/home/petmay01/linaro/qemu-for-merges/migration/qemu-file.c:119:15:
runtime error: load of misaligned address 0x1010101
01018545 for type 'int', which requires 4 byte alignment
0x101010101018545: note: pointer points here
<memory cannot be printed>
ahci-test: /home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:113:
void kill_qemu(QTestState *): Assertion `!WCORED
UMP(wstatus)' failed.
FAIL
GTester: last random seed: R02S0741b59625080b71b3c3e7b5f47baf32
(pid=2216)

something going wrong with a clearly bogus pointer...
The file/line reference is to qemu_file_get_error(), so I guess
something has wound up with a stale QEMUFile*.

Unfortunately this doesn't seem to reproduce. I haven't seen
it before, so my guess is this is an intermittent introduced
by your earlier migration pullreq which is now in master ?
Might only manifest when the host machine is under load or
during a 'make check -j8' parallel test run.

thanks
-- PMM
