Received: from eggs.gnu.org ([2001:4830:134:3::10]:39370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJ24E-0003GX-JN
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJ24B-0003F7-PW
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:21:58 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:17614)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJ24B-0003D2-DD
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:21:55 -0400
Date: Thu, 8 Jun 2017 21:21:13 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170608182113.nmxnvus26vplg5du@postretch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Subject: [Qemu-devel] [Proposal] I/O throttling through new -object interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

In continuation of the discussion at [0], here follows a proposal for a 
new ThrottleGroup object defined through QOM. 

Throttle groups are currently defined when instantiating a drive in the 
command line,, eg.  
-drive file=foo.qcow2,throttling.iops-total=100,throttling.group=bar
and also on QMP with the 'block_set_io_throttle' command, eg:

   { "execute": "block_set_io_throttle",
     "arguments": {
        "device": "virtio0",
        "iops": 100,
        "iops_rd": 0,
        "iops_wr": 0,
        "bps": 0,
        "bps_rd": 0,
        "bps_wr": 0
     }
   }

As part of my GSoC project, IO throttling is moved to a block filter 
driver, which means multiple filter nodes sharing ThrottleGroup 
instances, and also, chaining filter nodes. The old interface will be 
retained as much as possible. By defining ThrottleGroups with QOM the 
following interface can be used:
    -drive file=foo.qcow2,throttling.group=bar \
    -object throttle-group,iops-total=100,id=bar
which will be equivalent to the current command above. The 
'block_set_io_throttle' command can be extended with a "group" argument, 
that when defined instead of "device", will find and edit the object in 
question. Users can hotplug ThrottleGroups with object-add in QMP/HMP, 
then attach drives to a throttle group (ie adding a filter node in the 
drive path that points to that throttle group) with an 'attach-throttle' 
and detach with 'detach-throttle', each taking the drive and throttle 
group name as arguments. An alternative (but uglier) approach would be 
to use 'block_set_io_throttle' for this as well. Something that's also 
sound is a 'block_set_throttle_groups' that takes a list of groups and a 
drive as arguments. I think the last could be best if the relevant 
function does not become complex.
All this means that existing configuration will not be redefined 
everytime the object is referenced unless each limit is specified 
explicitly, like it was mentioned in the previous discussion.

Regarding 'query-block'. This case is complicated by the fact that it 
would be possible for a drive to have many nodes, thus the values 
printed by 'query-block' might be inaccurate if they only report one of 
the node configurations.  The current approach is to report only the 
first filter node in the BDS tree. A user with advanced throttling 
configurations might have no need for this command.

I'm not certain about this, since this could be handled internally by an 
application, but it might be useful to have queries to list all the 
throttle groups that affect a drive, and to list all the drives in a 
throttle group. Maybe defining the drives as a ThrottleGroup QOM 
property will take care of the latter and also attaching/detaching 
drives to a group through the property getter/setter. Thoughts?

[0] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg06245.html
