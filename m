Received: from eggs.gnu.org ([2001:4830:134:3::10]:53861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eFNq5-0001Qq-Jl
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eFNq4-0006Sp-Nh
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:20:33 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:42870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eFNq4-0006S6-Gc
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:20:32 -0500
Received: by mail-wm0-x233.google.com with SMTP id 5so474766wmk.1
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 09:20:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171116151233.GW2787@redhat.com>
References: <20171115115246.GA1955@redhat.com>
	<20171116144746.GE29106@stefanha-x1.localdomain>
	<4ddf423b-a713-8f8b-e7dc-c970ad206885@kamp.de>
	<20171116151233.GW2787@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 16 Nov 2017 17:20:30 +0000
Message-ID: <CAJSP0QXepBMucAFNSbihp6awkurZ=47fTwgv7UHQ3MRiATGS5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Effect of qemu-img convert -m and -W options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, libguestfs@redhat.com, qemu-devel <qemu-devel@nongnu.org>

On Thu, Nov 16, 2017 at 3:12 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> On Thu, Nov 16, 2017 at 03:51:29PM +0100, Peter Lieven wrote:
>> Afaik all writes to the same QCOW2 serialize because of the s->lock that
>> is held during the write. So its not suprising that there is no benefit from
>> mutliple threads as long as reading from the RAW file involves no delay.
>> Which is likely due to readahead of the OS.
>
> I guess this would explain it, thanks.

The theory is false for preallocated qcow2 image files.  Parallel
writes do occur in block/qcow2.c:qcow2_co_pwritev() if the cluster is
already allocated:

            qemu_co_mutex_unlock(&s->lock);  <----- parallel!
            BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
            trace_qcow2_writev_data(qemu_coroutine_self(),
                                    cluster_offset + offset_in_cluster);
            ret = bdrv_co_pwritev(bs->file,
                                  cluster_offset + offset_in_cluster,
                                  cur_bytes, &hd_qiov, 0);
            qemu_co_mutex_lock(&s->lock);

Stefan
