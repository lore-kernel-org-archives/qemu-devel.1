Received: from eggs.gnu.org ([209.51.188.92]:49249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gjb1L-0002hE-8f
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 21:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gjamA-00064G-9G
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 21:17:55 -0500
Date: Wed, 16 Jan 2019 10:18:05 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20190116021804.GA73677@tiger-server>
References: <1888836717.9067.1547583207433.ref@mail.yahoo.com>
	<1888836717.9067.1547583207433@mail.yahoo.com>
	<20190116011233.GA10810@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190116011233.GA10810@richard>
Subject: Re: [Qemu-devel] Devdax backend for vnvdimm not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Kamal Kakri <kamalkakri2017@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

On 2019-01-16 at 09:12:33 +0800, Wei Yang wrote:
> On Tue, Jan 15, 2019 at 08:13:27PM +0000, Kamal Kakri via Qemu-devel wrote:
> >Hi,
> >
> >I have a namespace (backed by real nvdimm h/w) configured in devdax mode:
> ># ndctl list -N -n namespace0.0
> >[
> >  {
> >    "dev":"namespace0.0",
> >    "mode":"devdax",
> >    "map":"dev",
> >    "size":16909336576,
> >    "uuid":"e5265c0a-d902-41ce-b1d1-87a78c358aa4",
> >    "chardev":"dax0.0"
> >  }
> >]
> >
> 
> Above is your host configuration, right?
> 
> >
> >When I try to configure my vm using "virsh" with something like this:
> >    <memory model='nvdimm' access='shared'>
> >      <source>
> >        <path>/dev/dax0.0</path>
> >        <align unit='KiB'>2048</align>
so that will apply the align=2048K for memory-backend-file?
> >        <pmem/>
> >      </source>
> >      <target>
> >        <size unit='KiB'>2097152</size>
> >        <node>0</node>
> >      </target>
> >      <alias name='nvdimm0'/>
> >      <address type='dimm' slot='0'/>
> >    </memory>
> >
> 
> I am not familiar with virsh, while I guess align here is the parameter passed
> to qemu.
> 
> Hmm...  as I being told, the alignment should be 128M.
2MB align is OK for this case.
> 
> >
> >I get an error while starting my vm:
> ># virsh start fox22vm
> >start: domain(optdata): fox22vm
> >start: found option <domain>: fox22vm
> >start: <domain> trying as domain NAME
> >error: Failed to start domain fox22vm
> >error: internal error: qemu unexpectedly closed the monitor: ftruncate: Invalid argument
> >2019-01-15T18:00:36.587467Z qemu-kvm: -object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/dev/dax0.0,share=yes,size=2147483648: unable to map backing store for guest RAM: Invalid argument
I didn't see the algin=2M option is applied here, which is must and minimal
granularity of devdax backend, is anything I missed?
> 
> The error message here shows the error is caused by mmap for an invalid
> argument. Hmm... but I am not sure which one is incorrect.
> 
> 
> Usually I run qemu directly, here is a qemu command line which works at my
> side:
> 
> qemu/x86_64-softmmu/qemu-system-x86_64 -machine pc,nvdimm \
> 	-m 6G,slots=4,maxmem=128G -smp 8 --enable-kvm \
> 	-drive file=/home/richard/guest/fedora29.img,format=raw -nographic \
> 	-drive file=/home/richard/guest/project.img,format=raw \
> 	-object memory-backend-file,id=mem1,share=on,mem-path=/dev/dax0.0,size=10G,align=128M \
> 	-device nvdimm,id=nvdimm1,memdev=mem1,label-size=128k
> 
> Maybe you can compare the difference between your virsh result to see the
> difference.
> 
> >
> >I have tried to add "align unit" to my virsh xml but it does not seem to pass it onto qemu (as much as I can see from the qemu cmd line in the logs at /var/log/libvirt/qemu)
> >
> >
> >Can anyone pls hint as to what possibly could be the issue ? Is this alignment related or something else ?
yes the alignment.
> >
> >Here are my versions:
> ># virsh --version
> >4.5.0
> >[root@fox22hv libexec]# /usr/libexec/qemu-kvm --version
> >QEMU emulator version 2.12.0 (qemu-kvm-rhev-2.12.0-18.el7_6.1)
> >Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
> ># uname -a
> >Linux fox22hv 4.19.0-1.el7.elrepo.x86_64 #1 SMP Mon Oct 22 10:40:32 EDT 2018 x86_64 x86_64 x86_64 GNU/Linux
> >
> >
> >
> 
> -- 
> Wei Yang
> Help you, Help me
> 
