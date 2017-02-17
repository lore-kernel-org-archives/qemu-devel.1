Received: from eggs.gnu.org ([2001:4830:134:3::10]:60797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cenqi-0002ZS-1c
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cenqg-00055Z-Vt
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:05:43 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cenqg-00054b-In
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:05:42 -0500
Received: by mail-wr0-x234.google.com with SMTP id i10so35112385wrb.0
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 11:05:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 19:05:20 +0000
Message-ID: <CAFEAcA9JWzUEmGa2Wxd5xPE4dVknOKBkt=wMda7CAgxzrgOc+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 0/3] generalize parsing of cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 17 February 2017 at 18:56, Igor Mammedov <imammedo@redhat.com> wrote:
> Some callers call CPUClass->parse_features manually to convert
> '-cpu cpufoo,featurestr' string to cpu type and featurestr
> into a set of global properties. And theni do controlled
> cpu creation with setting properties and completing it with realize.
> That's a lot of code duplication as they are practically
> reimplement the same parsing logic.
>
> Some don't and use cpu_generic_init() instead which does
> the same parsing along with creation/realizing cpu within one
> wrapper.
>
> And some trying to switch to controlled cpu creation,
> implement object_new()/set properties/realize steps
> but forget feature parsing logic witch lieads to 'bugs'
> commit 00909b585 (hw/arm/integratorcp: Support specifying features via -cpu)
>
>
> This series moves -cpu option parsing to generic machine code
> that removes a little of code duplication and makes cpus creation
> process more unified.

This API seems a little awkward for the SoC case, where
the board model doesn't actually know what the default
CPU model or the valid CPU models are, because it just
wants to say "create me a BCM2836 SoC" and let the SoC
object deal with determining whether it's always a cortex-a15
or if it might allow some user configurability either in
cpu choices or in optional flags.
Any thoughts about that use case?

(The stm32f205 SoC object has a "cpu-model" QOM property
that the board sets, but I think that's as much because
we somewhat awkwardly need to pass it into armv7m_init()
as a deliberate design choice.)

thanks
-- PMM
