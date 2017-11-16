Received: from eggs.gnu.org ([2001:4830:134:3::10]:48064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eFJIa-0007IC-2I
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eFJIW-0003vA-4q
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:29:40 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30878
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eFJIV-0003tz-Pk
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:29:36 -0500
References: <20171116022832.24894-1-maozy.fnst@cn.fujitsu.com>
	<20171116101348.vmwthadfeu3mzuke@starbug-vm.ie.oracle.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <35b94bce-6c06-a982-5568-2cabfb1e595f@cn.fujitsu.com>
Date: Thu, 16 Nov 2017 20:25:35 +0800
MIME-Version: 1.0
In-Reply-To: <20171116101348.vmwthadfeu3mzuke@starbug-vm.ie.oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] colo-compare: fix the dangerous assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>



On 11/16/2017 06:13 PM, Darren Kenny wrote:
> On Thu, Nov 16, 2017 at 10:28:32AM +0800, Mao Zhongyi wrote:
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Zhang Chen <zhangckid@gmail.com>
>> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Fixes: 8ec14402029d783720f4312ed8a925548e1dad61
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>
> Code-wise, this looks like a valid fix to the existing code.
>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Hi, Darren

> But testing wise, have you confirmed that things are behaving as you
> expected with the previous patch, since previously when calling
> colo_compare_connection(), the value of conn would have always been
> its initialized value of NULL.

Well, in my test machine the code like *con = conn, but when I made
the patch on another machine I wrote the code con = &conn carelessly.

> Just want to be sure that fixing this doesn't end up breaking your
> expected behaviour given that all your testing before would have had
> a NULL value in conn.

Thanks for the kind reminder.

Thanks,
Mao

> Thanks,
>
> Darren.
>
>> ---
>> net/colo-compare.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index ccdcba2..1ce195f 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -179,7 +179,7 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
>>                          "drop packet");
>>         }
>>     }
>> -    con = &conn;
>> +    *con = conn;
>>
>>     return 0;
>> }
>> --
>> 2.9.4
>>
>>
>>
>>
>
>
>
