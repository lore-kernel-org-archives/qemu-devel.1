Received: from eggs.gnu.org ([2001:4830:134:3::10]:36289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cr95i-00083V-GN
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cr95f-0005HI-AW
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:12:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cr95f-0005GU-2V
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:12:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 670E32E6067
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:12:09 +0000 (UTC)
Date: Thu, 23 Mar 2017 17:12:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170323201203.GA28530@thinpad.lan.raisama.net>
References: <20170322160052.2820-1-ehabkost@redhat.com>
	<20170322191305.GO2811@thinpad.lan.raisama.net>
	<38285f0d-bcb3-e0cd-6bf7-037e81f07b0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38285f0d-bcb3-e0cd-6bf7-037e81f07b0f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] script for crash-testing -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Thu, Mar 23, 2017 at 04:43:01PM +0100, Thomas Huth wrote:
> On 22.03.2017 20:13, Eduardo Habkost wrote:
> > On Wed, Mar 22, 2017 at 01:00:49PM -0300, Eduardo Habkost wrote:
> >> This series adds scripts/device-crashtest.py, that can be used to
> >> crash-test -device with multiple machine/accel/device
> >> combinations.
> >>
> >> The script found a few crashes on some machines/devices. A dump
> >> of existing cases can be seen here:
> >>   https://gist.github.com/ehabkost/503b0af0375f0d98d3e84017e8ca54eb
> >>
> >> The script contains a whitelist that can also be useful as
> >> documentation of existing ways -device can fail or crash.
> >>
> >> Note that the script takes a few hours to run on the default mode
> >> (testing all accel/machine/device combinations), but the "-r N"
> >> option can be used to make it only test N random samples.
> 
> Wow, impressive script, that must have been a lot of work 'til you've
> got it in a usable shape with that huge whitelist!
> 
> > Something I forgot to mention: I would like to run some subset of
> > these tests on "make check", but I don't know how we could choose
> > that subset. We could run, e.g., 100 random samples, but I am not
> > sure we really want to make "make check" non-deterministic.
> 
> Maybe limit the tests to the devices that have a high chance to work on
> different machines? ... that means primarily PCI, ISA and USB devices, I
> guess.

On the other hand, I believe the remaining devices are the ones
most likely to crash machines unexpectedly...

For reference, these are the numbers when trying to test every
single machine type:

Total: 89321 test cases
pci: 27749 test cases
usb: 5125 test cases
isa: 3948 test cases

>From those 89k test cases, 67k fail (cleanly). The top reasons they fail are:

Count | Whitelist entry
------+------------------------------------------------------------------------
20681 | {'log': "No '[\\w-]+' bus found for device '[\\w-]+'"}
13076 | {'log': "Option '-device [\\w.,-]+' cannot be handled by this machine"}
 4821 | {'log': '(Guest|ROM|Flash|Kernel) image must be specified'}
 4096 | {'device': '.*-(i386|x86_64)-cpu'}
 3200 | {'log': "images* must be given with the 'pflash' parameter"}
 3084 | {'log': "[cC]ould not load [\\w ]+ (BIOS|bios) '[\\w-]+\\.bin'"}
 1120 | {'log': 'Device [\\w.,-]+ can not be dynamically instantiated'}
  800 | {'log': "Couldn't find rom image '[\\w-]+\\.bin'"}
  607 | {'device': 'vhost-scsi.*'}
  551 | {'loglevel': 40, 'log': "Device 'serial0' is in use", 'exitcode': -6}
  476 | {'log': 'Device [\\w.,-]+ is not supported by this machine yet'}

So, a few things we can do:

1) Using query-device-slots: if the test code knew in advance
which buses/device-types are supported by each machine, we could
limit the number of devices being tested. That means the test
code will probably benefit from a query-device-slots command.

This would get rid of the following:

20681 | {'log': "No '[\\w-]+' bus found for device '[\\w-]+'"}
13076 | {'log': "Option '-device [\\w.,-]+' cannot be handled by this machine"}
 1120 | {'log': 'Device [\\w.,-]+ can not be dynamically instantiated'}
  476 | {'log': 'Device [\\w.,-]+ is not supported by this machine yet'}

2) Don't keep trying to test machines that can't be tested out of
the box because they need rom or kernel images.  The script can
first try to run the machine with no -device arguments, to ensure
it is really usable, before trying to test it with all devices.

This will get rid of the following:

 4821 | {'log': '(Guest|ROM|Flash|Kernel) image must be specified'}
 3200 | {'log': "images* must be given with the 'pflash' parameter"}
 3084 | {'log': "[cC]ould not load [\\w ]+ (BIOS|bios) '[\\w-]+\\.bin'"}
  800 | {'log': "Couldn't find rom image '[\\w-]+\\.bin'"}

3) Not testing the devices from the "devices that won't work out
   of the box" section. There are ~18k test cases matching those
   entries.

If I did the calculations right, all of the above would eliminate
more than 63k test cases.

-- 
Eduardo
