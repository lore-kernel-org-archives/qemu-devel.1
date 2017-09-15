Received: from eggs.gnu.org ([2001:4830:134:3::10]:50796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsqwR-0003n9-RF
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsqwO-0000M9-My
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:45:59 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:58397 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsqwO-0000Lt-Ap
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:45:56 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
	<CAFEAcA-rmX=gUdYTLK4g5TAWVTkCfkbkXXfCxmaaivv8XGdMXg@mail.gmail.com>
Date: Fri, 15 Sep 2017 16:45:42 +0300
In-Reply-To: <CAFEAcA-rmX=gUdYTLK4g5TAWVTkCfkbkXXfCxmaaivv8XGdMXg@mail.gmail.com>
	(Peter Maydell's message of "Thu, 14 Sep 2017 15:54:28 +0100")
Message-ID: <877ex0gjnd.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/22] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Peter Maydell writes:

> On 12 September 2017 at 22:01, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> =
wrote:
>> This series adds an API to add instrumentation events.
>>=20
>> It also provides additional APIs for:
>> * Controlling tracing events.
>> * Peek/poke guest memory.

>> Future APIs (for later series):
>> * Peek/poke guest registers.
>> * Add breakpoints to trigger instrumentation functions.
>> * Trigger instrumentation functions from guest code (former hypertrace).
>> * Add events for guest code translation/execution (once the respective t=
racing
>> events are accepted upstream).
>> * Add events for exceptions/syscalls.
>> * Add events for TB invalidation (necessary for libraries to deallocate =
any data
>> they might have allocated for the TBs they instrumented).
>>=20
>> The instrumentation code is dynamically loaded as a library into QEMU ei=
ther
>> when it starts or later using its remote control interfaces. The loaded =
code
>> only has access to function explicitly exported through the QI_VPUBLIC m=
acro.
>>=20
>> This series is branch 'devel-instrument' in
>> https://code.gso.ac.upc.edu/git/qemu-dbi.

> To parallel the comment I sent on Emilio's series: I think the
> first thing we should do here is work out the API we want to
> present to the instrumentation plugin, because that's permanent
> and we want to get it right. Then we can figure out the
> implementation details later.

> Particular notes:
>  * putting things in the instrumentation plugin API that basically
>    parallel some existing trace points is something I'm wary of,
>    because a lot of our existing tracing is "output something at
>    a point and in a way that's convenient for our internal
>    implementation", rather than "what is the right clean interface
>    to provide this sort of information". I'd rather we started
>    with a blank piece of paper and designed an API, and then
>    implemented it.

Do you have an opinion on specific trace points, or an observation in gener=
al?

I wanted to have the following events:

* cpu hotplug/hotunplug
* cpu reset
* memory access translation/execution
* BBL/TB translation/execution
* instruction translation/execution
* exceptions / syscalls


>  * I definitely don't think we should expose to the instrumentation
>    the distinction between translate time and execute time

Please see my response to your email in v6.

Also, I forgot an even simpler case, like instrumenting a subset of memory
accesses (e.g., only writes).


Thanks,
  Lluis
