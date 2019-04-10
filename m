Received: from eggs.gnu.org ([209.51.188.92]:36348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEFS0-0003aS-UP
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEFRz-0000Kq-SE
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:47:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEFRz-0000KS-Jk
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:47:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so3509189wra.12
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 08:47:47 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190409174018.25798-1-armbru@redhat.com>
	<f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
	<874l764eez.fsf@dusky.pond.sub.org>
	<38442eb0-501e-dbf8-60e0-74675a999dba@redhat.com>
	<87bm1e2yfa.fsf@dusky.pond.sub.org>
	<CAKmqyKM7fX6UqSU5K+w25xGxO2K4kqtyoRz7LMFN7GtBYL56KA@mail.gmail.com>
Message-ID: <b73bbac0-a501-0004-5a41-748e2b23ab13@redhat.com>
Date: Wed, 10 Apr 2019 17:47:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAKmqyKM7fX6UqSU5K+w25xGxO2K4kqtyoRz7LMFN7GtBYL56KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 4/10/19 8:34 AM, Alistair Francis wrote:
> On Tue, Apr 9, 2019 at 10:59 PM Markus Armbruster <armbru@redhat.com> wrote:
>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>> On 4/10/19 7:28 AM, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>>> On 4/9/19 7:40 PM, Markus Armbruster wrote:
>>>>>> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
>>>>>> computation of @dt_size overflows to a negative number, which then
>>>>>> gets converted to a very large size_t for g_malloc0() and
>>>>>> load_image_size().  In the (fortunately improbable) case g_malloc0()
>>>>>> succeeds and load_image_size() survives, we'd assign the negative
>>>>>> number to *sizep.  What that would do to the callers I can't say, but
>>>>>> it's unlikely to be good.
>>>>>>
>>>>>> Fix by rejecting images whose size would overflow.
>>>>>>
>>>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>>>> ---
>>>>>>  device_tree.c | 4 ++++
>>>>>>  1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/device_tree.c b/device_tree.c
>>>>>> index 296278e12a..f8b46b3c73 100644
>>>>>> --- a/device_tree.c
>>>>>> +++ b/device_tree.c
>>>>>> @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, int *sizep)
>>>>>>                       filename_path);
>>>>>>          goto fail;
>>>>>>      }
>>>>>> +    if (dt_size > INT_MAX / 2 - 10000) {
>>>>>
>>>>> We should avoid magic number duplication.
>>>>> That said, this patch looks safe.
>>>>>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>
>>>> Thanks!
>>>>
>>>>> BTW how did you figure that out?
>>>>
>>>> Downstream handling of upstream commit da885fe1ee8 led me to the
>>>> function.  I spotted dt_size = get_image_size(filename_path).
>>>> Experience has taught me to check the left hand side's type.  Bad.  Then
>>>> I saw how dt_size gets increased.  Worse.
>>>
>>> So you genuinely neglected to mention Kurtis Miller then :)
>>
>> Explanation, not excuse: the only occurence of the name in my downstream
>> reading was a two-liner BZ comment, which I totally missed in my haste
>> to give the fix a chance to make 4.0.  I certainly didn't mean to
>> deprive him of credit!

My English teacher explained me neglected sounds like a
reprimand/reproach (as in negligence), sorry I didn't mean to be rude
here, I wanted to say something like "Peter remarked you did gave
credits to the first one who reported this issue, but since you figured
this bug via your own way, the omission was not intentional then."

> No worries. I have sent the pull request and it includes the reported by.
> 
> Alistair
> 
>>
>> [...]
>>
