Received: from eggs.gnu.org ([2001:4830:134:3::10]:40890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g70pU-0008Hd-Rr
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g70pU-0004XR-6u
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:13:52 -0400
References: <20181001143218.17069-1-kwolf@redhat.com>
	<9a0e30f2-90d0-11ba-b5db-3e2df18590cc@redhat.com>
	<20181001160348.GB4445@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c038c3cd-2dc6-c32c-0a20-1256868dffc2@redhat.com>
Date: Mon, 1 Oct 2018 18:13:39 +0200
MIME-Version: 1.0
In-Reply-To: <20181001160348.GB4445@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] test-replication: Lock AioContext around
 blk_unref()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

On 01/10/2018 18:03, Kevin Wolf wrote:
>> Given the backtrace, I think bdrv_close should be taking the AioContex=
t
>> lock instead of blockdev_close_all_bdrv_states.
> Conversely, that would mean that calling bdrv_unref() with the
> AioContext lock held is a bug (because close callbacks can involve
> AIO_WAIT_WHILE()). I'm not sure if that's very practical.

What if bdrv_unref_child dropped the lock?

Perhaps it's simpler to just kill the lock though, if
bdrv_set_aio_context can be figured out.

Paolo

> Of course, there will probably be a lot of callers to fix either way
> after we define whether to hold the lock for bdrv_unref() or not. Eithe=
r
> you need to add locking to the places where it's missing or you need to
> drop the locks in all other places.
>=20
> I was leaning towards requiring the lock for bdrv_unref() (and
> therefore blk_unref()).
