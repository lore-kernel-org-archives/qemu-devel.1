Received: from eggs.gnu.org ([2001:4830:134:3::10]:37315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fdVak-0006Yx-Tu
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fdVae-0003l0-Pt
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:00:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.vnet.ibm.com>)
	id 1fdVae-0003gp-GL
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:00:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6C6xsaT064768
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 03:00:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k60m4d7s3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 03:00:34 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.vnet.ibm.com>;
	Thu, 12 Jul 2018 08:00:32 +0100
References: <153130635623.17872.6735154721391367314.stgit@lep8c.aus.stglabs.ibm.com>
	<a6e06c37-5fe8-589c-f0c4-dcffef0b4c60@vivier.eu>
	<96fc62a8-2369-05b6-17de-c10b52795f53@vivier.eu>
From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Date: Thu, 12 Jul 2018 12:30:27 +0530
MIME-Version: 1.0
In-Reply-To: <96fc62a8-2369-05b6-17de-c10b52795f53@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <07a9ce33-1a1a-a997-e99d-ebb89ef6e5e0@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: ppc64: use the correct values
 for F_*LK64s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au



On 07/12/2018 02:21 AM, Laurent Vivier wrote:
> Le 11/07/2018 =C3=A0 15:04, Laurent Vivier a =C3=A9crit=C2=A0:
>> Le 11/07/2018 =C3=A0 12:55, Shivaprasad G Bhat a =C3=A9crit=C2=A0:
>>> Qemu includes the glibc headers for the host defines and target heade=
rs are
>>> part of the qemu source themselves. The glibc has the F_GETLK64, F_SE=
TLK64
>>> and F_SETLKW64 defined to 12, 13 and 14 for all archs(generic) in
>>> sysdeps/unix/sysv/linux/bits/fcntl-linux.h. The linux kernel generic
>>> definition for F_*LK is 5, 6 & 7 and F_*LK64* is 12,13, and 14 as see=
n in
>>> include/uapi/asm-generic/fcntl.h. On 64bit machine, by default the ke=
rnel
>>> assumes all F_*LK to 64bit calls and doesnt support use of F_*LK64* a=
s
>>> can be seen in include/linux/fcntl.h in linux source.
>>>
>>> On x86_64 host, the values for F_*LK64* are set to 5, 6 and 7
>>> explicitly in /usr/include/x86_64-linux-gnu/bits/fcntl.h by the glibc.
>>> Whereas, a PPC64 host doesn't have such a definition in
>>> /usr/include/powerpc64le-linux-gnu/bits/fcntl.h by the glibc. So,
>>> the sources on PPC64 host sees the default value of F_*LK64*
>>> as 12, 13 & 14(fcntl-linux.h).
>>>
>>> Since the 64bit kernel doesnt support 12, 13 & 14; the glibc fcntl sy=
scall
>>> implementation(__libc_fcntl*(), __fcntl64_nocancel) does the F_*LK64*=
 value
>>> convertion back to F_*LK* values on PPC64 as seen in
>>> sysdeps/unix/sysv/linux/powerpc/powerpc64/sysdep.h with FCNTL_ADJUST_=
CMD()
>>> macro. Whereas on x86_64 host the values for F_*LK64* are set to 5, 6=
 and 7
>>> and no adjustments are needed.
>>>
>>> Since qemu doesnt use the glibc fcntl, but makes the safe_syscall* on=
 its
>>> own, the PPC64 qemu is calling the syscall with 12, 13, and 14(withou=
t
>>> adjustment) and they all fail. The fcntl calls to F_GETLK/F_SETLK|W a=
ll
>>> fail by all pplications run on PPC64 host user emulation.
>>>
>>> The fix here could be to see why on PPC64 the glibc is still keeping
>>> F_*LK64* different from F_*LK and why adjusting them to 5, 6 and 7 be=
fore
>>> the syscall for PPC only. See if we can make the
>>> /usr/include/powerpc64le-linux-gnu/bits/fcntl.h to have the values
>>> 5, 6 & 7 just like x86_64 and remove the adjustment code in glibc. Th=
at way,
>>> qemu sources see the kernel supported values in glibc headers.
>>>
>>> OR
>>>
>>> On PPC64 host, qemu sources see both F_LK* & F_LK64* as same and set =
to
>>> 12, 13 and 14 because __USE_FILE_OFFSET64 is defined in qemu
>>> sources(also refer sysdeps/unix/sysv/linux/bits/fcntl-linux.h).
>>> Since F_*LK and F_*LK64 are same, the value adjument like done by gli=
bc in
>>> qemu sources is difficult. So, Overwrite the glibc defaults with the =
actual
>>> supported values in Qemu. The current patch is doing this.
>>>
>>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
>>> ---
>>>   linux-user/syscall.c |   14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index 7b9ac3b408..1693e69ce0 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -250,6 +250,20 @@ static type name (type1 arg1,type2 arg2,type3 ar=
g3,type4 arg4,type5 arg5,	\
>>>   #define TARGET_NR__llseek TARGET_NR_llseek
>>>   #endif
>>>  =20
>>> +/* glibc headers has these defined to 12, 13 and 14 and is not suppo=
rted
>>> + * by kernel. The glibc fcntl call actually adjusts them back to 5, =
6 and 7
>>> + * before making the syscall(). Since we make the syscall directly,
>>> + * overwite/adjust to what is supported by the kernel.
>>> + */
>>> +#if defined(__linux__) && defined(__powerpc64__)
>>> +#undef F_GETLK64
>>> +#define F_GETLK64      5       /* Get record locking info.  */
>>> +#undef F_SETLK64
>>> +#define F_SETLK64      6       /* Set record locking info (non-block=
ing).  */
>>> +#undef F_SETLKW64
>>> +#define F_SETLKW64     7       /* Set record locking info (blocking)=
.  */
>>> +#endif
>>> +
>>>   #ifdef __NR_gettid
>>>   _syscall0(int, gettid)
>>>   #else
>>>
>> These macros are used in target_to_host_fcntl_cmd(), and this function
>> is used with safe_fcntl() and fcntl().
>>
>> So I think it would be cleaner to do the change after
>> target_to_host_fcntl_cmd() in do_fcntl() as it is done in glibc instea=
d
>> of redefining system values. Something like:
>>
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -6782,6 +6782,12 @@ static abi_long do_fcntl(int fd, int cmd,
>> abi_ulong arg)
>>       if (host_cmd =3D=3D -TARGET_EINVAL)
>>              return host_cmd;
>>
>> +#if defined(__linux__) && defined(__powerpc64__)
>> +    if (host_cmd >=3D F_GETLK64 && host_cmd <=3D F_SETLKW64) {
>> +        host_cmd -=3D F_GETLK64 - F_GETLK;
> But as you said, __USE_FILE_OFFSET64 is defined in qemu, and F_GETLK is
> equal to F_GETLK64, so we should use something like:
>
> ...
>      host_cmd -=3D F_GETLK64 - 5;
> ...
Hi Laurent, Thanks for the comments. I agree to the comments,
sending the v2 accordingly.

Thanks,
Shivaprasad

>
> Thanks,
> Laurent
>
