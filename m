Received: from eggs.gnu.org ([2001:4830:134:3::10]:50938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYg0H-0004jj-W1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYg0D-0000es-1D
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:07:05 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:38381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYg0C-0000cQ-RD
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:07:00 -0400
Received: by mail-pf0-x22c.google.com with SMTP id j17-v6so3278116pfn.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 16:07:00 -0700 (PDT)
References: <1529944302-14186-1-git-send-email-cota@braap.org>
	<168807dc-6c5b-fc1f-6a70-72e0a518b178@linaro.org>
	<20180627164757.GA17117@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c2ccb0a2-fc74-7d5c-3935-99522e19fed0@linaro.org>
Date: Thu, 28 Jun 2018 16:06:56 -0700
MIME-Version: 1.0
In-Reply-To: <20180627164757.GA17117@flamenco>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

On 06/27/2018 09:47 AM, Emilio G. Cota wrote:
>>> -    if (p2) {
>>> +    if (p2 && p2 != p) {
>>>          page_unlock(p2);
>>
>> ... so that you need no change here.
>> Otherwise it looks good.
> 
> I did that initially. However, note that if we do that then
> the second page is not added to the list of pages for this
> TB (via tb_page_add), which breaks the provided test case.
> 
>     page_lock_pair(&p, phys_pc, &p2, phys_page2, 1);
>     tb_page_add(p, tb, 0, phys_pc & TARGET_PAGE_MASK);
>     if (p2) {
>         tb_page_add(p2, tb, 1, phys_page2);
>     } else {
>         tb->page_addr[1] = -1;
>     }
> 
> Regardless of whether p1 and p2 point to the same physical page,
> the fact that the TB goes across two virtual pages should be
> preserved, and in this case tb_page_add must be called twice.

Hmm.  Ok.  Queued.


r~
