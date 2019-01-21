Received: from eggs.gnu.org ([209.51.188.92]:60787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleU7-0007gf-LF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleU3-0004aP-JX
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:39:45 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gleU1-0004SF-Ry
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:39:43 -0500
Received: by mail-oi1-x243.google.com with SMTP id y1so15294575oie.12
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20190121152218.9592-1-peter.maydell@linaro.org>
In-Reply-To: <20190121152218.9592-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:39:11 +0000
Message-ID: <CAFEAcA9prusajBwp-66Rio-xjT5vQ4j=WzT=-ww2AV0khpOPPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/4] tcg: support heterogenous CPU
 clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Emilio G . Cota" <cota@braap.org>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>

On Mon, 21 Jan 2019 at 15:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In the process of debugging my board code that uses this
> feature, I realized I needed to support the CPU object
> not being a direct child of the cluster object, which
> also lead me to the object_child_foreach_recursive()
> function which is a neater way to iterate children anyway.
> I also figured out we could add an assert which catches
> most "parenting CPU vs cluster realize ordering" bugs.
>
> Only patch 2 has changed here, others are already reviewed.
>
> Changes v2->v3:
>
>  * allow CPU objects to be indirect children of the cluster;
>    this is useful for ARMv7M, where the CPU object is a child
>    of the armv7m container and the board code that sets up
>    the cluster object only has the armv7m container object:
>    this is done by using object_child_foreach_recursive()
>    rather than an open-coded child iteration
>  * add an assertion that the cluster has at least one CPU,
>    which catches the easiest-to-make errors when creating
>    and populating the cluster

Oops, I should have tested this a bit more carefully before
sending it out. It needs an extra "patch 0" adding at the
start which makes xlnx_zynqmp_create_rpu() not create the
rpu-cluster object if there aren't any RPUs to put in it.
Otherwise we hit the new assertion when starting the
xlnx-zcu102 board with fewer than 5 CPUs. I'll send that
patch out in a second (but won't bother to re-roll the
entire patchset).

thanks
-- PMM
