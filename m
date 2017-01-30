Received: from eggs.gnu.org ([2001:4830:134:3::10]:35460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYJL7-00033G-C6
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 16:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYJL2-00029F-NG
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 16:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cYJL2-00028B-H1
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 16:18:12 -0500
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-8-pbonzini@redhat.com>
	<20170130155044.GP2118@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70a0127e-b698-9530-ddec-466c4a635f0c@redhat.com>
Date: Mon, 30 Jan 2017 16:18:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170130155044.GP2118@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/17] nbd: convert to use qio_channel_yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com



On 30/01/2017 10:50, Stefan Hajnoczi wrote:
> On Fri, Jan 20, 2017 at 05:43:12PM +0100, Paolo Bonzini wrote:
>> +        aio_co_wake(s->recv_coroutine[i]);
>> =20
>> -    qemu_coroutine_enter(nbd_get_client_session(bs)->send_coroutine);
>> +        /* We're woken up by the recv_coroutine itself.  */
>> +        qemu_coroutine_yield();
>=20
> This relies on recv_coroutine() entering us only after we've yielded -
> otherwise QEMU will crash.  The code and comments don't make it obvious
> why this is guaranteed to be safe.

It doesn't rely on that (that's the magic hidden behind aio_co_wake),
but you're right there is a documentation problem because I needed 10
minutes to remind myself why it's correct.

It works because neither coroutine is moving context:

- if the two coroutines are in the same context, aio_co_wake queues the
coroutine for execution after the yield, which is obviously okay;

- if they are in different context, the recv_coroutine's aio_co_wake
queues the read_reply_co with aio_co_schedule.  It is then woken up
through a bottom half, which executes only after read_reply has yielded.

It is implied by the aio_co_wake and aio_co_schedule documentation; all
requirements are satisfied:

1) aio_co_wake's comment says:

   * aio_co_wake may be executed either in coroutine or non-coroutine
   * context.  The coroutine must not be entered by anyone else while
   * aio_co_wake() is active.

   read_reply_co is only woken by one recv_coroutine at a time

2) And for the case where read_reply_co and recv_coroutine are in
   different contexts, aio_co_schedule's comment says:

   * In addition the coroutine must have yielded unless ctx
   * is the context in which the coroutine is running (i.e. the value of
   * qemu_get_current_aio_context() from the coroutine itself).

   which is okay because aio_co_wake always uses "the context in
   which the coroutine is running" as the argument to aio_co_schedule.

Any suggestions on how to document this properly?  I'm not sure a
comment in the NBD driver is the best place, because similar logic will
appear soon in other networked block drivers.

Paolo
