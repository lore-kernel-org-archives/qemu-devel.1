Received: from eggs.gnu.org ([2001:4830:134:3::10]:49071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cOnCE-00073G-EJ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cOnCB-0003J9-9l
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:09:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1cOnCB-0003Ie-3f
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:09:43 -0500
Date: Wed, 4 Jan 2017 16:09:39 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170104150938.GA9029@potion>
References: <1483438205-31110-1-git-send-email-peterx@redhat.com>
	<1483438205-31110-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483438205-31110-3-git-send-email-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v2 2/2] run_tests: allow run
 tests in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

2017-01-03 18:10+0800, Peter Xu:
> run_task.sh is getting slow. This patch is trying to make it faster by
> running the tests concurrently.
>=20
> We provide a new parameter "-j" for the run_tests.sh, which can be used
> to specify how many run queues we want for the tests. Default queue
> length is 1, which is the old behavior.
>=20
> Quick test on my laptop (4 cores, 2 threads each) shows 3x speed boost:
>=20
>    |-----------------+-----------|
>    | command         | time used |
>    |-----------------+-----------|
>    | run_test.sh     | 75s       |
>    | run_test.sh -j8 | 27s       |
>    |-----------------+-----------|
>=20
> Suggested-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  run_tests.sh           | 12 ++++++++++--
>  scripts/functions.bash | 15 ++++++++++++++-
>  scripts/global.bash    | 11 +++++++++++
>  3 files changed, 35 insertions(+), 3 deletions(-)

I like this diffstat a lot more, thanks :)

The script doesn't handle ^C well now (at least), which can be worked
around with

  trap exit SIGINT

but it would be nice to know if receiving signals in `wait` can't be
fixed.
