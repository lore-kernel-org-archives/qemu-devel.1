Received: from eggs.gnu.org ([209.51.188.92]:34350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpTKi-00057N-JS
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpTKg-0001kh-HB
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:33:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpTKe-0001iN-JL
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:33:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
	<20190131130850.6850-8-yuval.shaia@oracle.com>
	<42ba3330-f7ca-b5c5-126f-8dd97e343d51@redhat.com>
	<20190131200816.GA2838@lap1>
	<3557b3f3-cec5-fcb1-1527-e613fa446b89@redhat.com>
Date: Fri, 01 Feb 2019 08:33:44 +0100
In-Reply-To: <3557b3f3-cec5-fcb1-1527-e613fa446b89@redhat.com> (Eric Blake's
	message of "Thu, 31 Jan 2019 14:52:35 -0600")
Message-ID: <87ftt8j73b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 07/10] monitor: Expose pvrdma device
 statistics counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 1/31/19 2:08 PM, Yuval Shaia wrote:
>> On Thu, Jan 31, 2019 at 07:17:16AM -0600, Eric Blake wrote:
>>> On 1/31/19 7:08 AM, Yuval Shaia wrote:
>>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>>> ---
>>>>  hmp-commands-info.hx | 14 ++++++++++++++
>>>>  monitor.c            |  6 ++++++
>>>>  2 files changed, 20 insertions(+)
>> 
>> Hi Eric,
>> 
>>>
>>> Commit message should state WHY this is being added as an HMP-only
>>> command, and does not have a QMP counterpart.  It may be okay if the
>>> interface is only designed to be useful to developers, but having that
>>> justification in the git log is important.
>> 
>> Thanks for your review.
>> 
>> See, i need this interface mainly for development/debug purposes, to help
>> troubleshot problems and to give insights to what device "is doing".
>> 
>> Trace points are great but not effective in high load.
>> QMP as i see it, and correct me if i'm wrong, is used to report management
>> events etc and also here, is not effective in high load.

If QMP is not effective, HMP won't be effective, either.  But I guess
you mean something else, namely QMP *events* aren't effective, but
*polling* is.

That's an argument for polling, not an argument for not supporting QMP.

>> I choose this interface as it is interactive, i.e. whenever i need the info
>> i trigger 'info pvrdmastats' command from the monitor console.
>> 
>> During my research i notice that some devices (or families) have nice user
>> interface via virsh (blkstat, ifstat, memstat etc). Is it the preferred way
>> for non-devel/debug purposes?

Libvirt interfaces like these are built on top of *QMP* interfaces.  If
a libvirt interface would be useful, that's another argument for
supporting QMP.

> Using existing HMP-only debug interfaces as the design you copied is
> indeed acceptable justification for making yours HMP-only as well.  So
> now you just need to copy the rationale from this email into your commit
> message, so it doesn't get lost.

Yes.  If we conclude HMP-only is okay, then the rationale for it goes
into your commit message.

If we conclude we want HMP and QMP, I'll be happy to assist you with
adapting your patch.

HMP commands without a QMP equivalent are okay if their functionality
makes no sense in QMP, or is of use only for human users.

Example for "makes no sense in QMP": setting the current CPU, because a
QMP monitor doesn't have a current CPU.

Examples for "is of use only for human users": HMP command "help", the
integrated pocket calculator.

Debugging commands are kind of borderline.  Debugging is commonly a
human activity, where HMP is just fine.  However, humans create tools to
assist with their activities, and then QMP is useful.  While I wouldn't
encourage HMP-only for the debugging use case, I wouldn't veto it.

"Device statistics" sounds like it should have debugging uses.  But
statistics often have non-debugging uses as well.  What use cases can
you imagine for this command?

>> If this is the correct method for this purpose then let me know and i'll
>> update the git log message accordingly.
