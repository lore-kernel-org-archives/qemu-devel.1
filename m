Received: from eggs.gnu.org ([2001:4830:134:3::10]:49474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn39y-00006f-L3
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn39x-0007Cq-Nz
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:40:30 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180806123445.1459-4-peter.maydell@linaro.org> (Peter Maydell's
	message of "Mon, 6 Aug 2018 13:34:43 +0100")
References: <20180806123445.1459-1-peter.maydell@linaro.org>
	<20180806123445.1459-4-peter.maydell@linaro.org>
Reply-To: quintela@redhat.com
Date: Tue, 07 Aug 2018 16:40:17 +0200
Message-ID: <87600m2qb2.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 3/5] target/arm: Add dummy
 needed functions to M profile vmstate subsections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> Currently the migration code incorrectly treats a subsection with
> no .needed function pointer as if it was the subsection list
> terminator -- it is ignored and so is everything after it.
> Work around this by giving various M profile vmstate structs
> a 'needed' function that always returns true.
> We reuse m_needed() for this, since it's always true here.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> ---
> Not strictly a regression as it only affects M profile CPUs
> with the security extensions, and migration of those was
> broken anyway in 2.12 due to a different bug.
> ---
>  target/arm/machine.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 2e28d086bdf..ff4ec22bf75 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -184,6 +184,7 @@ static const VMStateDescription vmstate_m_faultmask_primask = {
>      .name = "cpu/m/faultmask-primask",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .needed = m_needed,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(env.v7m.faultmask[M_REG_NS], ARMCPU),
>          VMSTATE_UINT32(env.v7m.primask[M_REG_NS], ARMCPU),
> @@ -230,6 +231,7 @@ static const VMStateDescription vmstate_m_scr = {
>      .name = "cpu/m/scr",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .needed = m_needed,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(env.v7m.scr[M_REG_NS], ARMCPU),
>          VMSTATE_END_OF_LIST()
> @@ -240,6 +242,7 @@ static const VMStateDescription vmstate_m_other_sp = {
>      .name = "cpu/m/other-sp",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .needed = m_needed,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(env.v7m.other_sp, ARMCPU),
>          VMSTATE_END_OF_LIST()

But having 3 subsections with the same needed function ... we could have
a single subsection.

Later, Juan.
