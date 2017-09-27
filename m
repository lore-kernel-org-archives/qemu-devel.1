Received: from eggs.gnu.org ([2001:4830:134:3::10]:55826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxFUv-0003c7-HN
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxFUs-0007mU-Am
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:47:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxFUs-0007m8-1c
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:47:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C455FC4656
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 16:47:40 +0000 (UTC)
Date: Wed, 27 Sep 2017 17:47:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170927164735.GE2108@work-vm>
References: <20170926230709.22958-1-ehabkost@redhat.com>
	<20170926230709.22958-7-ehabkost@redhat.com>
	<92296b86-9676-c4a8-cf54-537e3641609a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92296b86-9676-c4a8-cf54-537e3641609a@redhat.com>
Subject: Re: [Qemu-devel] [RFC 6/6] device-crash-test: Multi-device
 device_add test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

* Thomas Huth (thuth@redhat.com) wrote:
> On 27.09.2017 01:07, Eduardo Habkost wrote:
> > When running device_add tests, test all devices in a single run
> > instead of restarting QEMU every time.
> > 
> > There's a plug_all testcase argument that can be used to make the
> > test code plug all devices at once.  I'm adding this mode because
> > there's a crash that was detected while testing the script
> > without any device_del command, but the crash goes away if we
> > device_del every device immediately:
> > 
> >   $ ../scripts/device-crash-test ./x86_64-softmmu/qemu-system-x86_64 --quick -t method=device_add  --strict -t plug_all=1
> >   INFO: running test case: binary=./x86_64-softmmu/qemu-system-x86_64 plug_all=1 accel=kvm machine=pc-0.12 device=* method=device_add
> >   WARNING: qemu received signal -6: ./x86_64-softmmu/qemu-system-x86_64 -chardev socket,id=mon,path=/var/tmp/qemu-23578-monitor.sock -mon chardev=mon,mode=control -display none -vga none -S -machine pc-0.12,accel=kvm
> >   ERROR: result: binary=./x86_64-softmmu/qemu-system-x86_64 plug_all=1 accel=kvm machine=pc-0.12 device=* method=device_add
> >   ERROR: cmdline: ./x86_64-softmmu/qemu-system-x86_64 -S -machine pc-0.12,accel=kvm
> >   ERROR: log: audio: Could not init `oss' audio driver
> >   ERROR: log: qemu-system-x86_64: .../qemu/migration/savevm.c:721: vmstate_register_with_alias_id: Assertion `!se->compat || se->instance_id == 0' failed.
> >   ERROR: last device_add device: usb-net
> 
> FWIW, I've seen similar crashes while working on my HMP device_add
> tester, when I skipped the device_del and plugged-in the devices a
> couple of times instead. I think this happens because some devices are
> doing a vmstate_register() in their instance_init() or realize()
> function, instead of using dc->vmsd as they should. However, with the
> git master branch as of today (31bc1d8481af414cfa2857f905e), I am
> currently not able anymore to reproduce the problem with the HMP
> device_add tester, so one of the recent "set user_creatable = false"
> patches might have fixed the issue for me already...

I think I've seen this problem when two things end up trying to register
with the same migration name;  I'll be honest I can't remember the
details, but I think the choice is either between having a full bus
name, e.g.

    pci-xx:yy.z:aa:bb:.c:...... then similar for the USB chain

or
    mydevice  + number

where number is the instance=id.  So to hit this I think
it's typically a case of messing up that long path and it no
longer being unique.
Printing the path in vmstate_register_with_alias_id after the
pstrcat might help.
I did add some sanity checking in there for a case I'd
previously hit where the name just got truncated, but I don't
think you should be able to hit that any more.

Dave

>  Thomas
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
