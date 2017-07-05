Received: from eggs.gnu.org ([2001:4830:134:3::10]:44822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSePJ-00024K-AG
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSePH-0004q5-Fo
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:07:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
Date: Wed, 05 Jul 2017 09:07:18 +0200
In-Reply-To: <20170703122505.32017-3-mreitz@redhat.com> (Max Reitz's message
	of "Mon, 3 Jul 2017 14:25:02 +0200")
Message-ID: <87r2xve509.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> This generic function (along with its implementations for different
> types) determines whether two QObjects are equal.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
[...]
> diff --git a/qobject/qnum.c b/qobject/qnum.c
> index 476e81c..784d061 100644
> --- a/qobject/qnum.c
> +++ b/qobject/qnum.c
> @@ -213,6 +213,59 @@ QNum *qobject_to_qnum(const QObject *obj)
>  }
>  
>  /**
> + * qnum_is_equal(): Test whether the two QNums are equal
> + */
> +bool qnum_is_equal(const QObject *x, const QObject *y)
> +{
> +    QNum *num_x = qobject_to_qnum(x);
> +    QNum *num_y = qobject_to_qnum(y);
> +
> +    switch (num_x->kind) {
> +    case QNUM_I64:
> +        switch (num_y->kind) {
> +        case QNUM_I64:
> +            /* Comparison in native int64_t type */
> +            return num_x->u.i64 == num_y->u.i64;
> +        case QNUM_U64:
> +            /* Implicit conversion of x to uin64_t, so we have to
> +             * check its sign before */
> +            return num_x->u.i64 >= 0 && num_x->u.i64 == num_y->u.u64;
> +        case QNUM_DOUBLE:
> +            /* Implicit conversion of x to double; no overflow
> +             * possible */
> +            return num_x->u.i64 == num_y->u.dbl;

Overflow is impossible, but loss of precision is possible:

    (double)9007199254740993ull == 9007199254740992.0

yields true.  Is this what we want?

> +        }
> +        abort();
> +    case QNUM_U64:
> +        switch (num_y->kind) {
> +        case QNUM_I64:
> +            return qnum_is_equal(y, x);
> +        case QNUM_U64:
> +            /* Comparison in native uint64_t type */
> +            return num_x->u.u64 == num_y->u.u64;
> +        case QNUM_DOUBLE:
> +            /* Implicit conversion of x to double; no overflow
> +             * possible */
> +            return num_x->u.u64 == num_y->u.dbl;

Similar loss of precision.

> +        }
> +        abort();
> +    case QNUM_DOUBLE:
> +        switch (num_y->kind) {
> +        case QNUM_I64:
> +            return qnum_is_equal(y, x);
> +        case QNUM_U64:
> +            return qnum_is_equal(y, x);
> +        case QNUM_DOUBLE:
> +            /* Comparison in native double type */
> +            return num_x->u.dbl == num_y->u.dbl;
> +        }
> +        abort();
> +    }
> +
> +    abort();
> +}

I think there's more than one sane interpretations of "is equal",
including:

* The mathematical numbers represented by @x and @y are equal.

* @x and @y have the same contents, i.e. same kind and u.

* @x and @y are the same object (listed for completeness; we don't need
  a function to compare pointers).

Your patch implements yet another one.  Which one do we want, and why?

The second is easier to implement than the first.

If we really want the first, you need to fix the loss of precision bugs.
I guess the obvious fix is

    return (double)x == x && x == y;

Note that this is what you do for mixed signedness: first check @x is
exactly representable in @y's type, then compare in @y's type.

Regardless of which one we pick, the function comment needs to explain.

> +
> +/**
>   * qnum_destroy_obj(): Free all memory allocated by a
>   * QNum object
>   */
[...]

Remainder of the patch looks good to me.
