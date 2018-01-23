Received: from eggs.gnu.org ([2001:4830:134:3::10]:57616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edxGF-0006It-6Y
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edxG9-0007Py-F9
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:01:07 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:41492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edxG9-0007Pm-84
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:01:01 -0500
Received: by mail-wr0-x22f.google.com with SMTP id v15so267354wrb.8
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 04:01:00 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-11-alex.bennee@linaro.org>
	<1393deaf-c207-6055-1f7c-f7ae814cf2db@amsat.org>
	<87shb3nwkc.fsf@linaro.org>
	<CAAdtpL48633TDoSnhv1-iZ0QjWWQsuD1DxJTsniJg+AHbeiT_g@mail.gmail.com>
	<CAFEAcA8bEPohja9fw-5_BUnfExX4KA_syce8dpdD=trShV=qAg@mail.gmail.com>
	<782d052d-f390-1a55-8a73-120753aa1472@amsat.org>
	<CAFEAcA90331Sezm-PwVFrMqP6Fgav0ujJv0Mkt7PAd_9CBrEFA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA90331Sezm-PwVFrMqP6Fgav0ujJv0Mkt7PAd_9CBrEFA@mail.gmail.com>
Date: Tue, 23 Jan 2018 12:00:58 +0000
Message-ID: <87mv147pj9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/20] fpu/softfloat: define decompose
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Francisco Iglesias <frasse.iglesias@gmail.com>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Dutcher <andrew@andrewdutcher.com>, bharata@linux.vnet.ibm.com, Aurelien Jarno <aurelien@aurel32.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 18 January 2018 at 14:59, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>> My comment was for a previous line:
>>
>>   uint64_t frac   : 64;
>>
>> I don't have enough compiler knowledge to be sure how this bitfield is
>> interpreted by the compiler. I understood the standard as bitfields are
>> for 'unsigned', and for IL32 we have sizeof(unsigned) =3D 32, so I wonder
>> how a :64 bitfield ends (bits >=3D 32 silently truncated?).
>
> Defining a 64-bit bitfield is a bit pointless (why not just use
> uint64_t?) but there's nothing particularly different for IL32P64 here.
> The spec says the underlying type is _Bool, signed int, unsigned
> into, or an implementation defined type. For QEMU's hosts 'int'
> is always 32 bits, so if gcc and clang allow bitfields on a
> 64-bit type like uint64_t (as an impdef extension) then they
> should work on all hosts. (In any case it needs to either work
> or give a compiler error, silent truncation isn't an option.)

Using explicit size types and an attribute on FloatClass seemed to be
enough:

/*
 * Classify a floating point number. Everything above float_class_qnan
 * is a NaN so cls >=3D float_class_qnan is any NaN.
 */

typedef enum __attribute__ ((__packed__)) {
    float_class_unclassified,
    float_class_zero,
    float_class_normal,
    float_class_inf,
    float_class_qnan,  /* all NaNs from here */
    float_class_snan,
    float_class_dnan,
    float_class_msnan, /* maybe silenced */
} FloatClass;

/*
 * Structure holding all of the decomposed parts of a float. The
 * exponent is unbiased and the fraction is normalized. All
 * calculations are done with a 64 bit fraction and then rounded as
 * appropriate for the final format.
 *
 * Thanks to the packed FloatClass a decent compiler should be able to
 * fit the whole structure into registers and avoid using the stack
 * for parameter passing.
 */

typedef struct {
    uint64_t frac;
    int32_t  exp;
    FloatClass cls;
    bool sign;
} FloatParts;

--
Alex Benn=C3=A9e
