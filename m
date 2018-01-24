Received: from eggs.gnu.org ([2001:4830:134:3::10]:56310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eePCZ-0004q8-TL
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eePCW-0003EB-Qr
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:51:11 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eePCW-0003Dt-Jw
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:51:08 -0500
Received: by mail-pg0-x244.google.com with SMTP id o13so3216112pgs.2
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 09:51:08 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1649f8cf-7346-21e7-59f4-896bc7bfb8f6@linaro.org>
Date: Wed, 24 Jan 2018 09:51:04 -0800
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 16/22] fpu/softfloat: re-factor
 round_to_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/24/2018 05:13 AM, Alex Bennée wrote:
> +static FloatParts round_to_int(FloatParts a, int rounding_mode, float_status *s)
> +{
> +
> +    switch (a.cls) {
> +    case float_class_snan:
> +        a.cls = s->default_nan_mode ? float_class_dnan : float_class_msnan;
> +        s->float_exception_flags |= float_flag_invalid;
> +        break;
> +    case float_class_zero:
> +    case float_class_inf:
> +    case float_class_qnan:
> +        /* already "integral" */
> +        break;

This mishandles float_class_qnan + default_nan_mode.
Consider how this would pass though pick_nan_parts(a, a, s).

I suspect a single-argument version of pick_nan_parts would be helpful:

static FloatParts return_nan(FloatParts a, float_status *s)
{
    switch (a.cls) {
    case float_class_snan:
        s->float_exception_flags |= float_flag_invalid;
        a.cls = float_class_msnan;
        /* FALLTHRU */

    case float_class_qnan:
        if (s->default_nan_mode) {
            a.cls = float_class_dnan;
        }
        break;

    default:
        g_assert_not_reached();
    }
}

and use this in round_to_int, scalbn, and sqrt.


r~
