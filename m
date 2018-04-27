Received: from eggs.gnu.org ([2001:4830:134:3::10]:45041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC0LV-0007rt-TI
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC0LU-0007z8-NJ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:11:17 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC0LU-0007y2-I1
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:11:16 -0400
Received: by mail-ot0-x243.google.com with SMTP id t1-v6so1404286ott.13
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 03:11:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NtuV06sw9UeQQxn40+KJo3xEgEQ64MFS6vWy4VtZvK7nw@mail.gmail.com>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
	<20180426104715.21702-16-peter.maydell@linaro.org>
	<CAHNT7NtuV06sw9UeQQxn40+KJo3xEgEQ64MFS6vWy4VtZvK7nw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 11:10:55 +0100
Message-ID: <CAFEAcA_ZEULz1r_YxSjXwOtXqbA47R=w2Pc43bL2qSBjNhrUfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 15/19] hw/arm/highbank: don't make sysram
 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 26 April 2018 at 23:03, Michael Clark <mjc@sifive.com> wrote:
>
>
> On Thu, Apr 26, 2018 at 10:47 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>>
>> Currently we use memory_region_init_ram_nomigrate() to create
>> the "highbank.sysram" memory region, and we don't manually
>> register it with vmstate_register_ram(). This currently
>> means that its contents are migrated but as a ram block
>> whose name is the empty string; in future it may mean they
>> are not migrated at all. Use memory_region_init_ram() instead.
>
>
> It is self evident that memory_region_init_ram() implies normal migration.

Yes; using the _nomigrate functions in these files looks odd
but it only looks odd as a result of a refactor we did.

Previously we had:
 * memory_region_init_ram() -- doesn't register the ram for migration
 * everybody has to manually call vmstate_register_ram()
Then we refactored so that:
 * the old memory_region_init_ram() is renamed to _nomigrate()
 * a new memory_region_init_ram() does that plus calls
   vmstate_register_ram() for you
 * callsites that were doing both calls got automatically rewritten
   to call the new memory_region_init_ram()
 * callsites that forgot the vmstate_register_ram() got rewritten
   to call memory_region_init_ram_nomigrate()

So board code that was previously making an easy and hard-to-spot
mistake (forgetting to call vmstate_register_ram()) got rewritten
so the mistake is more obvious (calling memory_region_init_ram_nomigrate
for no good reason).

thanks
-- PMM
