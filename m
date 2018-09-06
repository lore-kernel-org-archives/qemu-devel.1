Received: from eggs.gnu.org ([2001:4830:134:3::10]:37801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Simon.Hausmann@qt.io>) id 1fxrGi-0008Jo-6Z
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Simon.Hausmann@qt.io>) id 1fxrGf-0006NK-0H
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:12:08 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com
	([40.107.7.94]:22194
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Simon.Hausmann@qt.io>)
	id 1fxrGd-0006JW-TQ
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:12:04 -0400
References: <20180827084037.25316-1-simon.hausmann@qt.io>
	<0f69941d-51ea-4cc1-d668-416e697ae754@vivier.eu>
From: Simon Hausmann <simon.hausmann@qt.io>
Message-ID: <7fca8eab-e84f-a670-84dd-05aa851921ba@qt.io>
Date: Thu, 6 Sep 2018 12:11:57 +0200
MIME-Version: 1.0
In-Reply-To: <0f69941d-51ea-4cc1-d668-416e697ae754@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: add support for
 MADV_DONTNEED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Sami Nurmenniemi <sami.nurmenniemi@qt.io>, Riku Voipio <riku.voipio@iki.fi>, Simon Hausmann <simon.hausmann@qt.io>


On 9/6/18 11:34 AM, Laurent Vivier wrote:
> Le 27/08/2018 =C3=A0 10:40, Simon Hausmann a =C3=A9crit=C2=A0:
>> Most flags to madvise() are just hints, so typically ignoring the
>> syscall and returning okay is fine. However applications exist that do
>> rely on MADV_DONTNEED behavior to guarantee that upon subsequent access
>> the mapping is refreshed from the backing file or zero for anonymous
>> mappings. The file backed mappings this is tricky - hence the original
>> comment - but for anonymous mappings it is safe to forward. We just need
>> to remember which those mappings are, which is now stored in the flags.
>>
>> Cc: Riku Voipio <riku.voipio@iki.fi>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Cc: Sami Nurmenniemi <sami.nurmenniemi@qt.io>
>> Signed-off-by: Simon Hausmann <simon.hausmann@qt.io>
>>
>> --
>> v2:
>>    - align start and len on host page size
>> v3:
>>    - align start and len to target page size as it may be bigger than
>>      host
>>    - use immediate return in do_syscall
>>    - forward MADV_DONTNEED advice only for anonymously mapped pages
>>    - remember which mappings are anonymous in the page flags and preserv=
e
>>      those bits across mprotect calls.
>> ---
>>   accel/tcg/translate-all.c |  8 +++++--
>>   bsd-user/mmap.c           |  8 +++----
>>   include/exec/cpu-all.h    | 11 ++++++++-
>>   linux-user/elfload.c      |  3 ++-
>>   linux-user/mmap.c         | 49 +++++++++++++++++++++++++++++++++++----
>>   linux-user/qemu.h         |  1 +
>>   linux-user/syscall.c      | 12 ++++------
>>   7 files changed, 72 insertions(+), 20 deletions(-)
>>
>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>> index 898c3bb3d1..467fbd9aeb 100644
>> --- a/accel/tcg/translate-all.c
>> +++ b/accel/tcg/translate-all.c
>> @@ -2481,7 +2481,8 @@ int page_get_flags(target_ulong address)
>>   /* Modify the flags of a page and invalidate the code if necessary.
>>      The flag PAGE_WRITE_ORG is positioned automatically depending
>>      on PAGE_WRITE.  The mmap_lock should already be held.  */
>> -void page_set_flags(target_ulong start, target_ulong end, int flags)
>> +void page_set_flags(target_ulong start, target_ulong end, int flags,
>> +                    enum page_set_flags_mode mode)
> Is it possible to not add the mode, and only use "flags" to set the new
> flag? Using page_get_flags() to keep flags that needed to be kept?


Hm, the reason why I didn't do that is because page_set_flags operates

on a range while page_get_flags() gets the flags for only one page.

If you prefer not to have the mode, then I can see only two other options:


 =C2=A0=C2=A0=C2=A0 (1) Assume that the flags are typically homogeneous and=
 use=20
something like

page_set_flags(start, end, page_get_flags(start) | whatever)


 =C2=A0=C2=A0=C2=A0 (2) Change the call sites to not use the range setting =
ability of=20
page_set_flags but

loop itself.


I don't like either, so I went for the mode. But I can change to any way=20
you prefer.


>>   {
>>       target_ulong addr, len;
>>  =20
>> @@ -2513,7 +2514,10 @@ void page_set_flags(target_ulong start, target_ul=
ong end, int flags)
>>               p->first_tb) {
>>               tb_invalidate_phys_page(addr, 0);
>>           }
>> -        p->flags =3D flags;
>> +        if (mode =3D=3D PAGE_SET_ALL_FLAGS)
>> +            p->flags =3D flags;
>> +        else /* PAGE_SET_PROTECTION */
>> +            p->flags |=3D (p->flags & ~(PAGE_BITS - 1)) | (flags & PAGE=
_BITS);
>>       }
>>   }
>>  =20
>> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
>> index 17f4cd80aa..4bfac81af4 100644
>> --- a/bsd-user/mmap.c
>> +++ b/bsd-user/mmap.c
>> @@ -125,7 +125,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, =
int prot)
>>           if (ret !=3D 0)
>>               goto error;
>>       }
>> -    page_set_flags(start, start + len, prot | PAGE_VALID);
>> +    page_set_flags(start, start + len, prot, PAGE_SET_PROTECTION);
> Why do you remove the PAGE_VALID flag?


As the mode set PAGE_SET_PROTECTION, the page_set_flags call only=20
affects the protection

bits and the existing PAGE_VALID is preserved. I believe PAGE_VALID must=20
be set for that range.

If that assumption is wrong, then I could change page_set_flags to=20
implicitly set PAGE_VALID if the

mode is to apply new protection flags. Would that be ok?


> ...
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 8638612aec..c59cf4359c 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -1702,7 +1702,8 @@ static void zero_bss(abi_ulong elf_bss, abi_ulong =
last_bss, int prot)
>>  =20
>>       /* Ensure that the bss page(s) are valid */
>>       if ((page_get_flags(last_bss-1) & prot) !=3D prot) {
>> -        page_set_flags(elf_bss & TARGET_PAGE_MASK, last_bss, prot | PAG=
E_VALID);
>> +        page_set_flags(elf_bss & TARGET_PAGE_MASK, last_bss, prot,
>> +                       PAGE_SET_PROTECTION);
>>       }
> PAGE_VALID?


Oh! You're right, here I mistakenly thought the pages are already marked=20
valid, but

it appears that this is a new mapping, so I'll fix that to set PAGE_VALID.


>>  =20
>>       if (host_start < host_map_start) {
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index 41e0983ce8..fff29ee04b 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -124,7 +124,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, =
int prot)
>>           if (ret !=3D 0)
>>               goto error;
>>       }
>> -    page_set_flags(start, start + len, prot | PAGE_VALID);
>> +    page_set_flags(start, start + len, prot, PAGE_SET_PROTECTION);
>>       mmap_unlock();
> PAGE_VALID?
>
> ...


Same - potentially wrong - reasoning as with the other mprotect() wrapper.

>> +int target_madvise(abi_ulong start, abi_ulong len, int advice)
>> +{
>> +    abi_ulong end, addr;
>> +    int ret;
>> +
>> +    len =3D TARGET_PAGE_ALIGN(len);
>> +    start &=3D TARGET_PAGE_MASK;
>> +
>> +    if (!guest_range_valid(start, len)) {
>> +        errno =3D EINVAL;
>> +        return -1;
>> +    }
>> +
>> +    /* A straight passthrough may not be safe because qemu sometimes
>> +       turns private file-backed mappings into anonymous mappings.
>> +       Most flags are hints so we ignore them.
>> +       One exception is made for MADV_DONTNEED on anonymous mappings,
>> +       that applications may rely on to zero out pages. */
>> +    if (advice & MADV_DONTNEED) {
>> +        end =3D start + len;
>> +        for (addr =3D start; addr < end; addr +=3D TARGET_PAGE_SIZE) {
>> +            if (page_get_flags(addr) & PAGE_MAP_ANONYMOUS) {
>> +                ret =3D madvise(g2h(addr), TARGET_PAGE_SIZE, MADV_DONTN=
EED);
> these values must be aligned on host page size.
>
Sorry, I think I assumed from the earlier statement that the target page=20
size may be bigger than the

host and that that would be sufficient for host alignment. I didn't=20
consider that the reverse may also apply.

Would the following be correct?


 =C2=A0=C2=A0=C2=A0 (1) Use target aligned start/len for guest_range_valid =
call

 =C2=A0=C2=A0=C2=A0 (2) Use host aligned start/end/increment for the loop (=
including=20
the page_get_flags call parameters).


Thanks for the feedback :)


Simon
