Received: from eggs.gnu.org ([2001:4830:134:3::10]:46280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIee8-00058w-Ow
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIee4-0002Tl-Kr
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:21:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dIee4-0002TS-Bz
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:21:24 -0400
Date: Wed, 7 Jun 2017 18:21:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170607172119.GM2099@work-vm>
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-3-pasic@linux.vnet.ibm.com>
	<20170607110758.GC2099@work-vm>
	<c6466750-6d71-988c-6c81-9c54f5ca995a@linux.vnet.ibm.com>
	<20170607120138.GD2384@work-vm>
	<1fb16203-3857-d0aa-498e-4acca6a28a41@linux.vnet.ibm.com>
	<20170607171021.GK2099@work-vm>
	<a918bec2-971e-c51f-9909-f4b7149ad98e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a918bec2-971e-c51f-9909-f4b7149ad98e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] vmstate: error hint for failed
 equal checks part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 06/07/2017 07:10 PM, Dr. David Alan Gilbert wrote:
> > * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>
> >>
> >> On 06/07/2017 02:01 PM, Dr. David Alan Gilbert wrote:
> >>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>>>
> >>>>
> >>>> On 06/07/2017 01:07 PM, Dr. David Alan Gilbert wrote:
> >>>>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>>>>> Verbose error reporting for the _EQUAL family. Modify the standard _EQUAL
> >>>>>> so the hint states the assertion probably failed due to a bug. Introduce
> >>>>>> _EQUAL_HINT for specifying a context specific hint.
> >>>>>>
> >>>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>>>>
> >>>>> I'd prefer not to print 'Bug!?' by default - they already get the
> >>>>> message telling them something didn't match and the migration fails.
> >>>>> There are none-bug ways of this happening, e.g. a user starting a VM on
> >>>>> the source and destination with different configs.
> >>>>
> >>>> I admit, my objective with 'Bug!?' was to provoke. My train of thought is
> >>>> to encourage the programmer to think about and document the circumstances
> >>>> under which such an assertion is supposed to fail (and against which it
> >>>> is supposed to guard).
> >>>>
> >>>> I do not know how skillful are our users but a 4 != 5 then maybe a name
> >>>> of a vmstate field is probably quite scary and not very revealing. I doubt
> >>>> a non qemu developer can use it for something else that reporting a bug.
> >>>>
> >>>> Consequently if there are non-bug ways one can use the hint and state them.
> >>>> Your example with the misconfigured target, by the way, is IMHO also be due
> >>>> to a bug of the management software IMHO.
> >>>>
> >>>> To sum it up: IMHO the message provided by a failing _EQUAL is to ugly
> >>>> and Qemuspeak to be presented to an user-user in non-bug cases. Agree?
> >>>> Disagree?
> >>>
> >>> Disagree.
> >>>
> >>> I don't mind giving field names etc; they make it easy for us as
> >>> developers to track down what's happening, but also sometimes they help
> >>> endusers work around a prolem or see where the problem is; of course
> >>> that varies depending on the field name, but some of our names are
> >>> reasonable (e.g. there's a VMSTATE_INT32_EQUAL on 'queue_size' in
> >>> vmmouse.c).  They're also pretty good if two end users hit the same
> >>> problem they can see the same error message in a bug report.
> >>>
> >>> We often have customer-facing support people look at logs before they
> >>> get as far as us developers; if we have bugs that are 
> >>> 'if it's a failing BLAH device complaining about the BAR field'
> >>> then this fixes it, then that helps them find workarounds/fixes quickly
> >>> even if they don't understand what the BAR field is.
> >>>
> >>
> >> You seem to forget, that I'm not proposing omitting this information,
> >> but extending it with something civilized so one can distinguish between
> >> an assert failed should have never happened situation an a as good as
> >> reasonable error handling for an expected error scenario. IMHO the current
> >> EQUAL looks more like the former (assert) and less like the later (error
> >> reporting for an expected error scenario). Agree? Dissagree?
> > 
> > Yes, the current EQUAL is very terse; but we can't actually tell from
> > the use which case it is; it'll all work nicely when people actually add
> > the correct hint text in useful locations.
> > 
> 
> You are right.
> 
> Since Juan also requested the adding an extra param to the original
> macros variant I will go with that.
> 
> I shied away form it in the first place because I did not want to
> bother the users of the macros without clarifying with the migration
> gurus how the new interface should look like.

If you just make the existing callers pass NULL then that's fine.

Dave

> Thanks a lot!
> 
> Regards,
> Halil
> 
> >> Having a field name is great! That's beyond discussion.
> >>
> >> I see, my 'sum it up' above was a bit unfortunate: it sounds like I'm
> >> against the inclusion of technical info and not against a lack of non
> >> technical info. Sorry for that!
> > 
> > No, that's fine.
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
