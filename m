Received: from eggs.gnu.org ([2001:4830:134:3::10]:59336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6zF-0007IQ-Cv
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6zE-0001UX-M6
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:57:25 -0400
References: <20170316212351.13797-1-jsnow@redhat.com>
	<CAJSP0QU1g9iijqMnrf27Yp5BTr_U4c--+GqYTnvnVtyud0O2Gw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb9eafce-797e-3d94-d6da-4b519772fcaf@redhat.com>
Date: Thu, 23 Mar 2017 18:57:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QU1g9iijqMnrf27Yp5BTr_U4c--+GqYTnvnVtyud0O2Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/3] block: pause block
 jobs for bdrv_drain_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>



On 23/03/2017 18:44, Stefan Hajnoczi wrote:
>> It's possible to wedge QEMU if the guest tries to reset a virtio-pci
>> device as QEMU is also using the drive for a blockjob. This patchset
>> aims to allow us to safely pause/resume jobs attached to individual
>> nodes in a manner similar to how bdrv_drain_all_begin/end do.
>=20
> Weird, I thought the 0 nanosecond sleep that block jobs do in their
> main loop allows aio_poll() loops to finish.

The 0 nanosecond sleep is now done in the BDS AioContext rather than in=20
the "non-aio_poll-aware" main loop:

    commit 0b9caf9b3166c8deb3c4f3a774c2384b069dc29c
    Author: Fam Zheng <famz@redhat.com>
    Date:   Tue Aug 26 15:15:43 2014 +0800

    coroutine: Drop co_sleep_ns
   =20
    block_job_sleep_ns is the only user. Since we are moving towards
    AioContext aware code, it's better to use the explicit version and dr=
op
    the old one.
   =20
    Signed-off-by: Fam Zheng <famz@redhat.com>
    Reviewed-by: Beno=C3=AEt Canet <benoit.canet@nodalink.com>
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> I've CCed Fam because I think he has also tackled this issue in the pas=
t.

Yes, he fixed the same issue for bdrv_drain_all.

Paolo
