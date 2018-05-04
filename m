Received: from eggs.gnu.org ([2001:4830:134:3::10]:38135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEc7z-0004HL-Iv
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEc7w-0002wR-Cw
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:56:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fEc7w-0002wC-7j
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:56:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 605EC42EF0F7
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 14:56:03 +0000 (UTC)
References: <1525326658-3078-1-git-send-email-thuth@redhat.com>
	<87k1slot93.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <54f1bb8c-c61e-557a-952d-92ba1297e818@redhat.com>
Date: Fri, 4 May 2018 16:55:57 +0200
MIME-Version: 1.0
In-Reply-To: <87k1slot93.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net: Silence 'has no peer' messages in
 testing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On 03.05.2018 13:47, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> When running qtests with -nodefaults, we are not interested in
>> these 'XYZ has no peer' messages.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  net/net.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/net.c b/net/net.c
>> index 29f8398..58bf85e 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -1427,12 +1427,13 @@ void net_check_clients(void)
>>  
>>      net_hub_check_clients();
>>  
>> -    QTAILQ_FOREACH(nc, &net_clients, next) {
>> -        if (!nc->peer) {
>> -            warn_report("%s %s has no peer",
>> -                        nc->info->type == NET_CLIENT_DRIVER_NIC
>> -                        ? "nic" : "netdev",
>> -                        nc->name);
>> +    if (!qtest_enabled() || nd_table[0].used) {
> 
> I understand the !qtest_enabled part, but not the nd_table[0].used
> part.  Can you explain?

Sure: I want to silence the message in qtest mode with -nodefaults.
qtest mode enabled means qtest_enabled() returns true.
-nodefaults enabled means nd_table[0].used is set to false.
So silence the message if qtest_enabled() && !nd_table[0].used.
Negates to: Print the message if !qtest_enabled || nd_table[0].used.

>> +        QTAILQ_FOREACH(nc, &net_clients, next) {
>> +            if (!nc->peer) {
>> +                warn_report("%s %s has no peer",
>> +                            nc->info->type == NET_CLIENT_DRIVER_NIC
>> +                            ? "nic" : "netdev", nc->name);
>> +            }
>>          }
>>      }

 Thomas
