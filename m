Received: from eggs.gnu.org ([2001:4830:134:3::10]:44531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPo7k-0001M5-Sp
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPo7h-0006xf-1K
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:58:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fPo7g-0006xU-S8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:58:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59D0A4022414
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 11:58:04 +0000 (UTC)
Date: Mon, 4 Jun 2018 13:58:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180604135802.0106a89c@redhat.com>
In-Reply-To: <8297e5b4-dca4-f080-fb87-4cf29a2bb857@redhat.com>
References: <20180604102752.32260-1-berrange@redhat.com>
	<8297e5b4-dca4-f080-fb87-4cf29a2bb857@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: don't use RUN_STATE_PRECONFIG unless
 --preconfig is given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michal Privoznik <mprivozn@redhat.com>

On Mon, 4 Jun 2018 12:33:04 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 2018-06-04 12:27, Daniel P. Berrang=C3=A9 wrote:
> > The RUN_STATE_PRECONFIG state is not supposed to be reachable unless the
> > --preconfig argument is given to QEMU, but when it was introduced in:
> >=20
> >   commit 047f7038f586d2150f16c6d9ba9cfd0479f0f6ac
> >   Author: Igor Mammedov <imammedo@redhat.com>
> >   Date:   Fri May 11 19:24:43 2018 +0200
> >=20
> >     cli: add --preconfig option
> >=20
> > The global 'current_run_state' variable was changed to have an initial
> > value of RUN_STATE_PRECONFIG regardless of whether --preconfig is given.
That was intentional, see 8a36283e12 commit message which has it right.
I should fix doc comment qapi/run-state.json though as it's misleading
(I've meant it reachable for user, while doc comment applies to
not only to user but to qemu internals as well).
I'll post a patch to clarify doc comment.

Idea behind PRECONFIG runstate is to start spitting PRELAUNCH
runstate (which is historically ended up as a dump for almost everything)
into smaller more manageable part.

Michal's patch should fix issue short term and
I'll look more at the issues Max found out, maybe there is more to fix.

> > It then relies on the main loop to toggle it back to RUN_STATE_PRELAUNCH
> > when --preconfig is not given. This is racy because it means that there
> > is a window where QEMU is in RUN_STATE_PRECONFIG despite --preconfig not
> > being given. This can be seen with the failure:
> >=20
> >   $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
> >   QEMU 2.12.50 monitor - type 'help' for more information
> >   (qemu)
> >   HMP not available in preconfig state, use QMP instead
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  vl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-) =20
>=20
> This indeed fixes the issue that the preconfig state is reachable
> without --preconfig, but it still keeps the main loop being invoked
> twice (which means that e.g. HMP will process a single character before
> the main loop is actually really invoked:
>=20
> $ echo quit | x86_64-softmmu/qemu-system-x86_64 \
>     -drive file=3D/dev/null,if=3Dide,readonly=3Don -monitor stdio
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu) qqemu-system-x86_64: Initialization of device ide-hd failed:
> Block node is read-only
>=20
> (Note the "q" before "qemu-system-x86_64"))
>=20
> (Naively,) I agree with Michal that the main loop should only be invoked
> twice if --preconfig has been given, which is implemented by his patch:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00367.html
>=20
> Max
>=20
