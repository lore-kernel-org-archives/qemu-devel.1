Received: from eggs.gnu.org ([2001:4830:134:3::10]:40458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gAZyy-000464-Sx
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gAZyy-0003nh-0o
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:22:24 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:40719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gAZyx-0003nU-SV
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:22:23 -0400
Received: by mail-qt1-x843.google.com with SMTP id b4-v6so9498092qtc.7
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 05:22:23 -0700 (PDT)
References: <20180918185246.18109-1-danielhb413@gmail.com>
	<20180918185246.18109-3-danielhb413@gmail.com>
	<875zy97wxp.fsf@dusky.pond.sub.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <becedf12-3d15-a073-0cd3-39d20a7e241a@gmail.com>
Date: Thu, 11 Oct 2018 09:22:18 -0300
MIME-Version: 1.0
In-Reply-To: <875zy97wxp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v9 2/3] qga: update guest-suspend-ram and
 guest-suspend-hybrid descriptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, mdroth@linux.vnet.ibm.com, imammedo@redhat.com



On 10/11/18 4:40 AM, Markus Armbruster wrote:
> Daniel Henrique Barboza <danielhb413@gmail.com> writes:
>
>> This patch updates the descriptions of 'guest-suspend-ram' and
>> 'guest-suspend-hybrid' to mention that both commands relies now
>> on the proper support for wake up from suspend, retrieved by the
>> 'wakeup-suspend-support' attribute of the 'query-current-machine'
>> QMP command.
>>
>> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> ---
>>   qga/qapi-schema.json | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> index dfbc4a5e32..7ae7e2502c 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json
>> @@ -567,9 +567,9 @@
>>   # For the best results it's strongly recommended to have the pm-utils
>>   # package installed in the guest.
>>   #
>> -# IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
>> -# command.  Thus, it's *required* to query QEMU for the presence of the
>> -# 'system_wakeup' command before issuing guest-suspend-ram.
>> +# IMPORTANT: guest-suspend-ram requires working wakeup support in
>> +# QEMU. You *must* check QMP command query-current-machine returns
>> +# wakeup-suspend-support: true before issuing this command.
>>   #
>>   # This command does NOT return a response on success. There are two options
>>   # to check for success:
>> @@ -594,9 +594,9 @@
>>   #
>>   # This command requires the pm-utils package to be installed in the guest.
>>   #
>> -# IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
>> -# command.  Thus, it's *required* to query QEMU for the presence of the
>> -# 'system_wakeup' command before issuing guest-suspend-hybrid.
>> +# IMPORTANT: guest-suspend-hybrid requires working wakeup support in
>> +# QEMU. You *must* check QMP command query-current-machine returns
>> +# wakeup-suspend-support: true before issuing this command.
>>   #
>>   # This command does NOT return a response on success. There are two options
>>   # to check for success:
> The emphasis in "You *must* check" hints at all kinds of terrible
> disasters if you don't, but then you're not pointing to any.
>
> So, what can happen if you issue this command when query-current-machine
> returns wakeup-suspend-support: false?

That's fair. If you don't check for flag when issuing 
guest-suspend-{ram/hybrid},
what happens is that QEMU will suspend the guest (QGA will suspend the
guest via systemctl, regardless of the guest arch) but system_wakeup 
will not
be able to wake the guest back up. You'll need to reboot the guest.

What  do you think of this new text?

+# IMPORTANT: guest-suspend-hybrid requires working wakeup support in
+# QEMU. You *must* check QMP command query-current-machine returns
+# wakeup-suspend-support: true before issuing this command. Failure in
+# doing so can result in a suspended guest that QEMU will not be able to
+# awaken, forcing the user to power cycle the guest to bring it back.
