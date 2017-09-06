Received: from eggs.gnu.org ([2001:4830:134:3::10]:56510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpTQ7-0001ZA-Bd
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpTQ2-00067Z-CJ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:02:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dpTQ2-00066a-6E
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:02:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 307227E426
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 06:02:33 +0000 (UTC)
References: <f9d56290959d378dfa65b3906bf0d822ab938ac9.1504617551.git.mprivozn@redhat.com>
	<a0659c96-31c6-d193-19bb-438fe6aa2601@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <8173dc23-3027-9ca2-9567-c70534728d75@redhat.com>
Date: Wed, 6 Sep 2017 08:02:31 +0200
MIME-Version: 1.0
In-Reply-To: <a0659c96-31c6-d193-19bb-438fe6aa2601@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] watchdog: Allow setting action on the
 fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 09/05/2017 10:36 PM, Eric Blake wrote:
> On 09/05/2017 08:22 AM, Michal Privoznik wrote:
>> Currently, the only time that users can set watchdog action is at
>> the start as all we expose is this -watchdog-action command line
>> argument. This is suboptimal when users want to plug the device
>> later via monitor. Alternatively, they might want to change the
>> action for already existing device on the fly.
>>
>> At the same time, drop local redefinition of the actions eum in
> 
> s/eum/enum/
> 
>> watchdog.h in favour of the ones defined in schema.
>>
>> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1447169
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
> 
>> @@ -77,27 +80,17 @@ int select_watchdog(const char *p)
>>  
>>  int select_watchdog_action(const char *p)
>>  {
> 
>> +    int action;
>>  
>> +    action = qapi_enum_parse(WatchdogExpirationAction_lookup, p,
>> +                             WATCHDOG_EXPIRATION_ACTION__MAX, -1, NULL);
> 
> Semantic conflict; you need to rebase now that the qapi enum lookup code
> has landed (see commit ebf677c8 and parents)


D'oh. Okay.

> 
>> +
>> +    case WATCHDOG_EXPIRATION_ACTION__MAX:
>> +        /* keep gcc happy */
>> +        break;
> 
> Could use g_assert_not_reached() here instead.
> 
>> +++ b/qapi-schema.json
>> @@ -6539,3 +6539,12 @@
>>  # Since 2.9
>>  ##
>>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>> +
>> +##
>> +# @watchdog-set-action:
>> +#
>> +# Set watchdog action
>> +#
>> +# Since 2.11
>> +##
>> +{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogExpirationAction'} }
> 
> Can a machine have more than one watchdog device, in which case you'd
> want a device name to select which watchdog gets which action?  But the
> command-line version that you are replacing seems to be global, so I
> guess you're okay with this interface.
> 

Yeah, I don't think that a guest can have more than one watchdog:

/qemu.git $ ./x86_64-softmmu/qemu-system-x86_64 \
-watchdog ib700 -watchdog i6300esb
qemu-system-x86_64: -watchdog i6300esb: only one watchdog option may be
given

Also, would it make sense? I mean, what would be the benefit of having
two or more watchdogs?

Michal
