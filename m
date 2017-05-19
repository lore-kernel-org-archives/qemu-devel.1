Received: from eggs.gnu.org ([2001:4830:134:3::10]:35950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dBfM4-0008Hd-KP
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dBfM1-000220-AV
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:41:56 -0400
Received: from mail.ispras.ru ([83.149.199.45]:37616)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dBfM0-00021d-S3
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:41:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 19 May 2017 13:41:51 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <be98ada5-2a3b-f1c2-e477-7232f735b296@redhat.com>
References: <ffb376034ff184f2fcbe93d5317d9e76@ispras.ru>
	<be98ada5-2a3b-f1c2-e477-7232f735b296@redhat.com>
Message-ID: <693bb030c9da368d6285201008581394@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386: fix read/write cr with icount option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Devel <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Paolo Bonzini =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-05-19 12:59:
> On 19/05/2017 11:36, Mihail Abakumov wrote:
>> Running Windows with icount causes a crash in instruction of write cr.
>> This patch fixes it.
>>=20
>> Reading and writing cr cause an icount read because there are called
>> cpu_get_apic_tpr and cpu_set_apic_tpr functions. So, there is need
>> gen_io_start()/gen_io_end() calls.
>=20
> The patch looks good, but lacks a signoff.  Please read the Developer
> Certificate of Origin[1] and reply to this email with "Signed-off-by:
> Mihail Abakumov <mikhail.abakumov@ispras.ru>".
>=20
>=20
> [1]     Developer's Certificate of Origin 1.1
>=20
>         By making a contribution to this project, I certify that:
>=20
>         (a) The contribution was created in whole or in part by me and=20
> I
>             have the right to submit it under the open source license
>             indicated in the file; or
>=20
>         (b) The contribution is based upon previous work that, to the=20
> best
>             of my knowledge, is covered under an appropriate open=20
> source
>             license and I have the right under that license to submit=20
> that
>             work with modifications, whether created in whole or in=20
> part
>             by me, under the same open source license (unless I am
>             permitted to submit under a different license), as=20
> indicated
>             in the file; or
>=20
>         (c) The contribution was provided directly to me by some other
>             person who certified (a), (b) or (c) and I have not=20
> modified
>             it.
>=20
>         (d) I understand and agree that this project and the=20
> contribution
>             are public and that a record of the contribution (including=
=20
> all
>             personal information I submit with it, including my=20
> sign-off) is
>             maintained indefinitely and may be redistributed consistent=
=20
> with
>             this project or the open source license(s) involved.
>=20
> Thanks,
>=20
> Paolo

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>

>> ---
>>  target/i386/translate.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>=20
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index 06d8833..3b009bd 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -7907,14 +7907,26 @@ static target_ulong disas_insn(CPUX86State=20
>> *env,
>> DisasContext *s,
>>                  gen_update_cc_op(s);
>>                  gen_jmp_im(pc_start - s->cs_base);
>>                  if (b & 2) {
>> +                    if (s->tb->cflags & CF_USE_ICOUNT) {
>> +                        gen_io_start();
>> +                    }
>>                      gen_op_mov_v_reg(ot, cpu_T0, rm);
>>                      gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
>>                                           cpu_T0);
>> +                    if (s->tb->cflags & CF_USE_ICOUNT) {
>> +                        gen_io_end();
>> +                    }
>>                      gen_jmp_im(s->pc - s->cs_base);
>>                      gen_eob(s);
>>                  } else {
>> +                    if (s->tb->cflags & CF_USE_ICOUNT) {
>> +                        gen_io_start();
>> +                    }
>>                      gen_helper_read_crN(cpu_T0, cpu_env,
>> tcg_const_i32(reg));
>>                      gen_op_mov_reg_v(ot, rm, cpu_T0);
>> +                    if (s->tb->cflags & CF_USE_ICOUNT) {
>> +                        gen_io_end();
>> +                    }
>>                  }
>>                  break;
>>              default:
