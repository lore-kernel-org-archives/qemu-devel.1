Received: from eggs.gnu.org ([2001:4830:134:3::10]:57736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0j6u-0006mk-Kz
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0j6p-0001EB-NJ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:33:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0j6p-0001Dp-I8
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:33:31 -0400
Date: Tue, 27 Mar 2018 15:33:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327073315.GK17789@xz-mi>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-2-xiaoguangrong@tencent.com>
	<20180315102501.GA3062@work-vm>
	<423c901d-16b6-67fb-262b-3021e30871ec@gmail.com>
	<20180321081923.GB20571@xz-mi>
	<b957b756-4996-7e79-406d-9587000839c1@gmail.com>
	<20180326090213.GB17789@xz-mi>
	<73e25db4-997f-0fbf-0c73-6589283c4005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73e25db4-997f-0fbf-0c73-6589283c4005@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] migration: stop compressing page in
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, liang.z.li@intel.com, kvm@vger.kernel.org, quintela@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com

On Mon, Mar 26, 2018 at 11:43:33PM +0800, Xiao Guangrong wrote:
>=20
>=20
> On 03/26/2018 05:02 PM, Peter Xu wrote:
> > On Thu, Mar 22, 2018 at 07:38:07PM +0800, Xiao Guangrong wrote:
> > >=20
> > >=20
> > > On 03/21/2018 04:19 PM, Peter Xu wrote:
> > > > On Fri, Mar 16, 2018 at 04:05:14PM +0800, Xiao Guangrong wrote:
> > > > >=20
> > > > > Hi David,
> > > > >=20
> > > > > Thanks for your review.
> > > > >=20
> > > > > On 03/15/2018 06:25 PM, Dr. David Alan Gilbert wrote:
> > > > >=20
> > > > > > >     migration/ram.c | 32 ++++++++++++++++----------------
> > > > > >=20
> > > > > > Hi,
> > > > > >      Do you have some performance numbers to show this helps?=
  Were those
> > > > > > taken on a normal system or were they taken with one of the c=
ompression
> > > > > > accelerators (which I think the compression migration was des=
igned for)?
> > > > >=20
> > > > > Yes, i have tested it on my desktop, i7-4790 + 16G, by locally =
live migrate
> > > > > the VM which has 8 vCPUs + 6G memory and the max-bandwidth is l=
imited to 350.
> > > > >=20
> > > > > During the migration, a workload which has 8 threads repeatedly=
 written total
> > > > > 6G memory in the VM. Before this patchset, its bandwidth is ~25=
 mbps, after
> > > > > applying, the bandwidth is ~50 mbps.
> > > >=20
> > > > Hi, Guangrong,
> > > >=20
> > > > Not really review comments, but I got some questions. :)
> > >=20
> > > Your comments are always valuable to me! :)
> > >=20
> > > >=20
> > > > IIUC this patch will only change the behavior when last_sent_bloc=
k
> > > > changed.  I see that the performance is doubled after the change,
> > > > which is really promising.  However I don't fully understand why =
it
> > > > brings such a big difference considering that IMHO current code i=
s
> > > > sending dirty pages per-RAMBlock.  I mean, IMHO last_sent_block s=
hould
> > > > not change frequently?  Or am I wrong?
> > >=20
> > > It's depends on the configuration, each memory-region which is ram =
or
> > > file backend has a RAMBlock.
> > >=20
> > > Actually, more benefits comes from the fact that the performance & =
throughput
> > > of the multithreads has been improved as the threads is fed by the
> > > migration thread and the result is consumed by the migration
> > > thread.
> >=20
> > I'm not sure whether I got your points - I think you mean that the
> > compression threads and the migration thread can form a better
> > pipeline if the migration thread does not do any compression at all.
> >=20
> > I think I agree with that.
> >=20
> > However it does not really explain to me on why a very rare event
> > (sending the first page of a RAMBlock, considering bitmap sync is
> > rare) can greatly affect the performance (it shows a doubled boost).
> >=20
>=20
> I understand it is trick indeed, but it is not very hard to explain.
> Multi-threads (using 8 CPUs in our test) keep idle for a long time
> for the origin code, however, after our patch, as the normal is
> posted out async-ly that it's extremely fast as you said (the network
> is almost idle for current implementation) so it has a long time that
> the CPUs can be used effectively to generate more compressed data than
> before.

Ah.  If the compression threads are consuming more CPU after this
patch, then it can persuade me far better than the original numbers,
since AFAICT that means it's the real part of bandwidth that is
boosted (the first pages of RAMBlocks are not sent via compression
threads), and I suppose it proves a better pipeline.

>=20
> > Btw, about the numbers: IMHO the numbers might not be really "true
> > numbers".  Or say, even the bandwidth is doubled, IMHO it does not
> > mean the performance is doubled. Becasue the data has changed.
> >=20
> > Previously there were only compressed pages, and now for each cycle o=
f
> > RAMBlock looping we'll send a normal page (then we'll get more thing
> > to send).  So IMHO we don't really know whether we sent more pages
> > with this patch, we can only know we sent more bytes (e.g., an extrem=
e
> > case is that the extra 25Mbps/s are all caused by those normal pages,
> > and we can be sending exactly the same number of pages like before, o=
r
> > even worse?).
> >=20
>=20
> Current implementation uses CPU very ineffectively (it's our next work
> to be posted out) that the network is almost idle so posting more data
> out is a better choice=EF=BC=8Cfurther more, migration thread plays a r=
ole for
> parallel, it'd better to make it fast.
>=20
> > >=20
> > > >=20
> > > > Another follow-up question would be: have you measured how long t=
ime
> > > > needed to compress a 4k page, and how many time to send it?  I th=
ink
> > > > "sending the page" is not really meaningful considering that we j=
ust
> > > > put a page into the buffer (which should be extremely fast since =
we
> > > > don't really flush it every time), however I would be curious on =
how
> > > > slow would compressing a page be.
> > >=20
> > > I haven't benchmark the performance of zlib, i think it is CPU inte=
nsive
> > > workload, particularly, there no compression-accelerator (e.g, QAT)=
 on
> > > our production. BTW, we were using lzo instead of zlib which worked
> > > better for some workload.
> >=20
> > Never mind. Good to know about that.
> >=20
> > >=20
> > > Putting a page into buffer should depend on the network, i,e, if th=
e
> > > network is congested it should take long time. :)
> >=20
> > Again, considering that I don't know much on compression (especially =
I
> > hardly used that) mine are only questions, which should not block you=
r
> > patches to be either queued/merged/reposted when proper. :)
>=20
> Yes, i see. The discussion can potentially raise a better solution.
>=20
> Thanks for your comment, Peter!

I think I have no problem on this patch.  Please take my r-b if you
like:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

--=20
Peter Xu
