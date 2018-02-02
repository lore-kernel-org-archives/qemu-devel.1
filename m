Received: from eggs.gnu.org ([2001:4830:134:3::10]:36744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehhqM-0000tM-1l
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehhqI-0002zb-Q3
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:21:54 -0500
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:34663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehhqI-0002zE-K8
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:21:50 -0500
Received: by mail-qt0-x22b.google.com with SMTP id a27so32520244qtd.1
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 12:21:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180202183731.29990-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <256d25fe-42f3-7543-87c8-25665c207009@amsat.org>
Date: Fri, 2 Feb 2018 17:21:47 -0300
MIME-Version: 1.0
In-Reply-To: <20180202183731.29990-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 00/15] Remove some of the fprintf(stderr, "*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com

On 02/02/2018 03:37 PM, Markus Armbruster wrote:
> This is my attempt to salvage a good part of Alistair's error
> reporting cleanup series
> 
>     [PATCH v6 00/29]  Remove some of the fprintf(stderr, "*
> 
>     Continue on improving QEMUs logging/error messages by removing more
>     fprintf()'s.
> 
>     Unfortunatley my Coccinelle skills aren't that great so it's all done in
>     some nasty regex and a little bit of manual work.
> 
> It foundered on the problem that some of its fprintf() to
> error_report() conversions are inappropriate, see
> 
>     Message-ID: <87lghulqno.fsf@dusky.pond.sub.org>
>     https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04961.html
> 
> Alistair didn't feel like checking about one hundred conversions by
> hand, which is understandable.  But letting the work go to waste would
> be a shame, so I wrote an AWK script (see below) to extract a common
> kind of obviously good conversions: the ones where the fprintf() is
> followed by exit().  Judging from the diffstat, this salvages more
> than half of his conversion work.

Thanks for this :)

except patch 12 and the dtc submodule change reported by Eric in patch
15, series:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> v7:
> * Old PATCH 02,03,21 are already in master, drop
> * Conversions not obviously followed by exit() dropped
>   Nothing left in old PATCH 06-12,16,17,22, drop
>   R-bys dropped
> * Rebased, trivial conflict in the last patch resolved
> 
> 
> #!/usr/bin/awk -f
> 
> hunk && /^\+[ \t]*error_report/ {
>     n++
>     er_indent = match(substr($0, 2), /[^ \t]/)
>     er_nr = NR
>     plus = 0
>     fatal = 0
> }
> 
> hunk && er_indent && /^\+/ {
>     plus++
> }
> 
> hunk && er_indent && /^[ \t]*exit/ {
>     d = NR - er_nr - plus
>     if (maxd < d)
> 	maxd = d
>     fatal = 1
> }
> 
> hunk && er_indent && match(substr($0, 2), /[^ \t]/) < er_indent {
>     if (fatal)
> 	nf++
>     er_indent = 0
> }
> 
> hunk && /^[-+ ]/ {
>     hunk = hunk "\n" $0
>     next
> }
> 
> hunk {
>     if (n && nf && n != nf)
> 	print loc, "mixed hunk", n, nf >"/dev/stderr"
>     else if (n && !nf)
> 	print loc, "non-fatal hunk", n, nf >"/dev/stderr"
>     else if (!n || nf)
> 	print hunk
>     hunk = ""
> }
> 
> /^@@ / {
>     hunk = $0
>     loc = FILENAME ":" FNR ":"
>     n = nf = 0
>     next
> }
> 
> {
>     print
> }
> 
> END {
>     print "max distance", maxd+0 >"/dev/stderr"
> }
> 
> Alistair Francis (15):
>   audio: Replace AUDIO_FUNC with __func__
>   hw/arm: Replace fprintf(stderr, "*\n" with error_report()
>   hw/dma: Replace fprintf(stderr, "*\n" with error_report()
>   hw/lm32: Replace fprintf(stderr, "*\n" with error_report()
>   hw/mips: Replace fprintf(stderr, "*\n" with error_report()
>   hw/moxie: Replace fprintf(stderr, "*\n" with error_report()
>   hw/openrisc: Replace fprintf(stderr, "*\n" with error_report()
>   hw/pci*: Replace fprintf(stderr, "*\n" with error_report()
>   hw/ppc: Replace fprintf(stderr, "*\n" with error_report()
>   hw/sd: Replace fprintf(stderr, "*\n" with error_report()
>   hw/sparc*: Replace fprintf(stderr, "*\n" with error_report()
>   hw/timer: Replace fprintf(stderr, "*\n" with error_report()
>   hw/xen*: Replace fprintf(stderr, "*\n" with error_report()
>   tcg: Replace fprintf(stderr, "*\n" with error_report()
>   target: Use qemu_log() instead of fprintf(stderr, ...)
> 
>  audio/alsaaudio.c            |  4 ++--
>  audio/audio.c                | 40 +++++++++++++++----------------
>  audio/audio_int.h            |  6 -----
>  audio/audio_pt_int.c         | 28 +++++++++++-----------
>  audio/audio_template.h       | 26 ++++++++++----------
>  audio/dsoundaudio.c          |  2 +-
>  audio/mixeng.c               |  2 +-
>  audio/ossaudio.c             | 10 ++++----
>  audio/paaudio.c              | 56 ++++++++++++++++++++++----------------------
>  audio/sdlaudio.c             |  2 +-
>  audio/wavaudio.c             |  2 +-
>  cpus.c                       | 10 ++++----
>  dtc                          |  2 +-
>  exec.c                       |  6 ++---
>  hw/arm/armv7m.c              |  2 +-
>  hw/arm/boot.c                | 16 ++++++-------
>  hw/arm/gumstix.c             | 13 +++++-----
>  hw/arm/mainstone.c           |  7 +++---
>  hw/arm/musicpal.c            |  2 +-
>  hw/arm/omap1.c               |  5 ++--
>  hw/arm/omap2.c               |  3 ++-
>  hw/arm/omap_sx1.c            |  2 +-
>  hw/arm/pxa2xx.c              |  7 +++---
>  hw/arm/vexpress.c            |  8 +++----
>  hw/arm/z2.c                  |  6 ++---
>  hw/dma/soc_dma.c             | 36 ++++++++++++++--------------
>  hw/lm32/lm32_boards.c        |  7 +++---
>  hw/lm32/milkymist.c          |  7 +++---
>  hw/mips/mips_fulong2e.c      | 13 +++++-----
>  hw/mips/mips_jazz.c          |  4 ++--
>  hw/mips/mips_malta.c         | 16 ++++++-------
>  hw/mips/mips_mipssim.c       | 11 ++++-----
>  hw/mips/mips_r4k.c           | 16 ++++++-------
>  hw/moxie/moxiesim.c          | 13 +++++-----
>  hw/openrisc/openrisc_sim.c   |  4 ++--
>  hw/pci-host/bonito.c         |  6 ++---
>  hw/pci/pci.c                 |  4 ++--
>  hw/ppc/e500.c                | 16 ++++++-------
>  hw/ppc/mac_newworld.c        |  2 +-
>  hw/ppc/mac_oldworld.c        |  2 +-
>  hw/ppc/ppc405_boards.c       | 15 +++++-------
>  hw/ppc/ppc440_bamboo.c       | 16 ++++++-------
>  hw/ppc/prep.c                |  4 ++--
>  hw/ppc/virtex_ml507.c        |  4 ++--
>  hw/sd/sd.c                   |  7 +++---
>  hw/sparc/leon3.c             | 16 ++++++-------
>  hw/sparc/sun4m.c             | 16 ++++++-------
>  hw/sparc64/niagara.c         |  4 ++--
>  hw/sparc64/sun4u.c           | 10 ++++----
>  hw/timer/xilinx_timer.c      | 10 ++++----
>  hw/xen/xen-common.c          |  5 ++--
>  hw/xenpv/xen_machine_pv.c    |  9 +++----
>  target/cris/translate.c      |  2 +-
>  target/ppc/translate.c       | 36 ++++++++--------------------
>  target/sh4/translate.c       |  7 ++----
>  target/unicore32/translate.c |  2 +-
>  vl.c                         |  2 +-
>  57 files changed, 277 insertions(+), 312 deletions(-)
> 
