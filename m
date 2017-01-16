Received: from eggs.gnu.org ([2001:4830:134:3::10]:53664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT87P-0001lm-Cp
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT87L-0007jK-4s
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:18:43 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cT87K-0007jD-U9
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:18:39 -0500
Received: by mail-lf0-x244.google.com with SMTP id x1so7479452lff.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 06:18:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-6-pbonzini@redhat.com>
	<20170116125847.GI13096@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2399b53-b28f-9877-6112-b02a361bf6e4@redhat.com>
Date: Mon, 16 Jan 2017 15:18:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170116125847.GI13096@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/16] io: make qio_channel_yield aware of
 AioContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com



On 16/01/2017 13:58, Daniel P. Berrange wrote:
>> + * Request that qio_channel_yield() sets I/O handlers on
>> + * the given #AioContext.  If @ctx is %NULL, qio_channel_yield()
>> + * uses QEMU's main thread event loop.
>> + */
> Can you note that it is explicitly permitted to call this while
> inside a qio_channel_yield().

Yes:

 * You can move a #QIOChannel from an #AioContext to another even if
 * I/O handlers are set for a coroutine.  However, #QIOChannel provides
 * no synchronization between the calls to qio_channel_yield() and
 * qio_channel_set_aio_context().
 *
 * Therefore you should first call qio_channel_detach_aio_context()
 * to ensure that the coroutine is not entered concurrently.  Then,
 * while the coroutine has yielded, call qio_channel_set_aio_context(),
 * and then aio_co_schedule() to place the coroutine on the new
 * #AioContext.  The calls to qio_channel_detach_aio_context()
 * and qio_channel_set_aio_context() should be protected with
 * aio_context_acquire() and aio_context_release().

Paolo
