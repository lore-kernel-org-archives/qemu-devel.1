Received: from eggs.gnu.org ([2001:4830:134:3::10]:53208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1d0jjk-0008PH-5y
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1d0jjf-00043C-5x
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:09:12 -0400
Received: from mailpro.odiso.net ([89.248.211.110]:52096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1d0jje-0003yd-R0
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:09:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 9DF711093625
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 09:08:20 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OgIhayEuUd2G for <qemu-devel@nongnu.org>;
	Wed, 19 Apr 2017 09:08:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 841611093631
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 09:08:20 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vmJ4gCl0AQxe for <qemu-devel@nongnu.org>;
	Wed, 19 Apr 2017 09:08:20 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.111])
	by mailpro.odiso.net (Postfix) with ESMTP id 7191C1093630
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 09:08:20 +0200 (CEST)
Date: Wed, 19 Apr 2017 09:08:20 +0200 (CEST)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <1009091132.10984059.1492585700295.JavaMail.zimbra@oxygem.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] blockdev-mirror ,
 how to replace old nodename by new nodename ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi,

I'm trying to implement blockdev-mirror, to replace drive-mirror as we can pass more options with blockdev-mirror.


I would like to mirror an attached blockdev to a new blockdev, then switch at the end of block-job-complete, like for drive-mirror.


qemu command line (vm-138-disk-1.qcow2 filename on "drive-virtio0" nodename:

-blockdev {"node-name":"drive-virtio0","cache":{"direct":true},"driver":"qcow2","file":{"filename":"/var/lib/vz/images/138/vm-138-disk-1.qcow2","aio":"threads","driver":"file"}}
-device virtio-blk-pci,drive=drive-virtio0,id=virtio0,bus=pci.0,addr=0xa,write-cache=on


add a new blockdev with blockdev-add: (a file vm-138-disk-2.raw has been created before, I assign it to a "tempmirror" nodename)


{"arguments":{"driver":"raw","cache":{"direct":true},"node-name":"tempmirror","file":{"driver":"file","aio":"threads","filename":"/var/lib/vz/images/138/vm-138-disk-2.raw"}},"execute":"blockdev-add"}


blockdev-mirror:

{"arguments":{"job-id":"drive-virtio0","target":"tempmirror","sync":"full","replaces":"drive-virtio0","device":"drive-virtio0"},"execute":"blockdev-mirror"}

(I have try with or without replaces option)

then query-name-block-nodes, show vm-138-disk-2.raw file on tempmirror "node-name", and vm-138-disk1.qcow2 on "drive-virtio0" node-name
 

I expected that both was switched, like for drive-mirror.

Any idea ?

Regards,

Alexandre





[query-named-block-nodes","arguments":{}
$VAR1 = [
          {
            'bps_wr' => 0,
            'cache' => {
                         'no-flush' => bless( do{\(my $o = 0)}, 'JSON::PP::Boolean' ),
                         'direct' => bless( do{\(my $o = 1)}, 'JSON::PP::Boolean' ),
                         'writeback' => $VAR1->[0]{'cache'}{'direct'}
                       },
            'bps' => 0,
            'iops' => 0,
            'node-name' => 'toto',
            'ro' => $VAR1->[0]{'cache'}{'no-flush'},
            'image' => {
                         'actual-size' => 1074794496,
                         'filename' => '/var/lib/vz/images/138/vm-138-disk-2.raw',
                         'dirty-flag' => $VAR1->[0]{'cache'}{'no-flush'},
                         'format' => 'raw',
                         'virtual-size' => 1073741824
                       },
            'write_threshold' => 0,
            'iops_rd' => 0,
            'bps_rd' => 0,
            'encrypted' => $VAR1->[0]{'cache'}{'no-flush'},
            'encryption_key_missing' => $VAR1->[0]{'cache'}{'no-flush'},
            'backing_file_depth' => 0,
            'detect_zeroes' => 'off',
            'file' => '/var/lib/vz/images/138/vm-138-disk-2.raw',
            'drv' => 'raw',
            'iops_wr' => 0
          },
          {
            'ro' => $VAR1->[0]{'cache'}{'no-flush'},
            'node-name' => '#block132',
            'file' => '/var/lib/vz/images/138/vm-138-disk-2.raw',
            'detect_zeroes' => 'off',
            'iops_wr' => 0,
            'drv' => 'file',
            'iops_rd' => 0,
            'bps_rd' => 0,
            'image' => {
                         'actual-size' => 1074794496,
                         'filename' => '/var/lib/vz/images/138/vm-138-disk-2.raw',
                         'dirty-flag' => $VAR1->[0]{'cache'}{'no-flush'},
                         'virtual-size' => 1073741824,
                         'format' => 'file'
                       },
            'write_threshold' => 0,
            'backing_file_depth' => 0,
            'encryption_key_missing' => $VAR1->[0]{'cache'}{'no-flush'},
            'encrypted' => $VAR1->[0]{'cache'}{'no-flush'},
            'bps_wr' => 0,
            'bps' => 0,
            'iops' => 0,
            'cache' => {
                         'no-flush' => $VAR1->[0]{'cache'}{'no-flush'},
                         'direct' => $VAR1->[0]{'cache'}{'direct'},
                         'writeback' => $VAR1->[0]{'cache'}{'direct'}
                       }
          },
          {
            'drv' => 'qcow2',
            'iops_wr' => 0,
            'detect_zeroes' => 'off',
            'file' => '/var/lib/vz/images/138/vm-138-disk-1.qcow2',
            'encrypted' => $VAR1->[0]{'cache'}{'no-flush'},
            'encryption_key_missing' => $VAR1->[0]{'cache'}{'no-flush'},
            'backing_file_depth' => 0,
            'image' => {
                         'cluster-size' => 65536,
                         'virtual-size' => 1073741824,
                         'format-specific' => {
                                                'type' => 'qcow2',
                                                'data' => {
                                                            'corrupt' => $VAR1->[0]{'cache'}{'no-flush'},
                                                            'compat' => '1.1',
                                                            'lazy-refcounts' => $VAR1->[0]{'cache'}{'no-flush'},
                                                            'refcount-bits' => 16
                                                          }
                                              },
                         'format' => 'qcow2'
                       },
            'write_threshold' => 0,
            'bps_rd' => 0,
            'iops_rd' => 0,
            'ro' => $VAR1->[0]{'cache'}{'no-flush'},
            'node-name' => 'drive-virtio0',
            'bps' => 0,
            'iops' => 0,
            'cache' => {
                         'writeback' => $VAR1->[0]{'cache'}{'direct'},
                         'no-flush' => $VAR1->[0]{'cache'}{'no-flush'},
                         'direct' => $VAR1->[0]{'cache'}{'direct'}
                       },
            'bps_wr' => 0
          },
          {
            'detect_zeroes' => 'off',
            'file' => '/var/lib/vz/images/138/vm-138-disk-1.qcow2',
            'drv' => 'file',
            'iops_wr' => 0,
            'write_threshold' => 0,
            'image' => {
                         'format' => 'file',
                         'virtual-size' => 1074135040,
                         'dirty-flag' => $VAR1->[0]{'cache'}{'no-flush'},
                         'filename' => '/var/lib/vz/images/138/vm-138-disk-1.qcow2',
                         'actual-size' => 1075130368
                       },
            'bps_rd' => 0,
            'iops_rd' => 0,
            'encryption_key_missing' => $VAR1->[0]{'cache'}{'no-flush'},
            'encrypted' => $VAR1->[0]{'cache'}{'no-flush'},
            'backing_file_depth' => 0,
            'ro' => $VAR1->[0]{'cache'}{'no-flush'},
            'node-name' => '#block071',
            'bps' => 0,
            'iops' => 0,
            'cache' => {
                         'writeback' => $VAR1->[0]{'cache'}{'direct'},
                         'no-flush' => $VAR1->[0]{'cache'}{'no-flush'},
                         'direct' => $VAR1->[0]{'cache'}{'direct'}
                       },
            'bps_wr' => 0
          }
        ];


 
