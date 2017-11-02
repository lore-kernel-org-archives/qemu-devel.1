Received: from eggs.gnu.org ([2001:4830:134:3::10]:59178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eALis-0007B6-9V
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eALip-0002us-4Z
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:04:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eALio-0002u9-TT
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:04:15 -0400
Date: Thu, 2 Nov 2017 16:03:59 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <132030259.16705243.1509653039905.JavaMail.zimbra@redhat.com>
In-Reply-To: <9bbb7744-86e4-9c82-cf82-63a5429ac405@redhat.com>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112610.10516.78685.stgit@pasha-VirtualBox>
	<84c5cdaf-4ec6-f05c-e1a2-3228517d491a@redhat.com>
	<9bbb7744-86e4-9c82-cf82-63a5429ac405@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 13/26] cpus: only take BQL for sleeping
 threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter maydell <peter.maydell@linaro.org>, boost lists <boost.lists@gmail.com>, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria klimushenkova <maria.klimushenkova@ispras.ru>, dovgaluk@ispras.ru, kraxel@redhat.com, alex bennee <alex.bennee@linaro.org>



----- Original Message -----
> From: "David Hildenbrand" <david@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>, "Pavel Dovgalyuk" <Pavel.Dovga=
luk@ispras.ru>, qemu-devel@nongnu.org
> Cc: kwolf@redhat.com, "peter maydell" <peter.maydell@linaro.org>, "boost =
lists" <boost.lists@gmail.com>,
> quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.=
com, "maria klimushenkova"
> <maria.klimushenkova@ispras.ru>, dovgaluk@ispras.ru, kraxel@redhat.com, "=
alex bennee" <alex.bennee@linaro.org>
> Sent: Thursday, November 2, 2017 7:39:22 PM
> Subject: Re: [RFC PATCH 13/26] cpus: only take BQL for sleeping threads
>=20
> On 02.11.2017 12:08, Paolo Bonzini wrote:
> > On 31/10/2017 12:26, Pavel Dovgalyuk wrote:
> >> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>
> >> Now the only real need to hold the BQL is for when we sleep on the
> >> cpu->halt conditional. The lock is actually dropped while the thread
> >> sleeps so the actual window for contention is pretty small. This also
> >> means we can remove the special case hack for exclusive work and
> >> simply declare that work no longer has an implicit BQL held. This
> >> isn't a major problem async work is generally only changing things in
> >> the context of its own vCPU. If it needs to work across vCPUs it
> >> should be using the exclusive mechanism or possibly taking the lock
> >> itself.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> >=20
> > At least cpu_throttle_thread would fail with this patch.
> >=20
> > Also I am not sure if the s390 SIGP handlers are ready for this.
> >=20
>=20
> We have a global lock to the SIGP "facility". However we need the BQL in
> order to inject interrupts into CPUs (otherwise it would trigger an
> assert when injecting).
>=20
> We inject Restart and Stop interrupts from run_on_cpu. This requires the
> BQL. So Paolo should be right, this change would break s390x.

I had some patches to access interrupt_request with the atomic builtins.  I=
f
Pavel can first extract the other changes to the icount mechanism, I can
update them.

Paolo
