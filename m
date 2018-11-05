Received: from eggs.gnu.org ([2001:4830:134:3::10]:42343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJYGd-0005pB-DH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 01:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJYDj-00086V-Dz
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 01:18:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gJYDj-00085h-4z
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 01:18:43 -0500
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181102170730.12432-2-contrib@steffen-goertz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6e7d3eda-8303-ae7d-f5da-3e78e0796f57@redhat.com>
Date: Mon, 5 Nov 2018 07:18:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181102170730.12432-2-contrib@steffen-goertz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/13] qtest: Add set_irq_in command to
 set IRQ/GPIO level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>

On 2018-11-02 18:07, Steffen G=C3=B6rtz wrote:
> Adds a new qtest command "set_irq_in" which allows
> to set qemu gpio lines to a given level.
>=20
> Based on https://lists.gnu.org/archive/html/qemu-devel/2012-12/msg02363=
.html
> which never got merged.
>=20
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Originally-by: Matthew Ogilvie <mmogilvi_qemu@miniinfo.net>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qtest.c          | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/libqtest.c | 10 ++++++++++
>  tests/libqtest.h | 28 ++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)
[...]
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index ed88ff99d5..65bffa9ace 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -232,6 +232,19 @@ void qtest_irq_intercept_in(QTestState *s, const c=
har *string);
>   */
>  void qtest_irq_intercept_out(QTestState *s, const char *string);
> =20
> +/**
> + * qtest_set_irq_in:
> + * @s: QTestState instance to operate on.
> + * @string: QOM path of a device
> + * @name: IRQ name
> + * @irq: IRQ number
> + * @level: IRQ level
> + *
> + * Force given device/irq GPIO-in pin to the given level.
> + */
> +void qtest_set_irq_in(QTestState *s, const char *string, const char *n=
ame,
> +                      int irq, int level);
> +
>  /**
>   * qtest_outb:
>   * @s: #QTestState instance to operate on.
> @@ -678,6 +691,21 @@ static inline void irq_intercept_out(const char *s=
tring)
>      qtest_irq_intercept_out(global_qtest, string);
>  }
> =20
> +/**
> + * qtest_set_irq_in:
> + * @string: QOM path of a device
> + * @name: IRQ name
> + * @irq: IRQ number
> + * @level: IRQ level
> + *
> + * Force given device/IRQ GPIO-in pin to the given level.
> + */
> +static inline void set_irq_in(const char *string, const char *name,
> +                              int irq, int level)
> +{
> +    qtest_set_irq_in(global_qtest, string, name, irq, level);
> +}
> +
>  /**
>   * outb:
>   * @addr: I/O port to write to.
>=20

 Hi Steffen,

please don't add any new function wrappers around global_qtest anymore.
We recently already started to get rid of this global variable in a
couple of places (see
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Ddb57d7a3c284db2315d=
9 and
preceding commits for example), since it causes trouble in tests that
want to run multiple QEMU instances at once (in migration tests for
example). It would be good to have new code clean for this right from
the start.

 Thanks,
  Thomas
