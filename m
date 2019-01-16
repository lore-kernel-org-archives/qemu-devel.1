Received: from eggs.gnu.org ([209.51.188.92]:37797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gje5J-0002pL-Fy
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gje5F-00087r-7M
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:49:50 -0500
Date: Wed, 16 Jan 2019 13:49:31 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20190116054930.GB73677@tiger-server>
References: <1888836717.9067.1547583207433.ref@mail.yahoo.com>
	<1888836717.9067.1547583207433@mail.yahoo.com>
	<2050085823.124754.1547592669568@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2050085823.124754.1547592669568@mail.yahoo.com>
Subject: Re: [Qemu-devel] Devdax backend for vnvdimm not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamal Kakri <kamalkakri2017@yahoo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, luyao.zhong@intel.com

On 2019-01-15 at 22:51:09 +0000, Kamal Kakri via Qemu-devel wrote:
>  My devdax device is 2MB aligned so I dont think this is alignment related.# ndctl list -X -n namespace0.0
> [
>   {
>     "dev":"namespace0.0",
>     "mode":"devdax",
>     "map":"dev",
>     "size":16909336576,
>     "uuid":"e5265c0a-d902-41ce-b1d1-87a78c358aa4",
>     "daxregion":{
>       "id":0,
>       "size":16909336576,
>       "align":2097152,  ------------------------->
>       "devices":[
>         {
>           "chardev":"dax0.0",
>           "size":16909336576
>         }
>       ]
>     }
>   }
> ]
> 
> 
> I even tried to create vnvdimm of exact same size as my devdax namespace, thinking that it would not need to ftruncate in that case but I still get the same error:
> # virsh start fox22vm
> start: domain(optdata): fox22vm
> start: found option <domain>: fox22vm
> start: <domain> trying as domain NAME
> error: Failed to start domain fox22vm
> error: internal error: qemu unexpectedly closed the monitor: ftruncate: Invalid argument
> 2019-01-15T21:58:52.647221Z qemu-kvm: -object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/dev/dax0.0,share=yes,size=16909336576: unable to map backing store for guest RAM: Invalid argument
> 
> 
> Has anyone ever got devdax backed vnvdimm configured and working? 
> If yes then pls let me know what libvirt/qemu/kernel version you have used to get it working.
> 
> Thanks.
>     On Tuesday, January 15, 2019, 3:13:27 PM EST, Kamal Kakri <kamalkakri2017@yahoo.com> wrote:  
>  
>  Hi,
> 
> I have a namespace (backed by real nvdimm h/w) configured in devdax mode:
> # ndctl list -N -n namespace0.0
> [
>   {
>     "dev":"namespace0.0",
>     "mode":"devdax",
>     "map":"dev",
>     "size":16909336576,
>     "uuid":"e5265c0a-d902-41ce-b1d1-87a78c358aa4",
>     "chardev":"dax0.0"
>   }
> ]
> 
> 
> When I try to configure my vm using "virsh" with something like this:
>     <memory model='nvdimm' access='shared'>
>       <source>
>         <path>/dev/dax0.0</path>
>         <align unit='KiB'>2048</align>
this should be alignsize, Add Luyao.
>         <pmem/>
>       </source>
>       <target>
>         <size unit='KiB'>2097152</size>
>         <node>0</node>
>       </target>
>       <alias name='nvdimm0'/>
>       <address type='dimm' slot='0'/>
>     </memory>
> 
> 
> I get an error while starting my vm:
> # virsh start fox22vm
> start: domain(optdata): fox22vm
> start: found option <domain>: fox22vm
> start: <domain> trying as domain NAME
> error: Failed to start domain fox22vm
> error: internal error: qemu unexpectedly closed the monitor: ftruncate: Invalid argument
> 2019-01-15T18:00:36.587467Z qemu-kvm: -object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/dev/dax0.0,share=yes,size=2147483648: unable to map backing store for guest RAM: Invalid argument
> 
> I have tried to add "align unit" to my virsh xml but it does not seem to pass it onto qemu (as much as I can see from the qemu cmd line in the logs at /var/log/libvirt/qemu)
> 
> 
> Can anyone pls hint as to what possibly could be the issue ? Is this alignment related or something else ?
> 
> Here are my versions:
> # virsh --version
> 4.5.0
> [root@fox22hv libexec]# /usr/libexec/qemu-kvm --version
> QEMU emulator version 2.12.0 (qemu-kvm-rhev-2.12.0-18.el7_6.1)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
> # uname -a
> Linux fox22hv 4.19.0-1.el7.elrepo.x86_64 #1 SMP Mon Oct 22 10:40:32 EDT 2018 x86_64 x86_64 x86_64 GNU/Linux
> 
> 
> 
> 
>   
