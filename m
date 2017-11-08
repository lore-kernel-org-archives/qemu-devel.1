Received: from eggs.gnu.org ([2001:4830:134:3::10]:36119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCOjx-0001ds-A4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCOjs-0007hQ-6J
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:41:52 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:44603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eCOjr-0007gu-U4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:41:48 -0500
Received: by mail-wm0-x22d.google.com with SMTP id n74so17708047wmi.1
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 03:41:47 -0800 (PST)
References: <20171107150558.22131-1-alex.bennee@linaro.org>
	<20171107150558.22131-11-alex.bennee@linaro.org>
	<20171108105800.GD8971@e103592.cambridge.arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171108105800.GD8971@e103592.cambridge.arm.com>
Date: Wed, 08 Nov 2017 11:41:45 +0000
Message-ID: <87k1z1q9om.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 10/10] risu_reginfo_aarch64: add SVE
 support to reginfo_dump_mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dave Martin <Dave.Martin@arm.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>


Dave Martin <Dave.Martin@arm.com> writes:

> On Tue, Nov 07, 2017 at 03:05:58PM +0000, Alex Benn=C3=A9e wrote:
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  risu_reginfo_aarch64.c | 49 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>>  1 file changed, 49 insertions(+)
>>
>> diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
>> index 7c97790..8aba192 100644
>> --- a/risu_reginfo_aarch64.c
>> +++ b/risu_reginfo_aarch64.c
>> @@ -141,6 +141,18 @@ int reginfo_is_eq(struct reginfo *r1, struct reginf=
o *r2)
>>      return memcmp(r1, r2, sizeof(*r1)) =3D=3D 0;
>>  }
>>
>> +#ifdef SVE_MAGIC
>> +static int sve_zreg_is_eq(struct reginfo *r1, struct reginfo *r2, int z)
>> +{
>> +    return memcmp(r1->zregs[z], r2->zregs[z], sizeof(*r1->zregs[z])) =
=3D=3D 0;
>> +}
>> +
>> +static int sve_preg_is_eq(struct reginfo *r1, struct reginfo *r2, int p)
>> +{
>> +    return memcmp(r1->pregs[p], r2->pregs[p], sizeof(*r1->pregs[p])) =
=3D=3D 0;
>> +}
>> +#endif
>> +
>>  /* reginfo_dump: print state to a stream, returns nonzero on success */
>>  int reginfo_dump(struct reginfo *ri, FILE * f)
>>  {
>> @@ -216,5 +228,42 @@ int reginfo_dump_mismatch(struct reginfo *m, struct=
 reginfo *a, FILE * f)
>>          }
>>      }
>>
>> +#ifdef SVE_MAGIC
>> +    if (test_sve) {
>> +        if (m->vl !=3D a->vl) {
>> +            fprintf(f, "  SVE VL  : %d vs %d\n", m->vl, a->vl);
>> +        }
>> +        for (i =3D 0; i < SVE_NUM_PREGS; i++) {
>> +           if (!sve_preg_is_eq(m, a, i)) {
>> +              int q;
>> +              fprintf(f, "  P%2d   : ", i);
>> +              for (q =3D 0; q < sve_vq_from_vl(m->vl); q++) {
>> +                 fprintf(f, "%04x", m->pregs[i][q]);
>> +              }
>> +              fprintf(f, " vs ");
>> +              for (q =3D 0; q < sve_vq_from_vl(m->vl); q++) {
>> +                 fprintf(f, "%04x", a->pregs[i][q]);
>> +              }
>> +              fprintf(f, "\n");
>> +            }
>> +        }
>> +        for (i =3D 0; i < SVE_NUM_ZREGS; i++) {
>> +           if (!sve_zreg_is_eq(m, a, i)) {
>> +              int q;
>> +              char *pad=3D"";
>> +              fprintf(f, "  Z%2d   : ", i);
>> +              for (q =3D 0; q < sve_vq_from_vl(m->vl); q++) {
>> +                 if (m->zregs[i][q] !=3D a->zregs[i][q]) {
>> +                    fprintf(f, "%sq%02d: %016" PRIx64 "%016" PRIx64 " v=
s %016" PRIx64 "%016" PRIx64"\n", pad, q,
>> +                            (uint64_t) (m->zregs[i][q] >> 64), (uint64_=
t) m->zregs[i][q],
>> +                            (uint64_t) (a->zregs[i][q] >> 64), (uint64_=
t) a->zregs[i][q]);
>> +                    pad =3D "          ";
>> +                 }
>> +              }
>> +           }
>> +        }
>
> No FFR?
>
> Perhaps I should have explicitly encoded FFR as "P16" -- that sort of
> works and saves some open-coding of the extra special case, but it feels
> less correct.

Oops, yeah missed that out. I'll add it to the next version.

Good catch!

>
> You could do
>
> static int sve_preg_is_eq(uint16_t const (*p1)[SVE_VQ_MAX],
> 				uint16_t const (*p2)[SVE_VQ_MAX])
> {
> 	return memcmp(p1, p2, sizeof *p1) =3D=3D 0;
> }
>
> /* ... */
>
> sve_preg_is_eq(&r1->pregs[p], &r2->pregs[p])
>
> /* ... */
>
> sve_preg_is_eq(&r1->ffr, &r2->ffr)
>
> (or some variation on this theme).  ffr is a specialised predicate
> register, so I think you can assume that it really does have the same
> type as pregs[p].  Coding the above way will give a typcheck error if
> not.

Ahh ok thanks.

>
> Cheers
> ---Dave


--
Alex Benn=C3=A9e
