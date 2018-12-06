Received: from eggs.gnu.org ([2001:4830:134:3::10]:52731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUss4-0007u2-Nb
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUsrx-0001Zj-C7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:35:11 -0500
Date: Thu, 6 Dec 2018 13:34:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181206133459.5a25be16.cohuck@redhat.com>
In-Reply-To: <45f67421-f26d-a5e5-d388-de65e6cc26ec@linux.ibm.com>
References: <45f67421-f26d-a5e5-d388-de65e6cc26ec@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [0/3] vfio-ccw: support hsch/csch (kernel part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On Wed, 5 Dec 2018 13:08:56 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Connie,
> 
> Sorry if this does not thread nicely. I never received the original (Thunderbird 
> corruption/hangs) so I had to fake it :).

I hopefully managed to restore the rest of the cc:s :)

> 
>  >> My point is, when the subchannel is disabled, 'firmware' is responsible
>  >> for suppressing interrupts and error conditions, and also for
>  >> doing the appropriate recovery procedure, so to say under the hood.  
>  >
>  > I don't think there's actually much of a 'recovery' possible at a
>  > subchannel level (other than 'have you tried turning it off and on
>  > again?'); the interesting stuff is all at the device-specific level.
>  >  
>  >> I think Jason has discovered some problems related to this while doing
>  >> his DASD IPL with vfio-ccw work, but I don't quite remember any more.  
>  >
>  > cc:ing Jason, in case he remembers :)  
> 
> Here is what Halil was talking about.
> I'm seeing a problem during kvm on z development of vfio-ccw (passthrough dasd). 
> After a fresh IPL of the host system, sometimes my first channel program 
> executed on my vfio-ccw device generates a unit check. The sense data given for 
> that unit check indicates that a reset event has occurred. This is apparently 
> normal to see after a device, channel or subsystem reset.

Sounds reasonable.

> I'm trying to figure out how to deal with this unit check in the vfio-ccw kernel 
> driver. The thinking at the moment is to just retry any i/o operation a limited 
> number of times after any unit check, then give up if the i/o operation still 
> does not succeed. The kernel apparently uses a similar approach for the regular 
> dasd driver.

Is that unit check in response to a channel program submitted by the
guest? If yes, I think that the unit check should be reflected back to
the guest as well in that case. We should only keep the unit check to
ourselves if it was triggered by something internally.

[On a tangent: Do current dasds actually support concurrent sense, or
do you still need to collect the sense data via a sense ccw after a
unit check?]
