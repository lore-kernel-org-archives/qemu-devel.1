Received: from eggs.gnu.org ([2001:4830:134:3::10]:44239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEPFo-0007UG-0E
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEPFk-0002QZ-Qn
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:11:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fEPFk-0002QN-Ke
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:11:16 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-27-git-send-email-mst@redhat.com>
	<1f476403-7ba8-a1f1-363c-b866dd6f4d4b@redhat.com>
	<20180504035934-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d180c8c8-d28c-7a7e-4a97-0dd386b29c64@redhat.com>
Date: Fri, 4 May 2018 03:11:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180504035934-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 26/67] cpu: replace command line flags with
 preprocessor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

On 04.05.2018 03:01, Michael S. Tsirkin wrote:
> On Fri, May 04, 2018 at 02:35:49AM +0200, Thomas Huth wrote:
>> On 03.05.2018 21:51, Michael S. Tsirkin wrote:
>>> Each target is currently built with a different set of include
>>> directories, this is what makes it possible to pull in a separate copy
>>> of cpu.h depending on the target.
>>>
>>> Replace with per-target ifdefs which are easier to understand.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>  include/cpu.h | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>  create mode 100644 include/cpu.h
>>>
>>> diff --git a/include/cpu.h b/include/cpu.h
>>> new file mode 100644
>>> index 0000000..b18f163
>>> --- /dev/null
>>> +++ b/include/cpu.h
>>> @@ -0,0 +1,2 @@
>>> +#include "target-dir.h"
>>> +#include TARGET_DIR(cpu.h)
>>
>> That's a *bad* idea. As far as I can see, this way, cpu.h is now
>> suddenly available to generic, non-target specific code. The headers in
>> target/* are "hidden" by purpose for all code that gets compiled via
>> common-obj-y and if you now make it available for everybody again, we'll
>> end up in ugly situation where common code might have been compiled with
>> target specific defines from target specific headers... Please don't do
>> that!
>>
>>  Thomas
> 
> Are you sure that is the case? TARGET_XXX defines really shouldn't be
> set for non-target specific code.

Hm, ok, now I see that you've added a

#else
#error "Target-specific directory include missing"

in that target-dir.h header. So instead of not being able to include the
header since it is not in the header search path, we now will get an
error message instead... ok, that should be fine, too, so never mind.

 Thomas
