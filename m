Received: from eggs.gnu.org ([2001:4830:134:3::10]:54515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hatzimiltos@gmail.com>) id 1dAXa0-0002iA-K9
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hatzimiltos@gmail.com>) id 1dAXZy-0002wc-Uk
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:11:40 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hatzimiltos@gmail.com>)
	id 1dAXZy-0002vR-Jh
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:11:38 -0400
Received: by mail-wm0-x233.google.com with SMTP id d127so109874928wmf.0
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 01:11:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALUZMn0ppiDx_5jVAmCKqATH7EtDacvarOcY6gF-oh2z3C+3MQ@mail.gmail.com>
References: <CALUZMn0mRMY7mx5ysWdSamV+UGbjwuif8UxQ47gFDK3fx8Hw2w@mail.gmail.com>
	<6e9a0dff-949f-5ac9-2315-cbe0e4c99f58@redhat.com>
	<CALUZMn14qgNz8y+15bsKFwyB9Ganoh0wzu5tfokCDRSASnBeKA@mail.gmail.com>
	<0c725626-6485-c777-46e3-99423670df89@redhat.com>
	<CALUZMn3W06H83E7hr4cHQ2jACp7A2x8hNyU1YirJssd3S7ut2Q@mail.gmail.com>
	<c41daf1b-1ead-0809-57f8-2bfd168b36e6@redhat.com>
	<CALUZMn3xVkhXRw7M08OaFs_NSE5WVV4U+CqsG2bPqzLLRWORtA@mail.gmail.com>
	<CALUZMn1zCo2_hsY5nyZ-J=ofSCj=WoEhYB2sis_goS-KA7mfvA@mail.gmail.com>
	<7e48191b-d660-ded5-0382-5643b0c15ce4@redhat.com>
	<CALUZMn3-wWyeo3_ONHN52PEDk2Hyin7LoPfjOFtL1Rspq3WYKA@mail.gmail.com>
	<8a18aa4b-8151-57f4-f209-6245acb6393e@redhat.com>
	<CALUZMn0ppiDx_5jVAmCKqATH7EtDacvarOcY6gF-oh2z3C+3MQ@mail.gmail.com>
From: Miltiadis Hatzimihail <hatzimiltos@gmail.com>
Date: Tue, 16 May 2017 09:11:16 +0100
Message-ID: <CALUZMn2NJ-pxyYHEH3uvX5VGKH5xttQx2ZOsked+zyE5ph1c1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest SIGILL when different IO is implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

=E2=80=8BI ve seen that I ve accidentally dropped the list from the email..

So for fstps for the 32bit - how does this patch look?

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c

index a252081d..83b0fd2 100644

--- a/arch/x86/kvm/emulate.c

+++ b/arch/x86/kvm/emulate.c

@@ -1139,6 +1139,27 @@ static int em_fninit(struct x86_emulate_ctxt *ctxt)

               return X86EMUL_CONTINUE;

}



+static int em_fld(struct x86_emulate_ctxt *ctxt)

+{

+             ctxt->ops->get_fpu(ctxt);

+             asm volatile("fld %0": "+m"(ctxt->src.val));

+             ctxt->ops->put_fpu(ctxt);

+

+             return X86EMUL_CONTINUE;

+}

+

+static int em_fstp(struct x86_emulate_ctxt *ctxt)

+{

+             u32 fcw;

+

+             ctxt->ops->get_fpu(ctxt);

+             asm volatile("fstp %0": "+m"(fcw));

+             ctxt->ops->put_fpu(ctxt);

+

+             ctxt->dst.val =3D fcw;

+             return X86EMUL_CONTINUE;

+}

+

static int em_fnstcw(struct x86_emulate_ctxt *ctxt)

{

               u16 fcw;

@@ -4438,7 +4459,7 @@ static const struct gprefix pfx_0f_e7 =3D {

};



 static const struct escape escape_d9 =3D { {

-              N, N, N, N, N, N, N, I(DstMem16 | Mov, em_fnstcw),

+             I(SrcMem | Stack, em_fld), N, N, I(DstMem | Mov | Stack,
em_fstp), N, N, N, I(DstMem16 | Mov, em_fnstcw),

}, {

               /* 0xC0 - 0xC7 */

               N, N, N, N, N, N, N, N,=E2=80=8B


Miltiadis Hatzimihail


On Tue, May 16, 2017 at 9:09 AM, Miltiadis Hatzimihail <
hatzimiltos@gmail.com> wrote:

> How does this patch look to you?
>
> --- a/arch/x86/kvm/emulate.c
>
> +++ b/arch/x86/kvm/emulate.c
>
> @@ -1139,6 +1139,27 @@ static int em_fninit(struct x86_emulate_ctxt *ctxt=
)
>
>                return X86EMUL_CONTINUE;
>
> }
>
>
>
> +static int em_fld(struct x86_emulate_ctxt *ctxt)
>
> +{
>
> +             ctxt->ops->get_fpu(ctxt);
>
> +             asm volatile("fld %0": "+m"(ctxt->src.val));
>
> +             ctxt->ops->put_fpu(ctxt);
>
> +
>
> +             return X86EMUL_CONTINUE;
>
> +}
>
> +
>
> +static int em_fstp(struct x86_emulate_ctxt *ctxt)
>
> +{
>
> +             u32 fcw;
>
> +
>
> +             ctxt->ops->get_fpu(ctxt);
>
> +             asm volatile("fstp %0": "+m"(fcw));
>
> +             ctxt->ops->put_fpu(ctxt);
>
> +
>
> +             ctxt->dst.val =3D fcw;
>
> +             return X86EMUL_CONTINUE;
>
> +}
>
> +
>
> static int em_fnstcw(struct x86_emulate_ctxt *ctxt)
>
> {
>
>                u16 fcw;
>
> @@ -4438,7 +4459,7 @@ static const struct gprefix pfx_0f_e7 =3D {
>
> };
>
>
>
>  static const struct escape escape_d9 =3D { {
>
> -              N, N, N, N, N, N, N, I(DstMem16 | Mov, em_fnstcw),
>
> +             I(SrcMem | Stack, em_fld), N, N, I(DstMem | Mov | Stack,
> em_fstp), N, N, N, I(DstMem16 | Mov, em_fnstcw),
>
> }, {
>
>                /* 0xC0 - 0xC7 */
>
>                N, N, N, N, N, N, N, N,
>
>
> Miltiadis Hatzimihail
>
>
> On Mon, May 15, 2017 at 8:58 AM, Paolo Bonzini <pbonzini@redhat.com>
> wrote:
>
>>
>>
>> On 15/05/2017 08:42, Miltiadis Hatzimihail wrote:
>> > Thanks - is it just a matter of adjusting your old patch for this
>> > command? (I looked up the opcode and it was dd or d9 I think).
>>
>> The encoding of fstps is a bit different because it's an x87
>> instruction, but the idea is the same.
>>
>> Paolo
>> >
>> > Miltiadis Hatzimihail
>> >
>> >
>> > On Fri, May 12, 2017 at 1:00 PM, Paolo Bonzini <pbonzini@redhat.com
>> > <mailto:pbonzini@redhat.com>> wrote:
>> >
>> >
>> >
>> >     On 12/05/2017 09:26, Miltiadis Hatzimihail wrote:
>> >     > I ve tried the same today using a 32-bit Guest OS and the illega=
l
>> >     > instruction this time is
>> >     >
>> >     > fstps %(ecx)
>> >     >
>> >     > Is it a similar case to the movss one? (the previous Guest I was
>> using
>> >     > was 64 bit).
>> >
>> >     Yes, it is.
>> >
>> >     Paolo
>> >
>> >     > Also, I had to start QEMU using the following command line
>> options:
>> >     >
>> >     > qemu -cpu host,-sse2
>> >     >
>> >     > because one my programs was giving me an illegal instruction
>> based on
>> >     > the above and it worked by disabling it.
>> >     >
>> >     > =E2=80=8BRegards
>> >     > Milton
>> >     >
>> >     > On Thu, May 11, 2017 at 2:12 PM, Miltiadis Hatzimihail
>> >     > <hatzimiltos@gmail.com <mailto:hatzimiltos@gmail.com>
>> >     <mailto:hatzimiltos@gmail.com <mailto:hatzimiltos@gmail.com>>>
>> wrote:
>> >     >
>> >     >     Ok many thanks for your help.
>> >     >
>> >     >     =E2=80=8BMilton
>> >     >
>> >     >     On Thu, May 11, 2017 at 2:11 PM, Paolo Bonzini <
>> pbonzini@redhat.com <mailto:pbonzini@redhat.com>
>> >     >     <mailto:pbonzini@redhat.com <mailto:pbonzini@redhat.com>>>
>> wrote:
>> >     >
>> >     >
>> >     >
>> >     >         On 11/05/2017 14:47, Miltiadis Hatzimihail wrote:
>> >     >         > That's great thanks for the clarification.
>> >     >         >
>> >     >         > Is this patch going to make it to the mainline at some
>> >     point?
>> >     >
>> >     >         Not exactly as is, because it has a small defect (it
>> >     always reads 16
>> >     >         bytes from memory), but something like that will.
>> >     >
>> >     >         Paolo
>> >     >
>> >     >
>> >     >
>> >
>> >
>>
>
>
