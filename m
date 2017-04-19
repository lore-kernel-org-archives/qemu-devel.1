Received: from eggs.gnu.org ([2001:4830:134:3::10]:37180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0lVc-0007j1-MI
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0lVZ-0003EY-I4
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d0lVZ-0003EC-C7
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:02:41 -0400
Date: Wed, 19 Apr 2017 17:02:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170419090236.GA14508@lemon.lan>
References: <1009091132.10984059.1492585700295.JavaMail.zimbra@oxygem.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1009091132.10984059.1492585700295.JavaMail.zimbra@oxygem.tv>
Subject: Re: [Qemu-devel] blockdev-mirror ,
 how to replace old nodename by new nodename ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, 04/19 09:08, Alexandre DERUMIER wrote:
> Hi,
> 
> I'm trying to implement blockdev-mirror, to replace drive-mirror as we can pass more options with blockdev-mirror.
> 
> 
> I would like to mirror an attached blockdev to a new blockdev, then switch at the end of block-job-complete, like for drive-mirror.
> 
> 
> qemu command line (vm-138-disk-1.qcow2 filename on "drive-virtio0" nodename:
> 
> -blockdev {"node-name":"drive-virtio0","cache":{"direct":true},"driver":"qcow2","file":{"filename":"/var/lib/vz/images/138/vm-138-disk-1.qcow2","aio":"threads","driver":"file"}}
> -device virtio-blk-pci,drive=drive-virtio0,id=virtio0,bus=pci.0,addr=0xa,write-cache=on
> 
> 
> add a new blockdev with blockdev-add: (a file vm-138-disk-2.raw has been created before, I assign it to a "tempmirror" nodename)
> 
> 
> {"arguments":{"driver":"raw","cache":{"direct":true},"node-name":"tempmirror","file":{"driver":"file","aio":"threads","filename":"/var/lib/vz/images/138/vm-138-disk-2.raw"}},"execute":"blockdev-add"}
> 
> 
> blockdev-mirror:
> 
> {"arguments":{"job-id":"drive-virtio0","target":"tempmirror","sync":"full","replaces":"drive-virtio0","device":"drive-virtio0"},"execute":"blockdev-mirror"}
> 
> (I have try with or without replaces option)
> 
> then query-name-block-nodes, show vm-138-disk-2.raw file on tempmirror "node-name", and vm-138-disk1.qcow2 on "drive-virtio0" node-name
>  
> 
> I expected that both was switched, like for drive-mirror.

The replace/switch happens when you do block-job-complete.

And I think in your use case "replaces" is not needed. That one is for replacing
a node under quorum

Fam
