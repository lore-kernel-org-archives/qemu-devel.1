Received: from eggs.gnu.org ([2001:4830:134:3::10]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cYjk6-0005GK-30
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cYjk2-0006XA-Vj
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:29:50 -0500
Received: from [59.151.112.132] (port=29386 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cYjk2-0006Uo-KG
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:29:46 -0500
References: <1484746795-19523-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<87y3xw8urn.fsf@linaro.org>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <f83bc24b-645d-d050-61c2-bc5d08cee246@cn.fujitsu.com>
Date: Wed, 1 Feb 2017 09:29:26 +0800
MIME-Version: 1.0
In-Reply-To: <87y3xw8urn.fsf@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] vl: Ensure the
 cpu_synchronize_all_post_init() in the appropriate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, sergey.fedorov@linaro.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com

Hi, Alex

Sorry for late reply.

At 01/27/2017 10:03 PM, Alex Bennée wrote:
>
> Dou Liyang <douly.fnst@cn.fujitsu.com> writes:
>
>> At the Qemu initialization, we call the cpu_synchronize_all_post_init()
>> to synchronize All CPU states to KVM in the ./vl.c::main().
>>
>> Currently, it is called before we initialize the CPUs, which created by
>> "-device" command, So, these CPUs may be ignored to synchronize.
>>
>> The patch moves the numa_post_machine_init func in the appropriate
>> location to make sure that all the CPUs has already been created
>> when it is called.
>
> This doesn't match what the patch does (the function is
> cpu_synchronise_all_post_init) but I see another patch is already merged
> that moved the NUMA one.
>

Oops, Yes, I make the mistake.

> I'm afraid you'll need to re-base anyway because it no longer applies
> cleanly.
>

Yes, I will re-base it.

Thanks,

	Liyang


>
>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> ---
>>
>> Change log v1-> v2:
>> 1. Split it from
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03354.html
>> 2. Rewrite the log.
>>
>>  vl.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/vl.c b/vl.c
>> index c643d3f..38269be 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4547,8 +4547,6 @@ int main(int argc, char **argv, char **envp)
>>
>>      audio_init();
>>
>> -    cpu_synchronize_all_post_init();
>> -
>>      numa_post_machine_init();
>>
>>      if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
>> @@ -4571,6 +4569,9 @@ int main(int argc, char **argv, char **envp)
>>                            device_init_func, NULL, NULL)) {
>>          exit(1);
>>      }
>> +
>> +    cpu_synchronize_all_post_init();
>> +
>>      rom_reset_order_override();
>>
>>      /* Did we create any drives that we failed to create a device for? */
>
>
> --
> Alex Bennée
>
>
>
