Received: from eggs.gnu.org ([2001:4830:134:3::10]:39271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR4gk-0004ou-Pq
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR4gh-0007sY-GH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:19:14 -0500
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:40092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR4gh-0007sJ-8m
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:19:11 -0500
Received: by mail-pf0-x235.google.com with SMTP id v26so10334795pfl.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 15:19:11 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-19-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <08a4580a-a812-3976-a5e5-7b69472b59a2@linaro.org>
Date: Mon, 18 Dec 2017 15:19:04 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 18/19] fpu/softfloat: re-factor minmax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/11/2017 04:57 AM, Alex Bennée wrote:
> +static decomposed_parts minmax_decomposed(decomposed_parts a,
> +                                          decomposed_parts b,
> +                                          bool ismin, bool ieee, bool ismag,
> +                                          float_status *s)
> +{
> +        if (a.cls >= float_class_qnan

Indent is off by 4.

> +                    if (s->default_nan_mode) {
> +                        a.cls = float_class_msnan;
> +                        return a;

float_class_dnan.  That said, can't you fall through to pick_nan_parts and have
that (and float_flag_invalid) handled already?

> +        if (a.cls == float_class_zero || b.cls == float_class_zero) {
> +            if (a.cls == float_class_normal) {
> +                if (a.sign) {
> +                    return ismin ? a : b;
> +                } else {
> +                    return ismin ? b : a;
> +                }
> +            } else if (b.cls == float_class_normal) {
> +                if (b.sign) {
> +                    return ismin ? b : a;
> +                } else {
> +                    return ismin ? a : b;
> +                }
> +            }
> +        }

With respect to zero, normal and inf should be handled the same.
Both of those middle tests should be

  a.cls == float_class_normal || a.cls == float_class_inf

It would appear this section is not honoring ismag.

This is one case where I think it might be helpful to do

    int a_exp, b_exp;
    bool a_sign, b_sign;

    if (nans) {
        ...
    }

    switch (a.cls) {
    case float_class_normal:
        a_exp = a.exp;
        break;
    case float_class_inf:
        a_exp = INT_MAX;
        break;
    case float_class_zero:
        a_exp = INT_MIN;
        break;
    }
    switch (b.cls) {
        ....
    }
    a_sign = a.sign;
    b_sign = b.sign
    if (ismag) {
        a_sign = b_sign = 0;
    }

    if (a_sign == b_sign) {
        bool a_less = a_exp < b_exp;
        if (a_exp == b_exp) {
            a_less = a.frac < b.frac;
        }
        return a_sign ^ a_less ^ ismin ? b : a;
    } else {
        return a_sign ^ ismin ? b : a;
    }


r~
