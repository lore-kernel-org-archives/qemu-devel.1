Received: from eggs.gnu.org ([2001:4830:134:3::10]:55603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cQQvx-0002af-VL
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cQQvt-00058S-AL
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:47:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cQQvt-00058J-1Z
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:47:41 -0500
Date: Mon, 9 Jan 2017 11:47:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170109034731.GG4135@pxdev.xzpeter.org>
References: <1483673581-7843-1-git-send-email-peterx@redhat.com>
	<1483673581-7843-3-git-send-email-peterx@redhat.com>
	<20170106144041.3ruyijfgwlpqpfei@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106144041.3ruyijfgwlpqpfei@kamzik.brq.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v3 2/2] run_tests: allow run
 tests in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Fri, Jan 06, 2017 at 03:40:41PM +0100, Andrew Jones wrote:
> On Fri, Jan 06, 2017 at 11:33:01AM +0800, Peter Xu wrote:
> > run_task.sh is getting slow. This patch is trying to make it faster b=
y
> > running the tests concurrently.
> >=20
> > We provide a new parameter "-j" for the run_tests.sh, which can be us=
ed
> > to specify how many run queues we want for the tests. Default queue
> > length is 1, which is the old behavior.
> >=20
> > Quick test on my laptop (4 cores, 2 threads each) shows 3x speed boos=
t:
> >=20
> >    |-----------------+-----------|
> >    | command         | time used |
> >    |-----------------+-----------|
> >    | run_test.sh     | 75s       |
> >    | run_test.sh -j8 | 27s       |
> >    |-----------------+-----------|
> >=20
> > Suggested-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>=20
> Radim suggested how to implement this, but not the idea of implementing
> it. The suggested-by tag is for ideas, not the code, and the idea (whic=
h
> is a good one) was yours, not Radim's. So the above tag should be remov=
ed.
> It's hard to credit Radim for his help here. Adding a signed-off-by to
> indicate co-authorship is probably the best you can do. Of course he's
> the maintainer and will add that when he merges anyway though...

I see, thanks for the clarification. Then let me remove this line.

>=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  run_tests.sh           | 12 ++++++++++--
> >  scripts/functions.bash | 17 ++++++++++++++++-
> >  scripts/global.bash    | 11 +++++++++++
> >  3 files changed, 37 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/run_tests.sh b/run_tests.sh
> > index e1bb3a6..a4fc895 100755
> > --- a/run_tests.sh
> > +++ b/run_tests.sh
> > @@ -14,10 +14,11 @@ function usage()
> >  {
> >  cat <<EOF
> > =20
> > -Usage: $0 [-g group] [-h] [-v]
> > +Usage: $0 [-g group] [-h] [-v] [-j N]
>=20
> s/N/num_run_queues/

Sure.

[...]

> > @@ -38,6 +39,13 @@ while getopts "g:hv" opt; do
> >              usage
> >              exit
> >              ;;
> > +        j)
> > +            ut_run_queues=3D$OPTARG
> > +            if ! is_number "$ut_run_queues"; then
> > +                echo "Invalid -j option: $ut_run_queues"
> > +                exit 1
> > +            fi
>=20
> Instead of adding is_number() and just checking for numeric
> input, I'd check the input is > 0. A string input resolves
> as zero when treated as a number, so it'll fail too.

Wasn't familiar with shell arithmetic before. Your suggestion is much
simpler, thanks.

>=20
> > +            ;;
> >          v)
> >              verbose=3D"yes"
> >              ;;
> > diff --git a/scripts/functions.bash b/scripts/functions.bash
> > index d1d2e1c..c6281f4 100644
> > --- a/scripts/functions.bash
> > +++ b/scripts/functions.bash
> > @@ -1,9 +1,18 @@
> > +source scripts/global.bash
> > +
> >  function run_task()
> >  {
> >  	local testname=3D"$2"
> > =20
> > +	while [[ "$(jobs | wc -l)" =3D=3D $ut_run_queues ]]; do
>=20
> Bash arithmetic expressions should use (( ... )) instead
> of [[ ... ]]

Will do.

[...]

> > diff --git a/scripts/global.bash b/scripts/global.bash
> > index 77b0b29..52095bd 100644
> > --- a/scripts/global.bash
> > +++ b/scripts/global.bash
> > @@ -1,2 +1,13 @@
> >  : ${ut_log_dir:=3Dlogs}
> >  : ${ut_log_summary:=3D${ut_log_dir}/SUMMARY}
> > +: ${ut_run_queues:=3D1}
> > +
> > +function ut_in_parallel()
> > +{
> > +    [[ $ut_run_queues !=3D 1 ]]
> > +}
>=20
> I don't see any users of ut_in_parallel. Anyway I'd drop it
> and open code the condition, with ((...)), when needed.

Yes, it should be removed.

Thanks!

-- peterx
