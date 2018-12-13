Received: from eggs.gnu.org ([2001:4830:134:3::10]:33337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXSIt-00087O-KM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXSIq-0006Tx-UM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:49:31 -0500
Date: Thu, 13 Dec 2018 15:49:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181213144914.GH5427@linux.fritz.box>
References: <DB6PR07MB33330E3562B0AF0ECC8307BCAEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<DB6PR07MB3333E95C513AF2EF14AAE615AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<14b32e39-a9f6-1a83-87e6-6e150954ddb7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b32e39-a9f6-1a83-87e6-6e150954ddb7@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Request for clarification on qemu-img
 convert behavior zeroing target host_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "De Backer, Fred (Nokia - BE/Antwerp)" <fred.de_backer@nokia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nir Soffer <nsoffer@redhat.com>, qemu block <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, "Aamir T, Owais (Nokia - IN/Chennai)" <owais.aamir_t@nokia.com>

Am 13.12.2018 um 15:17 hat Eric Blake geschrieben:
> On 12/13/18 7:12 AM, De Backer, Fred (Nokia - BE/Antwerp) wrote:
> > Hi,
> > 
> > We're using Openstack Ironic to deploy baremetal servers. During the deployment process an agent (ironic-python-agent) running on Fedora linux uses qemu-img to write a qcow2 file to a blockdevice.
> > 
> > Recently we saw a change in behavior of qemu-img. Previously we were using Fedora 27 containing a fedora packaged version of qemu-img v2.10.2 (qemu-img-2.10.2-1.fc27.x86_64.rpm); now we use Fedora 29 containing a fedora packaged version of qemu-img v3.0.0 (qemu-img-3.0.0-2.fc29.x86_64.rpm).
> > 
> > The command that is run by the ironic-python-agent (the same in both FC27 and FC29) is: qemu-img -t directsync -O host_device /tmp/image.qcow2 /dev/sda
> > 
> > We observe that in Fedora 29 the qemu-img, before imaging the disk, it fully zeroes it. Taking into account the disk size, the whole process now takes 35 minutes instead of 50 seconds. This causes the ironic-python-agent operation to time-out. The Fedora 27 qemu-img doesn't do that.
> 
> Known issue; Nir and Rich have posted a previous thread on the topic, and
> the conclusion is that we need to make qemu-img smarter about NOT requesting
> pre-zeroing of devices where that is more expensive than just zeroing as we
> go.
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg01182.html

Yes, we should be careful to avoid the fallback in this case.

However, how could this ever go from 50 seconds for writing the whole
image to 35 minutes?! Even if you end up writing the whole image twice
because you write zeros first and then overwrite them everywhere with
data, shouldn't the maximum be doubling the time, i.e. 100 seconds?

Why is the write_zeroes fallback _that_ slow? It will also hit guests
that request write_zeroes, so I feel this is worth investigating a bit
more nevertheless.

Can you check with strace which operation actually succeeds writing
zeros to /dev/sda? The first thing we try is fallocate with
FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE. This should always be fast,
so I suppose this fails in your case. The next thing is BLKZEROOUT,
which I think can do a fallback in the kernel. Does this return success?
Otherwise we have another fallback mechanism inside of QEMU, which would
use normal pwrite calls with a zeroed buffer.

Once we know which mechanism is used, we can look into why it is so
abysmally slow.

Kevin
