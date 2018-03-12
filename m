Received: from eggs.gnu.org ([2001:4830:134:3::10]:58669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evRRt-0001Nj-S4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evRRo-0003n2-V3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:41:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1evRRo-0003mf-Oy
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:41:20 -0400
Date: Tue, 13 Mar 2018 01:41:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180312174102.GD8326@lemon.usersys.redhat.com>
References: <20180312120849.20073-1-marcandre.lureau@redhat.com>
	<CAJ+F1CJM2mk8BKUm=kkKwTJJSjqNT7Hd0pdLM_=ZTMzxnb6FHw@mail.gmail.com>
	<20180312171122.GC8326@lemon.usersys.redhat.com>
	<CAJ+F1CKugGNH7kdchrpuF+GXSPMd4s2-w7bSCpH3UNHiwQGR1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKugGNH7kdchrpuF+GXSPMd4s2-w7bSCpH3UNHiwQGR1A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: make docker-test-debug@fedora run
 sanitizers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Mon, 03/12 18:17, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Mon, Mar 12, 2018 at 6:11 PM, Fam Zheng <famz@redhat.com> wrote:
> > On Mon, 03/12 15:11, Marc-Andr=E9 Lureau wrote:
> >> Hi Fam,
> >>
> >> It would be great if patchew could run the debug/sanitizer build.
> >> Unfortunately, except x86 target, the run is full of ASAN leaks or
> >> warnings.
> >>
> >> Do you think patchew could learn to do regression testing? By that I
> >> mean that patchew could compare a patchset output with the current
> >> master (that output should be cached for multiple tests). The output
> >> to compare here would be the errors reported by ASAN during the buil=
d.
> >> (eventually, this could be used for other metrics some day). If so,
> >> would you be willing to help me implementing it?
> >
> > The question is can we simply rely on the exit code of cmp or diff fo=
r that kind
> > of comparison? If there is any out-of-order texts, that simple diff w=
on't work.
>=20
> If the tests are run sequentially, i think it should produce the same
> output when run multiple times (to be verified).

In that case the test will last for a long time. Currently patchew isn't =
very
good as multi-tasking. But that is one option we can explore (like we can=
 devote
one VM for asan test).

>=20
> However, if there are leaks already, and the address of allocation or
> symbols change, this may produce diff on existing lines.

Maybe we can come up with a 'make docker-test-debug-filtered@fedora' or a
relatively simple 'make docker-test-debug@fedora | sed -e "..."' command =
that
can be fed to diff.

>=20
> What I would like to see is the diff of added (or removed) lines.
>=20
> I suppose that should be possible, I'll do some experiments.
>=20
> > Anything more intelligent/sensible should go as a policy, and patchew=
 should
> > continue focus on mechanisms.
>=20
> hmm ok :)

Like said above, I think it's possible to postprocess the output to make =
it easy
to diff/cmp. By mechanism/policy I mean the place to draw a line to code
Patchew.  However patchew has a database where we can write test script s=
nippets
(as configurations) that is "the policy".

Fam
