Received: from eggs.gnu.org ([2001:4830:134:3::10]:43325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d0n4o-0000WC-Pg
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d0n4j-0004H6-Ok
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1d0n4j-0004G2-FH
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:43:05 -0400
Date: Wed, 19 Apr 2017 12:43:00 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170419104300.gousbztqfl5j4k7q@eukaryote>
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

On Wed, Apr 19, 2017 at 09:08:20AM +0200, Alexandre DERUMIER wrote:
> Hi,
> 
> I'm trying to implement blockdev-mirror, to replace drive-mirror as we
> can pass more options with blockdev-mirror.
>
> 
> I would like to mirror an attached blockdev to a new blockdev, then
> switch at the end of block-job-complete, like for drive-mirror.
 
[...]

> blockdev-mirror:
> 
> {"arguments":{"job-id":"drive-virtio0","target":"tempmirror","sync":"full","replaces":"drive-virtio0","device":"drive-virtio0"},"execute":"blockdev-mirror"}
> 
> (I have try with or without replaces option)
> 
> then query-name-block-nodes, show vm-138-disk-2.raw file on tempmirror
> "node-name", and vm-138-disk1.qcow2 on "drive-virtio0" node-name
> 
> I expected that both was switched, like for drive-mirror.

For me, 'blockdev-mirror' does do the switch when I issue
'block-job-complete' (similar to 'drive-mirror')

The below is my test from Git:

I was here (on Git):

    $ git describe
    v2.9.0-rc5

-----------------------------------------------------------------------
$ qemu-img create -f qcow2 /export/target2.qcow2 1G
Formatting '/export/target2.qcow2', fmt=qcow2 size=1073741824 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
-----------------------------------------------------------------------
QMP> 
{
  "execute":"blockdev-add",
  "arguments":{
    "driver":"qcow2",
    "node-name":"node1",
    "file":{
      "driver":"file",
      "filename":"/export/target2.qcow2"
    }
  }
}
{"return": {}}
-----------------------------------------------------------------------
QMP> 
{"execute":"query-named-block-nodes"}
[...]
-----------------------------------------------------------------------
QMP>
{
  "execute":"blockdev-mirror",
  "arguments":{
    "device":"foo",
    "job-id":"job-2",
    "target":"node2",
    "sync":"full"
  }
}
{"return": {}}
{"timestamp": {"seconds": 1492598410, "microseconds": 35946}, "event": "BLOCK_JOB_READY", "data": {"device": "job-2", "len": 24182784, "offset": 24182784, "speed": 0, "type": "mirror"}}
-----------------------------------------------------------------------
QMP>
{
  "execute":"block-job-complete",
  "arguments":{
    "device":"job-2"
  }
}
{"return": {}}
{"timestamp": {"seconds": 1492598419, "microseconds": 115458}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job-2", "len": 24182784, "offset": 24182784, "speed": 0, "type": "mirror"}}
-----------------------------------------------------------------------


[...]


-- 
/kashyap
