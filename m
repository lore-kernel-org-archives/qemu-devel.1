Received: from eggs.gnu.org ([209.51.188.92]:35187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel.santos@pobox.com>) id 1hJTN4-0003Es-H1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 21:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel.santos@pobox.com>) id 1hJTN3-0003Zq-5b
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 21:40:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <daniel.santos@pobox.com>)
	id 1hJTN1-0003Xo-5x
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 21:40:15 -0400
References: <20190417194821.23017-1-daniel.santos@pobox.com>
	<CAL1e-=jNcnCgdQM7+qYM_fArLLUET-KtyHEGDboPK_pXqYu+=g@mail.gmail.com>
From: Daniel Santos <daniel.santos@pobox.com>
Message-ID: <7c0ac4a2-8947-ddde-dd0c-dd2fa27fd0de@pobox.com>
Date: Wed, 24 Apr 2019 20:39:38 -0500
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jNcnCgdQM7+qYM_fArLLUET-KtyHEGDboPK_pXqYu+=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mips: Fix "Unexpected FPU mode"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hello,

Sorry for my slow reply.=C2=A0 I don't mind that, as long as I end up bei=
ng
shown as the author in git. :)=C2=A0 I've never committed from an email
before, so I'm not sure how that works.=C2=A0 Does adding another "From: =
"
header in the body patch that up with git-am?

I don't know how much I'll be contributing to qemu in the future --
there are a few crazy things I have considered trying to add and I'll be
using qemu quite a bit in the future, so this probably won't be my only
patch.=C2=A0 But in this case, I just *really* needed to get something MI=
PS
running on my workstation.

Also, as my big "please note", it would be good for somebody more
familiar with that code to make sure anything else that isn't explicitly
initialized will behave correctly after being memset to zero.=C2=A0 When =
a
zero is OK, I often add an explicit this.that =3D 0; to clarify the
intention and just expect gcc to compile it away.

Thanks!
Daniel

On 4/23/19 1:00 PM, Aleksandar Markovic wrote:
> On Wed, Apr 17, 2019 at 9:50 PM Daniel Santos <daniel.santos@pobox.com>=
 wrote:
>> In load_elf_binary, struct image_info interp_info is used without bein=
g
>> properly initialized.  One result is that when the ELF's program heade=
r
>> doesn't contain an entry for the ABI flags, then the value of the stru=
ct
>> image_info's fp_abi field is set to whatever happened to be in stack
>> memory at the time.
>>
>> This patch both sanitizes interp_info and initializes fp_abi for
>> TARGET_MIPS to MIPS_ABI_FP_UNKNOWN so that when we don't know the FP
>> ABI, we don't just blow up.  Currently, this bug is a complete stopper
>> for some MIPS binaries.
>>
>> ***PLEASE NOTE***
>> There may be other bugs as a result of struct image_info interp_info
>> fields not being properly initialized -- this patch only addresses the
>> fp_abi field.  I reccomend somebody who knows the code better than I
>> audit this function and the whole of that execution path.
>>
>> Fixes bug #1825002 and affects 3.1.0 and 4.x, reccomend backporting to
>> 3.1.0.
>>
>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
>> ---
> Daniel, not knowing that you already send this patch, I included it in =
another
> series (with different title and commit message, but the same content):
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03813.html
>
> Please let's track this patch there.
>
> I will change the commit message to bring it closer to the yours versio=
n
> in the next version of the series, and I will review the patch from MIP=
S
> point of view.
>
> Just advice for the future: Before sending patches to qemu-devel,
> check what are maintainers for the applicable code. There is even a
> script for that: <qemu-root>/scripts/get_maintainers.pl
>
> There are also other rules and conventiones, and all of them are
> mentioned on the page "How to submit a patch" on QEMU web site.
>
> But, in any case, many thanks for discovering and reporting the bug,
> and even devising the fix!
>
> Yours,
> Aleksandar
>
>>  linux-user/elfload.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index c1a26021f8..7f09d572a2 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -2698,6 +2698,11 @@ int load_elf_binary(struct linux_binprm *bprm, =
struct image_info *info)
>>      char *elf_interpreter =3D NULL;
>>      char *scratch;
>>
>> +    memset(&interp_info, 0, sizeof(interp_info));
>> +#ifdef TARGET_MIPS
>> +    interp_info.fp_abi =3D MIPS_ABI_FP_UNKNOWN;
>> +#endif
>> +
>>      info->start_mmap =3D (abi_ulong)ELF_START_MMAP;
>>
>>      load_elf_image(bprm->filename, bprm->fd, info,
>> --
>> 2.19.2
>>
>>
