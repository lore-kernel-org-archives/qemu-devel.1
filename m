Received: from eggs.gnu.org ([209.51.188.92]:42195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw7uC-0001aO-H5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw7uB-0007S2-N4
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:06:00 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-12-kwolf@redhat.com>
	<3efe273b-16af-4927-b684-57cf71275923@redhat.com>
	<20190219112308.GI4727@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c06a66f0-5883-613d-59c0-160b0fd27925@redhat.com>
Date: Tue, 19 Feb 2019 10:04:54 -0600
MIME-Version: 1.0
In-Reply-To: <20190219112308.GI4727@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/12] block: Use normal drain for
 bdrv_set_aio_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On 2/19/19 5:23 AM, Kevin Wolf wrote:
> Am 18.02.2019 um 21:57 hat Eric Blake geschrieben:
>> On 2/18/19 10:18 AM, Kevin Wolf wrote:
>>> Now that bdrv_set_aio_context() works inside drained sections, it can
>>> also use the real drain function instead of open coding something
>>> similar.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---

>>> +/* The caller must own the AioContext lock for the old AioContext of bs, but it
>>> + * must not own the AioContext lock for new_context. */
>>
>> Is this comment still accurate, given
>>
>>>  void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
>>>  {
>>> -    AioContext *ctx = bdrv_get_aio_context(bs);
>>> -
>>> -    if (ctx == new_context) {
>>> +    if (bdrv_get_aio_context(bs) == new_context) {
>>>          return;
>>>      }
>>
>> the short-circuiting when the old context is the new context?
> 
> Hm, yes, old == new is an exception where you quite obviously can't have
> old locked and new unlocked at the same time.
> 
> So is adding this enough?
> 
>     (unless new_context is the same as the current context of bs)

Works for me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
