Received: from eggs.gnu.org ([2001:4830:134:3::10]:49789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fKltb-0007KO-12
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fKlta-0007en-9m
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:34:43 -0400
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-24-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c049f864-304d-f8ee-4b2f-1476a602be30@redhat.com>
Date: Mon, 21 May 2018 16:34:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180521140402.23318-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/27] hw/core/or-irq: Support more than 16
 inputs to an OR gate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 21/05/2018 16:03, Peter Maydell wrote:
> + * VMState array; devices with more inputs than this need to
> + * migrate the extra lines via a subsection.
> + * The subsection migrates as much of the levels[] array as is needed
> + * (including repeating the first 16 elements), to avoid the awkwardness
> + * of splitting it in two to meet the requirements of VMSTATE_VARRAY_UINT16.
> + */
> +#define OLD_MAX_OR_LINES 16
> +#if MAX_OR_LINES < OLD_MAX_OR_LINES
> +#error MAX_OR_LINES must be at least 16 for migration compatibility
> +#endif
> +
> +static bool vmstate_extras_needed(void *opaque)
> +{
> +    qemu_or_irq *s = OR_IRQ(opaque);
> +
> +    return s->num_lines >= OLD_MAX_OR_LINES;
> +}
> +
> +static const VMStateDescription vmstate_or_irq_extras = {
> +    .name = "or-irq-extras",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vmstate_extras_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_VARRAY_UINT16_UNSAFE(levels, qemu_or_irq, num_lines, 0,
> +                                     vmstate_info_bool, bool),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +


Why do the levels have to be migrated at all?  It should be enough if
the IRQ level is either migrated manually, or restored (e.g. in
post_save callbacks) through other data that is migrated.

Paolo
