Received: from eggs.gnu.org ([2001:4830:134:3::10]:59815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dGQho-0002dv-Nl
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dGQhn-0001uQ-SD
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:04:04 -0400
Date: Thu, 1 Jun 2017 16:03:52 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170601140352.lcfv55eaba775zbm@eukaryote>
References: <20170529190322.xc2e2uh7wp6hlcs6@eukaryote>
	<w514lw22y70.fsf@maestria.local.igalia.com>
	<20170531145720.lc5tlssve5eeyyf4@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531145720.lc5tlssve5eeyyf4@eukaryote>
Subject: Re: [Qemu-devel] [RFC] Making 'block-stream',
 and 'block-commit' accept node-name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, May 31, 2017 at 04:57:20PM +0200, Kashyap Chamarthy wrote:
> On Tue, May 30, 2017 at 04:53:23PM +0200, Alberto Garcia wrote:
> > On Mon 29 May 2017 09:03:22 PM CEST, Kashyap Chamarthy wrote:

[...]

> > > While we have `blockdev-{mirror, backup}` as 'node-name'-alternatives
> > > for `drive-{mirror, backup}`, as the eagle-eyed will, the
> > > `block-stream` and `block-commit` commands still operate on file names
> > > for parameters 'base' and 'top'.
> > 
> > block-stream does accept a node name for the top and base images (see
> > 554b614765090f47d and 312fe09cc8af86c).

Indeed it does.  The key here is the 'base-node' parameter.  Thanks!

Test
----

To turn this:

    [A] <-- [B] <-- [C] <-- [D]

Into:

    [A] <-- [C] <-- [D]

#----------------------------------------------------------------------
Check the backing file depth of image [D]:

    $ qemu-img info --backing-chain d.qcow2  | grep "backing file:"
    backing file: c.qcow2
    backing file: b.qcow2
    backing file: ./a.qcow2
#----------------------------------------------------------------------

Perform intermediate streaming:

(QEMU) block-stream device=node-C base-node=node-A job-id=job0                                                                                                                     
{
    "execute": "block-stream", 
    "arguments": {
        "device": "node-D", 
        "job-id": "job0", 
        "base-node": "node-A"
    }
}
{
    "return": {}
}
(QEMU) 
{u'timestamp': {u'seconds': 1496325065, u'microseconds': 808768}, u'data': {u'device': u'job0', u'type': u'stream', u'speed': 0, u'len': 41126400, u'offset': 41126400}, u'event': u'BLOCK_JOB_COMPLETED'}
#----------------------------------------------------------------------

Check the backing file depth, it is now: A <- C <- D:

$ qemu-img info --backing-chain d.qcow2  | grep "backing file:"
backing file: c.qcow2
backing file: ./a.qcow2
#----------------------------------------------------------------------

[...]

-- 
/kashyap
