Received: from eggs.gnu.org ([2001:4830:134:3::10]:58440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOFBp-0002N6-6n
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 21:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOFBm-0006lU-48
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 21:51:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOFBl-0006kp-UE
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 21:51:02 -0500
Date: Tue, 3 Jan 2017 10:50:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170103025056.GB22664@pxdev.xzpeter.org>
References: <1483266886-25050-1-git-send-email-peterx@redhat.com>
	<38d74124-eb01-c381-8dd9-2a6334c71fa3@redhat.com>
	<20170102202555.GF2395@potion>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170102202555.GF2395@potion>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH 0/2] run_tests: support
 concurrent test execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>

On Mon, Jan 02, 2017 at 09:25:56PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
> 2017-01-02 18:07+0100, Paolo Bonzini:
> > On 01/01/2017 11:34, Peter Xu wrote:
> >> run_tests.sh is getting slower. Maybe it's time to let it run faster=
.
> >> An obvious issue is that, we were running the tests sequentially in
> >> the past.
> >>=20
> >> This series provides another new "-j" parameter. "-j 8" means we run
> >> the tests on 8 task queues. That'll fasten the script a lot. A very
> >> quick test of mine shows 3x speed boost with 8 task queues.
> >>=20
> >> Most of the changes are in scripts/tash.bash of patch 2, which
> >> implemented the main logic for task managements. Please see commit
> >> message for more information.
> >>=20
> >> I did a quick "make standalone" test to make sure this series won't
> >> break it. However I am not sure whether it'll break other thing that=
 I
> >> don't know...
> >=20
> > Would it work if run_tests.sh wrote a Makefile for all the tests (wit=
h
> > phony targets only), and then simply ran "make -f Makefile.tmp -jN"?
>=20
> We would need to change for_each_unittest to print the command line
> instead of running it and add a executable wrapper for run() from
> scripts/runtime.bash to have something to pass those arguments to.
> After that, we could generate a Makefile.
>=20
> I think we can do the queue with ~3 lines of bash and the Makefile woul=
d
> complicate it more.
>=20
> Btw. I just leaned that xargs provides a simpler, but sufficient,
> queueing functionality, e.g.
>=20
>   echo "echo a\0 (sleep 1; echo b)\0 echo c\0 sleep 1\0 echo d" |
>     xargs -0 -L 1 -P 2 sh -c

Good to know this. :)

Looks like above example didn't work, I changed it a bit:

  echo -e "echo a\0 sleep 1 && echo b\0 echo c\0 sleep 1 && echo d" | xar=
gs -0 -L 1 -P 2 sh -c

But I would still prefer not using it - I'll prefer "readability" over
"less lines of codes" in this case.

-- peterx
