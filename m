Received: from eggs.gnu.org ([2001:4830:134:3::10]:34201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <piotr.rybicki@innervision.pl>) id 1cmMib-0000GL-Uh
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <piotr.rybicki@innervision.pl>) id 1cmMiX-0000RY-4q
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:44:38 -0500
Received: from mail.iv.net.pl ([195.191.233.10]:44753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <piotr.rybicki@innervision.pl>)
	id 1cmMiW-0000Qv-BJ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:44:33 -0500
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
	<940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
	<9d6c61bc-4a95-ce72-3565-e498f9c2b351@redhat.com>
	<b815c2f9-1ce9-efed-4afa-c3553786dab1@redhat.com>
	<7829c1dc-9138-c784-dcc5-3c46ec9b5c05@innervision.pl>
	<20170310144928.h5ozia5cybxstuwc@eukaryote>
From: Piotr Rybicki <piotr.rybicki@innervision.pl>
Message-ID: <3181186b-cc3a-90c7-83ab-b3b85d9e6c7a@innervision.pl>
Date: Fri, 10 Mar 2017 16:44:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170310144928.h5ozia5cybxstuwc@eukaryote>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] external snapshots freezes block device since qemu
 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org



W dniu 2017-03-10 o 15:49, Kashyap Chamarthy pisze:
> On Thu, Mar 09, 2017 at 11:11:09AM +0100, Piotr Rybicki wrote:
>> Hello there.
>>
>> I discovered, that since qemu 2.8 , external snapshots (very similar to:
>> http://wiki.libvirt.org/page/Live-disk-backup-with-active-blockcommit),
> When I wrote this Wiki page, I tested it only with regular QCOW2 files
> on EXT4 file system.
It used to work very well with raw files on gluster via fuse. I've 
tested with local storage - it acts the same.

>
>> freezes block device after:
>>
>> # virsh blockcommit (...)
>>
>> There is no error message after completion of the command above.
>> I'm using gluster + ZFS fuse mount as a storage for a VM on gentoo.
>> libvirt debug showed nothing helpful.
>> With qemu <2.8 -: snapshots are working as expected.
>>
>> Is this a known issue?
>> Is it qemu or libvirt ?
>>
>> If it helps, how can i diagnose this further?a
> To see what libvirt is sending to QEMU, you can enable the debug log
> filters, which can give some clue:
>
> - In /etc/libvirt/libvirtd.conf, set these config attributes
>
>      log_filters="1:libvirt 1:qemu 1:conf 1:security 3:event 3:json 3:file 3:object 1:util"
>      log_outputs="1:file:/var/log/libvirt/libvirtd.log"
>
> - Restart libvirtd:
>
>      $ systemctl restart libvirtd
>
> - Perform your `blockcommit` test.
>
> PS: A gentle reminder -- when reporting upstream, you'll likely better
> help if you at least test with the latest releases (libvirt-3.1.0, and
> QEMU 2.8), if not from Git.
Thanks for pinting this out.

I've tried several libvirt versions, including latest 3.1.0
Qemu 2.7 / 2.7.1 works fine, only issue is at qemu 2.8 (git version is 
not usable right now - it crashes before i can start blockcommit)

Command complete successfully, but qemu is locked when accessing it's 
disks. For example - one cannot ssh into vm.

libvirtd.log:

2017-03-10 15:04:26.069+0000: 16381: debug : virIdentitySetAttr:248 : 
ident=0x7f4e08001660 attribute=7 value=C=PL,O=InnerVision Sp. z 
o.o.,L=Warszawa,ST=Mazowieckie,CN=adm
2017-03-10 15:04:26.069+0000: 16381: debug : virThreadJobSet:96 : Thread 
16381 (virNetServerHandleJob) is now running job remoteDispatchAuthList
2017-03-10 15:04:26.069+0000: 16381: debug : virThreadJobClear:121 : 
Thread 16381 (virNetServerHandleJob) finished job remoteDispatchAuthList 
with ret=0
2017-03-10 15:04:26.070+0000: 16379: debug : virThreadJobSet:96 : Thread 
16379 (virNetServerHandleJob) is now running job 
remoteDispatchConnectSupportsFeature
2017-03-10 15:04:26.070+0000: 16379: debug : virThreadJobClear:121 : 
Thread 16379 (virNetServerHandleJob) finished job 
remoteDispatchConnectSupportsFeature with ret=0
2017-03-10 15:04:26.071+0000: 16378: debug : virThreadJobSet:96 : Thread 
16378 (virNetServerHandleJob) is now running job remoteDispatchConnectOpen
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpen:1169 : 
name=qemu:///system
2017-03-10 15:04:26.071+0000: 16378: debug : virConfLoadConfig:1604 : 
Loading config file '/etc/libvirt/libvirt.conf'
2017-03-10 15:04:26.071+0000: 16378: debug : virConfReadFile:778 : 
filename=/etc/libvirt/libvirt.conf
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : virConfAddEntry:241 : Add 
entry (null) (nil)
2017-03-10 15:04:26.071+0000: 16378: debug : 
virConfGetValueStringList:981 : Get value string list (nil) 0
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1033 
: Split "qemu:///system" to URI components:
   scheme qemu
   server <null>
   user <null>
   port -1
   path /system
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1083 
: trying driver 0 (Test) ...
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1098 
: driver 0 Test returned DECLINED
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1083 
: trying driver 1 (VMWARE) ...
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1098 
: driver 1 VMWARE returned DECLINED
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1083 
: trying driver 2 (ESX) ...
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1098 
: driver 2 ESX returned DECLINED
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1083 
: trying driver 3 (remote) ...
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1098 
: driver 3 remote returned DECLINED
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1083 
: trying driver 4 (QEMU) ...
2017-03-10 15:04:26.071+0000: 16378: debug : virConnectOpenInternal:1098 
: driver 4 QEMU returned SUCCESS
2017-03-10 15:04:26.071+0000: 16378: debug : virThreadJobClear:121 : 
Thread 16378 (virNetServerHandleJob) finished job 
remoteDispatchConnectOpen with ret=0
2017-03-10 15:04:26.072+0000: 16380: debug : virThreadJobSet:96 : Thread 
16380 (virNetServerHandleJob) is now running job 
remoteDispatchConnectSupportsFeature
2017-03-10 15:04:26.072+0000: 16380: debug : virThreadJobClear:121 : 
Thread 16380 (virNetServerHandleJob) finished job 
remoteDispatchConnectSupportsFeature with ret=0
2017-03-10 15:04:26.072+0000: 16382: debug : virThreadJobSet:96 : Thread 
16382 (virNetServerHandleJob) is now running job 
remoteDispatchConnectSupportsFeature
2017-03-10 15:04:26.072+0000: 16382: debug : virThreadJobClear:121 : 
Thread 16382 (virNetServerHandleJob) finished job 
remoteDispatchConnectSupportsFeature with ret=0
2017-03-10 15:04:26.072+0000: 16381: debug : virThreadJobSet:96 : Thread 
16381 (virNetServerHandleJob) is now running job 
remoteDispatchConnectRegisterCloseCallback
2017-03-10 15:04:26.072+0000: 16381: debug : 
virConnectRegisterCloseCallback:1218 : conn=0x7f4e20002fe0
2017-03-10 15:04:26.072+0000: 16381: debug : virThreadJobClear:121 : 
Thread 16381 (virNetServerHandleJob) finished job 
remoteDispatchConnectRegisterCloseCallback with ret=0
2017-03-10 15:04:26.073+0000: 16379: debug : virThreadJobSet:96 : Thread 
16379 (virNetServerHandleJob) is now running job 
remoteDispatchDomainLookupByName
2017-03-10 15:04:26.073+0000: 16379: debug : virDomainLookupByName:416 : 
conn=0x7f4e20002fe0, name=ESBEK-tor1
2017-03-10 15:04:26.073+0000: 16379: debug : virThreadJobClear:121 : 
Thread 16379 (virNetServerHandleJob) finished job 
remoteDispatchDomainLookupByName with ret=0
2017-03-10 15:04:26.074+0000: 16378: debug : virThreadJobSet:96 : Thread 
16378 (virNetServerHandleJob) is now running job 
remoteDispatchConnectDomainEventCallbackRegisterAny
2017-03-10 15:04:26.074+0000: 16378: debug : 
virConnectDomainEventRegisterAny:9081 : dom=0x7f4e20002cd0, (VM: 
name=ESBEK-tor1, uuid=f40593c0-d196-bb4b-0886-f1b32f86c9a1), 
conn=0x7f4e20002fe0, eventID=8, cb=0x55ffc489d678, 
opaque=0x7f4e200035f0, freecb=0x55ffc489acf0
2017-03-10 15:04:26.074+0000: 16378: debug : 
virObjectEventCallbackListAddID:415 : conn=0x7f4e20002fe0 
cblist=0x7f4dd81a1060 key=0x7f4e287cbb00 filter=(nil) 
filter_opaque=(nil) klass=0x7f4ddc012ce0 eventID=8 
callback=0x55ffc489d678 opaque=0x7f4e200035f0 legacy=0 
callbackID=0x7f4e287cbb94 serverFilter=0
2017-03-10 15:04:26.074+0000: 16378: debug : virThreadJobClear:121 : 
Thread 16378 (virNetServerHandleJob) finished job 
remoteDispatchConnectDomainEventCallbackRegisterAny with ret=0
2017-03-10 15:04:26.074+0000: 16380: debug : virThreadJobSet:96 : Thread 
16380 (virNetServerHandleJob) is now running job 
remoteDispatchConnectDomainEventCallbackRegisterAny
2017-03-10 15:04:26.074+0000: 16380: debug : 
virConnectDomainEventRegisterAny:9081 : dom=0x7f4e10003210, (VM: 
name=ESBEK-tor1, uuid=f40593c0-d196-bb4b-0886-f1b32f86c9a1), 
conn=0x7f4e20002fe0, eventID=16, cb=0x55ffc489c8e0, 
opaque=0x7f4e10000cf0, freecb=0x55ffc489acf0
2017-03-10 15:04:26.074+0000: 16380: debug : 
virObjectEventCallbackListAddID:415 : conn=0x7f4e20002fe0 
cblist=0x7f4dd81a1060 key=0x7f4e277c9b00 filter=(nil) 
filter_opaque=(nil) klass=0x7f4ddc012ce0 eventID=16 
callback=0x55ffc489c8e0 opaque=0x7f4e10000cf0 legacy=0 
callbackID=0x7f4e277c9b94 serverFilter=0
2017-03-10 15:04:26.075+0000: 16380: debug : virThreadJobClear:121 : 
Thread 16380 (virNetServerHandleJob) finished job 
remoteDispatchConnectDomainEventCallbackRegisterAny with ret=0
2017-03-10 15:04:26.075+0000: 16382: debug : virThreadJobSet:96 : Thread 
16382 (virNetServerHandleJob) is now running job 
remoteDispatchDomainBlockCommit
2017-03-10 15:04:26.075+0000: 16382: debug : virDomainBlockCommit:10200 
: dom=0x7f4e00003310, (VM: name=ESBEK-tor1, 
uuid=f40593c0-d196-bb4b-0886-f1b32f86c9a1), disk=vda, base=<null>, 
top=<null>, bandwidth=0, flags=4
2017-03-10 15:04:26.075+0000: 16382: debug : 
qemuDomainObjBeginJobInternal:3412 : Starting job: modify 
(vm=0x7f4dd81fd3c0 name=ESBEK-tor1, current job=none async=none)
2017-03-10 15:04:26.075+0000: 16382: debug : 
qemuDomainObjBeginJobInternal:3453 : Started job: modify (async=none 
vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.075+0000: 16382: debug : qemuSetupImagePathCgroup:72 
: Allow path /data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img, perms: rw
2017-03-10 15:04:26.090+0000: 16382: debug : 
qemuDomainObjEnterMonitorInternal:3676 : Entering monitor 
(mon=0x7f4ddc000ec0 vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.090+0000: 16382: debug : 
qemuMonitorDiskNameLookup:3286 : mon:0x7f4ddc000ec0 vm:0x7f4dd81fd3c0 
json:1 fd:20
2017-03-10 15:04:26.090+0000: 16382: debug : 
qemuMonitorJSONCommandWithFd:296 : Send command 
'{"execute":"query-block","id":"libvirt-27"}' for write with FD -1
2017-03-10 15:04:26.090+0000: 16382: info : qemuMonitorSend:1009 : 
QEMU_MONITOR_SEND_MSG: mon=0x7f4ddc000ec0 
msg={"execute":"query-block","id":"libvirt-27"}
  fd=-1
2017-03-10 15:04:26.090+0000: 16377: info : qemuMonitorIOWrite:534 : 
QEMU_MONITOR_IO_WRITE: mon=0x7f4ddc000ec0 
buf={"execute":"query-block","id":"libvirt-27"}
  len=45 ret=45 errno=0
2017-03-10 15:04:26.093+0000: 16377: info : qemuMonitorIOProcess:429 : 
QEMU_MONITOR_IO_PROCESS: mon=0x7f4ddc000ec0 buf={"return": 
[{"io-status": "ok", "device": "drive-ide0-1-0", "locked": false, 
"removable": true, "tray_open": false, "type": "unknown"}, {"io-status": 
"ok", "device": "drive-virtio-disk0", "locked": false, "removable": 
false, "inserted": {"iops_rd": 1000, "detect_zeroes": "off", "image": 
{"backing-image": {"virtual-size": 10737418240, "filename": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "format": "raw", 
"actual-size": 1400521216, "dirty-flag": false}, 
"backing-filename-format": "raw", "virtual-size": 10737418240, 
"filename": "/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"cluster-size": 65536, "format": "qcow2", "actual-size": 29184, 
"format-specific": {"type": "qcow2", "data": {"compat": "1.1", 
"lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, 
"full-backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"dirty-flag": false}, "iops_wr": 1000, "group": "drive-virtio-disk0", 
"ro": false, "node-name len=1023
2017-03-10 15:04:26.093+0000: 16377: debug : 
qemuMonitorJSONIOProcess:260 : Total used 0 bytes out of 1023 available 
in buffer
2017-03-10 15:04:26.093+0000: 16377: info : qemuMonitorIOProcess:429 : 
QEMU_MONITOR_IO_PROCESS: mon=0x7f4ddc000ec0 buf={"return": 
[{"io-status": "ok", "device": "drive-ide0-1-0", "locked": false, 
"removable": true, "tray_open": false, "type": "unknown"}, {"io-status": 
"ok", "device": "drive-virtio-disk0", "locked": false, "removable": 
false, "inserted": {"iops_rd": 1000, "detect_zeroes": "off", "image": 
{"backing-image": {"virtual-size": 10737418240, "filename": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "format": "raw", 
"actual-size": 1400521216, "dirty-flag": false}, 
"backing-filename-format": "raw", "virtual-size": 10737418240, 
"filename": "/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"cluster-size": 65536, "format": "qcow2", "actual-size": 29184, 
"format-specific": {"type": "qcow2", "data": {"compat": "1.1", 
"lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, 
"full-backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"dirty-flag": false}, "iops_wr": 1000, "group": "drive-virtio-disk0", 
"ro": false, "node-name": "#block382", "bps_wr_max_length": 1, 
"backing_file_depth": 1, "iops_rd_max_length": 1, "bps_wr_max": 
10485760, "bps_rd_max_length": 1, "drv": "qcow2", "iops_rd_max": 100, 
"iops": 0, "bps_wr": 104857600, "bps_rd_max": 10485760, 
"write_threshold": 0, "backing_file": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "encrypted": false, 
"bps": 0, "bps_rd": 104857600, "cache": {"no-flush": false, "direct": 
false, "writeback": false}, "file": 
"/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"iops_wr_max_length": 1, "encryption_key_missing": false, "iops_wr_max": 
100}, "type": "unknown"}], "id": "libvirt-27"}
  len=1645
2017-03-10 15:04:26.093+0000: 16377: debug : 
qemuMonitorJSONIOProcessLine:191 : Line [{"return": [{"io-status": "ok", 
"device": "drive-ide0-1-0", "locked": false, "removable": true, 
"tray_open": false, "type": "unknown"}, {"io-status": "ok", "device": 
"drive-virtio-disk0", "locked": false, "removable": false, "inserted": 
{"iops_rd": 1000, "detect_zeroes": "off", "image": {"backing-image": 
{"virtual-size": 10737418240, "filename": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "format": "raw", 
"actual-size": 1400521216, "dirty-flag": false}, 
"backing-filename-format": "raw", "virtual-size": 10737418240, 
"filename": "/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"cluster-size": 65536, "format": "qcow2", "actual-size": 29184, 
"format-specific": {"type": "qcow2", "data": {"compat": "1.1", 
"lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, 
"full-backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"dirty-flag": false}, "iops_wr": 1000, "group": "drive-virtio-disk0", 
"ro": false, "node-name": "#block382", "bps_wr_max_length": 1, 
"backing_file_depth": 1, "iops_rd_max_length": 1, "bps_wr_max": 
10485760, "bps_rd_max_length": 1, "drv": "qcow2", "iops_rd_max": 100, 
"iops": 0, "bps_wr": 104857600, "bps_rd_max": 10485760, 
"write_threshold": 0, "backing_file": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "encrypted": false, 
"bps": 0, "bps_rd": 104857600, "cache": {"no-flush": false, "direct": 
false, "writeback": false}, "file": 
"/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"iops_wr_max_length": 1, "encryption_key_missing": false, "iops_wr_max": 
100}, "type": "unknown"}], "id": "libvirt-27"}]
2017-03-10 15:04:26.094+0000: 16377: info : 
qemuMonitorJSONIOProcessLine:211 : QEMU_MONITOR_RECV_REPLY: 
mon=0x7f4ddc000ec0 reply={"return": [{"io-status": "ok", "device": 
"drive-ide0-1-0", "locked": false, "removable": true, "tray_open": 
false, "type": "unknown"}, {"io-status": "ok", "device": 
"drive-virtio-disk0", "locked": false, "removable": false, "inserted": 
{"iops_rd": 1000, "detect_zeroes": "off", "image": {"backing-image": 
{"virtual-size": 10737418240, "filename": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "format": "raw", 
"actual-size": 1400521216, "dirty-flag": false}, 
"backing-filename-format": "raw", "virtual-size": 10737418240, 
"filename": "/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"cluster-size": 65536, "format": "qcow2", "actual-size": 29184, 
"format-specific": {"type": "qcow2", "data": {"compat": "1.1", 
"lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, 
"full-backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"dirty-flag": false}, "iops_wr": 1000, "group": "drive-virtio-disk0", 
"ro": false, "node-name": "#block382", "bps_wr_max_length": 1, 
"backing_file_depth": 1, "iops_rd_max_length": 1, "bps_wr_max": 
10485760, "bps_rd_max_length": 1, "drv": "qcow2", "iops_rd_max": 100, 
"iops": 0, "bps_wr": 104857600, "bps_rd_max": 10485760, 
"write_threshold": 0, "backing_file": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "encrypted": false, 
"bps": 0, "bps_rd": 104857600, "cache": {"no-flush": false, "direct": 
false, "writeback": false}, "file": 
"/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"iops_wr_max_length": 1, "encryption_key_missing": false, "iops_wr_max": 
100}, "type": "unknown"}], "id": "libvirt-27"}
2017-03-10 15:04:26.094+0000: 16377: debug : 
qemuMonitorJSONIOProcess:260 : Total used 1645 bytes out of 1645 
available in buffer
2017-03-10 15:04:26.094+0000: 16382: debug : 
qemuMonitorJSONCommandWithFd:301 : Receive command reply ret=0 
rxObject=0x55ffc58d0930
2017-03-10 15:04:26.094+0000: 16382: debug : 
qemuMonitorDiskNameLookup:3286 : mon:0x7f4ddc000ec0 vm:0x7f4dd81fd3c0 
json:1 fd:20
2017-03-10 15:04:26.094+0000: 16382: debug : 
qemuMonitorJSONCommandWithFd:296 : Send command 
'{"execute":"query-block","id":"libvirt-28"}' for write with FD -1
2017-03-10 15:04:26.094+0000: 16382: info : qemuMonitorSend:1009 : 
QEMU_MONITOR_SEND_MSG: mon=0x7f4ddc000ec0 
msg={"execute":"query-block","id":"libvirt-28"}
  fd=-1
2017-03-10 15:04:26.094+0000: 16377: info : qemuMonitorIOWrite:534 : 
QEMU_MONITOR_IO_WRITE: mon=0x7f4ddc000ec0 
buf={"execute":"query-block","id":"libvirt-28"}
  len=45 ret=45 errno=0
2017-03-10 15:04:26.096+0000: 16377: info : qemuMonitorIOProcess:429 : 
QEMU_MONITOR_IO_PROCESS: mon=0x7f4ddc000ec0 buf={"return": 
[{"io-status": "ok", "device": "drive-ide0-1-0", "locked": false, 
"removable": true, "tray_open": false, "type": "unknown"}, {"io-status": 
"ok", "device": "drive-virtio-disk0", "locked": false, "removable": 
false, "inserted": {"iops_rd": 1000, "detect_zeroes": "off", "image": 
{"backing-image": {"virtual-size": 10737418240, "filename": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "format": "raw", 
"actual-size": 1400521216, "dirty-flag": false}, 
"backing-filename-format": "raw", "virtual-size": 10737418240, 
"filename": "/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"cluster-size": 65536, "format": "qcow2", "actual-size": 29184, 
"format-specific": {"type": "qcow2", "data": {"compat": "1.1", 
"lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, 
"full-backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"dirty-flag": false}, "iops_wr": 1000, "group": "drive-virtio-disk0", 
"ro": false, "node-name len=1023
2017-03-10 15:04:26.096+0000: 16377: debug : 
qemuMonitorJSONIOProcess:260 : Total used 0 bytes out of 1023 available 
in buffer
2017-03-10 15:04:26.096+0000: 16377: info : qemuMonitorIOProcess:429 : 
QEMU_MONITOR_IO_PROCESS: mon=0x7f4ddc000ec0 buf={"return": 
[{"io-status": "ok", "device": "drive-ide0-1-0", "locked": false, 
"removable": true, "tray_open": false, "type": "unknown"}, {"io-status": 
"ok", "device": "drive-virtio-disk0", "locked": false, "removable": 
false, "inserted": {"iops_rd": 1000, "detect_zeroes": "off", "image": 
{"backing-image": {"virtual-size": 10737418240, "filename": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "format": "raw", 
"actual-size": 1400521216, "dirty-flag": false}, 
"backing-filename-format": "raw", "virtual-size": 10737418240, 
"filename": "/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"cluster-size": 65536, "format": "qcow2", "actual-size": 29184, 
"format-specific": {"type": "qcow2", "data": {"compat": "1.1", 
"lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, 
"full-backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"dirty-flag": false}, "iops_wr": 1000, "group": "drive-virtio-disk0", 
"ro": false, "node-name": "#block382", "bps_wr_max_length": 1, 
"backing_file_depth": 1, "iops_rd_max_length": 1, "bps_wr_max": 
10485760, "bps_rd_max_length": 1, "drv": "qcow2", "iops_rd_max": 100, 
"iops": 0, "bps_wr": 104857600, "bps_rd_max": 10485760, 
"write_threshold": 0, "backing_file": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "encrypted": false, 
"bps": 0, "bps_rd": 104857600, "cache": {"no-flush": false, "direct": 
false, "writeback": false}, "file": 
"/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"iops_wr_max_length": 1, "encryption_key_missing": false, "iops_wr_max": 
100}, "type": "unknown"}], "id": "libvirt-28"}
  len=1645
2017-03-10 15:04:26.096+0000: 16377: debug : 
qemuMonitorJSONIOProcessLine:191 : Line [{"return": [{"io-status": "ok", 
"device": "drive-ide0-1-0", "locked": false, "removable": true, 
"tray_open": false, "type": "unknown"}, {"io-status": "ok", "device": 
"drive-virtio-disk0", "locked": false, "removable": false, "inserted": 
{"iops_rd": 1000, "detect_zeroes": "off", "image": {"backing-image": 
{"virtual-size": 10737418240, "filename": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "format": "raw", 
"actual-size": 1400521216, "dirty-flag": false}, 
"backing-filename-format": "raw", "virtual-size": 10737418240, 
"filename": "/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"cluster-size": 65536, "format": "qcow2", "actual-size": 29184, 
"format-specific": {"type": "qcow2", "data": {"compat": "1.1", 
"lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, 
"full-backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"dirty-flag": false}, "iops_wr": 1000, "group": "drive-virtio-disk0", 
"ro": false, "node-name": "#block382", "bps_wr_max_length": 1, 
"backing_file_depth": 1, "iops_rd_max_length": 1, "bps_wr_max": 
10485760, "bps_rd_max_length": 1, "drv": "qcow2", "iops_rd_max": 100, 
"iops": 0, "bps_wr": 104857600, "bps_rd_max": 10485760, 
"write_threshold": 0, "backing_file": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "encrypted": false, 
"bps": 0, "bps_rd": 104857600, "cache": {"no-flush": false, "direct": 
false, "writeback": false}, "file": 
"/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"iops_wr_max_length": 1, "encryption_key_missing": false, "iops_wr_max": 
100}, "type": "unknown"}], "id": "libvirt-28"}]
2017-03-10 15:04:26.096+0000: 16377: info : 
qemuMonitorJSONIOProcessLine:211 : QEMU_MONITOR_RECV_REPLY: 
mon=0x7f4ddc000ec0 reply={"return": [{"io-status": "ok", "device": 
"drive-ide0-1-0", "locked": false, "removable": true, "tray_open": 
false, "type": "unknown"}, {"io-status": "ok", "device": 
"drive-virtio-disk0", "locked": false, "removable": false, "inserted": 
{"iops_rd": 1000, "detect_zeroes": "off", "image": {"backing-image": 
{"virtual-size": 10737418240, "filename": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "format": "raw", 
"actual-size": 1400521216, "dirty-flag": false}, 
"backing-filename-format": "raw", "virtual-size": 10737418240, 
"filename": "/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"cluster-size": 65536, "format": "qcow2", "actual-size": 29184, 
"format-specific": {"type": "qcow2", "data": {"compat": "1.1", 
"lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, 
"full-backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"backing-filename": "/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", 
"dirty-flag": false}, "iops_wr": 1000, "group": "drive-virtio-disk0", 
"ro": false, "node-name": "#block382", "bps_wr_max_length": 1, 
"backing_file_depth": 1, "iops_rd_max_length": 1, "bps_wr_max": 
10485760, "bps_rd_max_length": 1, "drv": "qcow2", "iops_rd_max": 100, 
"iops": 0, "bps_wr": 104857600, "bps_rd_max": 10485760, 
"write_threshold": 0, "backing_file": 
"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img", "encrypted": false, 
"bps": 0, "bps_rd": 104857600, "cache": {"no-flush": false, "direct": 
false, "writeback": false}, "file": 
"/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2", 
"iops_wr_max_length": 1, "encryption_key_missing": false, "iops_wr_max": 
100}, "type": "unknown"}], "id": "libvirt-28"}
2017-03-10 15:04:26.096+0000: 16377: debug : 
qemuMonitorJSONIOProcess:260 : Total used 1645 bytes out of 1645 
available in buffer
2017-03-10 15:04:26.096+0000: 16382: debug : 
qemuMonitorJSONCommandWithFd:301 : Receive command reply ret=0 
rxObject=0x55ffc58d0930
2017-03-10 15:04:26.097+0000: 16382: debug : qemuMonitorBlockCommit:3258 
: device=drive-virtio-disk0, 
top=/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2, 
base=/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img, backingName=<null>, 
bandwidth=0
2017-03-10 15:04:26.097+0000: 16382: debug : qemuMonitorBlockCommit:3260 
: mon:0x7f4ddc000ec0 vm:0x7f4dd81fd3c0 json:1 fd:20
2017-03-10 15:04:26.097+0000: 16382: debug : 
qemuMonitorJSONCommandWithFd:296 : Send command 
'{"execute":"block-commit","arguments":{"device":"drive-virtio-disk0","top":"/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2","base":"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img"},"id":"libvirt-29"}' 
for write with FD -1
2017-03-10 15:04:26.097+0000: 16382: info : qemuMonitorSend:1009 : 
QEMU_MONITOR_SEND_MSG: mon=0x7f4ddc000ec0 
msg={"execute":"block-commit","arguments":{"device":"drive-virtio-disk0","top":"/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2","base":"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img"},"id":"libvirt-29"}
  fd=-1
2017-03-10 15:04:26.097+0000: 16377: info : qemuMonitorIOWrite:534 : 
QEMU_MONITOR_IO_WRITE: mon=0x7f4ddc000ec0 
buf={"execute":"block-commit","arguments":{"device":"drive-virtio-disk0","top":"/data/volumes/pool2/ESBEK/snap/ESBEK-tor1-sys.img.qcow2","base":"/data/volumes/pool2/ESBEK/ESBEK-tor1-sys.img"},"id":"libvirt-29"}
  len=208 ret=208 errno=0
2017-03-10 15:04:26.110+0000: 16377: info : qemuMonitorIOProcess:429 : 
QEMU_MONITOR_IO_PROCESS: mon=0x7f4ddc000ec0 buf={"return": {}, "id": 
"libvirt-29"}
  len=36
2017-03-10 15:04:26.110+0000: 16377: debug : 
qemuMonitorJSONIOProcessLine:191 : Line [{"return": {}, "id": "libvirt-29"}]
2017-03-10 15:04:26.110+0000: 16377: info : 
qemuMonitorJSONIOProcessLine:211 : QEMU_MONITOR_RECV_REPLY: 
mon=0x7f4ddc000ec0 reply={"return": {}, "id": "libvirt-29"}
2017-03-10 15:04:26.110+0000: 16377: debug : 
qemuMonitorJSONIOProcess:260 : Total used 36 bytes out of 36 available 
in buffer
2017-03-10 15:04:26.110+0000: 16382: debug : 
qemuMonitorJSONCommandWithFd:301 : Receive command reply ret=0 
rxObject=0x55ffc58d0930
2017-03-10 15:04:26.110+0000: 16382: debug : 
qemuDomainObjExitMonitorInternal:3699 : Exited monitor 
(mon=0x7f4ddc000ec0 vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.111+0000: 16382: debug : qemuDomainObjEndJob:3607 : 
Stopping job: modify (async=none vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.111+0000: 16382: debug : virThreadJobClear:121 : 
Thread 16382 (virNetServerHandleJob) finished job 
remoteDispatchDomainBlockCommit with ret=0
2017-03-10 15:04:26.111+0000: 16381: debug : virThreadJobSet:96 : Thread 
16381 (virNetServerHandleJob) is now running job 
remoteDispatchDomainGetBlockJobInfo
2017-03-10 15:04:26.111+0000: 16381: debug : 
virDomainGetBlockJobInfo:9654 : dom=0x7f4e08000e70, (VM: 
name=ESBEK-tor1, uuid=f40593c0-d196-bb4b-0886-f1b32f86c9a1), disk=vda, 
info=0x7f4e26fc8c70, flags=0
2017-03-10 15:04:26.111+0000: 16381: debug : 
qemuDomainObjBeginJobInternal:3412 : Starting job: query 
(vm=0x7f4dd81fd3c0 name=ESBEK-tor1, current job=none async=none)
2017-03-10 15:04:26.111+0000: 16381: debug : 
qemuDomainObjBeginJobInternal:3453 : Started job: query (async=none 
vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.111+0000: 16381: debug : 
qemuDomainObjEnterMonitorInternal:3676 : Entering monitor 
(mon=0x7f4ddc000ec0 vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.111+0000: 16381: debug : 
qemuMonitorGetBlockJobInfo:3434 : alias=virtio-disk0, info=0x7f4e26fc8b90
2017-03-10 15:04:26.111+0000: 16381: debug : 
qemuMonitorGetAllBlockJobInfo:3415 : mon:0x7f4ddc000ec0 
vm:0x7f4dd81fd3c0 json:1 fd:20
2017-03-10 15:04:26.111+0000: 16381: debug : 
qemuMonitorJSONCommandWithFd:296 : Send command 
'{"execute":"query-block-jobs","id":"libvirt-30"}' for write with FD -1
2017-03-10 15:04:26.111+0000: 16381: info : qemuMonitorSend:1009 : 
QEMU_MONITOR_SEND_MSG: mon=0x7f4ddc000ec0 
msg={"execute":"query-block-jobs","id":"libvirt-30"}
  fd=-1
2017-03-10 15:04:26.111+0000: 16377: info : qemuMonitorIOWrite:534 : 
QEMU_MONITOR_IO_WRITE: mon=0x7f4ddc000ec0 
buf={"execute":"query-block-jobs","id":"libvirt-30"}
  len=50 ret=50 errno=0
2017-03-10 15:04:26.115+0000: 16377: info : qemuMonitorIOProcess:429 : 
QEMU_MONITOR_IO_PROCESS: mon=0x7f4ddc000ec0 buf={"timestamp": 
{"seconds": 1489158266, "microseconds": 115061}, "event": 
"BLOCK_JOB_READY", "data": {"device": "drive-virtio-disk0", "len": 
65536, "offset": 65536, "speed": 0, "type": "commit"}}
  len=195
2017-03-10 15:04:26.115+0000: 16377: debug : 
qemuMonitorJSONIOProcessLine:191 : Line [{"timestamp": {"seconds": 
1489158266, "microseconds": 115061}, "event": "BLOCK_JOB_READY", "data": 
{"device": "drive-virtio-disk0", "len": 65536, "offset": 65536, "speed": 
0, "type": "commit"}}]
2017-03-10 15:04:26.115+0000: 16377: info : 
qemuMonitorJSONIOProcessLine:206 : QEMU_MONITOR_RECV_EVENT: 
mon=0x7f4ddc000ec0 event={"timestamp": {"seconds": 1489158266, 
"microseconds": 115061}, "event": "BLOCK_JOB_READY", "data": {"device": 
"drive-virtio-disk0", "len": 65536, "offset": 65536, "speed": 0, "type": 
"commit"}}
2017-03-10 15:04:26.115+0000: 16377: debug : 
qemuMonitorJSONIOProcessEvent:152 : mon=0x7f4ddc000ec0 obj=0x55ffc58d7e20
2017-03-10 15:04:26.115+0000: 16377: debug : qemuMonitorEmitEvent:1272 : 
mon=0x7f4ddc000ec0 event=BLOCK_JOB_READY
2017-03-10 15:04:26.115+0000: 16377: debug : qemuProcessHandleEvent:617 
: vm=0x7f4dd81fd3c0
2017-03-10 15:04:26.115+0000: 16377: debug : virObjectEventNew:640 : 
obj=0x55ffc58d0760
2017-03-10 15:04:26.115+0000: 16377: debug : 
qemuMonitorJSONIOProcessEvent:177 : handle BLOCK_JOB_READY 
handler=0x7f4e1cd3aed0 data=0x55ffc58d8d50
2017-03-10 15:04:26.115+0000: 16377: debug : 
qemuMonitorEmitBlockJob:1464 : mon=0x7f4ddc000ec0
2017-03-10 15:04:26.115+0000: 16377: debug : 
qemuProcessHandleBlockJob:976 : Block job for device drive-virtio-disk0 
(domain: 0x7f4dd81fd3c0,ESBEK-tor1) type 3 status 3
2017-03-10 15:04:26.115+0000: 16377: debug : 
qemuMonitorJSONIOProcess:260 : Total used 195 bytes out of 195 available 
in buffer
2017-03-10 15:04:26.115+0000: 16377: debug : virObjectEventDispose:134 : 
obj=0x55ffc58d0760
2017-03-10 15:04:26.115+0000: 16377: info : qemuMonitorIOProcess:429 : 
QEMU_MONITOR_IO_PROCESS: mon=0x7f4ddc000ec0 buf={"return": 
[{"io-status": "ok", "device": "drive-virtio-disk0", "busy": false, 
"len": 65536, "offset": 65536, "paused": false, "speed": 0, "ready": 
true, "type": "commit"}], "id": "libvirt-30"}
  len=195
2017-03-10 15:04:26.115+0000: 16377: debug : 
qemuMonitorJSONIOProcessLine:191 : Line [{"return": [{"io-status": "ok", 
"device": "drive-virtio-disk0", "busy": false, "len": 65536, "offset": 
65536, "paused": false, "speed": 0, "ready": true, "type": "commit"}], 
"id": "libvirt-30"}]
2017-03-10 15:04:26.115+0000: 16377: info : 
qemuMonitorJSONIOProcessLine:211 : QEMU_MONITOR_RECV_REPLY: 
mon=0x7f4ddc000ec0 reply={"return": [{"io-status": "ok", "device": 
"drive-virtio-disk0", "busy": false, "len": 65536, "offset": 65536, 
"paused": false, "speed": 0, "ready": true, "type": "commit"}], "id": 
"libvirt-30"}
2017-03-10 15:04:26.115+0000: 16377: debug : 
qemuMonitorJSONIOProcess:260 : Total used 195 bytes out of 195 available 
in buffer
2017-03-10 15:04:26.115+0000: 19721: debug : virThreadJobSetWorker:77 : 
Thread 19721 is running worker qemuProcessEventHandler
2017-03-10 15:04:26.116+0000: 16381: debug : 
qemuMonitorJSONCommandWithFd:301 : Receive command reply ret=0 
rxObject=0x55ffc58d7e20
2017-03-10 15:04:26.116+0000: 19721: debug : 
qemuProcessEventHandler:4579 : vm=0x7f4dd81fd3c0, event=5
2017-03-10 15:04:26.116+0000: 19721: debug : 
qemuDomainObjBeginJobInternal:3412 : Starting job: modify 
(vm=0x7f4dd81fd3c0 name=ESBEK-tor1, current job=query async=none)
2017-03-10 15:04:26.116+0000: 19721: debug : 
qemuDomainObjBeginJobInternal:3435 : Waiting for job (vm=0x7f4dd81fd3c0 
name=ESBEK-tor1)
2017-03-10 15:04:26.116+0000: 16381: debug : 
qemuDomainObjExitMonitorInternal:3699 : Exited monitor 
(mon=0x7f4ddc000ec0 vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.116+0000: 16381: debug : qemuDomainObjEndJob:3607 : 
Stopping job: query (async=none vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.116+0000: 19721: debug : 
qemuDomainObjBeginJobInternal:3453 : Started job: modify (async=none 
vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.116+0000: 16381: debug : virThreadJobClear:121 : 
Thread 16381 (virNetServerHandleJob) finished job 
remoteDispatchDomainGetBlockJobInfo with ret=0
2017-03-10 15:04:26.117+0000: 19721: debug : 
qemuBlockJobEventProcess:104 : disk=vda, mirrorState=yes, type=3, status=3
2017-03-10 15:04:26.117+0000: 19721: debug : virObjectEventNew:640 : 
obj=0x7f4ddc013480
2017-03-10 15:04:26.117+0000: 19721: debug : virObjectEventNew:640 : 
obj=0x7f4ddc012970
2017-03-10 15:04:26.117+0000: 19721: debug : qemuDomainObjEndJob:3607 : 
Stopping job: modify (async=none vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.117+0000: 16377: debug : virObjectEventDispose:134 : 
obj=0x7f4ddc013480
2017-03-10 15:04:26.117+0000: 16377: debug : virObjectEventDispose:134 : 
obj=0x7f4ddc012970
2017-03-10 15:04:26.617+0000: 16379: debug : virThreadJobSet:96 : Thread 
16379 (virNetServerHandleJob) is now running job 
remoteDispatchDomainGetBlockJobInfo
2017-03-10 15:04:26.617+0000: 16379: debug : 
virDomainGetBlockJobInfo:9654 : dom=0x7f4e18000b60, (VM: 
name=ESBEK-tor1, uuid=f40593c0-d196-bb4b-0886-f1b32f86c9a1), disk=vda, 
info=0x7f4e27fcac70, flags=0
2017-03-10 15:04:26.617+0000: 16379: debug : 
qemuDomainObjBeginJobInternal:3412 : Starting job: query 
(vm=0x7f4dd81fd3c0 name=ESBEK-tor1, current job=none async=none)
2017-03-10 15:04:26.617+0000: 16379: debug : 
qemuDomainObjBeginJobInternal:3453 : Started job: query (async=none 
vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.617+0000: 16379: debug : 
qemuDomainObjEnterMonitorInternal:3676 : Entering monitor 
(mon=0x7f4ddc000ec0 vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.617+0000: 16379: debug : 
qemuMonitorGetBlockJobInfo:3434 : alias=virtio-disk0, info=0x7f4e27fcab90
2017-03-10 15:04:26.617+0000: 16379: debug : 
qemuMonitorGetAllBlockJobInfo:3415 : mon:0x7f4ddc000ec0 
vm:0x7f4dd81fd3c0 json:1 fd:20
2017-03-10 15:04:26.617+0000: 16379: debug : 
qemuMonitorJSONCommandWithFd:296 : Send command 
'{"execute":"query-block-jobs","id":"libvirt-31"}' for write with FD -1
2017-03-10 15:04:26.617+0000: 16379: info : qemuMonitorSend:1009 : 
QEMU_MONITOR_SEND_MSG: mon=0x7f4ddc000ec0 
msg={"execute":"query-block-jobs","id":"libvirt-31"}
  fd=-1
2017-03-10 15:04:26.618+0000: 16377: info : qemuMonitorIOWrite:534 : 
QEMU_MONITOR_IO_WRITE: mon=0x7f4ddc000ec0 
buf={"execute":"query-block-jobs","id":"libvirt-31"}
  len=50 ret=50 errno=0
2017-03-10 15:04:26.619+0000: 16377: info : qemuMonitorIOProcess:429 : 
QEMU_MONITOR_IO_PROCESS: mon=0x7f4ddc000ec0 buf={"return": 
[{"io-status": "ok", "device": "drive-virtio-disk0", "busy": false, 
"len": 65536, "offset": 65536, "paused": false, "speed": 0, "ready": 
true, "type": "commit"}], "id": "libvirt-31"}
  len=195
2017-03-10 15:04:26.619+0000: 16377: debug : 
qemuMonitorJSONIOProcessLine:191 : Line [{"return": [{"io-status": "ok", 
"device": "drive-virtio-disk0", "busy": false, "len": 65536, "offset": 
65536, "paused": false, "speed": 0, "ready": true, "type": "commit"}], 
"id": "libvirt-31"}]
2017-03-10 15:04:26.619+0000: 16377: info : 
qemuMonitorJSONIOProcessLine:211 : QEMU_MONITOR_RECV_REPLY: 
mon=0x7f4ddc000ec0 reply={"return": [{"io-status": "ok", "device": 
"drive-virtio-disk0", "busy": false, "len": 65536, "offset": 65536, 
"paused": false, "speed": 0, "ready": true, "type": "commit"}], "id": 
"libvirt-31"}
2017-03-10 15:04:26.619+0000: 16377: debug : 
qemuMonitorJSONIOProcess:260 : Total used 195 bytes out of 195 available 
in buffer
2017-03-10 15:04:26.620+0000: 16379: debug : 
qemuMonitorJSONCommandWithFd:301 : Receive command reply ret=0 
rxObject=0x55ffc58d8e00
2017-03-10 15:04:26.620+0000: 16379: debug : 
qemuDomainObjExitMonitorInternal:3699 : Exited monitor 
(mon=0x7f4ddc000ec0 vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.620+0000: 16379: debug : qemuDomainObjEndJob:3607 : 
Stopping job: query (async=none vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.620+0000: 16379: debug : virThreadJobClear:121 : 
Thread 16379 (virNetServerHandleJob) finished job 
remoteDispatchDomainGetBlockJobInfo with ret=0
2017-03-10 15:04:26.620+0000: 16378: debug : virThreadJobSet:96 : Thread 
16378 (virNetServerHandleJob) is now running job 
remoteDispatchDomainBlockJobAbort
2017-03-10 15:04:26.620+0000: 16378: debug : virDomainBlockJobAbort:9592 
: dom=0x7f4e20001040, (VM: name=ESBEK-tor1, 
uuid=f40593c0-d196-bb4b-0886-f1b32f86c9a1), disk=vda, flags=2
2017-03-10 15:04:26.620+0000: 16378: debug : 
qemuDomainObjBeginJobInternal:3412 : Starting job: modify 
(vm=0x7f4dd81fd3c0 name=ESBEK-tor1, current job=none async=none)
2017-03-10 15:04:26.620+0000: 16378: debug : 
qemuDomainObjBeginJobInternal:3453 : Started job: modify (async=none 
vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.620+0000: 16378: debug : qemuBlockJobSyncBegin:230 : 
disk=vda
2017-03-10 15:04:26.620+0000: 16378: debug : 
qemuDomainObjEnterMonitorInternal:3676 : Entering monitor 
(mon=0x7f4ddc000ec0 vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.620+0000: 16378: debug : qemuMonitorDrivePivot:3297 
: device=drive-virtio-disk0
2017-03-10 15:04:26.620+0000: 16378: debug : qemuMonitorDrivePivot:3299 
: mon:0x7f4ddc000ec0 vm:0x7f4dd81fd3c0 json:1 fd:20
2017-03-10 15:04:26.620+0000: 16378: debug : 
qemuMonitorJSONCommandWithFd:296 : Send command 
'{"execute":"block-job-complete","arguments":{"device":"drive-virtio-disk0"},"id":"libvirt-32"}' 
for write with FD -1
2017-03-10 15:04:26.620+0000: 16378: info : qemuMonitorSend:1009 : 
QEMU_MONITOR_SEND_MSG: mon=0x7f4ddc000ec0 
msg={"execute":"block-job-complete","arguments":{"device":"drive-virtio-disk0"},"id":"libvirt-32"}
  fd=-1
2017-03-10 15:04:26.621+0000: 16377: info : qemuMonitorIOWrite:534 : 
QEMU_MONITOR_IO_WRITE: mon=0x7f4ddc000ec0 
buf={"execute":"block-job-complete","arguments":{"device":"drive-virtio-disk0"},"id":"libvirt-32"}
  len=96 ret=96 errno=0
2017-03-10 15:04:26.624+0000: 16377: info : qemuMonitorIOProcess:429 : 
QEMU_MONITOR_IO_PROCESS: mon=0x7f4ddc000ec0 buf={"return": {}, "id": 
"libvirt-32"}
  len=36
2017-03-10 15:04:26.624+0000: 16377: debug : 
qemuMonitorJSONIOProcessLine:191 : Line [{"return": {}, "id": "libvirt-32"}]
2017-03-10 15:04:26.624+0000: 16377: info : 
qemuMonitorJSONIOProcessLine:211 : QEMU_MONITOR_RECV_REPLY: 
mon=0x7f4ddc000ec0 reply={"return": {}, "id": "libvirt-32"}
2017-03-10 15:04:26.624+0000: 16377: debug : 
qemuMonitorJSONIOProcess:260 : Total used 36 bytes out of 36 available 
in buffer
2017-03-10 15:04:26.624+0000: 16378: debug : 
qemuMonitorJSONCommandWithFd:301 : Receive command reply ret=0 
rxObject=0x55ffc58d7e20
2017-03-10 15:04:26.624+0000: 16378: debug : 
qemuDomainObjExitMonitorInternal:3699 : Exited monitor 
(mon=0x7f4ddc000ec0 vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.624+0000: 16377: info : qemuMonitorIOProcess:429 : 
QEMU_MONITOR_IO_PROCESS: mon=0x7f4ddc000ec0 buf={"timestamp": 
{"seconds": 1489158266, "microseconds": 624625}, "event": 
"BLOCK_JOB_COMPLETED", "data": {"device": "drive-virtio-disk0", "len": 
65536, "offset": 65536, "speed": 0, "type": "commit"}}
  len=199
2017-03-10 15:04:26.624+0000: 16377: debug : 
qemuMonitorJSONIOProcessLine:191 : Line [{"timestamp": {"seconds": 
1489158266, "microseconds": 624625}, "event": "BLOCK_JOB_COMPLETED", 
"data": {"device": "drive-virtio-disk0", "len": 65536, "offset": 65536, 
"speed": 0, "type": "commit"}}]
2017-03-10 15:04:26.624+0000: 16377: info : 
qemuMonitorJSONIOProcessLine:206 : QEMU_MONITOR_RECV_EVENT: 
mon=0x7f4ddc000ec0 event={"timestamp": {"seconds": 1489158266, 
"microseconds": 624625}, "event": "BLOCK_JOB_COMPLETED", "data": 
{"device": "drive-virtio-disk0", "len": 65536, "offset": 65536, "speed": 
0, "type": "commit"}}
2017-03-10 15:04:26.624+0000: 16377: debug : 
qemuMonitorJSONIOProcessEvent:152 : mon=0x7f4ddc000ec0 obj=0x55ffc58d7e20
2017-03-10 15:04:26.624+0000: 16377: debug : qemuMonitorEmitEvent:1272 : 
mon=0x7f4ddc000ec0 event=BLOCK_JOB_COMPLETED
2017-03-10 15:04:26.624+0000: 16377: debug : qemuProcessHandleEvent:617 
: vm=0x7f4dd81fd3c0
2017-03-10 15:04:26.624+0000: 16377: debug : virObjectEventNew:640 : 
obj=0x55ffc58d0760
2017-03-10 15:04:26.624+0000: 16377: debug : 
qemuMonitorJSONIOProcessEvent:177 : handle BLOCK_JOB_COMPLETED 
handler=0x7f4e1cd3aee0 data=0x55ffc58d8d50
2017-03-10 15:04:26.624+0000: 16377: debug : 
qemuMonitorEmitBlockJob:1464 : mon=0x7f4ddc000ec0
2017-03-10 15:04:26.624+0000: 16377: debug : 
qemuProcessHandleBlockJob:976 : Block job for device drive-virtio-disk0 
(domain: 0x7f4dd81fd3c0,ESBEK-tor1) type 3 status 0
2017-03-10 15:04:26.624+0000: 16377: debug : 
qemuMonitorJSONIOProcess:260 : Total used 199 bytes out of 199 available 
in buffer
2017-03-10 15:04:26.624+0000: 16378: debug : 
qemuBlockJobEventProcess:104 : disk=vda, mirrorState=pivot, type=3, status=0
2017-03-10 15:04:26.624+0000: 16377: debug : virObjectEventDispose:134 : 
obj=0x55ffc58d0760
2017-03-10 15:04:26.625+0000: 16378: debug : virObjectEventNew:640 : 
obj=0x7f4e200008e0
2017-03-10 15:04:26.625+0000: 16378: debug : virObjectEventNew:640 : 
obj=0x7f4e200032d0
2017-03-10 15:04:26.653+0000: 16378: debug : qemuBlockJobSyncEnd:250 : 
disk=vda
2017-03-10 15:04:26.653+0000: 16378: debug : qemuDomainObjEndJob:3607 : 
Stopping job: modify (async=none vm=0x7f4dd81fd3c0 name=ESBEK-tor1)
2017-03-10 15:04:26.653+0000: 16378: debug : virThreadJobClear:121 : 
Thread 16378 (virNetServerHandleJob) finished job 
remoteDispatchDomainBlockJobAbort with ret=0
2017-03-10 15:04:26.653+0000: 16377: debug : virObjectEventDispose:134 : 
obj=0x7f4e200008e0
2017-03-10 15:04:26.653+0000: 16377: debug : virObjectEventDispose:134 : 
obj=0x7f4e200032d0
2017-03-10 15:04:26.654+0000: 16380: debug : virThreadJobSet:96 : Thread 
16380 (virNetServerHandleJob) is now running job 
remoteDispatchConnectDomainEventCallbackDeregisterAny
2017-03-10 15:04:26.654+0000: 16380: debug : 
virConnectDomainEventDeregisterAny:9134 : conn=0x7f4e20002fe0, callbackID=0
2017-03-10 15:04:26.654+0000: 16380: debug : virThreadJobClear:121 : 
Thread 16380 (virNetServerHandleJob) finished job 
remoteDispatchConnectDomainEventCallbackDeregisterAny with ret=0
2017-03-10 15:04:26.655+0000: 16382: debug : virThreadJobSet:96 : Thread 
16382 (virNetServerHandleJob) is now running job 
remoteDispatchConnectDomainEventCallbackDeregisterAny
2017-03-10 15:04:26.655+0000: 16382: debug : 
virConnectDomainEventDeregisterAny:9134 : conn=0x7f4e20002fe0, callbackID=1
2017-03-10 15:04:26.655+0000: 16382: debug : virThreadJobClear:121 : 
Thread 16382 (virNetServerHandleJob) finished job 
remoteDispatchConnectDomainEventCallbackDeregisterAny with ret=0
2017-03-10 15:04:26.655+0000: 16381: debug : virThreadJobSet:96 : Thread 
16381 (virNetServerHandleJob) is now running job 
remoteDispatchConnectUnregisterCloseCallback
2017-03-10 15:04:26.655+0000: 16381: debug : 
virConnectUnregisterCloseCallback:1253 : conn=0x7f4e20002fe0
2017-03-10 15:04:26.655+0000: 16381: debug : virThreadJobClear:121 : 
Thread 16381 (virNetServerHandleJob) finished job 
remoteDispatchConnectUnregisterCloseCallback with ret=0
2017-03-10 15:04:26.656+0000: 16379: debug : virThreadJobSet:96 : Thread 
16379 (virNetServerHandleJob) is now running job remoteDispatchConnectClose
2017-03-10 15:04:26.656+0000: 16379: debug : virThreadJobClear:121 : 
Thread 16379 (virNetServerHandleJob) finished job 
remoteDispatchConnectClose with ret=0
2017-03-10 15:04:26.656+0000: 16377: debug : virIdentitySetAttr:248 : 
ident=0x55ffc58d17e0 attribute=4 value=16377
2017-03-10 15:04:26.656+0000: 16377: debug : virIdentitySetAttr:248 : 
ident=0x55ffc58d17e0 attribute=5 value=759159
2017-03-10 15:04:26.656+0000: 16377: debug : virIdentitySetAttr:248 : 
ident=0x55ffc58d17e0 attribute=0 value=root
2017-03-10 15:04:26.656+0000: 16377: debug : virIdentitySetAttr:248 : 
ident=0x55ffc58d17e0 attribute=1 value=0
2017-03-10 15:04:26.656+0000: 16377: debug : virIdentitySetAttr:248 : 
ident=0x55ffc58d17e0 attribute=2 value=root
2017-03-10 15:04:26.656+0000: 16377: debug : virIdentitySetAttr:248 : 
ident=0x55ffc58d17e0 attribute=3 value=0
2017-03-10 15:04:26.656+0000: 16377: debug : virConnectClose:1290 : 
conn=0x7f4e20002fe0
2017-03-10 15:04:26.656+0000: 16377: debug : virCloseCallbacksRun:325 : 
conn=0x7f4e20002fe0


Best regards
Piotr Rybicki
