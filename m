Received: from eggs.gnu.org ([2001:4830:134:3::10]:48417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d3NES-0007oP-Ns
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d3NEM-0001BX-Nj
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:43:48 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d3NEM-0001AA-HN
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:43:42 -0400
Received: by mail-wm0-x22b.google.com with SMTP id w64so51095952wma.0
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:43:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CACTTzNbu0NwXBw+Jj=8L2Nw+SBA3jLQ1-WDSa6-TgBuZwHj4ZQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7b6ceca-2414-e162-edb3-dabe2c9b392c@redhat.com>
Date: Wed, 26 Apr 2017 15:43:37 +0200
MIME-Version: 1.0
In-Reply-To: <CACTTzNbu0NwXBw+Jj=8L2Nw+SBA3jLQ1-WDSa6-TgBuZwHj4ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-kvm hangs with DAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yigal Korman <yigal@plexistor.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kvm@vger.kernel.org, qemu-devel@nongnu.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>



On 24/04/2017 08:16, Yigal Korman wrote:
> This is a re-post, I didn't send it to all relevant mailing lists before...
> 
> Original below.
> 
> Hi everyone,
> 
> I have an interesting issue with DAX and KVM - I'm trying to boot a VM
> with its memory mapped to a DAX-mounted file (kernel 4.9).
> 
> The use case is a bit wacky but I'm trying to recreate something
> similar to what clearlinux[1] described (although they don't use this
> method anymore).
> 
> When mapping the memory to a regular ext4 file, the VM boots fine.
> But when mapping to ext4+dax, the VM won't boot or perhaps boots
> extremely slowly.
> In both cases the FS is on a memory pmem device.
> 
> Here's a snippet of how I load things:
> 
> mkfs.ext4 /dev/pmem0
> mount /dev/pmem0 /mnt
> fallocate -l 512M /mnt/mem
> qemu-system-x86_64 -nodefconfig -nodefaults \
>  -drive if=virtio,file=centos7.qcow2,index=0,media=disk \
>  --enable-kvm -serial telnet:localhost:4443,server,nowait \
>  -device sga -m 512 -smp 1,sockets=1,cores=1,threads=1 \
>  -object memory-backend-file,prealloc=yes,mem-path=/mnt/mem,share=on,size=512M,id=ram
> \
>  -numa node,nodeid=0,cpus=0,memdev=ram \
>  -net nic,model=virtio,vlan=0 \
>  -net user,vlan=0,hostname=vm,hostfwd=tcp:127.0.0.1:8001-:22 \
>  -name test -monitor telnet:localhost:4444,server,nowait
> 
> I use a headless host so I usually connect to the VM with 'telnet
> localhost 4443'.
> 
> The above works and the VM boots in seconds.
> When adding '-o dax' to the mount command, I can catch the grub menu
> during boot but it gets stuck.
> Sometimes if I wait about 20 minutes, I see some kernel boot messages
> appear, but no errors.
> 
> I've already tried something Dan Williams suggested - using 'dd'
> instead of 'fallocate', but it didn't seem to help.
> 
> Also tried profiling the first 30s of qemu boot with 'perf stat' -
> doesn't seem any clearer to me but here are the results:
> 
> for ext4 w/o DAX:
> 
>        4804.688402      task-clock (msec)         #    0.160 CPUs
> utilized
>             22,389      context-switches          #    0.005 M/sec
>                144      cpu-migrations            #    0.030 K/sec
>            158,611      page-faults               #    0.033 M/sec
>      7,537,184,564      cycles                    #    1.569 GHz
>      8,034,998,998      instructions              #    1.07  insn per
> cycle
>      1,612,266,593      branches                  #  335.561 M/sec
>          8,574,733      branch-misses             #    0.53% of all
> branches
> 
> for ext4 w/ DAX:
> 
>       30001.643354      task-clock (msec)         #    1.000 CPUs
> utilized
>                584      context-switches          #    0.019 K/sec
>                 12      cpu-migrations            #    0.000 K/sec
>            274,575      page-faults               #    0.009 M/sec
>      2,131,506,685      cycles                    #    0.071 GHz
>      2,252,004,361      instructions              #    1.06  insn per
> cycle
>        439,086,052      branches                  #   14.635 M/sec
>          2,663,760      branch-misses             #    0.61% of all
> branches
> 
> Seems like w/o DAX, the boot will complete in seconds and the CPU will
> remain idle and w/ DAX the CPU is working very hard and there much
> more page-faults.

Can you try catching a trace with the following command:

trace-cmd record -e kvm -e kvmmmu qemu-kvm *rest of qemu command line*

(requires running as root)? Please send it xz-ipped to me, not the
mailing list, since it can be large.

Paolo
