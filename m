Received: from eggs.gnu.org ([2001:4830:134:3::10]:55924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpTNN-0000hR-JA
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpTNI-0004e7-Kq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:59:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpTNI-0004dl-Bl
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57B198553C
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 05:59:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <f9d56290959d378dfa65b3906bf0d822ab938ac9.1504617551.git.mprivozn@redhat.com>
	<a0659c96-31c6-d193-19bb-438fe6aa2601@redhat.com>
Date: Wed, 06 Sep 2017 07:59:41 +0200
In-Reply-To: <a0659c96-31c6-d193-19bb-438fe6aa2601@redhat.com> (Eric Blake's
	message of "Tue, 5 Sep 2017 15:36:15 -0500")
Message-ID: <87k21cfjua.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

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
>
>> +
>> +    case WATCHDOG_EXPIRATION_ACTION__MAX:
>> +        /* keep gcc happy */
>> +        break;
>
> Could use g_assert_not_reached() here instead.

Catches one out of approximately 2^64 invalid values.  To catches all,
and in fewer words:

        default:
            assert(0);

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

For better or worse, all watchdogs share the action, see
hw/watchdog/watchdog.c.

Watchdogs predate qdev.  Commit 9dd986c lets you configure up to one,
with two command line options: --watchdog and --watchdog-action.  In a
way, --watchdog configures the frontend, and --watchdog-action the
backend (having watchdog.c in hw/watchdog/ contradicts this view,
though).

Since the frontends got qdevified (commit 09aaa16), you can configure
any number of watchdog frontends, but still only one backend shared by
all.  Unsharing the backend wasn't worth the trouble, because having
multiple watchdogs would be weird, and multiple watchdogs with different
actions would be weirder.  Trouble would include maintaining command
line backward compatibility, as always.

Of course, if we *want* to unshare the backend, we should do it *before*
we add QMP backward compatibility to the trouble.
