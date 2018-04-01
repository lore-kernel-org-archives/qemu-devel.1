Received: from eggs.gnu.org ([2001:4830:134:3::10]:38212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f2jVA-0001iO-W1
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f2jVA-0001tN-4m
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:22:56 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:37485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f2jV9-0001tH-Vo
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:22:56 -0400
Received: by mail-yw0-x241.google.com with SMTP id y23so4452166ywy.4
	for <qemu-devel@nongnu.org>; Sun, 01 Apr 2018 13:22:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a2eb3458-6f61-e9e7-20df-d9b9325ef2ed@vivier.eu>
References: <20180401192421.29712-1-jcmvbkbc@gmail.com>
	<a2eb3458-6f61-e9e7-20df-d9b9325ef2ed@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 1 Apr 2018 13:22:54 -0700
Message-ID: <CAMo8BfKYDtkP_M+MUxiAK3bO96PXkJVrqSiau3K7f_=pqGnVFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: linux-user: fix sysv IPC
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Sun, Apr 1, 2018 at 12:57 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 01/04/2018 =C3=A0 21:24, Max Filippov a =C3=A9crit :
>>  struct target_shmid_ds {
>>      struct target_ipc_perm shm_perm;    /* operation permission struct =
*/
>> -    abi_int shm_segsz;                  /* size of segment in bytes */
>> +    abi_long shm_segsz;                 /* size of segment in bytes */
>> +#ifdef TARGET_WORDS_BIGENDIAN
>> +    abi_ulong __unused1;
>>      abi_long shm_atime;                 /* time of last shmat() */
>> +    abi_ulong __unused2;
>>      abi_long shm_dtime;                 /* time of last shmdt() */
>> +    abi_ulong __unused3;
>>      abi_long shm_ctime;                 /* time of last change by shmct=
l() */
>> -    abi_ushort shm_cpid;                /* pid of creator */
>> -    abi_ushort shm_lpid;                /* pid of last shmop */
>> -    abi_ushort shm_nattch;              /* number of current attaches *=
/
>> -    abi_ushort shm_unused;              /* compatibility */
>> +#else
>> +    abi_long shm_atime;                 /* time of last shmat() */
>> +    abi_ulong __unused1;
>> +    abi_long shm_dtime;                 /* time of last shmdt() */
>>      abi_ulong __unused2;
>> +    abi_long shm_ctime;                 /* time of last change by shmct=
l() */
>>      abi_ulong __unused3;
>> +#endif
>> +    abi_uint shm_cpid;                  /* pid of creator */
>> +    abi_uint shm_lpid;                  /* pid of last shmop */
>> +    abi_ulong shm_nattch;               /* number of current attaches *=
/
>> +    abi_ulong __unused4;
>> +    abi_ulong __unused5;
>>  };
>
> This is weird: shmid64_ds in arch/xtensa/include/uapi/asm/shmbuf.h has
> two part like yours, but both parts have exactly the same fields order.
>
> Could you explain?

Ooops, my bad. I haven't checked how this part works and I guess
the kernel definitions were meant to be different, but alas, they're not.
I'll drop this part.

--=20
Thanks.
-- Max
