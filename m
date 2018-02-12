Received: from eggs.gnu.org ([2001:4830:134:3::10]:60918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1elDcl-0000AC-5z
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1elDcg-0007ZZ-3P
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:54:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1elDcf-0007Xz-P4
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:54:17 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1CCrf4X062055
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 07:54:16 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3abqtbu8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 07:54:16 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 12 Feb 2018 12:54:13 -0000
References: <20180212124718.21935-1-mreitz@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 12 Feb 2018 13:54:09 +0100
MIME-Version: 1.0
In-Reply-To: <20180212124718.21935-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ec6116a6-80f7-4375-ecce-d34cb532c77d@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Use virtio-blk in 155
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>


On 02/12/2018 01:47 PM, Max Reitz wrote:
> Only a few select machine types support floppy drives and there is
> actually nothing preventing us from using virtio here, so let's do it.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>



> ---
>  tests/qemu-iotests/155 | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
> index fc9fa975be..42dae04c83 100755
> --- a/tests/qemu-iotests/155
> +++ b/tests/qemu-iotests/155
> @@ -64,7 +64,7 @@ class BaseClass(iotests.QMPTestCase):
>                      'file': {'driver': 'file',
>                               'filename': source_img}}
>          self.vm.add_blockdev(self.qmp_to_opts(blockdev))
> -        self.vm.add_device('floppy,id=qdev0,drive=source')
> +        self.vm.add_device('virtio-blk,id=qdev0,drive=source')
>          self.vm.launch()
> 
>          self.assertIntactSourceBackingChain()
> @@ -173,21 +173,24 @@ class MirrorBaseClass(BaseClass):
>      def testFull(self):
>          self.runMirror('full')
> 
> -        node = self.findBlockNode('target', 'qdev0')
> +        node = self.findBlockNode('target',
> +                                  '/machine/peripheral/qdev0/virtio-backend')
>          self.assertCorrectBackingImage(node, None)
>          self.assertIntactSourceBackingChain()
> 
>      def testTop(self):
>          self.runMirror('top')
> 
> -        node = self.findBlockNode('target', 'qdev0')
> +        node = self.findBlockNode('target',
> +                                  '/machine/peripheral/qdev0/virtio-backend')
>          self.assertCorrectBackingImage(node, back2_img)
>          self.assertIntactSourceBackingChain()
> 
>      def testNone(self):
>          self.runMirror('none')
> 
> -        node = self.findBlockNode('target', 'qdev0')
> +        node = self.findBlockNode('target',
> +                                  '/machine/peripheral/qdev0/virtio-backend')
>          self.assertCorrectBackingImage(node, source_img)
>          self.assertIntactSourceBackingChain()
> 
> @@ -239,7 +242,8 @@ class TestCommit(BaseClass):
> 
>          self.vm.event_wait('BLOCK_JOB_COMPLETED')
> 
> -        node = self.findBlockNode(None, 'qdev0')
> +        node = self.findBlockNode(None,
> +                                  '/machine/peripheral/qdev0/virtio-backend')
>          self.assert_qmp(node, 'image' + '/backing-image' * 0 + '/filename',
>                          back1_img)
>          self.assert_qmp(node, 'image' + '/backing-image' * 1 + '/filename',
> 
