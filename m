Received: from eggs.gnu.org ([2001:4830:134:3::10]:47412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR4nw-0007yg-Fb
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR4nt-0004yj-Ru
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:26:40 -0500
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:41914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR4nt-0004yF-M2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:26:37 -0500
Received: by mail-pl0-x229.google.com with SMTP id g2so5793755pli.8
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 15:26:37 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a3fbf87d-e898-d2a7-6dab-2615dfe60939@linaro.org>
Date: Mon, 18 Dec 2017 15:26:31 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 19/19] fpu/softfloat: re-factor compare
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
> +    if (a.cls == float_class_zero || b.cls == float_class_zero) {
> +        if (a.cls == float_class_normal) {
> +            return a.sign ? float_relation_less : float_relation_greater;
> +        } else if (b.cls == float_class_normal) {
> +            return b.sign ? float_relation_greater : float_relation_less;
> +        } else if (a.cls == b.cls) {
> +            return float_relation_equal;
> +        }
> +    }

This misses out on infinity handling, which should be like normals.
Perhaps better as

    if (a.cls == float_class_zero) {
        if (b.cls == float_class_zero) {
            return float_relation_equal;
        }
        return b.sign ? float_relation_greater : float_relation_less;
    } else if (b.cls == float_class_zero) {
        return a.sign ? float_relation_less : float_relation_greater;
    }

> +    /* The only infinity we need to explicitly worry about is
> +     * comparing two together, otherwise the max_exp/sign details are
> +     * enough to compare to normal numbers
> +     */

I don't think it's wise to rely on the contents of .exp for float_class_inf.
Really, the only valid member for that type is sign.  Better as

    if (a.cls == float_class_inf) {
        if (b.cls == float_class_inf) {
            if (a.sign == b.sign) {
                return float_relation_equal;
            }
        }
        return a.sign ? float_relation_less : float_relation_greater;
    } else if (b.cls == float_class_inf) {
        return b.sign ? float_relation_less : float_relation_greater;
    }


r~
