Received: from eggs.gnu.org ([2001:4830:134:3::10]:32953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gHspm-0004pg-AN
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gHsph-0007eB-30
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:55:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gHspg-0007dY-Sq
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:55:01 -0400
References: <1540365080-6844-1-git-send-email-liq3ea@gmail.com>
	<4d64d42a-8727-81aa-6015-a9db92abca76@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b8e3151d-b453-67a7-89ef-cdf2ff257a6b@redhat.com>
Date: Wed, 31 Oct 2018 10:54:56 -0500
MIME-Version: 1.0
In-Reply-To: <4d64d42a-8727-81aa-6015-a9db92abca76@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fw_cfg_reboot: ensure reboot_time is
 nonegative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Li Qiang <liq3ea@gmail.com>, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 10/24/18 6:35 AM, Laszlo Ersek wrote:
> On 10/24/18 09:11, Li Qiang wrote:
>> This can avoid setting a negative value to
>> etc/boot-fail-wait.
>>
>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>> ---
>>   hw/nvram/fw_cfg.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index f4a52d8..276dcb1 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -199,12 +199,17 @@ static void fw_cfg_reboot(FWCfgState *s)
>>               reboot_timeout = strtol(p, &p, 10);

Looks like Markus handled the question about replacing strtol(), so I'll 
just point out one additional nit:

>>           }
>>       }
>> -    /* validate the input */
>> -    if (reboot_timeout > 0xffff) {
>> -        error_report("reboot timeout is larger than 65535, force it to 65535.");

Pre-existing, but now's as good a time as any to improve it:

>> -        reboot_timeout = 0xffff;
>> +
>> +    if (reboot_timeout >= 0) {
>> +        /* validate the input */
>> +        if (reboot_timeout > 0xffff) {
>> +            error_report("reboot timeout is larger than 65535,"
>> +                         "force it to 65535.");

error_report() callers generally do not end with trailing '.'

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
