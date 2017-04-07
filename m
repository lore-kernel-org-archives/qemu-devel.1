Received: from eggs.gnu.org ([2001:4830:134:3::10]:58017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwbPb-0008Ae-Al
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 17:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwbPY-0004fy-4u
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 17:27:19 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwbPY-0004fp-0v
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 17:27:16 -0400
Received: by mail-qt0-x243.google.com with SMTP id r5so11436806qtb.2
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 14:27:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170406154107.9178-1-dgilbert@redhat.com>
	<48d5bb0d-25a9-365c-04fa-e3dad7ecf6e8@redhat.com>
	<6a5a2849-1ae4-cd54-d4f6-00d32f4d7e29@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <417ce2f3-ccb6-16a2-5495-724a66df6365@amsat.org>
Date: Fri, 7 Apr 2017 18:27:11 -0300
MIME-Version: 1.0
In-Reply-To: <6a5a2849-1ae4-cd54-d4f6-00d32f4d7e29@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9?] tests/check-qdict: Fix missing
 brackets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On 04/06/2017 12:55 PM, Eric Blake wrote:
> On 04/06/2017 10:49 AM, Eric Blake wrote:
>> On 04/06/2017 10:41 AM, Dr. David Alan Gilbert (git) wrote:
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> Gcc 7 (on Fedora 26) spotted odd use of integers instead of a
>>> boolean; it's got a point.
>>>
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> ---
>>>  tests/check-qdict.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
>>> index 81162ee572..6f3fbcf9c1 100644
>>> --- a/tests/check-qdict.c
>>> +++ b/tests/check-qdict.c
>>> @@ -559,7 +559,7 @@ static void qdict_join_test(void)
>>>          g_assert(qdict_size(dict1) == 2);
>>>          g_assert(qdict_size(dict2) == !overwrite);
>>>
>>> -        g_assert(qdict_get_int(dict1, "foo") == overwrite ? 84 : 42);
>>> +        g_assert(qdict_get_int(dict1, "foo") == (overwrite ? 84 : 42));
>>
>> How is the test passing pre-patch, and why does it not change the test
>> post-patch?  Does that mean that overwrite is not doing what we expected?
>
> Replying to myself:
>
> Pre-patch, it was reached twice (once for overwrite=false, once for
> overwrite=true), as:
>
> (42 == false) ? 84 : 42
> (84 == true) ? 84 : 42
>
> which simplifies to 42 on both iterations, and g_assert(42) succeeds.
> In fact, this is a tautology - no matter WHAT value we encounter, the
> assert succeeds, so we are not actually testing that the value matters.
>
> Post-patch, it becomes:
>
> 42 == (false ? 84 : 42)
> 84 == (true ? 84 : 42)
>
> which is then asserting that we actually have the value we expect.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Safe for 2.9, but late enough that it also doesn't matter if it slips
> until 2.10.
>

another case which demonstrate human _optimized_ C is more bug prone 
than verbose basic code...

Most cpp generates the same asm code with the following C:

if (overwrite) {
     g_assert(qdict_get_int(dict1, "foo") == 84);
} else {
     g_assert(qdict_get_int(dict1, "foo") == 42);
}

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
