Received: from eggs.gnu.org ([2001:4830:134:3::10]:38423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiHb-0002eK-BH
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiHW-0005EF-Bz
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:12:59 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:45525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZiHW-0005DM-66
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:12:54 -0500
Received: by mail-pg0-x241.google.com with SMTP id c194so2792188pga.12
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:12:54 -0800 (PST)
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<20171218174552.18871-3-richard.henderson@linaro.org>
	<CAFEAcA9igMy9u0WdTBvJWms1G4Cd2m0QXUucJeXCJ1Uo=7OAMw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <300b87dc-7a0c-dda9-058d-674b115d06a1@linaro.org>
Date: Thu, 11 Jan 2018 11:12:50 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9igMy9u0WdTBvJWms1G4Cd2m0QXUucJeXCJ1Uo=7OAMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/23] target/arm: Add SVE decode skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 01/11/2018 10:20 AM, Peter Maydell wrote:
> On 18 December 2017 at 17:45, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Including only 4, as-yet unimplemented, instruction patterns
>> so that the whole thing compiles.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-a64.h | 111 +++++++++++++++++++++++++++++++++++++++++++++
>>  target/arm/translate-a64.c |  91 +++++++------------------------------
>>  target/arm/translate-sve.c |  48 ++++++++++++++++++++
>>  .gitignore                 |   1 +
>>  target/arm/Makefile.objs   |  11 +++++
>>  target/arm/sve.def         |  45 ++++++++++++++++++
>>  6 files changed, 233 insertions(+), 74 deletions(-)
>>  create mode 100644 target/arm/translate-a64.h
>>  create mode 100644 target/arm/translate-sve.c
>>  create mode 100644 target/arm/sve.def
> 
> This will be easier to review if you split the stuff that's
> purely code motion from the .c file to the .h into its own
> patch.

Ok.

>> +target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.def $(DECODETREE)
>> +       $(call quiet-command,\
>> +         $(PYTHON) $(DECODETREE) -o $@ --decode disas_sve \
>> +               $(SRC_PATH)/target/arm/sve.def || rm -f $@, \
>> +               "GEN", $@)
>> +
>> +target/arm/translate-sve.o: target/arm/decode-sve.inc.c
>> +obj-$(TARGET_AARCH64) += translate-sve.o
> 
> If we're serious about the idea that this decoder script is
> general purpose, we should have a rules.mak rune for
> generally invoking it to create a decode-foo.inc.c from a foo.def.

I didn't want to attempt to generalize this until we have two users.
Particularly if we wind up with extra options to the script to change other
behavior.


r~
