Received: from eggs.gnu.org ([2001:4830:134:3::10]:41467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fAays-0007ZF-N6
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fAayp-0005wi-Fu
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:54:06 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1fAayp-0005vk-6F
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:54:03 -0400
References: <20180423075215.4572-1-christophe.lyon@st.com>
	<20180423075215.4572-3-christophe.lyon@st.com>
	<CAFEAcA9tnh9j=QMxZm7RTMzaRVxh10oEGDCYYO5TL5TvAuvLXw@mail.gmail.com>
From: Christophe Lyon <christophe.lyon@st.com>
Message-ID: <d3762ab7-e23c-9078-0e1f-57addc334cbe@st.com>
Date: Mon, 23 Apr 2018 14:53:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9tnh9j=QMxZm7RTMzaRVxh10oEGDCYYO5TL5TvAuvLXw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ARM/FDPIC v2 2/4] linux-user: ARM-FDPIC: Identify
 ARM FDPIC binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 23/04/2018 14:17, Peter Maydell wrote:
> On 23 April 2018 at 08:51, Christophe Lyon <christophe.lyon@st.com> wro=
te:
>> Define an ARM-specific version of elf_is_fdpic:
>> FDPIC ELF objects are identified with e_ident[EI_OSABI] =3D=3D
>> ELFOSABI_ARM_FDPIC.
>>
>> Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
>> Signed-off-by: Christophe Lyon <christophe.lyon@st.com>
>>
>> diff --git a/include/elf.h b/include/elf.h
>> index c0dc9bb..934dbbd 100644
>> --- a/include/elf.h
>> +++ b/include/elf.h
>> @@ -1483,6 +1483,7 @@ typedef struct elf64_shdr {
>>   #define ELFOSABI_TRU64          10      /* Compaq TRU64 UNIX.  */
>>   #define ELFOSABI_MODESTO        11      /* Novell Modesto.  */
>>   #define ELFOSABI_OPENBSD        12      /* OpenBSD.  */
>> +#define ELFOSABI_ARM_FDPIC      65      /* ARM FDPIC */
>>   #define ELFOSABI_ARM            97      /* ARM */
>>   #define ELFOSABI_STANDALONE     255     /* Standalone (embedded) app=
lication */
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index bbe93b0..76d7718 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -1681,11 +1681,18 @@ static void zero_bss(abi_ulong elf_bss, abi_ul=
ong last_bss, int prot)
>>       }
>>   }
>>
>> +#ifdef TARGET_ARM
>> +static int elf_is_fdpic(struct elfhdr *exec)
>> +{
>> +    return exec->e_ident[EI_OSABI] =3D=3D ELFOSABI_ARM_FDPIC;
>> +}
>> +#else
>>   /* Default implementation, always false.  */
>>   static int elf_is_fdpic(struct elfhdr *exec)
>>   {
>>       return 0;
>>   }
>> +#endif
>=20
> I have a strong dislike for per-target ifdef ladders. Can we instead
> put the target's implementation of elf_is_fdpic() into
> linux-user/$ARCH/target_elf.h
> and also have that header do
> #define TARGET_HAS_ELF_FDPIC
>=20
> and then in the generic code we can protect the default elf_is_fdpic()
> with #ifndef TARGET_HAS_ELF_FDPIC.
>=20

How invasive could that be?
Your proposal is appealing, but target_elf.h is only included by linux-us=
er/main.c, which does not define elfhdr etc...
All that knowledge is in linux-user/elfload.c, which controls what includ=
e/elf.h defines.

Should I re-engineer that?

Thanks,

Christophe


> thanks
> -- PMM
> .
>=20
