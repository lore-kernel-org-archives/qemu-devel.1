Received: from eggs.gnu.org ([2001:4830:134:3::10]:45046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRxEY-0000SA-2W
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRxEU-00088Y-4r
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:29:14 -0500
Received: from [59.151.112.132] (port=62405 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRxET-00088O-Ns
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:29:10 -0500
References: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<87a8av4bdr.fsf@dusky.pond.sub.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58789120.8030809@cn.fujitsu.com>
Date: Fri, 13 Jan 2017 16:34:40 +0800
MIME-Version: 1.0
In-Reply-To: <87a8av4bdr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 00/10] Convert msix_init() to error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, "Michael S.
	Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Hannes Reinecke <hare@suse.de>, Dmitry Fleytman <dmitry@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>



On 01/13/2017 04:22 PM, Markus Armbruster wrote:
> Cao jin <caoj.fnst@cn.fujitsu.com> writes:
> 
>> Only a tiny modification in patch "megasas: remove unnecessary
>> megasas_use_msix()" to fix a megasas issue.
> 
> Please have a look at Michael's review in
> Message-ID: <20170112163519-mutt-send-email-mst@kernel.org>
> 

Oh...thanks for reminding, I missed that mail...

>> v8 changelog:
>> 1. reorder: place the "megasas: remove unnecessary megasas_use_msix()"
>>    as the last one. and fix the bug in it, detailed description in it,
>>    also removed the R-b of it.
>> 2. Add the Acked-by from Marcel for first 9 patches; add the R-b from Markus
>>    to "hcd-xhci: check & correct param before using it".
>>
>> Test:
>> 1. make check ok
>> 2. command line test for all affected device, make sure their realization
>>    is ok.
>> 3. detailed test for megasas, hcd-xhci, vmxnet3.
>>    megasas: install a linux distro is ok
>>    ./qemu-system-x86_64 --enable-kvm -m 1024
>>    -device megasas,id=scsi0,bus=pci.0
>>    -drive file=/xx/scsi-disk.img,if=none,id=drive-scsi0
>>    -device scsi-disk,bus=scsi0.0,channel=0,scsi-id=4,lun=0,drive=drive-scsi0,id=scsi0-4
>>    -cdrom /xx/Fedora-Server-DVD-x86_64-23.iso --monitor stdio
>>
>>    hcd-xhci: partition the usbstick.img, mkfs, write to file, is ok
>>    ./qemu-system-x86_64 -M q35 -m 1024 --enable-kvm
>>    -drive if=none,id=usbstick,file=/xx/usbstick.img
>>    -device nec-usb-xhci,id=usb,p2=8,p3=8,bus=pcie.0
>>    -device usb-storage,bus=usb.0,drive=usbstick --monitor stdio
>>    /xx/FedoraWorkStatsion23-x86_64.img
>>
>>    vmxnet3: ping another destination belongs to host's network is ok.
>>    But no migration test, because I don't have a spare machine for now.
>>    ./qemu-system-x86_64 -M q35 -m 1024 --enable-kvm
>>    -netdev tap,id=mynet0 -device vmxnet3,netdev=mynet0
>>    --monitor stdio /home/pino/vm/FedoraWorkStatsion23-x86_64.img
> 
> You could migrate to a new QEMU on the same machine.
> 
> Or, if you don't want to deal with two instances of QEMU running at the
> same time, migrate to file:
> 
>     (qemu) migrate "exec:cat >zzz"
> 
> Start the target with -incoming "exec:cat zzz".  Better than nothing.
> 

Thanks for the info, I will try

-- 
Sincerely,
Cao jin
