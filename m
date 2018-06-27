Received: from eggs.gnu.org ([2001:4830:134:3::10]:46067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY0C3-0004Nw-6z
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY0Bz-00061h-AO
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:28:27 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:36969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY0Bz-000614-0j
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:28:23 -0400
Received: by mail-pg0-x22c.google.com with SMTP id o11-v6so241447pgv.4
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 19:28:22 -0700 (PDT)
References: <1529944302-14186-1-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <168807dc-6c5b-fc1f-6a70-72e0a518b178@linaro.org>
Date: Tue, 26 Jun 2018 19:28:19 -0700
MIME-Version: 1.0
In-Reply-To: <1529944302-14186-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] translate-all: fix locking of TBs whose
 two pages share the same physical page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

On 06/25/2018 09:31 AM, Emilio G. Cota wrote:
> +    } else if (page1 == page2) {
> +        page_lock(p1);
> +        if (ret_p2) {
> +            *ret_p2 = p1;

I think you should set NULL here...

> @@ -1623,7 +1641,7 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
>          tb = existing_tb;
>      }
>  
> -    if (p2) {
> +    if (p2 && p2 != p) {
>          page_unlock(p2);

... so that you need no change here.
Otherwise it looks good.


r~
