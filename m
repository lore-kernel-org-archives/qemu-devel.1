Received: from eggs.gnu.org ([2001:4830:134:3::10]:50651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLVtf-0000vx-6C
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLVtc-0005d6-14
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:09:35 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eLVtb-0005ck-Qp
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:09:31 -0500
Received: by mail-pl0-x241.google.com with SMTP id x22so8957319pln.11
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 07:09:31 -0800 (PST)
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
	<1512153879-5291-5-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <609844a3-c004-6268-5174-557096d9e33c@linaro.org>
Date: Sun, 3 Dec 2017 07:09:27 -0800
MIME-Version: 1.0
In-Reply-To: <1512153879-5291-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] target/arm: Split M profile MNegPri
 mmu index into user and priv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 12/01/2017 10:44 AM, Peter Maydell wrote:
> For M profile, we currently have an mmu index MNegPri for
> "requested execution priority negative". This fails to
> distinguish "requested execution priority negative, privileged"
> from "requested execution priority negative, usermode", but
> the two can return different results for MPU lookups. Fix this
> by splitting MNegPri into MNegPriPriv and MNegPriUser, and
> similarly for the Secure equivalent MSNegPri.
> 
> This takes us from 6 M profile MMU modes to 8, which means
> we need to bump NB_MMU_MODES; this is OK since the point
> where we are forced to reduce TLB sizes is 9 MMU modes.
> 
> (It would in theory be possible to stick with 6 MMU indexes:
> {mpu-disabled,user,privileged} x {secure,nonsecure} since
> in the MPU-disabled case the result of an MPU lookup is
> always the same for both user and privileged code. However
> we would then need to rework the TB flags handling to put
> user/priv into the TB flags separately from the mmuidx.
> Adding an extra couple of mmu indexes is simpler.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       | 49 ++++++++++++++++++++++++++++---------------------
>  target/arm/internals.h |  6 ++++--
>  target/arm/helper.c    | 14 ++++++++++----
>  target/arm/translate.c |  8 ++++++--
>  4 files changed, 48 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
