Received: from eggs.gnu.org ([2001:4830:134:3::10]:33055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBK0F-0003dj-BV
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBK0C-0007ER-7L
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:58:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fBK0C-0007EG-0s
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:58:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7616281A88D8
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 12:58:27 +0000 (UTC)
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-5-lersek@redhat.com>
	<87in8faij4.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1647e39c-b5fd-d4fc-fa86-04b254100805@redhat.com>
Date: Wed, 25 Apr 2018 14:58:25 +0200
MIME-Version: 1.0
In-Reply-To: <87in8faij4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] qapi: change the type of
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
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

On 04/25/18 08:48, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> Now that we have @SysEmuTarget, it makes sense to restict
>> @TargetInfo.@arch to valid sysemu targets at the schema level.
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
>>     PATCHv1:
>>     
>>     - qmp_query_target(): pass (-1) as fallback value [Markus]
>>     - qmp_query_target(): catch lookup error with error_abort [Markus]
>>     
>>     RFCv3:
>>     
>>     - The patch is new in this version. [Markus]
>>
>>  qapi/misc.json |  6 ++++--
>>  arch_init.c    | 10 +++++++++-
>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 104d013adba6..460866cf542f 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -1,18 +1,20 @@
>>  # -*- Mode: Python -*-
>>  #
>>  
>>  ##
>>  # = Miscellanea
>>  ##
>>  
>> +{ 'include': 'common.json' }
>> +
>>  ##
>>  # @qmp_capabilities:
>>  #
>>  # Enable QMP capabilities.
>>  #
>>  # Arguments:
>>  #
>>  # @enable:   An optional list of QMPCapability values to enable.  The
>>  #            client must not enable any capability that is not
>>  #            mentioned in the QMP greeting message.  If the field is not
>>  #            provided, it means no QMP capabilities will be enabled.
>> @@ -2441,28 +2443,28 @@
>>  #      ]
>>  #    }
>>  #
>>  ##
>>  { 'command': 'query-fdsets', 'returns': ['FdsetInfo'] }
>>  
>>  ##
>>  # @TargetInfo:
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
>>  #
>>  # Return information about the target for this QEMU
>>  #
>>  # Returns: TargetInfo
>>  #
>>  # Since: 1.2.0
>>  ##
>>  { 'command': 'query-target', 'returns': 'TargetInfo' }
>> diff --git a/arch_init.c b/arch_init.c
>> index 6ee07478bd11..ee3a57019000 100644
>> --- a/arch_init.c
>> +++ b/arch_init.c
>> @@ -21,22 +21,23 @@
>>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>   * THE SOFTWARE.
>>   */
>>  #include "qemu/osdep.h"
>>  #include "qemu-common.h"
>>  #include "cpu.h"
>>  #include "sysemu/sysemu.h"
>>  #include "sysemu/arch_init.h"
>>  #include "hw/pci/pci.h"
>>  #include "hw/audio/soundhw.h"
>>  #include "qapi/qapi-commands-misc.h"
>> +#include "qapi/error.h"
>>  #include "qemu/config-file.h"
>>  #include "qemu/error-report.h"
>>  #include "hw/acpi/acpi.h"
>>  #include "qemu/help_option.h"
>>  
>>  #ifdef TARGET_SPARC
>>  int graphic_width = 1024;
>>  int graphic_height = 768;
>>  int graphic_depth = 8;
>>  #else
>>  int graphic_width = 800;
>> @@ -104,15 +105,22 @@ int xen_available(void)
>>      return 1;
>>  #else
>>      return 0;
>>  #endif
>>  }
>>  
>>  
>>  TargetInfo *qmp_query_target(Error **errp)
>>  {
>>      TargetInfo *info = g_malloc0(sizeof(*info));
>>  
>> -    info->arch = g_strdup(TARGET_NAME);
>> +    /*
>> +     * The fallback enum value is irrelevant here (TARGET_NAME is a
>> +     * macro and can never be NULL), so simply pass (-1). Also, the
>> +     * lookup should never fail -- if it fails, then @SysEmuTarget needs
>> +     * extending. Catch that with "error_abort".
>> +     */
>> +    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, -1,
>> +                                 &error_abort);
>>  
>>      return info;
>>  }
> 
> Not sure the comment is carrying its weight; for me, the use of -1 and
> &error_abort feels obvious enough.  But my feelings are subjective and
> could be off.

No, you are right, I'll drop the comment. I had to explain the arguments
to myself at first, but in retrospect they're not complicated enough to
merit a comment.

> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks!
Laszlo
