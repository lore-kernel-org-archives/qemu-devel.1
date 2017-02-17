Received: from eggs.gnu.org ([2001:4830:134:3::10]:59473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceiDy-0002qu-Nj
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceiDv-0002iK-I0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:05:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ceiDv-0002gq-C7
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:05:19 -0500
Date: Fri, 17 Feb 2017 14:05:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170217140516.35d4ded5@nial.brq.redhat.com>
In-Reply-To: <918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert
	(git)" <dgilbert@redhat.com>, mst@redhat.com

On Fri, 17 Feb 2017 13:50:40 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> CC Dave
> 
> On 02/17/17 11:43, Igor Mammedov wrote:
> > On Thu, 16 Feb 2017 15:15:36 -0800
> > ben@skyportsystems.com wrote:
> > 
> >> From: Ben Warren <ben@skyportsystems.com>
> >>
> >> This implements the VM Generation ID feature by passing a 128-bit
> >> GUID to the guest via a fw_cfg blob.
> >> Any time the GUID changes, an ACPI notify event is sent to the guest
> >>
> >> The user interface is a simple device with one parameter:
> >>  - guid (string, must be "auto" or in UUID format
> >>    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
> > I've given it some testing with WS2012R2 and v4 patches for Seabios,
> > 
> > Windows is able to read initial GUID allocation and writeback
> > seems to work somehow:
> > 
> > (qemu) info vm-generation-id 
> > c109c09b-0e8b-42d5-9b33-8409c9dcd16c
> > 
> > vmgenid client in Windows reads it as 2 following 64bit integers:
> > 42d50e8bc109c09b:6cd1dcc90984339b
> > 
> > However update path/restore from snapshot doesn't
> > here is as I've tested it:
> > 
> > qemu-system-x86_64 -device vmgenid,id=testvgid,guid=auto -monitor stdio
> > (qemu) info vm-generation-id 
> > c109c09b-0e8b-42d5-9b33-8409c9dcd16c
> > (qemu) stop
> > (qemu) migrate "exec:gzip -c > STATEFILE.gz" 
> > (qemu) quit
> > 
> > qemu-system-x86_64 -device vmgenid,id=testvgid,guid=auto -monitor stdio
> > -incoming "exec: gzip -c -d STATEFILE.gz"
> > (qemu) info vm-generation-id 
> > 28b587fa-991b-4267-80d7-9cf28b746fe9
> > 
> > guest
> >  1. doesn't get GPE notification that it must receive
> >  2. vmgenid client in Windows reads the same value
> >       42d50e8bc109c09b:6cd1dcc90984339b
> 
> Hmmm, I wonder if we need something like this, in vmgenid_post_load():
> 
> commit 90c647db8d59e47c9000affc0d81754eb346e939
> Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Date:   Fri Apr 15 12:41:30 2016 +0100
> 
>     Fix pflash migration
> 
> with the idea being that in a single device's post_load callback, we
> shouldn't perform machine-wide actions (post_load is likely for fixing
> up the device itself). If machine-wide actions are necessary, we should
> temporarily register a "vm change state handler", and do the thing once
> that handler is called (when the machine has been loaded fully and is
> about to continue execution).
> 
> Can you please try the attached patch on top? (Build tested only.)
it doesn't help

> 
> Thanks!
> Laszlo
