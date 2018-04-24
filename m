Received: from eggs.gnu.org ([2001:4830:134:3::10]:35680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fAr9K-0006Gn-16
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 02:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fAr9G-0004kp-Lq
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 02:09:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fAr9G-0004kZ-Gi
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 02:09:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF58740201A2
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 06:09:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180420231246.23130-1-lersek@redhat.com>
	<20180420231246.23130-3-lersek@redhat.com>
	<87y3hented.fsf@dusky.pond.sub.org>
	<e1920d3f-cd23-6e53-32af-7c084734370d@redhat.com>
Date: Tue, 24 Apr 2018 08:09:40 +0200
In-Reply-To: <e1920d3f-cd23-6e53-32af-7c084734370d@redhat.com> (Laszlo Ersek's
	message of "Mon, 23 Apr 2018 20:42:22 +0200")
Message-ID: <87efj5jftn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [qemu RFC v3 2/3] qapi: change the type of
 TargetInfo.arch from string to enum SysEmuTarget
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <dgibson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Laszlo Ersek <lersek@redhat.com> writes:

> On 04/23/18 11:50, Markus Armbruster wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>> 
>>> Now that we have @SysEmuTarget, it makes sense to restict
>>> @TargetInfo.@arch to valid sysemu targets at the schema level.
>> 
>> We could mention that supported targets become visible in QMP
>> introspection.  But I can't see what QMP clients could do with this
>> information, so let's not bother.
>> 
>>>
>>> Cc: "Daniel P. Berrange" <berrange@redhat.com>
>>> Cc: David Gibson <dgibson@redhat.com>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Kashyap Chamarthy <kchamart@redhat.com>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>> ---
>>>
>>> Notes:
>>>     RFCv3:
>>>     
>>>     - The patch is new in this version. [Markus]
>>>
>>>  qapi/misc.json |  6 ++++--
>>>  arch_init.c    | 18 +++++++++++++++++-
>>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/qapi/misc.json b/qapi/misc.json
>>> index 5636f4a14997..3b4fbc534089 100644
>>> --- a/qapi/misc.json
>>> +++ b/qapi/misc.json
>>> @@ -5,6 +5,8 @@
>>>  # = Miscellanea
>>>  ##
>>>  
>>> +{ 'include': 'common.json' }
>>> +
>>>  ##
>>>  # @qmp_capabilities:
>>>  #
>>> @@ -2449,12 +2451,12 @@
>>>  #
>>>  # Information describing the QEMU target.
>>>  #
>>> -# @arch: the target architecture (eg "x86_64", "i386", etc)
>>> +# @arch: the target architecture
>>>  #
>>>  # Since: 1.2.0
>>>  ##
>>>  { 'struct': 'TargetInfo',
>>> -  'data': { 'arch': 'str' } }
>>> +  'data': { 'arch': 'SysEmuTarget' } }
>>>  
>>>  ##
>>>  # @query-target:
>>> diff --git a/arch_init.c b/arch_init.c
>>> index 6ee07478bd11..4367f30291f8 100644
>>> --- a/arch_init.c
>>> +++ b/arch_init.c
>>> @@ -29,6 +29,7 @@
>>>  #include "hw/pci/pci.h"
>>>  #include "hw/audio/soundhw.h"
>>>  #include "qapi/qapi-commands-misc.h"
>>> +#include "qapi/error.h"
>>>  #include "qemu/config-file.h"
>>>  #include "qemu/error-report.h"
>>>  #include "hw/acpi/acpi.h"
>>> @@ -111,8 +112,23 @@ int xen_available(void)
>>>  TargetInfo *qmp_query_target(Error **errp)
>>>  {
>>>      TargetInfo *info = g_malloc0(sizeof(*info));
>>> +    Error *local_err = NULL;
>>>  
>>> -    info->arch = g_strdup(TARGET_NAME);
>>> +    /*
>>> +     * The fallback enum value is irrelevant here (TARGET_NAME is a
>>> +     * macro and can never be NULL), so simply pass zero. Also, the
>> 
>> We pass -1 in similar cases elsewhere.
>> 
>>> +     * lookup should never fail -- if it fails, then @SysEmuTarget needs
>>> +     * extending. Catch that with an assertion, but also handle it
>>> +     * gracefully, in case someone adventurous disables assertions.
>>> +     */
>>> +    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, 0,
>>> +                                 &local_err);
>>> +    g_assert(!local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        qapi_free_TargetInfo(info);
>>> +        return NULL;
>>> +    }
>> 
>> Simpler:
>> 
>>        info->arch = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, 0,
>>                                     &error_abort);
>
> OK, I'll use this form -- but should I use -1 or 0, after all, for
> default value?

I count more than a dozen instances of -1, and none of zero.  Please use
-1.
