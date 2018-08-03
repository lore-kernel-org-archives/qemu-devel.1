Received: from eggs.gnu.org ([2001:4830:134:3::10]:53125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fldK2-000111-Mg
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 12:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fldJR-0002VQ-JK
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 12:53:02 -0400
References: <20180803154955.25251-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ac9be27-7775-1863-c34c-cdce85eab53e@redhat.com>
Date: Fri, 3 Aug 2018 18:51:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180803154955.25251-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] async: Fix aio_notify_accept
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On 03/08/2018 17:49, Fam Zheng wrote:
>  void aio_notify_accept(AioContext *ctx)
>  {
> -    if (atomic_xchg(&ctx->notified, false)) {
> +    /* If ctx->notify_me >=3D 2, another aio_poll() is waiting which m=
ay need the
> +     * ctx->notifier event to wake up, so don't already clear it just =
because "we" are
> +     * done iterating. */
> +    if (atomic_read(&ctx->notify_me) < 2
> +        && atomic_xchg(&ctx->notified, false)) {
>          event_notifier_test_and_clear(&ctx->notifier);
>      }
>  }

I'm worried that this would this cause a busy wait, and I don't
understand the issue.

When aio_poll()s are nested, outer calls are in the "dispatch" phase and
therefore do not need notification.

In your situation is notify_me actually ever >2?

Paolo
