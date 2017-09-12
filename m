Received: from eggs.gnu.org ([2001:4830:134:3::10]:42074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drijU-0005Vp-Ga
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drijQ-0007TB-J4
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:47:56 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-33-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <39007427-a185-1cb3-a0d8-8d0d3954c8b1@redhat.com>
Date: Tue, 12 Sep 2017 12:47:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-33-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 32/38] libqtest: Merge qtest_irq*() with
 irq*()
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
>  qtest_get_irq()
>  qtest_irq_intercept_in()
>  qtest_irq_intercept_out()
> with their short counterparts.  All callers that previously
> used the short form now make it explicit that they are relying on
> global_qtest, and later patches can then clean things up to remove
> the global variable.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h         | 47 ++++++-----------------------------------------
>  tests/libqtest.c         |  6 +++---
>  tests/fdc-test.c         | 48 ++++++++++++++++++++++++------------------------
>  tests/ide-test.c         | 17 +++++++++--------
>  tests/ipmi-bt-test.c     |  6 +++---
>  tests/ipmi-kcs-test.c    |  8 ++++----
>  tests/libqos/libqos-pc.c |  2 +-
>  tests/rtc-test.c         | 10 +++++-----
>  tests/tco-test.c         |  2 +-
>  tests/wdt_ib700-test.c   |  8 ++++----
>  10 files changed, 60 insertions(+), 94 deletions(-)
> 
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 26d5f37bc9..8398c0fd07 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -176,33 +176,33 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
>  char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap);
> 
>  /**
> - * qtest_get_irq:
> + * get_irq:
>   * @s: #QTestState instance to operate on.
>   * @num: Interrupt to observe.
>   *
>   * Returns: The level of the @num interrupt.
>   */
> -bool qtest_get_irq(QTestState *s, int num);
> +bool get_irq(QTestState *s, int num);
> 
>  /**
> - * qtest_irq_intercept_in:
> + * irq_intercept_in:
>   * @s: #QTestState instance to operate on.
>   * @string: QOM path of a device.
>   *
>   * Associate qtest irqs with the GPIO-in pins of the device
>   * whose path is specified by @string.
>   */
> -void qtest_irq_intercept_in(QTestState *s, const char *string);
> +void irq_intercept_in(QTestState *s, const char *string);
> 
>  /**
> - * qtest_irq_intercept_out:
> + * irq_intercept_out:
>   * @s: #QTestState instance to operate on.
>   * @string: QOM path of a device.
>   *
>   * Associate qtest irqs with the GPIO-out pins of the device
>   * whose path is specified by @string.
>   */
> -void qtest_irq_intercept_out(QTestState *s, const char *string);
> +void irq_intercept_out(QTestState *s, const char *string);

Could we please also keep the qtest prefix here?

 Thomas
