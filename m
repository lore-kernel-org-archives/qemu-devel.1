Received: from eggs.gnu.org ([209.51.188.92]:52267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE61w-0008Km-Ou
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE61u-0002nk-Qs
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:44:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hE61t-0002mR-JC
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:44:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so1086557wml.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 22:44:13 -0700 (PDT)
References: <20190409174018.25798-1-armbru@redhat.com>
	<f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
	<874l764eez.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <38442eb0-501e-dbf8-60e0-74675a999dba@redhat.com>
Date: Wed, 10 Apr 2019 07:44:10 +0200
MIME-Version: 1.0
In-Reply-To: <874l764eez.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair.francis@wdc.com, slp@redhat.com, david@gibson.dropbear.id.au

On 4/10/19 7:28 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>> On 4/9/19 7:40 PM, Markus Armbruster wrote:
>>> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
>>> computation of @dt_size overflows to a negative number, which then
>>> gets converted to a very large size_t for g_malloc0() and
>>> load_image_size().  In the (fortunately improbable) case g_malloc0()
>>> succeeds and load_image_size() survives, we'd assign the negative
>>> number to *sizep.  What that would do to the callers I can't say, but
>>> it's unlikely to be good.
>>>
>>> Fix by rejecting images whose size would overflow.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  device_tree.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/device_tree.c b/device_tree.c
>>> index 296278e12a..f8b46b3c73 100644
>>> --- a/device_tree.c
>>> +++ b/device_tree.c
>>> @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, int *sizep)
>>>                       filename_path);
>>>          goto fail;
>>>      }
>>> +    if (dt_size > INT_MAX / 2 - 10000) {
>>
>> We should avoid magic number duplication.
>> That said, this patch looks safe.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks!
> 
>> BTW how did you figure that out?
> 
> Downstream handling of upstream commit da885fe1ee8 led me to the
> function.  I spotted dt_size = get_image_size(filename_path).
> Experience has taught me to check the left hand side's type.  Bad.  Then
> I saw how dt_size gets increased.  Worse.

So you genuinely neglected to mention Kurtis Miller then :)

>>> +        error_report("Device tree file '%s' is too large", filename_path);
>>> +        goto fail;
>>> +    }
>>>  
>>>      /* Expand to 2x size to give enough room for manipulation.  */
>>>      dt_size += 10000;
>>>
