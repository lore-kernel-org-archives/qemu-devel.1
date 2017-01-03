Received: from eggs.gnu.org ([2001:4830:134:3::10]:57279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOF66-0000uY-D4
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 21:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOF63-0005FE-7T
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 21:45:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOF62-0005EM-Uv
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 21:45:07 -0500
Date: Tue, 3 Jan 2017 10:45:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170103024501.GA22664@pxdev.xzpeter.org>
References: <1483266886-25050-1-git-send-email-peterx@redhat.com>
	<1483266886-25050-3-git-send-email-peterx@redhat.com>
	<20170102201824.GA2892@potion>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170102201824.GA2892@potion>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH 2/2] run_tests: allow run
 tests in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

On Mon, Jan 02, 2017 at 09:18:24PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
> 2017-01-01 18:34+0800, Peter Xu:
> > run_task.sh is getting slow. This patch is trying to make it faster b=
y
> > running the tests concurrently.
> >=20
> > First of all, we provide a new parameter "-j" for the run_tests.sh,
> > which can be used to specify how many run queues we want for the test=
s.
> > When "-j" is not provided, we'll keep the old behavior.
> >=20
> > When the tests are running concurrently, we will use seperate log fil=
e
> > for each test case (currently located in logs/ dir, with name
> > test.TESTNAME.log), to avoid test logs messing up with each other.
> >=20
> > A quick test on my laptop (x86 with 4 cores and 2 threads, so 8
> > processors) shows 3x improvement on overall test time:
> >=20
> >    |-----------------+-----------|
> >    | command         | time used |
> >    |-----------------+-----------|
> >    | run_test.sh     | 75s       |
> >    | run_test.sh -j8 | 27s       |
> >    |-----------------+-----------|
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > diff --git a/scripts/functions.bash b/scripts/functions.bash
> > @@ -1,7 +1,18 @@
> > +source scripts/global.bash
> > +source scripts/task.bash
> > +
> >  function run_task()
> >  {
> > -	RUNTIME_log_file=3D$ut_default_log_file
> > -	"$@"
> > +	local testname=3D"$2"
> > +
> > +	if ut_in_parallel; then
> > +		RUNTIME_log_file=3D"${ut_log_dir}/test.${testname}.log"
>=20
> No need for the "test." prefix.
>=20
> I would do this change regardless of ut_in_parallel.  Having output of
> all tests in one file just wasted time when most usecases were to find =
a
> specific failed test.
>=20
> > +		# run in background
> > +		task_enqueue "$@"
>=20
> Couldn't the queue be much simpler ...
>=20
> > +	else
> > +		RUNTIME_log_file=3D$ut_default_log_file
> > +		"$@"
> > +	fi
> >  }
> > =20
> >  function for_each_unittest()
> > @@ -51,5 +62,10 @@ function for_each_unittest()
> >  		fi
> >  	done
>=20
> ... like this:
>=20
>   while [ "`jobs | wc -l`" -gt $ut_run_queues ]; do
>     wait

I suppose you mean "wait -n" here? And also a "if" should suffice
here, though a "while" won't hurt as well.

>   done
>   run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch=
" "$check" "$accel" "$timeout" &

I think this might work, however it has assumption that these $cmd
tasks are the only jobs that is running in the background.

I didn't notice the "-n" parameter for "wait", otherwise I won't
bother using SIGUSR1 at all. :)

Thanks,

-- peterx
