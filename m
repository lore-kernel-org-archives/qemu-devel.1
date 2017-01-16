Received: from eggs.gnu.org ([2001:4830:134:3::10]:35320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTB4P-0001Om-E5
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTB4O-0000Et-If
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:27:49 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:34964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTB4O-0000Di-6f
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:27:48 -0500
Received: by mail-ua0-x22e.google.com with SMTP id y9so86286496uae.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:27:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484477462-14088-1-git-send-email-zhaoshenglong@huawei.com>
References: <1484477462-14088-1-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 17:27:27 +0000
Message-ID: <CAFEAcA_pKX-v6q2uE-5+mWXYyEfooYCUFu4kVEL1N_DS5yjA2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] arm: virt: Fix the segmentation fault when
 specifying an unsupported CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wu.wubin@huawei.com

On 15 January 2017 at 10:51, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
>
> For example, using -cpu generic will cause qemu segmentation fault.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  hw/arm/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7a03f84..4b301c2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -175,7 +175,7 @@ static bool cpuname_valid(const char *cpu)
>      int i;
>
>      for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
> -        if (strcmp(cpu, valid_cpus[i]) == 0) {
> +        if (valid_cpus[i] != NULL && strcmp(cpu, valid_cpus[i]) == 0) {
>              return true;
>          }
>      }

A better fix is to just remove the NULL entry from the
valid_cpus[] array. We already have one "stop when we
run out of entries" condition (the ARRAY_SIZE check),
we don't need two...

thanks
-- PMM
