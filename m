Received: from eggs.gnu.org ([2001:4830:134:3::10]:34646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXGSf-0001yl-Uu
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXGSb-0005jd-UB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:34:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dXGSb-0005jF-NJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:57 -0400
References: <DM2PR21MB0060B20A50AEEC8B6816154C9EA00@DM2PR21MB0060.namprd21.prod.outlook.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1263c0a6-263f-0b3b-c84a-f882df33856b@redhat.com>
Date: Mon, 17 Jul 2017 20:33:55 -0400
MIME-Version: 1.0
In-Reply-To: <DM2PR21MB0060B20A50AEEC8B6816154C9EA00@DM2PR21MB0060.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Disable image locking for snapshot drive?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>



On 07/17/2017 07:30 PM, Andrew Baumann via Qemu-devel wrote:
> Hi all,
> 
> I'm running a recent Linux build of qemu on Windows Subsystem for Linux (WSL) which doesn't appear to implement file locking:
> 
> $ qemu-system-aarch64 ... -drive file=test.vhdx,if=none,id=hd0 -device virtio-blk-pci,drive=hd0
> qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to unlock byte 100
> qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to unlock byte 100
> qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to lock byte 100
> 
> That's no big deal; I can switch it off:
> 
> $ qemu-system-aarch64 ... -drive file=test.vhdx,if=none,file.locking=off,id=hd0 ...
> (all good)
> 
> But how can I do the same for a snapshot drive?
> 
> $ qemu-system-aarch64 ... -drive file=test.vhdx,if=none,file.locking=off,id=hd0 -snapshot ...
> qemu-system-aarch64: -drive file=test.vhdx,if=none,file.locking=off,id=hd0: Failed to unlock byte 100
> qemu-system-aarch64: -drive file=test.vhdx,if=none,file.locking=off,id=hd0: Failed to unlock byte 100
> qemu-system-aarch64: -drive file=test.vhdx,if=none,file.locking=off,id=hd0: Could not create temporary overlay '/var/tmp/vl.o83dxn': Failed to lock byte 100
> 
> (I also tried the snapshot=on drive option with similar results.)
> 
> Thanks,
> Andrew
> 

Looks like the shorthand "-snapshot" doesn't let you specify any further
options, which is a bummer.

You may need to do something a little more manual, and create your own
temporary overlay, and launch QEMU pointing to that overlay instead.

That sounds like a bit of a hassle.

Can we compile locking support out of QEMU instead for this platform? Or
is there a runtime option for disabling it globally?
