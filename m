Received: from eggs.gnu.org ([2001:4830:134:3::10]:50099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fAgQ2-0000Ya-Le
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fAgPx-00019a-O1
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:42:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fAgPx-000196-IP
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:42:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AE5AF6404
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 18:42:24 +0000 (UTC)
References: <20180420231246.23130-1-lersek@redhat.com>
	<20180420231246.23130-3-lersek@redhat.com>
	<87y3hented.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e1920d3f-cd23-6e53-32af-7c084734370d@redhat.com>
Date: Mon, 23 Apr 2018 20:42:22 +0200
MIME-Version: 1.0
In-Reply-To: <87y3hented.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Thomas Huth <thuth@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

On 04/23/18 11:50, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> Now that we have @SysEmuTarget, it makes sense to restict
>> @TargetInfo.@arch to valid sysemu targets at the schema level.
> 
> We could mention that supported targets become visible in QMP
> introspection.  But I can't see what QMP clients could do with this
> information, so let's not bother.
> 
>>
>> Cc: "Daniel P. Berrange" <berrange@redhat.com>
>> Cc: David Gibson <dgibson@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Kashyap Chamarthy <kchamart@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>
>> Notes:
>>     RFCv3:
>>     
>>     - The patch is new in this version. [Markus]
>>
>>  qapi/misc.json |  6 ++++--
>>  arch_init.c    | 18 +++++++++++++++++-
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 5636f4a14997..3b4fbc534089 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -5,6 +5,8 @@
>>  # = Miscellanea
>>  ##
>>  
>> +{ 'include': 'common.json' }
>> +
>>  ##
>>  # @qmp_capabilities:
>>  #
>> @@ -2449,12 +2451,12 @@
>>  #
>>  # Information describing the QEMU target.
>>  #
>> -# @arch: the target architecture (eg "x86_64", "i386", etc)
>> +# @arch: the target architecture
>>  #
>>  # Since: 1.2.0
>>  ##
>>  { 'struct': 'TargetInfo',
>> -  'data': { 'arch': 'str' } }
>> +  'data': { 'arch': 'SysEmuTarget' } }
>>  
>>  ##
>>  # @query-target:
>> diff --git a/arch_init.c b/arch_init.c
>> index 6ee07478bd11..4367f30291f8 100644
>> --- a/arch_init.c
>> +++ b/arch_init.c
>> @@ -29,6 +29,7 @@
>>  #include "hw/pci/pci.h"
>>  #include "hw/audio/soundhw.h"
>>  #include "qapi/qapi-commands-misc.h"
>> +#include "qapi/error.h"
>>  #include "qemu/config-file.h"
>>  #include "qemu/error-report.h"
>>  #include "hw/acpi/acpi.h"
>> @@ -111,8 +112,23 @@ int xen_available(void)
>>  TargetInfo *qmp_query_target(Error **errp)
>>  {
>>      TargetInfo *info = g_malloc0(sizeof(*info));
>> +    Error *local_err = NULL;
>>  
>> -    info->arch = g_strdup(TARGET_NAME);
>> +    /*
>> +     * The fallback enum value is irrelevant here (TARGET_NAME is a
>> +     * macro and can never be NULL), so simply pass zero. Also, the
> 
> We pass -1 in similar cases elsewhere.
> 
>> +     * lookup should never fail -- if it fails, then @SysEmuTarget needs
>> +     * extending. Catch that with an assertion, but also handle it
>> +     * gracefully, in case someone adventurous disables assertions.
>> +     */
>> +    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, 0,
>> +                                 &local_err);
>> +    g_assert(!local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        qapi_free_TargetInfo(info);
>> +        return NULL;
>> +    }
> 
> Simpler:
> 
>        info->arch = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, 0,
>                                     &error_abort);

OK, I'll use this form -- but should I use -1 or 0, after all, for
default value?

Thanks,
Laszlo

> 
>>  
>>      return info;
>>  }
