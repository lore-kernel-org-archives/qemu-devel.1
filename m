Received: from eggs.gnu.org ([2001:4830:134:3::10]:38472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmcJz-0001ue-Em
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmcJy-00034r-Gq
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:03 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmcJy-00034b-9s
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:02 -0400
Received: by mail-oi0-x241.google.com with SMTP id v8-v6so21129830oie.5
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 03:01:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180803163646.31068-2-peter.maydell@linaro.org>
References: <20180803163646.31068-1-peter.maydell@linaro.org>
	<20180803163646.31068-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 11:00:40 +0100
Message-ID: <CAFEAcA_qmdth9SjAcoRrAmDLP36-oHyT6BmaQv0U88mnDh2+7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] hw/intc/arm_gicv3_common:
 Give no-migration-shift-bug subsection a needed function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Forgot to cc Shannon on this one. Given that the missing .needed
function meant we weren't ever transmitting the subsection with
the no-shift-bug flag, this ought to mean that for current
master migration of KVM goes wrong (since the destination thinks
the source has the bug when it does not). I'm just going to try
to set up to test this...

thanks
-- PMM

On 3 August 2018 at 17:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> Currently the migration code incorrectly treats a subsection with
> no .needed function pointer as if it was the subsection list
> terminator -- it is ignored and so is everything after it.
> Work around this by giving vmstate_gicv3_gicd_no_migration_shift_bug
> a 'needed' function that always returns true.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This should go into 3.0 to avoid awkward migration compat problems:
> the no-migration-shift-bug subsection is new in 3.0.
> ---
>  hw/intc/arm_gicv3_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index ff326b374ad..e58bc8b8105 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -203,10 +203,16 @@ static int gicv3_gicd_no_migration_shift_bug_post_load(void *opaque,
>      return 0;
>  }
>
> +static bool needed_always(void *opaque)
> +{
> +    return true;
> +}
> +
>  const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
>      .name = "arm_gicv3/gicd_no_migration_shift_bug",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .needed = needed_always,
>      .pre_load = gicv3_gicd_no_migration_shift_bug_pre_load,
>      .post_load = gicv3_gicd_no_migration_shift_bug_post_load,
>      .fields = (VMStateField[]) {
> --
> 2.17.1
