Received: from eggs.gnu.org ([2001:4830:134:3::10]:32818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpCQv-0000un-Qi
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpCQq-0007Tc-SG
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:54:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dpCQq-0007Sj-Le
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D5FA68D7
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 11:54:15 +0000 (UTC)
References: <b604df0885958328765a9d481186a5d60a9ab4b1.1504609507.git.mprivozn@redhat.com>
	<87shg1tle7.fsf@dusky.pond.sub.org>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <3b92c8bd-6575-1821-757a-8256639c45da@redhat.com>
Date: Tue, 5 Sep 2017 13:54:13 +0200
MIME-Version: 1.0
In-Reply-To: <87shg1tle7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] watchdog: Allow setting action on the fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 09/05/2017 01:50 PM, Markus Armbruster wrote:
> Michal Privoznik <mprivozn@redhat.com> writes:
> 
>> Currently, the only time that users can set watchdog action is at
>> the start as all we expose is this -watchdog-action command line
>> argument. This is suboptimal when users want to plug the device
>> later via monitor. Alternatively, they might want to change the
>> action for already existing device on the fly.
>>
>> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1447169
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>  hw/watchdog/watchdog.c | 9 +++++++++
>>  qapi-schema.json       | 9 +++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
>> index 0c5c9cde1c..971f05c61a 100644
>> --- a/hw/watchdog/watchdog.c
>> +++ b/hw/watchdog/watchdog.c
>> @@ -29,6 +29,8 @@
>>  #include "qapi-event.h"
>>  #include "hw/nmi.h"
>>  #include "qemu/help_option.h"
>> +#include "qmp-commands.h"
>> +#include "qapi/qmp/qerror.h"
>>  
>>  static int watchdog_action = WDT_RESET;
>>  static QLIST_HEAD(watchdog_list, WatchdogTimerModel) watchdog_list;
>> @@ -147,3 +149,10 @@ void watchdog_perform_action(void)
>>          break;
>>      }
>>  }
>> +
>> +void qmp_watchdog_set_action(const char *action, Error **errp)
>> +{
>> +    if (select_watchdog_action(action) == -1) {
>> +        error_setg(errp, QERR_INVALID_PARAMETER, action);
>> +    }
>> +}
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 802ea53d00..be81ffc0bb 100644
>> --- a/qapi-schema.json
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
>> +{ 'command': 'watchdog-set-action', 'data' : {'action': 'str'} }
> 
> @action needs to be a QAPI enum.  It'll replace the #defines in
> watchdog.  select_watchdog_action() then calls qapi_enum_parse() to map
> string to enum, and qmp_watchdog_set_action() to make the actual change.

Oh, okay. Sure, I can do that. I guess it makes the set of actions
introspectable?

Michal
