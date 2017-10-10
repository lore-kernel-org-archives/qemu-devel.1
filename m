Received: from eggs.gnu.org ([2001:4830:134:3::10]:38127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1otA-0007zO-FH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1ot5-0006Bh-TC
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:23:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e1ot5-0006BK-N3
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:23:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CAFq1WaKFes0czd9bKSWA0jbBWGiBk-vu+Owra6u-JGGjADui5g@mail.gmail.com>
	<9138d85e-26c5-71f5-54c0-44da066169c3@redhat.com>
Date: Tue, 10 Oct 2017 09:23:32 +0200
In-Reply-To: <9138d85e-26c5-71f5-54c0-44da066169c3@redhat.com> (John Snow's
	message of "Mon, 9 Oct 2017 11:41:25 -0400")
Message-ID: <87d15vlb4b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Using qemu command not able launch VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Koushik Dutta <koushikcseist@gmail.com>, qemu-devel@nongnu.org

John Snow <jsnow@redhat.com> writes:

> On 10/07/2017 03:53 AM, Koushik Dutta wrote:
>> Hi All (qemu members),
>> 
>> I installed qemu utility in my host machine. I want to start Virtual
>> machine using qemu command.
>> 
>> My host machine: Intel-X86
>> Script for launching VM :
>> 
>> T=/home/koushik/vpp/cloud_ubuntu_img
>>     sudo qemu-system-i386  -enable-kvm -m 1024 -smp
>> sockets=1,cpus=4,cores=2 -cpu host \
>>     -vga none -nographic \
>>     -kernel $T/vmlinuz-4.4.0-96-generic --append "console=ttyAMA0
>> root=/dev/vda rw"  \
>>     -drive file=$T/custom32.img,if=virtio,aio=threads \
>>     -chardev socket,id=char1,path=/tmp/sock1.sock \
>>     -netdev type=vhost-user,id=mynet1,chardev=char1,vhostforce\
>>     -device virtio-net-pci,mac=00:00:00:00:00:01,netdev=mynet1 \
>>     -object
>> memory-backend-file,id=mem,size=1024M,mem-path=/dev/hugepages,share=on \
>>     -numa node,memdev=mem -mem-prealloc \
>>     #-debugcon file:debug.log -global isa-debugcon.iobase=0x402
>> 
>> 
>> Bug:  Invalid netdev type
>> 
>> Please let me know where i did wrong.

Sure: you didn't quote the full error message :)

Please try again.

>> Please help me.
>> Thanks to all in advance.
>> 
>> 
>> Thanks & Regards,
>> Koushik
>> 
>
> type isn't a named parameter, it's positional.
>
> -netdev vhost-user,foo=bar
>
> Please take a look at the output from -help. look for "vhost-user."

Actually, -netdev vhost-user,... is shorthand for -netdev
type=vhost-user,...

I suspect the actual problem is vhost-user not being compiled in, i.e.
CONFIG_VHOST_NET_USED is off.  Sadly, this isn't reflected in --help.
Screwed up in commit 03ce574442d.
