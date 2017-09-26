Received: from eggs.gnu.org ([2001:4830:134:3::10]:52670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwlo2-00072p-Kc
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwlnx-0005N1-Il
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:05:30 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dwlnx-0005Mb-89
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:05:25 -0400
Received: by mail-wr0-x243.google.com with SMTP id u48so1939468wrf.4
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 02:05:25 -0700 (PDT)
Date: Tue, 26 Sep 2017 10:05:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170926090521.GE16834@stefanha-x1.localdomain>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1506384414.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/8]  Remove some of the fprintf(stderr,
 "*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Sep 25, 2017 at 05:08:34PM -0700, Alistair Francis wrote:
> 
> Continue on improving QEMUs logging/error messages by removing more
> fprintf()'s.
> 
> Unfortunatley my Coccinelle skills aren't that great so it's all done in
> some nasty regex and a little bit of manual work.
> 
> 
> 
> Alistair Francis (8):
>   Replace all occurances of __FUNCTION__ with __func__
>   tests: Replace fprintf(stderr, "*\n" with error_report()
>   hw: Replace fprintf(stderr, "*\n" with error_report()
>   block: Replace fprintf(stderr, "*\n" with error_report()
>   util: Replace fprintf(stderr, "*\n" with error_report()
>   ui: Replace fprintf(stderr, "*\n" with error_report()
>   tcg: Replace fprintf(stderr, "*\n" with error_report()
>   target: Replace fprintf(stderr, "*\n" with error_report()
> 
>  audio/audio_int.h                      |   2 +-
>  block/file-posix.c                     |   6 +-
>  block/file-win32.c                     |   3 +-
>  block/linux-aio.c                      |   5 +-
>  block/parallels.c                      |   7 ++-
>  block/qcow2-cluster.c                  |   2 +-
>  block/qcow2-refcount.c                 |  95 +++++++++++++++----------------
>  block/qcow2.c                          |   8 +--
>  block/quorum.c                         |   5 +-
>  block/ssh.c                            |   4 +-
>  block/vdi.c                            |  14 +++--
>  block/vpc.c                            |   5 +-
>  block/vvfat.c                          |  99 ++++++++++++++++++---------------

Please don't convert fprintfs to error_report in the block layer yet.
error_report() uses the cur_mon global variable in a way that is not
thread-safe:

  void error_vprintf(const char *fmt, va_list ap)
  {
      if (cur_mon && !monitor_cur_is_qmp()) {
          monitor_vprintf(cur_mon, fmt, ap);

This is a time-of-check-to-time-of-use race condition.
monitor_cur_is_qmp() itself also suffers from a race condition.

I guess we haven't seen issues because error_report() is rarely called.

Stefan
