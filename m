Received: from eggs.gnu.org ([2001:4830:134:3::10]:54469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gMbid-0002yB-F0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gMbic-0003As-Bd
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:39:15 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gMbic-0003AU-5e
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:39:14 -0500
Received: by mail-qk1-x742.google.com with SMTP id d135so20478945qkc.12
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 08:39:14 -0800 (PST)
References: <20181113160908.12706-1-danielhb413@gmail.com>
	<7274afaf-06ad-c93f-370a-151f1605cabb@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <914ac120-dcd1-06ac-7a97-5cc73b759cb0@gmail.com>
Date: Tue, 13 Nov 2018 14:39:09 -0200
MIME-Version: 1.0
In-Reply-To: <7274afaf-06ad-c93f-370a-151f1605cabb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] qga: update docs with systemd suspend
 support info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com



On 11/13/18 2:32 PM, Eric Blake wrote:
> On 11/13/18 10:09 AM, Daniel Henrique Barboza wrote:
>> Commit 067927d62e ("qga: systemd hibernate/suspend/hybrid-sleep
>> support") failed to update qapi-schema.json after adding systemd
>> hibernate/suspend/hybrid-sleep capabilities to guest-suspend-* QGA
>> commands.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   qga/qapi-schema.json | 37 ++++++++++++++++++++++++++-----------
>>   1 file changed, 26 insertions(+), 11 deletions(-)
>
>> +++ b/qga/qapi-schema.json
>> @@ -532,12 +532,16 @@
>>   #
>>   # Suspend guest to disk.
>>   #
>> -# This command tries to execute the scripts provided by the pm-utils 
>> package.
>> -# If it's not available, the suspend operation will be performed by 
>> manually
>> -# writing to a sysfs file.
>> +# This command attempts to suspend the guest using three strategies, 
>> in this
>> +# order:
>>   #
>> -# For the best results it's strongly recommended to have the pm-utils
>> -# package installed in the guest.
>> +# - systemd hibernate
>> +# - pm-utils (via pm-hibernate)
>> +# - manual write into sysfs
>> +#
>> +# If the guest does not have systemd hibernate support, the scripts 
>> in pm-utils
>> +# package are executed, in case pm-utils is available. Manual write 
>> in sysfs
>> +# is a last resort.
>
> Does this paragraph add any information compared to the earlier list?

Perhaps we can remove the paragraph and add "if available" remarks in 
the listing?
Like:

+# - systemd hibernate, if supported
+# - pm-utils (via pm-hibernate), if pm-utils is installed
+# - manual write into sysfs as a last resort

Same for the other 2 cases below.

>
>>   #
>>   # This command does NOT return a response on success. There is a 
>> high chance
>>   # the command succeeded if the VM exits with a zero exit status or, 
>> when
>> @@ -560,12 +564,16 @@
>>   #
>>   # Suspend guest to ram.
>>   #
>> -# This command tries to execute the scripts provided by the pm-utils 
>> package.
>> -# If it's not available, the suspend operation will be performed by 
>> manually
>> -# writing to a sysfs file.
>> +# This command attempts to suspend the guest using three strategies, 
>> in this
>> +# order:
>> +#
>> +# - systemd suspend
>> +# - pm-utils (via pm-suspend)
>> +# - manual write into sysfs
>>   #
>> -# For the best results it's strongly recommended to have the pm-utils
>> -# package installed in the guest.
>> +# If the guest does not have systemd suspend support, the scripts in 
>> pm-utils
>> +# package are executed, in case pm-utils is available. Manual write 
>> in sysfs
>> +# is a last resort.
>
> Likewise.
>
>>   #
>>   # IMPORTANT: guest-suspend-ram requires QEMU to support the 
>> 'system_wakeup'
>>   # command.  Thus, it's *required* to query QEMU for the presence of 
>> the
>> @@ -592,7 +600,14 @@
>>   #
>>   # Save guest state to disk and suspend to ram.
>>   #
>> -# This command requires the pm-utils package to be installed in the 
>> guest.
>> +# This command attempts to suspend the guest using three strategies, 
>> in this
>> +# order:
>> +#
>> +# - systemd hybrid-sleep
>> +# - pm-utils (via pm-suspend-hybrid)
>> +#
>> +# If the guest does not have systemd hybrid-sleep support, the 
>> scripts in
>> +# pm-utils package are executed, in case pm-utils is available.
>
> "using three strategies" but a list of only 2 seems odd.
>

Copy/paste busted!
