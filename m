Received: from eggs.gnu.org ([2001:4830:134:3::10]:52878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJiyI-0002N3-N8
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJiyD-0006Kv-RU
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:42:58 -0500
Date: Tue, 28 Nov 2017 17:42:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128174248.46b9624c.cohuck@redhat.com>
In-Reply-To: <e88bef2f-ac0d-5a75-fe92-14ce821bc101@linux.vnet.ibm.com>
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<20171128113546.7f3f2b38.cohuck@redhat.com>
	<e88bef2f-ac0d-5a75-fe92-14ce821bc101@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 0/5] (FIXED) Interactive
 Boot Menu for DASD and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, frankja@linux.vnet.ibm.com

On Tue, 28 Nov 2017 11:35:16 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

> On 11/28/2017 05:35 AM, Cornelia Huck wrote:
> > On Mon, 27 Nov 2017 15:55:31 -0500
> > "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
> >  
> >> These patches implement a boot menu for ECKD DASD and SCSI guests on s390x.
> >> The menu will only appear if the disk has been configured for IPL with the
> >> zIPL tool and with the following QEMU command line options:
> >>
> >>      -boot menu=on[,splash-time=X] and/or -machine loadparm='prompt'
> >>
> >> or via the following libvirt domain xml:
> >>
> >>      <os>
> >>        <bootmenu enable='yes' timeout='X'/>
> >>      </os>
> >>
> >>      or
> >> 	
> >>      <disk>
> >>        ...
> >>        <boot order='1' loadparm='PROMPT'/>
> >>      </disk>
> >>
> >> Where X is some positive integer representing time in milliseconds.
> >>
> >> Loadparm will override all boot options.  
> > I have a bit of trouble parsing that last sentence: Do you mean a
> > loadparm other than 'prompt' will disable the menu and just boot the
> > specified entry, without any delay? (That's what would make most sense
> > to me.)  
> 
> Correct. If loadparm is given boot index, we simply boot that entry.
> I like "a loadparm other than 'prompt' will disable the menu and just
> boot the specified entry"... I hope you don't mind if I steal it ;)

Not at all :)

> 
> >  
> >> Collin L. Walling (5):
> >>    s390-ccw: update libc.h
> >>    s390-ccw: ipl structs for eckd cdl/ldl
> >>    s390-ccw: parse and set boot menu options
> >>    s390-ccw: interactive boot menu for eckd dasd
> >>    s390-ccw: interactive boot menu for scsi
> >>
> >>   hw/s390x/ipl.c              |  23 +++++++
> >>   hw/s390x/ipl.h              |   8 ++-
> >>   pc-bios/s390-ccw/Makefile   |   2 +-
> >>   pc-bios/s390-ccw/bootmap.c  | 110 ++++++++++++++++++++++++++++------
> >>   pc-bios/s390-ccw/bootmap.h  |  73 +++++++++++++----------
> >>   pc-bios/s390-ccw/iplb.h     |   8 ++-
> >>   pc-bios/s390-ccw/libc.h     |  94 +++++++++++++++++++++++++++++
> >>   pc-bios/s390-ccw/main.c     |  35 +++++------
> >>   pc-bios/s390-ccw/menu.c     | 122 +++++++++++++++++++++++++++++++++++++
> >>   pc-bios/s390-ccw/s390-ccw.h |   7 +++
> >>   pc-bios/s390-ccw/sclp.c     | 142 +++++++++++++++++++++++++++++++++++++++++---
> >>   11 files changed, 546 insertions(+), 78 deletions(-)
> >>   create mode 100644 pc-bios/s390-ccw/menu.c
> >>  
> >  
> 
