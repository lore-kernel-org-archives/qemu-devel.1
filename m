Received: from eggs.gnu.org ([2001:4830:134:3::10]:42903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drilZ-0006tp-SB
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drilY-0000e3-VQ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:50:05 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-34-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fc568804-a418-fe3c-a3e5-69a52af267d4@redhat.com>
Date: Tue, 12 Sep 2017 12:49:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-34-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 33/38] libqtest: Merge qtest_{in,
 out}[bwl]() with {in, out}[bwl]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>

On 11.09.2017 19:20, Eric Blake wrote:
> Maintaining two layers of libqtest APIs, one that takes an explicit
> QTestState object, and the other that uses the implicit global_qtest,
> is annoying.  In the interest of getting rid of global implicit
> state and having less code to maintain, merge:
>  qtest_outb()
>  qtest_outw()
>  qtest_outl()
>  qtest_inb()
>  qtest_inw()
>  qtest_inl()
> with their short counterparts.  All callers that previously
> used the short form now make it explicit that they are relying on
> global_qtest, and later patches can then clean things up to remove
> the global variable.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h        | 99 ++++++-------------------------------------------
>  tests/multiboot/libc.h  |  2 +-
>  tests/libqtest.c        | 14 +++----
>  tests/boot-order-test.c |  4 +-
>  tests/endianness-test.c | 12 +++---
>  tests/fdc-test.c        | 77 ++++++++++++++++++++------------------
>  tests/hd-geo-test.c     |  4 +-
>  tests/ipmi-bt-test.c    | 12 +++---
>  tests/ipmi-kcs-test.c   |  8 ++--
>  tests/libqos/fw_cfg.c   |  4 +-
>  tests/libqos/pci-pc.c   | 44 +++++++++++-----------
>  tests/libqos/pci.c      |  2 +-
>  tests/m48t59-test.c     |  8 ++--
>  tests/multiboot/libc.c  |  2 +-
>  tests/pvpanic-test.c    |  4 +-
>  tests/rtc-test.c        |  8 ++--
>  tests/wdt_ib700-test.c  |  8 ++--
>  17 files changed, 120 insertions(+), 192 deletions(-)
> 
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 8398c0fd07..520f745e7b 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -205,61 +205,61 @@ void irq_intercept_in(QTestState *s, const char *string);
>  void irq_intercept_out(QTestState *s, const char *string);
> 
>  /**
> - * qtest_outb:
> + * outb:
>   * @s: #QTestState instance to operate on.
>   * @addr: I/O port to write to.
>   * @value: Value being written.
>   *
>   * Write an 8-bit value to an I/O port.
>   */
> -void qtest_outb(QTestState *s, uint16_t addr, uint8_t value);
> +void outb(QTestState *s, uint16_t addr, uint8_t value);

Could we please also keep the qtest prefix here? ... same applies for
all your other following "Merge ..." patches in this series...

 Thomas
