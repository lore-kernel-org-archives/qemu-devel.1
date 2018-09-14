Received: from eggs.gnu.org ([2001:4830:134:3::10]:60862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0pmA-0003di-5R
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0pm9-0006ne-C5
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:12:54 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-12-kwolf@redhat.com>
	<908e08a4-a58a-e4e1-5eb7-fe9d17adfbe3@redhat.com>
	<20180913165954.GB5172@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf0ed459-0c81-82ba-a60d-736170469501@redhat.com>
Date: Fri, 14 Sep 2018 17:12:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180913165954.GB5172@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/17] block-backend: Decrease in_flight
 only after callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

On 13/09/2018 18:59, Kevin Wolf wrote:
> Am 13.09.2018 um 17:10 hat Paolo Bonzini geschrieben:
>> On 13/09/2018 14:52, Kevin Wolf wrote:
>>> + if (qemu_get_current_aio_context() == qemu_get_aio_context()) {
>>> + /* If we are in the main thread, the callback is allowed to unref
>>> + * the BlockBackend, so we have to hold an additional reference */
>>> + blk_ref(acb->rwco.blk);
>>> + }
>>> acb->common.cb(acb->common.opaque, acb->rwco.ret);
>>> + blk_dec_in_flight(acb->rwco.blk);
>>> + if (qemu_get_current_aio_context() == qemu_get_aio_context()) {
>>> + blk_unref(acb->rwco.blk);
>>> + }
>>
>> Is this something that happens only for some specific callers?  That is,
>> which callers are sure that the callback is invoked from the main thread?
> 
> I can't seem to reproduce the problem I saw any more even when reverting
> the bdrv_ref/unref pair. If I remember correctly it was actually a
> nested aio_poll() that was running a block job completion or something
> like that - which would obviously only happen on the main thread because
> the job intentionally defers to the main thread.
> 
> The only reason I made this conditional is that I think bdrv_unref()
> still isn't safe outside the main thread, is it?

Yes, making it conditional is correct, but it is quite fishy even with
the conditional.

As you mention, you could have a nested aio_poll() in the main thread,
for example invoked from a bottom half, but in that case I'd rather
track the caller that is creating the bottom half and see if it lacks a
bdrv_ref/bdrv_unref (or perhaps it's even higher in the tree that is
missing).

Paolo
