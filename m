Received: from eggs.gnu.org ([2001:4830:134:3::10]:34762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAfQa-0002Tc-Rt
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAfQV-0004nO-Uz
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:39:00 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAfQV-0004nF-Pz
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:38:55 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12-v6so18656404qti.4
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 10:38:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180423162523.6392-1-f4bug@amsat.org>
	<20180423162523.6392-3-f4bug@amsat.org>
	<756704ca-f41d-d0ec-fb57-cd844b6164e6@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c397f644-db18-1193-d8b2-457989e2c55f@amsat.org>
Date: Mon, 23 Apr 2018 14:38:50 -0300
MIME-Version: 1.0
In-Reply-To: <756704ca-f41d-d0ec-fb57-cd844b6164e6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] loader: Fix 64-bit misaligned
 member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paul Burton <paul.burton@mips.com>, qemu-devel@nongnu.org

On 04/23/2018 02:34 PM, Richard Henderson wrote:
> On 04/23/2018 06:25 AM, Philippe Mathieu-Daudé wrote:
>> Assuming the base of the fdt is aligned, a 32-bit property returns
>> a 32-bit aligned pointer...
> ...
>>      case 4:
>> -        *addr = fdt32_to_cpu(*(fdt32_t *)prop);
>> +        *addr = fdt32_to_cpu(ldl_he_p(prop));
>>          return 0;
> 
> So why are you changing the 32-bit case?

First to not assume base fdt is always 32-bit aligned,
second to keep calls similar and avoid someone use *(fdt64_t *) similar
to the 32-bit property. But this is avoidable with a simple comment
about why we have to use ldq_he_p().
