Received: from eggs.gnu.org ([2001:4830:134:3::10]:51640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eLpi1-0001mY-8X
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eLphy-0000O2-4N
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:18:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eLphx-0000Nn-UJ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:18:50 -0500
References: <1511505030-3669-1-git-send-email-yang.zhong@intel.com>
	<5A1A5C6E.9060409@huawei.com> <20171201105622.GB26237@yangzhon-Virtual>
	<74cccd14-e485-90d4-82d9-03355c05faca@redhat.com>
	<20171204120322.GA32151@yangzhon-Virtual>
	<20171204120705.GE20203@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9deb146d-b701-87fb-7fde-2ba04f02b29a@redhat.com>
Date: Mon, 4 Dec 2017 13:18:43 +0100
MIME-Version: 1.0
In-Reply-To: <20171204120705.GE20203@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: zhaoshenglong@huawei.com, stefanha@redhat.com, qemu-devel@nongnu.org, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, zhang.zhanghailiang@huawei.com

On 04/12/2017 13:07, Daniel P. Berrange wrote:
> On Mon, Dec 04, 2017 at 08:03:22PM +0800, Yang Zhong wrote:
>> On Fri, Dec 01, 2017 at 01:52:49PM +0100, Paolo Bonzini wrote:
>>> On 01/12/2017 11:56, Yang Zhong wrote:
>>>>   This issue should be caused by much times of system call by malloc_trim(),
>>>>   Shannon's test script include 60 scsi disks and 31 ioh3420 devices. We need 
>>>>   trade-off between VM perforamance and memory optimization. Whether below 
>>>>   method is suitable?
>>>>
>>>>   int num=1;
>>>>   ......
>>>>
>>>>   #if defined(CONFIG_MALLOC_TRIM)
>>>>         if(!(num++%5))
>>>>         {
>>>>              malloc_trim(4 * 1024 * 1024);
>>>>         }
>>>>   #endif
>>>>  
>>>>   Any comments are welcome! Thanks a lot!
>>>
>>> Indeed something like this will do, perhaps only trim once per second?
>>>
>>   Hello Paolo,
>>
>>   Thanks for comments!
>>   If we do trim once per second, maybe the frequency is a little high, what'e
>>   more, we need maintain one timer to call this, this also cost cpu resource.
>>
>>   I added the log and did the test here with my test qemu command, when VM bootup,
>>   which did more than 600 times free operations and 9 times memory trim in rcu 
>>   thread. If i use our ClearContainer qemu command, the memory trim will down 
>>   to 6 times. As for Shannon's test command, the malloc trim number will abosultly 
>>   increse.
>>
>>   In my above method, the trim is only executed in the multiple of 5, which will
>>   reduce trim times and do not heavily impact VM bootup performance. 
>>
>>   I also want to use synchronize_rcu() and free() to replace call_rcu(), but this
>>   method serialize to malloc() and free(), which will reduce VM performance.
>>
>>   The ultimate aim is to reduce trim system call during the VM bootup and running.
>>   It's appreciated that if you have better suggestions.
> 
> Does configuring QEMU to use tcmalloc or jemalloc instead of glibc's malloc
> give you the performance & menmory usage that you require? If so, it might
> not be worth bothering to hack around problems in glibc's malloc at all.

At least for tcmalloc, the default tuning is to pay little attention to
memory usage.

Paolo
