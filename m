Received: from eggs.gnu.org ([2001:4830:134:3::10]:58613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1eXQpD-0008PK-Vq
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1eXQp9-0002zn-Uz
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:10:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1eXQp9-0002xG-EF
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:10:11 -0500
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <e640381f-f64a-b541-1d08-14fcf7d22319@samsung.com>
Date: Fri, 05 Jan 2018 15:10:03 +0300
MIME-version: 1.0
In-reply-to: <6edfb28b-09fe-5fe9-7457-ed1cf1064a89@redhat.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131647eucas1p2ea569225550a2250ee75f76b482b7498@eucas1p2.samsung.com>
	<1509369390-8285-2-git-send-email-a.perevalov@samsung.com>
	<6edfb28b-09fe-5fe9-7457-ed1cf1064a89@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 1/6] migration: introduce
 postcopy-blocktime capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com

On 01/03/2018 12:20 AM, Eric Blake wrote:
> On 10/30/2017 08:16 AM, Alexey Perevalov wrote:
>> Right now it could be used on destination side to
>> enable vCPU blocktime calculation for postcopy live migration.
>> vCPU blocktime - it's time since vCPU thread was put into
>> interruptible sleep, till memory page was copied and thread awake.
>>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>> ---
>>   migration/migration.c | 9 +++++++++
>>   migration/migration.h | 1 +
>>   qapi/migration.json   | 6 +++++-
>>   3 files changed, 15 insertions(+), 1 deletion(-)
>>
> Is there any reason this has to be a new capability rather than
> unconditionally enabled?  What are the trade-offs for enabling vs.
> disabling the capability that warrant it being a knob?  Can we do a
> better job of documenting in which cases the user would want to change
> the knob from its default value, if we even need it to be a knob?
Hello Eric,
sorry for late response, it's holiday in whole Russia.

The reason we decided to introduce new capability it's
performance penalty, memory & cpu usage, in current version
it's not so high as in initial, it affects hot path of post-copy live 
migration.
Regarding documentation part, I'll answer in
"[PATCH v12 6/6] migration: add postcopy total blocktime into query-migrate"
thread.

>
>> +++ b/qapi/migration.json
>> @@ -352,12 +352,16 @@
>>   #
>>   # @x-multifd: Use more than one fd for migration (since 2.11)
>>   #
>> +# @postcopy-blocktime: Calculate downtime for postcopy live migration
>> +#                     (since 2.11)
>> +#
>>   # Since: 1.2
>>   ##
>>   { 'enum': 'MigrationCapability',
>>     'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>>              'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>> -           'block', 'return-path', 'pause-before-switchover', 'x-multifd' ] }
>> +           'block', 'return-path', 'pause-before-switchover', 'x-multifd',
>> +           'postcopy-blocktime' ] }
>>   
>>   ##
>>   # @MigrationCapabilityStatus:
>>

-- 
Best regards,
Alexey Perevalov
