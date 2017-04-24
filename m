Received: from eggs.gnu.org ([2001:4830:134:3::10]:41310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yigal@plexistor.com>) id 1d2XIz-0000Xo-EE
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yigal@plexistor.com>) id 1d2XIy-0004ev-F3
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:17:01 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:36095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yigal@plexistor.com>) id 1d2XIy-0004eV-8r
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:17:00 -0400
Received: by mail-qk0-x229.google.com with SMTP id u75so11917176qka.3
	for <qemu-devel@nongnu.org>; Sun, 23 Apr 2017 23:16:58 -0700 (PDT)
MIME-Version: 1.0
From: Yigal Korman <yigal@plexistor.com>
Date: Mon, 24 Apr 2017 09:16:37 +0300
Message-ID: <CACTTzNbu0NwXBw+Jj=8L2Nw+SBA3jLQ1-WDSa6-TgBuZwHj4ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qemu-kvm hangs with DAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, kvm@vger.kernel.org, qemu-devel@nongnu.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>

This is a re-post, I didn't send it to all relevant mailing lists before...

Original below.

Hi everyone,

I have an interesting issue with DAX and KVM - I'm trying to boot a VM
with its memory mapped to a DAX-mounted file (kernel 4.9).

The use case is a bit wacky but I'm trying to recreate something
similar to what clearlinux[1] described (although they don't use this
method anymore).

When mapping the memory to a regular ext4 file, the VM boots fine.
But when mapping to ext4+dax, the VM won't boot or perhaps boots
extremely slowly.
In both cases the FS is on a memory pmem device.

Here's a snippet of how I load things:

mkfs.ext4 /dev/pmem0
mount /dev/pmem0 /mnt
fallocate -l 512M /mnt/mem
qemu-system-x86_64 -nodefconfig -nodefaults \
 -drive if=virtio,file=centos7.qcow2,index=0,media=disk \
 --enable-kvm -serial telnet:localhost:4443,server,nowait \
 -device sga -m 512 -smp 1,sockets=1,cores=1,threads=1 \
 -object memory-backend-file,prealloc=yes,mem-path=/mnt/mem,share=on,size=512M,id=ram
\
 -numa node,nodeid=0,cpus=0,memdev=ram \
 -net nic,model=virtio,vlan=0 \
 -net user,vlan=0,hostname=vm,hostfwd=tcp:127.0.0.1:8001-:22 \
 -name test -monitor telnet:localhost:4444,server,nowait

I use a headless host so I usually connect to the VM with 'telnet
localhost 4443'.

The above works and the VM boots in seconds.
When adding '-o dax' to the mount command, I can catch the grub menu
during boot but it gets stuck.
Sometimes if I wait about 20 minutes, I see some kernel boot messages
appear, but no errors.

I've already tried something Dan Williams suggested - using 'dd'
instead of 'fallocate', but it didn't seem to help.

Also tried profiling the first 30s of qemu boot with 'perf stat' -
doesn't seem any clearer to me but here are the results:

for ext4 w/o DAX:

       4804.688402      task-clock (msec)         #    0.160 CPUs
utilized
            22,389      context-switches          #    0.005 M/sec
               144      cpu-migrations            #    0.030 K/sec
           158,611      page-faults               #    0.033 M/sec
     7,537,184,564      cycles                    #    1.569 GHz
     8,034,998,998      instructions              #    1.07  insn per
cycle
     1,612,266,593      branches                  #  335.561 M/sec
         8,574,733      branch-misses             #    0.53% of all
branches

for ext4 w/ DAX:

      30001.643354      task-clock (msec)         #    1.000 CPUs
utilized
               584      context-switches          #    0.019 K/sec
                12      cpu-migrations            #    0.000 K/sec
           274,575      page-faults               #    0.009 M/sec
     2,131,506,685      cycles                    #    0.071 GHz
     2,252,004,361      instructions              #    1.06  insn per
cycle
       439,086,052      branches                  #   14.635 M/sec
         2,663,760      branch-misses             #    0.61% of all
branches

Seems like w/o DAX, the boot will complete in seconds and the CPU will
remain idle and w/ DAX the CPU is working very hard and there much
more page-faults.

Any thoughts?

Regards,
Yigal
