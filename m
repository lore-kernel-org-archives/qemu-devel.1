Received: from eggs.gnu.org ([2001:4830:134:3::10]:42344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpUD5-0001eN-5G
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpUD1-0002G7-QB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:53:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dpUD1-0002FU-KD
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:53:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55972356C2
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 06:53:10 +0000 (UTC)
References: <f9d56290959d378dfa65b3906bf0d822ab938ac9.1504617551.git.mprivozn@redhat.com>
	<a0659c96-31c6-d193-19bb-438fe6aa2601@redhat.com>
	<87k21cfjua.fsf@dusky.pond.sub.org>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <49513875-a104-5150-7687-42a5203356fa@redhat.com>
Date: Wed, 6 Sep 2017 08:53:08 +0200
MIME-Version: 1.0
In-Reply-To: <87k21cfjua.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On 09/06/2017 07:59 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 09/05/2017 08:22 AM, Michal Privoznik wrote:
>>> Currently, the only time that users can set watchdog action is at
>>> the start as all we expose is this -watchdog-action command line
>>> argument. This is suboptimal when users want to plug the device
>>> later via monitor. Alternatively, they might want to change the
>>> action for already existing device on the fly.
>>>
>>> At the same time, drop local redefinition of the actions eum in
>>
>> s/eum/enum/
>>
>>> watchdog.h in favour of the ones defined in schema.
>>>
>>> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1447169
>>>
>>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>>> ---
>>
>>> @@ -77,27 +80,17 @@ int select_watchdog(const char *p)
>>>  
>>>  int select_watchdog_action(const char *p)
>>>  {
>>
>>> +    int action;
>>>  
>>> +    action = qapi_enum_parse(WatchdogExpirationAction_lookup, p,
>>> +                             WATCHDOG_EXPIRATION_ACTION__MAX, -1, NULL);
>>
>> Semantic conflict; you need to rebase now that the qapi enum lookup code
>> has landed (see commit ebf677c8 and parents)
>>
>>> +
>>> +    case WATCHDOG_EXPIRATION_ACTION__MAX:
>>> +        /* keep gcc happy */
>>> +        break;
>>
>> Could use g_assert_not_reached() here instead.
> 
> Catches one out of approximately 2^64 invalid values.  To catches all,
> and in fewer words:
> 
>         default:
>             assert(0);

I'm not a fan of this, but I'm not a qemu developer so I don't know what
your coding style is (if any for this case). However, since this switch
is over an enum, compiler will scream if a new value is introduced to
the enum and not handled in the switch. IMO it's useful because when I'm
adding new value I can immediately see what other places I need to consider.

Also, yeah, I am going to rename the enum in v3.

Michal
