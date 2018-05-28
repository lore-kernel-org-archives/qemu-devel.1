Received: from eggs.gnu.org ([2001:4830:134:3::10]:60370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNIOq-0005YI-PF
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNIOp-0005In-RA
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:41:24 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNIOp-0005IJ-Ln
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:41:23 -0400
Received: by mail-oi0-x244.google.com with SMTP id t22-v6so6944731oih.6
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 06:41:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <404a1921-710c-9ba1-349a-f68430aa0a1d@amsat.org>
References: <404a1921-710c-9ba1-349a-f68430aa0a1d@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 May 2018 14:41:02 +0100
Message-ID: <CAFEAcA_qFRWTos+Vgb_sKp=yArkHezFG9LBtirQgP5iHsDU4PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] What is the best git-way to add a new board?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 28 May 2018 at 06:02, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> 1/ how RISC-V boards got merged
>
>   Add devices individually,
>   finally add the board and default-configs/Makefile rules at once.
>
> PRO: commits are easier to cherry-pick/rebase
> CON: you can not test a single patch until applying the whole series
>      harder (less interest) to write qtests

I don't think this one has any real benefits over 1bis, below...

> 1bis/ example of the Smartfusion2 board
>
>   Variant of 1/, but also modify the default-configs/Makefile to
>   build each device.
>
> PRO: single patch can be test without much troubles,
>      unit/acceptance tests can be run without applying the whole series,
>      different people can work in parallel.
> CON: no integration test until the last 'board' commit
>
>
> 2/ Reverse Polish testing
>
>   Add a board stub (all devices as UnimplementedDevice) and Makefile
>   rule, then for each new device, replace the unimp board entry,
>     modify the default-configs/Makefile,
>     add unit/acceptance tests
>
> PRO: you can add an integration test since the first board commit :)
>        (enforcing Test Driven Development),
>      allow unpaid contributor to slowly push his work upstream
>        instead of painful rebases or his work lost by change of
>        interest or worth issues.
> CON: not acceptable by upstream except with good integration test
>      integration test might not be upstream-able due to license
>        incompatibilities (JTAG-extracted firmwares...)

I usually go with some mix of 1 and 2, so for the first
patchset upstream I have a board model and a few devices
and the rest are stubbed out, but within that series I
put the device models first and the board model last.
While I'm doing the development before sending I might
well have started with more stubs than the final version
I send out has.

It's also worth distinguishing between the shape of the
commits you send upstream (which should be optimized
for code review, for being a coherent but not oversized
patchset, for not breaking compilation midway through the
series, and so on), and how you work on them before you
send them out. You don't have to start writing code with
the first patch in the set :-)

thanks
-- PMM
