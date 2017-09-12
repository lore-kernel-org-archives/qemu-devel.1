Received: from eggs.gnu.org ([2001:4830:134:3::10]:41281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drihL-0004Ul-W6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drihK-0005jk-Fc
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:45:43 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-32-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1a629362-ebc5-7d28-463c-f6ec4639d29b@redhat.com>
Date: Tue, 12 Sep 2017 12:45:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-32-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 31/38] libqtest: Merge qtest_clock_*()
 with clock_*()
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
>  qtest_clock_set()
>  qtest_clock_step()
>  qtest_clock_step_next()
> with their short counterparts.  All callers that previously
> used the short form now make it explicit that they are relying on
> global_qtest, and later patches can then clean things up to remove
> the global variable.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h         | 50 ++++----------------------------
>  tests/libqtest.c         |  6 ++--
>  tests/e1000e-test.c      |  2 +-
>  tests/fdc-test.c         |  4 +--
>  tests/ide-test.c         |  2 +-
>  tests/libqos/virtio.c    |  8 +++---
>  tests/rtc-test.c         | 74 ++++++++++++++++++++++++------------------------
>  tests/rtl8139-test.c     | 10 +++----
>  tests/tco-test.c         | 22 +++++++-------
>  tests/test-arm-mptimer.c | 25 +++++++++-------
>  tests/wdt_ib700-test.c   | 12 ++++----
>  11 files changed, 90 insertions(+), 125 deletions(-)
> 
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 5651b77d2f..26d5f37bc9 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -417,17 +417,17 @@ void qtest_bufwrite(QTestState *s, uint64_t addr,
>  void qtest_memset(QTestState *s, uint64_t addr, uint8_t patt, size_t size);
> 
>  /**
> - * qtest_clock_step_next:
> + * clock_step_next:
>   * @s: #QTestState instance to operate on.
>   *
>   * Advance the QEMU_CLOCK_VIRTUAL to the next deadline.
>   *
>   * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
>   */
> -int64_t qtest_clock_step_next(QTestState *s);
> +int64_t clock_step_next(QTestState *s);
> 
>  /**
> - * qtest_clock_step:
> + * clock_step:
>   * @s: QTestState instance to operate on.
>   * @step: Number of nanoseconds to advance the clock by.
>   *
> @@ -435,10 +435,10 @@ int64_t qtest_clock_step_next(QTestState *s);
>   *
>   * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
>   */
> -int64_t qtest_clock_step(QTestState *s, int64_t step);
> +int64_t clock_step(QTestState *s, int64_t step);
> 
>  /**
> - * qtest_clock_set:
> + * clock_set:
>   * @s: QTestState instance to operate on.
>   * @val: Nanoseconds value to advance the clock to.
>   *
> @@ -446,7 +446,7 @@ int64_t qtest_clock_step(QTestState *s, int64_t step);
>   *
>   * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
>   */
> -int64_t qtest_clock_set(QTestState *s, int64_t val);
> +int64_t clock_set(QTestState *s, int64_t val);
 Could we please keep the "qtest" prefix here and rather get rid of the
other ones? Even if it's more to type, I prefer to have a proper prefix
here so that it is clear at the first sight that the functions belong to
the qtest framework.

 Thomas
