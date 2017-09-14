Received: from eggs.gnu.org ([2001:4830:134:3::10]:54068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsVXX-0004ba-U9
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsVXW-0002tI-W1
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:54:52 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:48085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsVXW-0002sO-OE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:54:50 -0400
Received: by mail-wr0-x234.google.com with SMTP id k20so6111264wre.4
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 07:54:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
References: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 15:54:28 +0100
Message-ID: <CAFEAcA-rmX=gUdYTLK4g5TAWVTkCfkbkXXfCxmaaivv8XGdMXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 12 September 2017 at 22:01, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wr=
ote:
> This series adds an API to add instrumentation events.
>
> It also provides additional APIs for:
> * Controlling tracing events.
> * Peek/poke guest memory.

> Future APIs (for later series):
> * Peek/poke guest registers.
> * Add breakpoints to trigger instrumentation functions.
> * Trigger instrumentation functions from guest code (former hypertrace).
> * Add events for guest code translation/execution (once the respective tr=
acing
>   events are accepted upstream).
> * Add events for exceptions/syscalls.
> * Add events for TB invalidation (necessary for libraries to deallocate a=
ny data
>   they might have allocated for the TBs they instrumented).
>
> The instrumentation code is dynamically loaded as a library into QEMU eit=
her
> when it starts or later using its remote control interfaces. The loaded c=
ode
> only has access to function explicitly exported through the QI_VPUBLIC ma=
cro.
>
> This series is branch 'devel-instrument' in
> https://code.gso.ac.upc.edu/git/qemu-dbi.

To parallel the comment I sent on Emilio's series: I think the
first thing we should do here is work out the API we want to
present to the instrumentation plugin, because that's permanent
and we want to get it right. Then we can figure out the
implementation details later.

Particular notes:
 * putting things in the instrumentation plugin API that basically
   parallel some existing trace points is something I'm wary of,
   because a lot of our existing tracing is "output something at
   a point and in a way that's convenient for our internal
   implementation", rather than "what is the right clean interface
   to provide this sort of information". I'd rather we started
   with a blank piece of paper and designed an API, and then
   implemented it.
 * I definitely don't think we should expose to the instrumentation
   the distinction between translate time and execute time

thanks
-- PMM
