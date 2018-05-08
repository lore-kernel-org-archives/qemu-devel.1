Received: from eggs.gnu.org ([2001:4830:134:3::10]:60887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG7m1-0001Oy-Mj
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG7lx-0002st-3A
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:55:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33890 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fG7lw-0002se-T7
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:55:37 -0400
References: <20180508163639.7138-1-laurent@vivier.eu>
	<CAMo8BfJg3P=xxdZpkyj6yayHh5ce7z2VKFru=o8DkcVQOBc-Zw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6818e2c-62b8-0c42-be22-d8ea9bc50b03@redhat.com>
Date: Tue, 8 May 2018 13:55:22 -0500
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJg3P=xxdZpkyj6yayHh5ce7z2VKFru=o8DkcVQOBc-Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel <qemu-devel@nongnu.org>

On 05/08/2018 12:08 PM, Max Filippov wrote:
> On Tue, May 8, 2018 at 9:36 AM, Laurent Vivier <laurent@vivier.eu> wrote:

In the subject, s/convertion/conversion/

>> As l_type values (F_RDLCK, F_WRLCK, F_UNLCK, F_EXLCK, F_SHLCK)
>> are not bitmasks, we can't use target_to_host_bitmask() and
>> host_to_target_bitmask() to convert them.
>>
>> Introduce target_to_host_flock() and host_to_target_flock()
>> to convert values between host and target.
>>

>> +static unsigned int host_to_target_flock(unsigned int type)
>> +{
>> +    switch (type) {
>> +#define TRANSTBL_CONVERT(a) case a: return TARGET_##a;
>> +    TRANSTBL_CONVERT(F_RDLCK)
>> +    TRANSTBL_CONVERT(F_WRLCK)
>> +    TRANSTBL_CONVERT(F_UNLCK)
>> +    TRANSTBL_CONVERT(F_EXLCK)
>> +    TRANSTBL_CONVERT(F_SHLCK)
>> +#undef  TRANSTBL_CONVERT
>> +    }
>> +    return type;
>> +}
>>
> 
> There's a duplication. Wouldn't it be better if it was done like the following:
> 
> #define FLOCK_TRANSTBL \
>      switch (type) {
>      TRANSTBL_CONVERT(F_RDLCK) \

If you do this, I'd lean towards omitting the trailing ; from 
TRANSTBL_CONVERT() and sticking it in FLOCK_TRANSTBL instead (it looks 
weird to see a statement-like macro called without a ';').

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
