Received: from eggs.gnu.org ([2001:4830:134:3::10]:58404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fgSk4-0005oe-DX
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 06:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fgSjz-00034U-Ee
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 06:34:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fgSjz-00034L-6z
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 06:34:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so10835097wre.6
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 03:34:27 -0700 (PDT)
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180718154200.26777-8-dplotnikov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f24de8e1-b0fd-1640-a145-7929616418ea@redhat.com>
Date: Fri, 20 Jul 2018 12:34:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180718154200.26777-8-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/17] background snapshot: introduce
 page buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, dgilbert@redhat.com, quintela@redhat.com
Cc: qemu-devel@nongnu.org

On 18/07/2018 17:41, Denis Plotnikov wrote:
> +static void ram_page_buffer_decrease_used(void)
> +{
> +    qemu_event_reset(&ram_state->page_buffer.used_decreased);
> +    atomic_dec(&ram_state->page_buffer.used);
> +    qemu_event_set(&ram_state->page_buffer.used_decreased);

As Peter noted, only the qemu_event_set is needed here, while...

> +}
> +
> +static void ram_page_buffer_increase_used_wait(void)
> +{
> +    int used, *used_ptr;
> +    RAMState *rs = ram_state;
> +    used_ptr = &rs->page_buffer.used;
> +    do {
> +        used = atomic_read(used_ptr);
> +        if (rs->page_buffer.capacity > used) {
> +            if (atomic_cmpxchg(used_ptr, used, used + 1) == used) {
> +                return;
> +            } else {
> +                continue;
> +            }
> +        } else {
> +            qemu_event_wait(&rs->page_buffer.used_decreased);
> +        }
> +    } while (true);

... the right idiom for using qemu_event_wait is this:

   if test condition
       reset
       if test condition
           wait

So something like

    for(;;) {
        used = atomic_read(used_ptr);
        if (rs->page_buffer.capacity <= used) {
            qemu_event_reset(&rs->page_buffer.used_decreased);
            used = atomic_read(used_ptr);
            if (rs->page_buffer.capacity <= used) {
                qemu_event_wait(&rs->page_buffer.used_decreased);
                continue;
            }
        }

        if (atomic_cmpxchg(used_ptr, used, used + 1) == used) {
            return;
        }
    }

Note that there must be a single thread doing the above.  Otherwise, you
have to use mutex and condvar.

Paolo
