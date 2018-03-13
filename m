Received: from eggs.gnu.org ([2001:4830:134:3::10]:42242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evk1H-0001A3-02
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evk1C-0002FJ-2U
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:31:11 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evk1B-0002EX-OY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:31:06 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-8-lukeshu@lukeshu.com>
	<b7b5505b-34a9-9ca3-c257-385ef91eed60@vivier.eu>
Message-ID: <8ac4ea80-7a1d-e52e-9e54-85a1f910a002@vivier.eu>
Date: Tue, 13 Mar 2018 14:30:37 +0100
MIME-Version: 1.0
In-Reply-To: <b7b5505b-34a9-9ca3-c257-385ef91eed60@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/10] linux-user: init_guest_space: Clean
 up control flow a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>, qemu-devel@nongnu.org
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>

Le 09/03/2018 à 21:37, Laurent Vivier a écrit :
> Le 28/12/2017 à 19:08, Luke Shumaker a écrit :
>> From: Luke Shumaker <lukeshu@parabola.nu>
>>
>> Instead of doing
>>
>>         if (check1) {
>>             if (check2) {
>>                success;
>>             }
>>         }
>>
>>         retry;
>>
>> Do a clearer
>>
>>         if (!check1) {
>>            goto try_again;
>>         }
>>
>>         if (!check2) {
>>            goto try_again;
>>         }
>>
>>         success;
>>
>>     try_again:
>>         retry;
>>
>> Besides being clearer, this makes it easier to insert more checks that
>> need to trigger a retry on check failure, or rearrange them, or anything
>> like that.
>>
>> Because some indentation is changing, "ignore space change" may be useful
>> for viewing this patch.
>>
>> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
>> ---
>>  linux-user/elfload.c | 34 +++++++++++++++++++---------------
>>  1 file changed, 19 insertions(+), 15 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index b560f5d6fe..5c0ad65611 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -1906,24 +1906,28 @@ unsigned long init_guest_space(unsigned long host_start,
>>          }
>>  
>>          /* Check to see if the address is valid.  */
>> -        if (!host_start || aligned_start == current_start) {
>> +        if (host_start && aligned_start != current_start) {
>> +            goto try_again;
>> +        }
>> +
>>  #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
>> -            /* On 32-bit ARM, we need to also be able to map the commpage.  */
>> -            int valid = init_guest_commpage(aligned_start - guest_start,
>> -                                            aligned_size + guest_start);
>> -            if (valid == 1) {
>> -                break;
>> -            } else if (valid == -1) {
>> -                munmap((void *)real_start, real_size);
>> -                return (unsigned long)-1;
>> -            }
>> -            /* valid == 0, so try again. */
>> -#else
>> -            /* On other architectures, whatever we have here is fine.  */
>> -            break;
>> -#endif
>> +        /* On 32-bit ARM, we need to also be able to map the commpage.  */
>> +        int valid = init_guest_commpage(aligned_start - guest_start,
>> +                                        aligned_size + guest_start);
>> +        if (valid == -1) {
>> +            munmap((void *)real_start, real_size);
>> +            return (unsigned long)-1;
>> +        } else if (valid == -1) {
> 
> I think it should be "if (valid == 0)" here.

Any comment?

Thanks,
Laurent
