Received: from eggs.gnu.org ([209.51.188.92]:51373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gyKa9-0002mm-Jm
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gyKa8-0005uZ-Mk
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:02:25 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gyKa7-0005oJ-Nq
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:02:24 -0500
Date: Mon, 25 Feb 2019 13:02:17 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190225180217.GA8578@flamenco>
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-8-cota@braap.org>
	<875zt7n8gz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zt7n8gz.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [RFC v2 07/38] queue: add QTAILQ_REMOVE_SEVERAL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On Mon, Feb 25, 2019 at 16:22:52 +0000, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > +/* remove @left, @right and all elements in between from @head */
> > +#define QTAILQ_REMOVE_SEVERAL(head, left, right, field) do {    \
> > +        if (((right)->field.tqe_next) != NULL)                  \
> > +            (right)->field.tqe_next->field.tqe_prev =           \
> > +                (left)->field.tqe_prev;                         \
> > +        else                                                    \
> > +            (head)->tqh_last = (left)->field.tqe_prev;          \
> > +        *(left)->field.tqe_prev = (right)->field.tqe_next;      \
> 
> This seems wrong, shouldn't it be:
> 
>   (left)->field.tqe_prev->field.tqe_next = (right)->field.tqe_next;

That would make too much sense, wouldn't it!

Looking at QTAILQ_REMOVE is the easiest way to reason about this:

#define QTAILQ_REMOVE(head, elm, field) do {                            \
        if (((elm)->field.tqe_next) != NULL)                            \
                (elm)->field.tqe_next->field.tqe_prev =                 \
                    (elm)->field.tqe_prev;                              \
        else                                                            \
                (head)->tqh_last = (elm)->field.tqe_prev;               \
        *(elm)->field.tqe_prev = (elm)->field.tqe_next;                 \
        (elm)->field.tqe_prev = NULL;                                   \
} while (/*CONSTCOND*/0)

Imagine we're removing the only element in the list. Thus,
*(elm)->field.tqe_prev will be setting (head)->tqh_first (to NULL).
IOW, we can't assume that the previous "element" (whether true element
or head) has a .tqe_next field (the head has .thq_first); note that
tqe_prev is a **, not a *.

> Although to be honest every time I read the QUEUE macros I end up with a headache...

You're not alone.

BTW, this code had to change for v3 because of 7274f01bb8 ("qemu/queue.h:
reimplement QTAILQ without pointer-to-pointers", 2019-01-11)

I think you might like that implementation better, since it is a little
closer to sanity, i.e. kernel-style lists :-)
It uses a more predictable structure (*prev,*next) that is shoehorned
with a union to avoid changing the memory layout.

Thanks,

		Emilio
