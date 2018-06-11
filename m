Received: from eggs.gnu.org ([2001:4830:134:3::10]:52204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSHl4-00066l-Gl
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSHkz-0007va-UY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:00:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSHkz-0007vP-Oc
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:00:53 -0400
Date: Mon, 11 Jun 2018 16:00:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180611080042.GK7736@xz-mi>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/12] migration: improve multithreads for
 compression and decompression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Mon, Jun 04, 2018 at 05:55:08PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>=20
> Background
> ----------
> Current implementation of compression and decompression are very
> hard to be enabled on productions. We noticed that too many wait-wakes
> go to kernel space and CPU usages are very low even if the system
> is really free
>=20
> The reasons are:
> 1) there are two many locks used to do synchronous=EF=BC=8Cthere
> =E3=80=80=E3=80=80is a global lock and each single thread has its own l=
ock,
> =E3=80=80=E3=80=80migration thread and work threads need to go to sleep=
 if
> =E3=80=80=E3=80=80these locks are busy
>=20
> 2) migration thread separately submits request to the thread
>    however, only one request can be pended, that means, the
>    thread has to go to sleep after finishing the request
>=20
> Our Ideas
> ---------
> To make it work better, we introduce a new multithread model,
> the user, currently it is the migration thread, submits request
> to each thread with round-robin manner, the thread has its own
> ring whose capacity is 4 and puts the result to a global ring
> which is lockless for multiple producers, the user fetches result
> out from the global ring and do remaining operations for the
> request, e.g, posting the compressed data out for migration on
> the source QEMU
>=20
> Other works in this patchset is offering some statistics to see
> if compression works as we expected and making the migration thread
> work fast so it can feed more requests to the threads

Hi, Guangrong,

I'm not sure whether my understanding is correct, but AFAIU the old
code has a major defect that it depends too much on the big lock.  The
critial section of the small lock seems to be very short always, and
also that's per-thread.  However we use the big lock in lots of
places: flush compress data, queue every page, or send the notifies in
the compression thread.

I haven't yet read the whole work, this work seems to be quite nice
according to your test results.  However have you thought about
firstly remove the big lock without touching much of other part of the
code, then continue to improve it?  Or have you ever tried to do so?
I don't think you need to do extra work for this, but I would
appreciate if you have existing test results to share.

In other words, would it be nicer to separate the work into two
pieces?

- one to refactor the existing locks, to see what we can gain by
  simplify the locks to minimum.  AFAIU now the locking used is still
  not ideal, my thinking is that _maybe_ we can start by removing the
  big lock, and use a semaphore or something to replace the "done"
  notification while still keep the small lock?  Even some busy
  looping?

- one to introduce the lockless ring buffer, to demostrate how the
  lockless data structure helps comparing to the locking ways

Then we can know which item contributed how much to the performance
numbers.  After all the new ring and thread model seems to be a big
chunk of work (sorry I haven't read them yet, but I will).

What do you think?

Thanks,

--=20
Peter Xu
