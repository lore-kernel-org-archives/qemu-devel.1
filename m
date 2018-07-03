Received: from eggs.gnu.org ([2001:4830:134:3::10]:34862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faHj1-0007VA-0l
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faHiy-0007n2-Bx
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:35:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1faHiy-0007ms-5Z
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:35:52 -0400
References: <1529053904-12607-1-git-send-email-dimastep@yandex-team.ru>
	<20180702085207.GA6032@dimastep-nix>
	<5149995f-2bb2-cbe8-1a2c-e16ed0ee3cd6@redhat.com>
	<20180703092711.GA823@dimastep-nix>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85ff3641-4d5f-2021-5364-b6d1d5823ec1@redhat.com>
Date: Tue, 3 Jul 2018 11:35:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180703092711.GA823@dimastep-nix>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] qemu-pr-helper: garbage response
 structure can be used to write data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>
Cc: qemu-devel@nongnu.org, wrfsh@yandex-team.ru

On 03/07/2018 11:27, Dima Stepanov wrote:
> On Mon, Jul 02, 2018 at 02:21:41PM +0200, Paolo Bonzini wrote:
>> On 02/07/2018 10:52, Dima Stepanov wrote:
>>> Ping.
>>>
>>> On Fri, Jun 15, 2018 at 12:11:44PM +0300, Dima Stepanov wrote:
>>>> The prh_co_entry() routine handles requests. The first part is to read a
>>>> request by calling the prh_read_request() routine, if:
>>>>   1. scsi_cdb_xfer(req->cdb) call returns 0, and
>>>>   2. req->cdb[0] == PERSISTENT_RESERVE_IN, then
>>>> The resp->result field will be uninitialized. As a result the resp.sz
>>>> field will be also uninitialized in the prh_co_entry() function.
>>>> The second part is to send the response by calling the
>>>> prh_write_response() routine:
>>>>   1. For the PERSISTENT_RESERVE_IN command, and
>>>>   2. resp->result == GOOD (previous successful reply or just luck), then
>>>> There is a probability that the following assert will not be trigered:
>>>>   assert(resp->sz <= req->sz && resp->sz <= sizeof(client->data));
>>>> As a result some uninitialized response will be sent.
>>>>
>>>> The fix is to initialize the response structure to CHECK_CONDITION and 0
>>>> values before calling the prh_read_request() routine.
>>
>> The actual bug is that the "if (sz > 0)" should apply only to 
>> PERSISTENT_RESERVE_OUT, and in fact it can be done in do_pr_out.  
>> PERSISTENT_RESERVE_IN with sz == 0 is weird but okay.
>>
>> This simplifies the code a bit too, because we can handle closing the 
>> file descriptor in prh_co_entry.
>>
>> Does something like this work for you?
> 
> Thanks for the feedback. Yes, this will work for me. Should i update the
> patch and resend it or you will just pick the version you suggested?

I will pick it, thanks!

Paolo
