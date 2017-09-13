Received: from eggs.gnu.org ([2001:4830:134:3::10]:40150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds4bQ-0005bm-QQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds4bM-0002SK-SF
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:09:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds4bM-0002RV-J7
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:09:00 -0400
Date: Wed, 13 Sep 2017 12:08:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913120856.28341e7b.cohuck@redhat.com>
In-Reply-To: <c7318e05-4032-13b4-e8e6-d4050abc5368@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-3-pasic@linux.vnet.ibm.com>
	<20170831111953.242ddc28.cohuck@redhat.com>
	<e805e756-495d-3125-eaf0-262635b9c545@linux.vnet.ibm.com>
	<20170905100234.7a92128e.cohuck@redhat.com>
	<bff0fcd2-4c1d-b5da-2d11-dc479d9d7275@linux.vnet.ibm.com>
	<20170905174606.1e0c6404.cohuck@redhat.com>
	<24e87c3e-2674-8fc1-cd0a-94f4907ddc7d@linux.vnet.ibm.com>
	<20170906082720.GZ31680@bjsdjshi@linux.vnet.ibm.com>
	<20170906132538.73b31142.cohuck@redhat.com>
	<20170907080208.GE31680@bjsdjshi@linux.vnet.ibm.com>
	<c7318e05-4032-13b4-e8e6-d4050abc5368@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] s390x: fix invalid use of cc 1 for SSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 7 Sep 2017 13:01:34 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/07/2017 10:02 AM, Dong Jia Shi wrote:
> > * Cornelia Huck <cohuck@redhat.com> [2017-09-06 13:25:38 +0200]:
> >   
> >> On Wed, 6 Sep 2017 16:27:20 +0800
> >> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> >>  
> >>> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-05 19:20:43 +0200]:
> >>>  
> >>>>
> >>>>
> >>>> On 09/05/2017 05:46 PM, Cornelia Huck wrote:    
> >>>>> On Tue, 5 Sep 2017 17:24:19 +0200
> >>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >>>>>     
> >>>>>> My problem with a program check (indicated by SCSW word 2 bit 10) is
> >>>>>> that, in my reading of the architecture, the semantic behind it is: The
> >>>>>> channel subsystem (not the cu or device) has detected, that the 
> >>>>>> the channel program (previously submitted as an ORB) is erroneous. Which
> >>>>>> programs are erroneous is specified by the architecture. What we have
> >>>>>> here does not qualify.
> >>>>>>
> >>>>>> My idea was to rather blame the virtual hardware (device) and put no blame
> >>>>>> on the program nor he channel subsystem. This could be done using device
> >>>>>> status (unit check with command reject, maybe unit exception) or interface
> >>>>>> check. My train of thought was, the problem is not consistent across a
> >>>>>> device type, so it has to be device specific.    
> >>>>>
> >>>>> Unit exception might be a better way to express what is happening here.
> >>>>> At least, it moves us away from cc 1 and not towards cc 3 :)
> >>>>>     
> >>>>
> >>>> I will do a follow up patch pursuing device exception.
> >>>>     
> >>>>>>
> >>>>>> Of course blaming the device could mislead the person encountering the
> >>>>>> problem, and make him believe it's an non-virtual hardware problem.
> >>>>>>
> >>>>>> About the misleading, I think the best we can do is log out a message
> >>>>>> indicating what really happened.    
> >>>>>
> >>>>> Just document it in the code? If it doesn't happen with Linux as a
> >>>>> guest, it is highly unlikely to be seen in the wild.
> >>>>>     
> >>>>
> >>>>
> >>>> Well we have two problems here:
> >>>> 1) Unit exception can be already defined by the device type for the
> >>>> command (reference: http://publibfp.dhe.ibm.com/cgi-bin/bookmgr/BOOKS/dz9ar110/2.6.10?DT=19920904110920).
> >>>> I think this one is what you mean. And I agree that's best handled
> >>>> with comment in code.    
> >>> Using unit check, with bit 3 byte 0 of the sense data set to 1, to
> >>> indicate an 'Equipment check', sounds a bit more proper than unit
> >>> exception.  
> >>
> >> I don't agree: Equipment check sounds a lot more dire (and seems to
> >> imply a malfunction). I like unit exception better.  
> > Got the point. Fair enough!
> >   
> 
> I do see some benefit in doing unit check over unit exception. Just
> kept quite to see the discussion unfold. As already said, unit exception
> seems to be something reserved for the device type to define in a more
> or less arbitrary but unambiguous way. I agreed to use this, because
> I trust Connie's assessment about not really being used by the
> devices in the wild (obviously nothing changed here).
> 
> If we consider the semantic of unit check with command reject, it's
> a surprisingly good match: basically device detected a programming
> error (which can not be detected by the channel-subsystem because it
> is device (type) specific). For reference see:
> http://publibfp.dhe.ibm.com/cgi-bin/bookmgr/BOOKS/dz9ar110/2.7.2.1?DT=19920904110920
> 
> IMHO that's almost exactly what we have here: the channel-program
> is good from the perspective of the channel subsystem, but the device
> can't deal with it. So we would not lie that the device is at fault
> (was Connie's concern initially) but we would not lie about having
> a generally invalid channel program (was my concern).
> 
> So how about an unit check with a command reject? (The only problem
> I see is is on the device vs device type plane -- but that ain't better
> for unit exception.)

I don't know, it feels a bit weird if I look at the cases where I saw
command reject in the wild before, even if seems to agree with the
architecture... but just a gut feeling.
