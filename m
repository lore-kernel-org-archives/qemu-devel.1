Received: from eggs.gnu.org ([2001:4830:134:3::10]:55320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffMoB-0002Ud-Bx
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffMo1-00022U-L7
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:02:15 -0400
Date: Tue, 17 Jul 2018 12:02:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180717120200.5bf388b4.cohuck@redhat.com>
In-Reply-To: <6d312b22-5af2-bed5-c920-9b5133598515@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
	<20180706100346.3dda6b10.cohuck@redhat.com>
	<6d312b22-5af2-bed5-c920-9b5133598515@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 10/15] s390-bios: Support for running
 format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Fri, 6 Jul 2018 10:35:06 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 07/06/2018 04:03 AM, Cornelia Huck wrote:
> > On Thu,  5 Jul 2018 13:25:38 -0400
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> >> +    senseIdCcw.count = sizeof(senseData);
> >> +
> >> +    if (do_cio(schid, ptr2u32(&senseIdCcw), CCW_FMT1)) {
> >> +        panic("Failed to run SenseID CCw\n");
> >> +    }
> >> +
> >> +    return senseData.cu_type;
> >> +}
> >> +
> >> +static bool irb_error(Irb *irb)
> >> +{
> >> +    /* We have to ignore Incorrect Length (cstat == 0x40) indicators because
> >> +     * real devices expect a 24 byte SenseID  buffer, and virtio devices expect
> >> +     * a much larger buffer. Neither device type can tolerate a buffer size
> >> +     * different from what they expect so they set this indicator.  
> > 
> > Hm... do you have details? Is that basic vs. extended SenseID
> > information?
> > 
> > (If the code in QEMU is making incorrect assumptions, I'd like to fix
> > that.)  
> 
> I really have no idea and was hoping someone who knows virtio ccw better 
> than myself would have some ideas. This comment simply documents what I 
> discovered in testing. I can look into it more if no one else has any 
> information on this. FWIW, it has been working without issue in my testing.

OK, I've looked at this a bit more. It seems that we always get at
least the basic information; the command, however, provides for a
variable length (the CIWs).

The Linux kernel always tries to get the maximum length (basic sense id
information + maximum number possible number of CIWs), but sets SLI as
it may get less of that. I'm not sure what I should return in QEMU for
emulated devices, the documentation of SenseID I could find is a bit
light on details (as the data can be of variable length). I think you
should simply always use SLI, as you don't know the length of the
SenseID data you can get beforehand.

(BTW, is there a newer public version of SA22-7204-01 - Common I/O
Device Commands - available? That one is a bit dated.)
