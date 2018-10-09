Received: from eggs.gnu.org ([2001:4830:134:3::10]:35413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9pIw-0004b7-Pa
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9pIv-0006TW-L5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:31:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9pIv-0006T0-8P
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:31:53 -0400
Received: by mail-oi1-x244.google.com with SMTP id e17-v6so788228oig.12
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 03:31:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181008181634.2d18e015.cohuck@redhat.com>
References: <20181008153204.18845-1-david@redhat.com>
	<20181008181634.2d18e015.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Oct 2018 11:31:30 +0100
Message-ID: <CAFEAcA9SyGWU2FaUsTgSj80tcT8QR0gr1nuGXW0v1D==P=-cYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/tcg: always enable AFP for linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 8 October 2018 at 17:16, Cornelia Huck <cohuck@redhat.com> wrote:
> On Mon,  8 Oct 2018 17:32:04 +0200
> David Hildenbrand <david@redhat.com> wrote:
>
>> linux-user should always enable AFP, otherwise our emulated binary
>> might crash once it tries to make use of additional floating-point
>> registers or instructions.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Fixes: db0504154e ("s390x/tcg: check for AFP-register, BFP and DFP data =
exceptions")
>> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/cpu.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 8ed4823d6e..18ba7f85a5 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -145,6 +145,11 @@ static void s390_cpu_full_reset(CPUState *s)
>>      env->cregs[0] =3D CR0_RESET;
>>      env->cregs[14] =3D CR14_RESET;
>>
>> +#if defined(CONFIG_USER_ONLY)
>> +    /* user mode should always be allowed to use the full FPU */
>> +    env->cregs[0] |=3D CR0_AFP;
>> +#endif
>> +
>>      /* architectured initial value for Breaking-Event-Address register =
*/
>>      env->gbea =3D 1;
>>
>
> In case this is applied directly:
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Tested-by: Cornelia Huck <cohuck@redhat.com>

Thanks; I've applied it to master, and also added 'make check-tcg'
to my set of things I run as part of a merge, which should catch
this kind of bug in future.

-- PMM
