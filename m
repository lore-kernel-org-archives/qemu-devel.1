Received: from eggs.gnu.org ([2001:4830:134:3::10]:34993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXmJn-0007X5-8X
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXmJm-00075K-3V
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:39:31 -0400
Date: Tue, 26 Jun 2018 13:39:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180626133920.446d33b9.cohuck@redhat.com>
In-Reply-To: <1530005740-25254-1-git-send-email-thuth@redhat.com>
References: <1530005740-25254-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] loader: Check access size when calling
 rom_ptr() to avoid crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 26 Jun 2018 11:35:40 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The rom_ptr() function allows direct access to the ROM blobs that we
> load during startup. However, there are currently no checks for the
> size of the accesses, so it's currently possible to crash QEMU for
> example with:
> 
> $ echo "Insane in the mainframe" > /tmp/test.txt
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -append xyz
> Segmentation fault (core dumped)
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -initrd /tmp/test.txt
> Segmentation fault (core dumped)
> $ echo -n HdrS > /tmp/hdr.txt
> $ sparc64-softmmu/qemu-system-sparc64 -kernel /tmp/hdr.txt -initrd /tmp/hdr.txt
> Segmentation fault (core dumped)
> 
> We need a possibility to check the size of the ROM area that we want
> to access, thus let's add a size parameter to the rom_ptr() function
> to avoid these problems.
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v4:
>  - Rebase (two more spots were using rom_ptr now)
>  - Remove INITRD_PARM_SIZE since it's unused now
> 
>  hw/core/loader.c     | 10 +++++-----
>  hw/mips/mips_malta.c |  6 ++++--
>  hw/s390x/ipl.c       | 18 ++++++++++++------
>  hw/sparc/sun4m.c     |  4 ++--
>  hw/sparc64/sun4u.c   |  4 ++--
>  include/hw/loader.h  |  2 +-
>  target/arm/cpu.c     |  2 +-
>  7 files changed, 27 insertions(+), 19 deletions(-)

Thanks, applied.
