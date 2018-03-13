Received: from eggs.gnu.org ([2001:4830:134:3::10]:48400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evkUR-0005Og-3c
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evkUL-0000xh-BT
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:01:19 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evkUL-0000wc-1e
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:01:13 -0400
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-8-lukeshu@lukeshu.com>
	<b7b5505b-34a9-9ca3-c257-385ef91eed60@vivier.eu>
	<8ac4ea80-7a1d-e52e-9e54-85a1f910a002@vivier.eu>
	<CAFEAcA8Oi3put6VzTQLh7JtAjSX3eFoRKXdV8WLBzE+89frB+A@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5588086c-5cc7-7930-c094-6334ef103942@vivier.eu>
Date: Tue, 13 Mar 2018 15:00:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Oi3put6VzTQLh7JtAjSX3eFoRKXdV8WLBzE+89frB+A@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Luke Shumaker <lukeshu@parabola.nu>, Luke Shumaker <lukeshu@lukeshu.com>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>

Le 13/03/2018 à 14:54, Peter Maydell a écrit :
> On 13 March 2018 at 13:30, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 09/03/2018 à 21:37, Laurent Vivier a écrit :
>>> Le 28/12/2017 à 19:08, Luke Shumaker a écrit :
>>>> --- a/linux-user/elfload.c
>>>> +++ b/linux-user/elfload.c
>>>> @@ -1906,24 +1906,28 @@ unsigned long init_guest_space(unsigned long host_start,
>>>>          }
>>>>
>>>>          /* Check to see if the address is valid.  */
>>>> -        if (!host_start || aligned_start == current_start) {
>>>> +        if (host_start && aligned_start != current_start) {
>>>> +            goto try_again;
>>>> +        }
>>>> +
>>>>  #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
>>>> -            /* On 32-bit ARM, we need to also be able to map the commpage.  */
>>>> -            int valid = init_guest_commpage(aligned_start - guest_start,
>>>> -                                            aligned_size + guest_start);
>>>> -            if (valid == 1) {
>>>> -                break;
>>>> -            } else if (valid == -1) {
>>>> -                munmap((void *)real_start, real_size);
>>>> -                return (unsigned long)-1;
>>>> -            }
>>>> -            /* valid == 0, so try again. */
>>>> -#else
>>>> -            /* On other architectures, whatever we have here is fine.  */
>>>> -            break;
>>>> -#endif
>>>> +        /* On 32-bit ARM, we need to also be able to map the commpage.  */
>>>> +        int valid = init_guest_commpage(aligned_start - guest_start,
>>>> +                                        aligned_size + guest_start);
>>>> +        if (valid == -1) {
>>>> +            munmap((void *)real_start, real_size);
>>>> +            return (unsigned long)-1;
>>>> +        } else if (valid == -1) {
>>>
>>> I think it should be "if (valid == 0)" here.
>>
>> Any comment?
> 
> Yes, I think I agree.
> 

Applied to my 'linux-user-for-2.12' branch with this change.

Thanks,
Laurent
