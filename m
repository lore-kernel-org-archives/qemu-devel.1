Received: from eggs.gnu.org ([209.51.188.92]:40320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDuz-0004nQ-Td
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDuz-0000yS-20
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:06:57 -0500
References: <20190213211827.20300-1-thomas.petazzoni@bootlin.com>
	<8defa16a-2af8-a1a7-0e3e-cb281f9a477d@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <07ad6417-eb6f-b35d-06b4-168c5090c95b@vivier.eu>
Date: Thu, 14 Feb 2019 11:05:45 +0100
MIME-Version: 1.0
In-Reply-To: <8defa16a-2af8-a1a7-0e3e-cb281f9a477d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] configure: improve usbfs
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-stable@nongnu.org

On 14/02/2019 08:00, Thomas Huth wrote:
> On 2019-02-13 22:18, Thomas Petazzoni wrote:
>> The current check to test if usbfs support should be compiled or not
>> solely relies on the presence of <linux/usbdevice_fs.h>, without
>> actually checking that all definition used by Qemu are provided by
>> this header file.
>>
>> With sufficiently old kernel headers, <linux/usbdevice_fs.h> may be
>> present, but some of the definitions needed by Qemu may not be
>> available.
>>
>> This commit improves the check by building a small program that
>> actually tests whether the necessary definitions are available.
>>
>> In addition, it fixes a bug where have_usbfs was set to "yes"
>> regardless of the result of the test.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>> ---
>>  configure | 19 +++++++++++++++++--
>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 3d89870d99..799c8e3b08 100755
>> --- a/configure
>> +++ b/configure
>> @@ -4266,10 +4266,25 @@ fi
>>  # check for usbfs
>>  have_usbfs=no
>>  if test "$linux_user" = "yes"; then
>> -  if check_include linux/usbdevice_fs.h; then
>> +  cat > $TMPC << EOF
>> +#include <linux/usbdevice_fs.h>
>> +
>> +#ifndef USBDEVFS_GET_CAPABILITIES
>> +#error "USBDEVFS_GET_CAPABILITIES undefined"
>> +#endif
>> +
>> +#ifndef USBDEVFS_DISCONNECT_CLAIM
>> +#error "USBDEVFS_DISCONNECT_CLAIM undefined"
>> +#endif
>> +
>> +int main(void)
>> +{
>> +    return 0;
>> +}
>> +EOF
>> +  if compile_prog "" ""; then
>>      have_usbfs=yes
>>    fi
>> -  have_usbfs=yes
>>  fi
>>  
>>  # check for fallocate
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
