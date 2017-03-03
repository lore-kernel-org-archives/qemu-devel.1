Received: from eggs.gnu.org ([2001:4830:134:3::10]:60581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjliU-0005ng-SN
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:49:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjliR-0001WZ-Nv
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:49:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjliR-0001WO-IN
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:49:43 -0500
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-5-alex.bennee@linaro.org>
	<CAFEAcA_REYx=z1x9K_P1UK4j-fNyZ3717UrHDCLVySPanb28KQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <776ee8db-a894-e17d-2cd9-234882daee0c@redhat.com>
Date: Fri, 3 Mar 2017 12:49:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_REYx=z1x9K_P1UK4j-fNyZ3717UrHDCLVySPanb28KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/11] translate: downgrade IRQ BQL
 asserts to tcg_debug_assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@greensocs.com>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>



On 03/03/2017 11:08, Peter Maydell wrote:
> On 2 March 2017 at 19:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>> While on MTTCG hosts it is very important that updates to
>> cpu->interrupt_request are protected by the BQL not all guests have
>> been converted to the correct locking yet. As a result we are seeing
>> breaking on non-MTTCG enabled guests in production builds.
>>
>> The locking in the guests needs to be fixed but while running single
>> threaded they will continue to work. By moving the asserts to
>> tcg_debug_asserts() they will still be useful during conversion
>> work (much like the existing assert_memory_lock/assert_tb_lock
>> asserts).
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  translate-all.c    | 2 +-
>>  translate-common.c | 3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/translate-all.c b/translate-all.c
>> index 9bac061c9b..7ee273410d 100644
>> --- a/translate-all.c
>> +++ b/translate-all.c
>> @@ -1928,7 +1928,7 @@ void dump_opcount_info(FILE *f, fprintf_function=
 cpu_fprintf)
>>
>>  void cpu_interrupt(CPUState *cpu, int mask)
>>  {
>> -    g_assert(qemu_mutex_iothread_locked());
>> +    tcg_debug_assert(qemu_mutex_iothread_locked());
>=20
> If CONFIG_DEBUG_TCG isn't enabled then tcg_debug_assert()
> turns into "if (!(X)) { __builtin_unreachable(); }", which
> means that instead of asserting we now run straight
> into compiler undefined behaviour, don't we?
> If what we want is "don't actually check this condition in
> the non-tcg-debug config" then we should do something
> that means we don't actually check the condition...

I think we should fix it for good and leave this as a hard assertion.

Paolo
