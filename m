Received: from eggs.gnu.org ([2001:4830:134:3::10]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCoAO-0003m7-DS
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCoAJ-0007d0-OU
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:50:52 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:54658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eCoAJ-0007at-Fm
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:50:47 -0500
Received: by mail-wm0-x22c.google.com with SMTP id r68so18250230wmr.3
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 06:50:47 -0800 (PST)
References: <20171107150558.22131-1-alex.bennee@linaro.org>
	<20171107150558.22131-8-alex.bennee@linaro.org>
	<20171109122144.GA22781@e103592.cambridge.arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171109122144.GA22781@e103592.cambridge.arm.com>
Date: Thu, 09 Nov 2017 14:50:44 +0000
Message-ID: <87a7zvqzej.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 07/10] risugen: add --sve support
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

> On Tue, Nov 07, 2017 at 03:05:55PM +0000, Alex Benn=C3=A9e wrote:
>> This is similar to the approach used by the FP/simd data in so far as
>> we generate a block of random data and then load into it. As there are
>> no post-index SVE operations we need to emit an additional incp
>> instruction to generate our offset into the array.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  risugen        |  3 +++
>>  risugen_arm.pm | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++-=
------
>>  2 files changed, 53 insertions(+), 7 deletions(-)
>>
>> diff --git a/risugen b/risugen
>> index aba4bb7..0ac8e86 100755
>> --- a/risugen
>> +++ b/risugen
>> @@ -317,6 +317,7 @@ sub main()
>>      my $condprob =3D 0;
>>      my $fpscr =3D 0;
>>      my $fp_enabled =3D 1;
>> +    my $sve_enabled =3D 1;
>>      my $big_endian =3D 0;
>>      my ($infile, $outfile);
>>
>> @@ -334,6 +335,7 @@ sub main()
>>                  },
>>                  "be" =3D> sub { $big_endian =3D 1; },
>>                  "no-fp" =3D> sub { $fp_enabled =3D 0; },
>> +                "sve" =3D> sub { $sve_enabled =3D 1; },
>>          ) or return 1;
>>      # allow "--pattern re,re" and "--pattern re --pattern re"
>>      @pattern_re =3D split(/,/,join(',',@pattern_re));
>> @@ -361,6 +363,7 @@ sub main()
>>          'fpscr' =3D> $fpscr,
>>          'numinsns' =3D> $numinsns,
>>          'fp_enabled' =3D> $fp_enabled,
>> +        'sve_enabled' =3D> $sve_enabled,
>>          'outfile' =3D> $outfile,
>>          'details' =3D> \%insn_details,
>>          'keys' =3D> \@insn_keys,
>> diff --git a/risugen_arm.pm b/risugen_arm.pm
>> index 2f10d58..8d1e1fd 100644
>> --- a/risugen_arm.pm
>> +++ b/risugen_arm.pm
>> @@ -472,9 +472,47 @@ sub write_random_aarch64_fpdata()
>>      }
>>  }
>>
>> -sub write_random_aarch64_regdata($)
>> +sub write_random_aarch64_svedata()
>>  {
>> -    my ($fp_enabled) =3D @_;
>> +    # Load SVE registers
>> +    my $align =3D 16;
>> +    my $vl =3D 16;                             # number of vqs
>
> Would this be better phrased
>
> 	my $vq =3D 16;				# quadwords per vector
>
>> +    my $datalen =3D (32 * $vl * 16) + $align;
>> +
>> +    write_pc_adr(0, (3 * 4) + ($align - 1)); # insn 1
>> +    write_align_reg(0, $align);              # insn 2
>> +    write_jump_fwd($datalen);                # insn 3
>> +
>> +    # align safety
>> +    for (my $i =3D 0; $i < ($align / 4); $i++) {
>> +        # align with nops
>> +        insn32(0xd503201f);
>> +    };
>> +
>> +    for (my $rt =3D 0; $rt <=3D 31; $rt++) {
>> +        for (my $q =3D 0; $q < $vl; $q++) {
>> +            write_random_fpreg_var(4); # quad
>> +        }
>> +    }
>> +
>> +    # Reset all the predicate registers to all true
>> +    for (my $p =3D 0; $p < 16; $p++) {
>> +        insn32(0x2518e3e0 | $p);
>> +    }
>> +
>> +    # there is no post index load so we do this by hand
>> +    write_mov_ri(1, 0);
>> +    for (my $rt =3D 0; $rt <=3D 31; $rt++) {
>> +        # ld1d    z0.d, p0/z, [x0, x1, lsl #3]
>> +        insn32(0xa5e14000 | $rt);
>> +        # incp    x1, p0.d
>> +        insn32(0x25ec8801);
>
> You could avoid this with the unpredicated form LDR (vector).
> (LD1x scalar+immediate doesn't provide enough immediate range).
>
> 	# ldr	z$rt, [x0, #$rt, mul vl]
> 	insn32(0x85804000 + $rt + (($rt & 7) << 10) + (($rt & 0x18) << 13));
>
> which is what the kernel does.

Ahh thanks.

> No harm in exercising different instructions though!  The kernel uses
> embarrassingly few.

Well that's what the actual random instructions are for. I haven't yet
considered if we need to group things together to properly exercise the
predicate code. So far RISU doesn't exercise conditional branches as
it's hard to do that without generating code that would lock up. It's
very much the "easy 80%" of instructions we target.

> Does it matter that the stride will depend on the actual current VL?
> If x0 just points to a block of random data, I guess it doesn't matter:
> some trailing data remains unused, but that doesn't make the used data
> any less random.

Not really. We do try and re-generate every N instructions so all the
floats don't just denormalise.

>
> [...]
>
> Cheers
> ---Dave


--
Alex Benn=C3=A9e
