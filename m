Received: from eggs.gnu.org ([2001:4830:134:3::10]:55618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duNJX-0007BP-7r
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duNJW-0002rl-CY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:32:07 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:43623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duNJW-0002pv-6U
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:32:06 -0400
Received: by mail-wm0-x231.google.com with SMTP id a137so1155922wma.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:32:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-3-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-3-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Sep 2017 19:31:44 +0100
Message-ID: <CAFEAcA8hy2Om-yf1QvoE33tB5u7tvs_mLJeUDR1Hm_SLq7WACA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 02/19] nvic: Add banked
 exception states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 12 September 2017 at 19:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> For the v8M security extension, some exceptions must be banked
> between security states. Add the new vecinfo array which holds
> the state for the banked exceptions and migrate it if the
> CPU the NVIC is attached to implements the security extension.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> +static const VMStateDescription vmstate_nvic_security = {
> +    .name = "nvic/m-security",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = nvic_security_needed,
> +    .post_load = &nvic_security_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT_ARRAY(sec_vectors, NVICState, NVIC_INTERNAL_VECTORS, 1,
> +                             vmstate_VecInfo, VecInfo),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_nvic = {
>      .name = "armv7m_nvic",
>      .version_id = 4,

This patch needs the following folded in, so that we actually
include the new vmstate subsection in the top level's subsection
list...

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 694b9e0..8793f75 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1205,6 +1205,10 @@ static const VMStateDescription vmstate_nvic = {
                              vmstate_VecInfo, VecInfo),
         VMSTATE_UINT32(prigroup, NVICState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &vmstate_nvic_security,
+        NULL
     }
 };

thanks
-- PMM
