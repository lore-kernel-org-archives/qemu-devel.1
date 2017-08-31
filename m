Received: from eggs.gnu.org ([2001:4830:134:3::10]:35316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnK9v-0007dm-SO
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnK9r-0005o0-KO
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:45:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnK9r-0005ng-Dg
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:44:59 -0400
From: Thomas Huth <thuth@redhat.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-4-pasic@linux.vnet.ibm.com>
	<62fe261c-09d4-e4c2-fb88-b8c05b700e56@redhat.com>
Message-ID: <f6d0ca23-f98b-6187-22ee-2a05098193c0@redhat.com>
Date: Thu, 31 Aug 2017 09:44:55 +0200
MIME-Version: 1.0
In-Reply-To: <62fe261c-09d4-e4c2-fb88-b8c05b700e56@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] s390x/css: be more consistent if
 broken beyond repair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 31.08.2017 08:10, Thomas Huth wrote:
> On 30.08.2017 18:36, Halil Pasic wrote:
>> If we detect that the internally manged state of the subchannel
>> is broken beyond repair while in do_subchannel_work in case of
>> virtual we just abort the operation and pretend all went well,
>> while in case of pass-through we honor the situation with -ENODEV
>> which results in cc 3 for the instruction whose handler triggered
>> the call.
>>
>> Let's be consistent on this and do the -ENODEV also for virtual
>> subchannels.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/css.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 0822538cde..bc47bf5b20 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -1078,7 +1078,7 @@ int do_subchannel_work_virtual(SubchDev *sch)
>>          sch_handle_start_func_virtual(sch);
>>      } else {
>>          /* Cannot happen. */
>> -        return 0;
>> +        return -ENODEV;
>>      }
>>      css_inject_io_interrupt(sch);
>>      return 0;
> 
> First, I think ENODEV is not really a good choice here since there
> certainly was a device. So maybe use EINVAL or EBADR or something else
> instead?
>
> Second, while return an error code is certainly better than returning 0,
> I think most errors will still go unnoticed here, since most callers of
> do_subchannel_work() seem to ignore the return value ... so I wonder
> whether we rather want to have another way to recognize this condition.
> If the comment is right and this really can not happen, I think you
> should use an g_assert_notreached() here instead. Otherwise the comment
> should be changed and it's maybe a good idea to use a
> qemu_log_mask(LOG_GUEST_ERROR, "subchannel in bad state bla bla...") here.

OK, after reading through patch 4/9 I think I've got the basic idea now
... you'll eventually set sch->iret.cc = 3 here instead, so the exact
error code does not really matter here.
But still - if it "Cannot happen", maybe an assert() or an additional
qemu_log would be appropriate?

 Thomas
