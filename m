Received: from eggs.gnu.org ([2001:4830:134:3::10]:48918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkTfE-00023t-Tj
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkTfA-0001Nc-Vo
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:22:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fkTfA-0001NI-PS
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:22:04 -0400
References: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
	<1533026124-6740-3-git-send-email-liq3ea@gmail.com>
	<20180731112906.GG2476@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e82fc85-41a8-58f1-026c-dc30fdab6dc0@redhat.com>
Date: Tue, 31 Jul 2018 07:22:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180731112906.GG2476@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Add qmp command for
 migrate_set_max_cpu_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, quintela@redhat.com, armbru@redhat.com, liqiang02@corp.netease.com, hzliuyingdong@corp.netease.com, qemu-devel@nongnu.org

On 07/31/2018 06:29 AM, Dr. David Alan Gilbert wrote:
> * Li Qiang (liq3ea@gmail.com) wrote:
>> The default max cpu throttle is 99, this is too big that may
>> influence the guest loads. Add a qmp to config it can make it
>> more flexible.
>>
>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> 
> This should be done as a migration parameter rather than a new command.
> For example, follow the cpu-throttle-increment parameter; and this
> should work just like it.

100% agreed - extend existing commands, instead of inventing a new one. 
But in the future, if you do have a valid reason to add a new command...


>> +++ b/qapi/migration.json
>> @@ -997,6 +997,19 @@
>>   { 'command': 'migrate_set_speed', 'data': {'value': 'int'} }
>>   
>>   ##
>> +# @migrate_set_max_cpu_throttle:
>> +#
>> +# Set maximum cpu throttle for migration.
>> +#
>> +# @value: maximum cpu throttle.
>> +#
>> +# Returns: nothing on success
>> +#
>> +# Since: 2.12

You've missed 2.12 by a long shot; you've also missed freeze for 3.0. 
The earliest you can introduce this is 3.1 (which does need to be 
documented even if you properly add this as a new parameter to the 
existing migration parameter commands).

>> +##
>> +{ 'command': 'migrate_set_max_cpu_throttle', 'data': {'value': 'int'} }

...new commands should favor '-' rather than '_' for separation between 
words.  And your documentation should mention which unit the throttle is 
in (bytes per second?)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
