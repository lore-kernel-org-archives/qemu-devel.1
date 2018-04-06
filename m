Received: from eggs.gnu.org ([2001:4830:134:3::10]:44949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4NHQ-0008G6-O5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4NHP-0003Lz-UG
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:03:32 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4NHP-0003Le-Ny
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:03:31 -0400
Received: by mail-oi0-x243.google.com with SMTP id c3-v6so403686oib.5
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 02:03:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316796c-49c7-2156-b277-6b6b886d06a6@redhat.com>
References: <20180328133152.24623-1-lvivier@redhat.com>
	<1316796c-49c7-2156-b277-6b6b886d06a6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 10:03:10 +0100
Message-ID: <CAFEAcA_Pshzy4-FWyfrStEvfG_j247JGmePncwEz=JZW5e8bNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: fix 16-byte vector operations
 detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Miroslav Rezanina <mrezanin@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 5 April 2018 at 21:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 28/03/2018 15:31, Laurent Vivier wrote:
>> configure tries to detect if the compiler
>> supports 16-byte vector operations.
>>
>> As stated in the comment of the detection
>> program, there is a problem with the system
>> compiler on GCC on Centos 7.
>>
>> This program doesn't actually detect the problem
>> with GCC on RHEL7 on PPC64LE (Red Hat 4.8.5-28).
>>
>> This patch updates the test to look more like
>> it is in QEMU helpers, and now detects the problem.
>>
>> The error reported is:
>>
>>   CC      ppc64-softmmu/accel/tcg/tcg-runtime-gvec.o
>>   ..//accel/tcg/tcg-runtime-gvec.c: In function =E2=80=98helper_gvec_shl=
8i=E2=80=99:
>>   ../accel/tcg/tcg-runtime-gvec.c:558:26: internal compiler error: in em=
it_move_insn, at expr.c:3495
>>            *(vec8 *)(d + i) =3D *(vec8 *)(a + i) << shift;
>>                             ^
>> Fixes: db43267 "tcg: Add generic vector expanders"
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  configure | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 4d0e92c96c..a2301dd0dc 100755
>> --- a/configure
>> +++ b/configure
>> @@ -5054,6 +5054,14 @@ static S2 c2;
>>  static S4 c4;
>>  static S8 c8;
>>  static int i;
>> +void helper(void *d, void *a, int shift, int i);
>> +void helper(void *d, void *a, int shift, int i)
>> +{
>> +  *(U1 *)(d + i) =3D *(U1 *)(a + i) << shift;
>> +  *(U2 *)(d + i) =3D *(U2 *)(a + i) << shift;
>> +  *(U4 *)(d + i) =3D *(U4 *)(a + i) << shift;
>> +  *(U8 *)(d + i) =3D *(U8 *)(a + i) << shift;
>> +}
>>  int main(void)
>>  {
>>    a1 +=3D b1; a2 +=3D b2; a4 +=3D b4; a8 +=3D b8;
>>
>
> Queued, thanks.

This is already in master...

thanks
-- PMM
