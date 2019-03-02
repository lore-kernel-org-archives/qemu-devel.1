Received: from eggs.gnu.org ([209.51.188.92]:33563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0Cky-0007Bo-I7
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0Ckt-0001Xv-SI
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:05:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0Ckt-0001Vn-Hs
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:05:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so1278017wml.2
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 14:05:15 -0800 (PST)
References: <155156252741.17588.3363806743942119527.malonedeb@gac.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fdd11781-4fc2-9623-110e-b8dab54f9700@redhat.com>
Date: Sat, 2 Mar 2019 23:05:12 +0100
MIME-Version: 1.0
In-Reply-To: <155156252741.17588.3363806743942119527.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1818367] [NEW] Initialization of device
 cfi.pflash01 failed: Block node is read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1818367 <1818367@bugs.launchpad.net>, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>

Hi José,

On 3/2/19 10:35 PM, José Pekkarinen wrote:
> Public bug reported:
> 
> Hi,
> 
> I have several vms defined in libvirt using ovmf for uefi, since a later
> update of my server I'm unable to start any of the domains defined. This is

This looks more like a libvirt issue than a QEMU one.

> an example of the output given:
> 
> # virsh start os-1
> error: Failed to start domain os-1
> error: internal error: qemu unexpectedly closed the monitor: 2019-03-02T21:23:51.726446Z qemu-system-x86_64: Initialization of device cfi.pflash01 failed: Block node is read-only
> 
> an example of domain is like this:
> 
> <domain type='kvm'>                                                                                                                                                                                                                                                            
>   <name>os-1</name>                                                                                                                                                                                                                                                            
>   <uuid>34c41008-ab91-483b-959c-81a7a12ae9be</uuid>                                                                                                                                                                                                                            
>   <memory unit='KiB'>8388608</memory>                                                                                                                                                                                                                                          
>   <currentMemory unit='KiB'>8388608</currentMemory>                                                                                                                                                                                                                            
>   <memoryBacking>                                                                                                                                                                                                                                                              
>     <hugepages/>                                                                                                                                                                                                                                                               
>   </memoryBacking>                                                                                                                                                                                                                                                             
>   <vcpu placement='static' cpuset='10-11,34-35'>4</vcpu>                                                                                                                                                                                                                       
>   <os>                                                                                                                                                                                                                                                                         
>     <type arch='x86_64' machine='pc-i440fx-2.12'>hvm</type>                                                                                                                                                                                                                    
>     <loader type='pflash'>/var/lib/libvirt/qemu/nvram/os-1-ovmf.fd</loader>                                                                                                                                                                                                    

This is the copy of your OVMF_VARS pflash, I can't find where this file
load the OVMF_CODE pflash.

>     <boot dev='network'/>                                                                                                                                                                                                                                                      
>     <boot dev='hd'/>                                                                                                                                                                                                                                                           
>   </os>                                                                                                                                                                                                                                                                        
>   <features>                                                                                                                                                                                                                                                                   
>     <acpi/>                                                                                                                                                                                                                                                                    
>     <apic/>                                                                                                                                                                                                                                                                    
>   </features>                                                                                                                                                                                                                                                                  
>   <cpu mode='host-passthrough' check='partial'/>                                                                                                                                                                                                                               
>   <clock offset='utc'>                                                                                                                                                                                                                                                         
>     <timer name='rtc' tickpolicy='catchup'/>                                                                                                                                                                                                                                   
>     <timer name='pit' tickpolicy='delay'/>                                                                                                                                                                                                                                     
>     <timer name='hpet' present='no'/>                                                                                                                                                                                                                                          
>   </clock>                                                                                                                                                                                                                                                                     
>   <on_poweroff>destroy</on_poweroff>                                                                                                                                                                                                                                           
>   <on_reboot>restart</on_reboot>                                                                                                                                                                                                                                               
>   <on_crash>destroy</on_crash>                                                                                                                                                                                                                                                 
>   <pm>                                                                                                                                                                                                                                                                         
>     <suspend-to-mem enabled='no'/>                                                                                                                                                                                                                                             
>     <suspend-to-disk enabled='no'/>                                                                                                                                                                                                                                            
>   </pm>                                                                                                                                                                                                                                                                        
>   <devices>                                                                                                                                                                                                                                                                    
>     <emulator>/usr/bin/qemu-system-x86_64</emulator>                                                                                                                                                                                                                           
>     <disk type='block' device='disk'>                                                                                                                                                                                                                                          
>       <driver name='qemu' type='raw' cache='none' io='native'/>                                                                                                                                                                                                                
>       <source dev='/dev/vg0/os-1-vda'/>                                                                                                                                                                                                                                   
>       <target dev='vda' bus='virtio'/>                                                                                                                                                                                                                                         
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x06' function='0x0'/>                                                                                                                                                                                              
>     </disk>                                                                                                                                                                                                                                                                    
>     <disk type='block' device='disk'>
>       <driver name='qemu' type='raw' cache='none' io='native'/>
>       <source dev='/dev/vg0/os-1-vdb'/>
>       <target dev='vdb' bus='virtio'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x07' function='0x0'/>
>     </disk>
>     <controller type='usb' index='0' model='ich9-ehci1'>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x7'/>
>     </controller>
>     <controller type='usb' index='0' model='ich9-uhci1'>
>       <master startport='0'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x0' multifunction='on'/>
>     </controller>
>     <controller type='usb' index='0' model='ich9-uhci2'>
>       <master startport='2'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x1'/>
>     </controller>
>     <controller type='usb' index='0' model='ich9-uhci3'>
>       <master startport='4'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x2'/>
>     </controller>
>     <controller type='pci' index='0' model='pci-root'/>
>     <controller type='ide' index='0'>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x1'/>
>     </controller>
>     <interface type='bridge'>
>       <mac address='52:54:00:78:cb:97'/>
>       <source bridge='virbr0'/>
>       <model type='rtl8139'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
>     </interface>
>     <interface type='bridge'>
>       <mac address='52:54:00:1c:4f:22'/>
>       <source bridge='virbr1'/>
>       <model type='rtl8139'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
>     </interface>
>     <serial type='pty'>
>       <target type='isa-serial' port='0'>
>         <model name='isa-serial'/>
>       </target>
>     </serial>
>     <console type='pty'>
>       <target type='serial' port='0'/>
>     </console>
>     <input type='mouse' bus='ps2'/>
>     <input type='keyboard' bus='ps2'/>
>     <graphics type='vnc' port='-1' autoport='yes'>
>       <listen type='address'/>
>     </graphics>
>     <video>
>       <model type='cirrus' vram='16384' heads='1' primary='yes'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0'/>
>     </video>
>     <memballoon model='virtio'>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x09' function='0x0'/>
>     </memballoon>
>   </devices>
> </domain>
> 
> where /var/lib/libvirt/qemu/nvram/os-1-ovmf.fd is a copy of
> /usr/share/edk2-ovmf/OVMF_VARS.fd. An the extract from my

Is the os-1-ovmf.fd file accessible by your libvirt/qemu user?

> /etc/libvirt/qemu.conf to define ovmf:
> 
> ...
> # Location of master nvram file                                                                                                                                                                                                                                                
> #                                                                                                                                                                                                                                                                              
> # When a domain is configured to use UEFI instead of standard                                                                                                                                                                                                                  
> # BIOS it may use a separate storage for UEFI variables. If                                                                                                                                                                                                                    
> # that's the case libvirt creates the variable store per domain                                                                                                                                                                                                                
> # using this master file as image. Each UEFI firmware can,                                                                                                                                                                                                                     
> # however, have different variables store. Therefore the nvram is                                                                                                                                                                                                              
> # a list of strings when a single item is in form of:                                                                                                                                                                                                                          
> #   ${PATH_TO_UEFI_FW}:${PATH_TO_UEFI_VARS}.                                                                                                                                                                                                                                   
> # Later, when libvirt creates per domain variable store, this list is                                                                                                                                                                                                          
> # searched for the master image. The UEFI firmware can be called                                                                                                                                                                                                               
> # differently for different guest architectures. For instance, it's OVMF                                                                                                                                                                                                       
> # for x86_64 and i686, but it's AAVMF for aarch64. The libvirt default                                                                                                                                                                                                         
> # follows this scheme.                                                                                                                                                                                                                                                         
> nvram = [                                                                                                                                                                                                                                                                      
>    "/usr/share/edk2-ovmf/OVMF_CODE.fd:/usr/share/edk2-ovmf/OVMF_VARS.fd",                                                                                                                                                                                                      
> ]
> ...
> 
> This setup used to work one month ago, now it's setup with:
> 
> QEMU emulator version 3.1.0
> libvirt-5.0.0
> linux-4.19.20

What is your OS distribution?

> 
> Any help appreciated.
> 
> Best regards.
> 
> José
> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> 

Regards,

Phil.
