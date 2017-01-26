Received: from eggs.gnu.org ([2001:4830:134:3::10]:38100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWih3-0007YG-BK
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWigz-00005j-FN
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:58:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWigz-00005S-5e
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:58:17 -0500
References: <20170126100705.6005-1-pbonzini@redhat.com>
	<20170126125433.5979903a@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0039c2fd-34cd-10a1-7f42-0baad9e40412@redhat.com>
Date: Thu, 26 Jan 2017 12:58:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170126125433.5979903a@bahia.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix v9fs_lock error case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com



On 26/01/2017 12:54, Greg Kurz wrote:
> On Thu, 26 Jan 2017 11:07:05 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> In this case, we are marshaling an error status instead of the errno value.
>> Reorganize the out and out_nofid labels to look like all the other cases.
>> Coverity reports this because the "err = -ENOENT" and "err = -EINVAL"
>> assignments above are dead, overwritten by the call to pdu_marshal.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
> 
> There was a confusion indeed: if the server fails it should report it to the
> client with an RERROR message.
> 
> Responding an RLOCK message with a P9_LOCK_ERROR status only makes sense
> when actually implementing locking (i.e. calling flock() on the backend),
> which isn't the case in QEMU as stated in the comment above v9fs_lock(). 
> We should hence always report a P9_LOCK_SUCCESS status when responding
> an RLOCK message.

Which my patch does in a very roundabout way: the first assignment to
status is now dead, and the pdu_marshal("b") always uses P9_LOCK_SUCCESS.

> Just to make it clear, I've modified your patch to open code this and
> pushed it to https://github.com/gkurz/qemu/commits/9p-next .

Much, better, thanks.

Paolo

> BTW, I've registered to https://scan.coverity.com/projects/qemu as
> Peter suggested on IRC. I'll have a look at the other 9pfs issues.
> 
> Cheers.
> 
> --
> Greg
> 
>>  hw/9pfs/9p.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>> index 99e9472..d028eca 100644
>> --- a/hw/9pfs/9p.c
>> +++ b/hw/9pfs/9p.c
>> @@ -3045,14 +3045,15 @@ static void coroutine_fn v9fs_lock(void *opaque)
>>          goto out;
>>      }
>>      status = P9_LOCK_SUCCESS;
>> -out:
>> -    put_fid(pdu, fidp);
>> -out_nofid:
>>      err = pdu_marshal(pdu, offset, "b", status);
>> -    if (err > 0) {
>> -        err += offset;
>> +    if (err < 0) {
>> +        goto out;
>>      }
>> +    err += offset;
>>      trace_v9fs_lock_return(pdu->tag, pdu->id, status);
>> +out:
>> +    put_fid(pdu, fidp);
>> +out_nofid:
>>      pdu_complete(pdu, err);
>>      v9fs_string_free(&flock.client_id);
>>  }
> 
