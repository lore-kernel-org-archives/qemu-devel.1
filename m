Received: from eggs.gnu.org ([2001:4830:134:3::10]:58725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1etGjk-0003oO-Ow
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1etGjk-0000oE-0P
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:50:52 -0500
MIME-Version: 1.0
In-Reply-To: <763029e7-f64d-72ef-4e6e-a8395423cbe5@vivier.eu>
References: <20180301173636.19082-1-jcmvbkbc@gmail.com>
	<91b370e2-d5aa-98b9-a005-2fe8f77881ee@vivier.eu>
	<CAMo8BfLV632wv7o9jX_=4W=a-tuJViUGjb2GitLdfHoj3SgkKg@mail.gmail.com>
	<763029e7-f64d-72ef-4e6e-a8395423cbe5@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 6 Mar 2018 09:50:49 -0800
Message-ID: <CAMo8BfLneghf9BfbBvGiS5yQxGD1R7xNBGMKYcwHmUAXtkB=7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/11] linux-user: fix
 mmap/munmap/mprotect/mremap/shmat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Tue, Mar 6, 2018 at 9:39 AM, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 06/03/2018 =C3=A0 18:28, Max Filippov a =C3=A9crit :
>> On Tue, Mar 6, 2018 at 4:02 AM, Laurent Vivier <laurent@vivier.eu> wrote=
:
>>> Le 01/03/2018 =C3=A0 18:36, Max Filippov a =C3=A9crit :
>>>>  #define GUEST_ADDR_MAX (reserved_va ? reserved_va : \
>>>> -                                    (1ul <<
> TARGET_VIRT_ADDR_SPACE_BITS) - 1)
>>>> +                        (2ul << (TARGET_VIRT_ADDR_SPACE_BITS - 1)) - =
1)
>>>
>>> I don't understand why you do this change. Could you explain?
>>
>> For a lot of targets TARGET_VIRT_ADDR_SPACE_BITS is the same as
>> HOST_LONG_BITS, so the shift results in undefined behavior. E.g. without
>> this change I see the following warnings when building such targets for
>> x86_64 host:
>>
>> linux-user/syscall.c:4905:10: note: in expansion of macro
> =E2=80=98guest_range_valid=E2=80=99
>>      if (!guest_range_valid(shmaddr, shm_info.shm_segsz)) {
>>           ^~~~~~~~~~~~~~~~~
>> include/exec/cpu-all.h:163:30: warning: left shift count >=3D width of
>> type [-Wshift-count-overflow]
>>                          (1ul << (TARGET_VIRT_ADDR_SPACE_BITS)) - 1)
>>
>> Changing it to 2ul << (TARGET_VIRT_ADDR_SPACE_BITS - 1)
>> fixes undefined behavior. Probably that deserves a comment in the
>> changelog.
>>
>
> Perhaps you can keep the scheme used originally with h2g_valid(), it's
> easier to read:
>
> #if HOST_LONG_BITS <=3D TARGET_VIRT_ADDR_SPACE_BITS
> #define GUEST_ADDR_MAX (reserved_va ? reserved_va : ~0ul)
> #else
> #define GUEST_ADDR_MAX (reserved_va ? reserved_va : \
>                         (1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
> #endif

Ok, will do.

--=20
Thanks.
-- Max
