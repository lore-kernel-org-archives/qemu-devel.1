Received: from eggs.gnu.org ([2001:4830:134:3::10]:56522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dECEC-0004aO-2f
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dECEB-0004o2-34
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:12:16 -0400
Date: Fri, 26 May 2017 12:12:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170526101205.GE7211@noname.str.redhat.com>
References: <4086b9ad1d1c912298f7c981f2c94a9f9a7026a3.1495536228.git.berto@igalia.com>
	<5925B107.1060404@virtuozzo.com>
	<f4437f01-1eb2-d1c1-3df5-ee992fab2036@virtuozzo.com>
	<w51inkqyt23.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51inkqyt23.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] qcow2: Merge the writing of the COW
 regions with the guest data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org

Am 24.05.2017 um 21:05 hat Alberto Garcia geschrieben:
> On Wed 24 May 2017 06:43:31 PM CEST, Anton Nefedov wrote:
> >> +    if (m->data_qiov) {
> >> +        qemu_iovec_reset(&qiov);
> >> +        qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
> >> +        qemu_iovec_concat(&qiov, m->data_qiov, 0, data_bytes);
> >> +        qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
> >
> > Can it be a problem if (m->data_qiov->niov == IOV_MAX)?
> > We had to add merge-iovecs code for the case (maybe there's better
> > solution?)
> 
> You're right, good catch! I'll add a check for that. To be honest I
> don't think that's likely to happen in practice, so if it does we can
> simply fall back to the old behavior (separate writes).
> 
> > Also, will this work if allocation is split into several l2metas?
> > e.g. one has cow_start.nb_bytes and another has cow_end.nb_bytes
> 
> The guest request will be merged with the first l2meta that has to copy
> at least one of the two regions. It doesn't matter if the other one has
> nb_bytes == 0.

I think we can improve this later so that we merge everything together
(multiple l2metas and guest data) into a single request, but what this
seris implements is still a very good first step, so we shouldn't let
this stop us from taking the good rather than waiting for the perfect.

Kevin
