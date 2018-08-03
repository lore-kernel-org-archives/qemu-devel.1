Received: from eggs.gnu.org ([2001:4830:134:3::10]:37641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fldv4-0004da-3M
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fldv3-0006z3-CI
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:31:18 -0400
Date: Fri, 3 Aug 2018 18:31:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180803173108.GG2802@work-vm>
References: <20180803163646.31068-1-peter.maydell@linaro.org>
	<20180803163646.31068-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803163646.31068-4-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: Add dummy needed functions
 to M profile vmstate subsections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Juan Quintela <quintela@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> Currently the migration code incorrectly treats a subsection with
> no .needed function pointer as if it was the subsection list
> terminator -- it is ignored and so is everything after it.
> Work around this by giving various M profile vmstate structs
> a 'needed' function that always returns true.
> We reuse m_needed() for this, since it's always true here.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

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
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
