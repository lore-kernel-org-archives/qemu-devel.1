Received: from eggs.gnu.org ([2001:4830:134:3::10]:46746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG8kG-0007K1-8c
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG8kB-0000xe-Ad
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:57:56 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fG8kB-0000x8-0U
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:57:51 -0400
References: <20180508163639.7138-1-laurent@vivier.eu>
	<CAMo8BfJg3P=xxdZpkyj6yayHh5ce7z2VKFru=o8DkcVQOBc-Zw@mail.gmail.com>
	<e6818e2c-62b8-0c42-be22-d8ea9bc50b03@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8fc5c56b-b49c-66e6-284c-e8590f453884@vivier.eu>
Date: Tue, 8 May 2018 21:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <e6818e2c-62b8-0c42-be22-d8ea9bc50b03@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix convertion of
 flock/flock64 l_type field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel <qemu-devel@nongnu.org>

Le 08/05/2018 à 20:55, Eric Blake a écrit :
> On 05/08/2018 12:08 PM, Max Filippov wrote:
>> On Tue, May 8, 2018 at 9:36 AM, Laurent Vivier <laurent@vivier.eu> wrote:
> 
> In the subject, s/convertion/conversion/
> 
>>> As l_type values (F_RDLCK, F_WRLCK, F_UNLCK, F_EXLCK, F_SHLCK)
>>> are not bitmasks, we can't use target_to_host_bitmask() and
>>> host_to_target_bitmask() to convert them.
>>>
>>> Introduce target_to_host_flock() and host_to_target_flock()
>>> to convert values between host and target.
>>>
> 
>>> +static unsigned int host_to_target_flock(unsigned int type)
>>> +{
>>> +    switch (type) {
>>> +#define TRANSTBL_CONVERT(a) case a: return TARGET_##a;
>>> +    TRANSTBL_CONVERT(F_RDLCK)
>>> +    TRANSTBL_CONVERT(F_WRLCK)
>>> +    TRANSTBL_CONVERT(F_UNLCK)
>>> +    TRANSTBL_CONVERT(F_EXLCK)
>>> +    TRANSTBL_CONVERT(F_SHLCK)
>>> +#undef  TRANSTBL_CONVERT
>>> +    }
>>> +    return type;
>>> +}
>>>
>>
>> There's a duplication. Wouldn't it be better if it was done like the
>> following:
>>
>> #define FLOCK_TRANSTBL \
>>      switch (type) {
>>      TRANSTBL_CONVERT(F_RDLCK) \
> 
> If you do this, I'd lean towards omitting the trailing ; from
> TRANSTBL_CONVERT() and sticking it in FLOCK_TRANSTBL instead (it looks
> weird to see a statement-like macro called without a ';').
> 

I have included this patch in the series "linux-user: fix sparc32plus"
and missed your comments. I'll update this patch in the v2 of the series.

Thanks,
Laurent
