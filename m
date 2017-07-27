Received: from eggs.gnu.org ([2001:4830:134:3::10]:56568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dagDg-00066S-Vm
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dagDg-0003gk-6F
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:40:41 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:37187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dagDf-0003gB-Q3
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:40:40 -0400
Received: by mail-wr0-x232.google.com with SMTP id 33so85388373wrz.4
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 03:40:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170727103253.GE10129@stefanha-x1.localdomain>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<87o9s88sb4.fsf@frigg.lan>
	<20170726112210.GD18489@stefanha-x1.localdomain>
	<871sp34bbc.fsf@frigg.lan>
	<20170727103253.GE10129@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2017 11:40:17 +0100
Message-ID: <CAFEAcA-Da7ZV7SL41TShqiy=icgo_nJXJxBqRr=RO+M23JsrGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 July 2017 at 11:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Wed, Jul 26, 2017 at 03:44:39PM +0300, Llu=C3=ADs Vilanova wrote:
>> And why exactly is this a threat? Because it can be used to "extend" QEM=
U
>> without touching its sources? Is this a realistic threat? (it's a rather=
 brittle
>> way to do it, so I'm not sure it's practical)
>
> Unfortunately it is a problem.  I recently came across a product that
> was using LD_PRELOAD=3D to "integrate" with QEMU.  People really abuse
> these interfaces instead of integrating their features cleanly into
> QEMU.

...if people who want to do this kind of thing already can and
do use LD_PRELOAD for it, I don't think we should worry too much
about trying to make the instrumentation plugin API bulletproof
against similar abuse.

> I see the use cases that Peter has been describing and am sure we can
> come up with good solutions.  What I care about is that it doesn't allow
> loading a .so that connects to arbitrary trace events.

That said, I agree that we don't really need an arbitrary-trace-event
setup here, and we should probably design our API so that it isn't
handing the trace plugin hooks pointers into QEMU's internals.
We want an API that makes it easy for people to do things based on
changes of the guest binary's state (registers, insns, etc etc)
and which makes it hard for them to accidentally trip themselves up
(eg by prodding around in QEMU internal data structures).
This will have the secondary benefit that it's unlikely that future
changes to QEMU will break plugin code.

>> As a side note, I find instrumentation to be most useful for guest code =
events,
>> which mostly contain non-pointer values (except for the CPUState*).

For instance we definitely should not be passing a CPUState* to
any plugin function.

thanks
-- PMM
