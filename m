Received: from eggs.gnu.org ([209.51.188.92]:43864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghGfh-0006wg-9H
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghGfg-0005kE-2D
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:25:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghGff-0005jN-QV
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:25:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<20190109142140.GC4867@localhost.localdomain>
	<095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
	<20190109144818.GE4867@localhost.localdomain>
	<756f6997-cb66-a82b-ae13-babb0e5fa827@redhat.com>
	<20190109151348.GG4867@localhost.localdomain>
Date: Wed, 09 Jan 2019 17:25:29 +0100
In-Reply-To: <20190109151348.GG4867@localhost.localdomain> (Kevin Wolf's
	message of "Wed, 9 Jan 2019 16:13:48 +0100")
Message-ID: <87lg3tbxxi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 09.01.2019 um 15:54 hat Max Reitz geschrieben:
>> On 09.01.19 15:48, Kevin Wolf wrote:
>> > Am 09.01.2019 um 15:27 hat Max Reitz geschrieben:
>> >> On 09.01.19 15:21, Kevin Wolf wrote:
>> >>> Am 09.01.2019 um 15:10 hat Max Reitz geschrieben:
>> >>>> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
>> >>>>> changes in v2:
>> >>>>> - removed the "RFC" marker;
>> >>>>> - added a new patch (patch 2) that removes
>> >>>>> bdrv_snapshot_delete_by_id_or_name from the code;
>> >>>>> - made changes in patch 1 as suggested by Murilo;
>> >>>>> - previous patch set link:
>> >>>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
>> >>>>>
>> >>>>>
>> >>>>> It is not uncommon to see bugs being opened by testers that attempt to
>> >>>>> create VM snapshots using HMP. It turns out that "0" and "1" are quite
>> >>>>> common snapshot names and they trigger a lot of bugs. I gave an example
>> >>>>> in the commit message of patch 1, but to sum up here: QEMU treats the
>> >>>>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
>> >>>>> is documented as such, but this can lead to strange situations.
>> >>>>>
>> >>>>> Given that it is strange for an API to consider a parameter to be 2 fields
>> >>>>> at the same time, and inadvently treating them as one or the other, and
>> >>>>> that removing the ID field is too drastic, my idea here is to keep the
>> >>>>> ID field for internal control, but do not let the user set it.
>> >>>>>
>> >>>>> I guess there's room for discussion about considering this change an API
>> >>>>> change or not. It doesn't affect users of HMP and it doesn't affect Libvirt,
>> >>>>> but simplifying the meaning of the parameters of savevm/loadvm/delvm.
>> >>>>
>> >>>> (Yes, very late reply, I'm sorry...)
>> >>>>
>> >>>> I do think it affects users of HMP, because right now you can delete
>> >>>> snapshots with their ID, and after this series you cannot.
>> >>>
>> >>> Can there be snapshots that can't be identified by a snapshot name, but
>> >>> only by their ID?
>> >>
>> >> I don't know, but what I meant is that if you have scripts to do all
>> >> this, you might have to adjust them with this change.
>> > 
>> > That's what the H in HMP means.
>> > 
>> >>>> I think we had a short discussion about just disallowing numeric
>> >>>> snapshot names.  How bad would that be?
>> >>>
>> >>> It would be incompatible with existing images and result in a more
>> >>> complex snapshot identifier resolution. Why would it be any better?
>> >>
>> >> It wouldn't be incompatible with existing images if we'd just disallow
>> >> creating such snapshots.  I don't see how the identifier resolution
>> >> would be more complex.
>> >>
>> >> I don't know if it'd be better.  I'd just find it simpler (for us, that
>> >> is -- for users, I'm not sure).
>> > 
>> > Identifier resolution A:
>> > - Find a snapshot that has the given identifier as a name
>> > - If no such snapshot exists, it is an error
>> > 
>> > Identifier resolution B:
>> > - If the identifier is a number, find a snapshot that has the given
>> >   identifier as its ID
>> > - If the identifier is not a number, find a snapshot that has the given
>> >   identifier as a name
>> > - If no such snapshot exists, it is an error
>> 
>> No, my idea was to keep the resolution the same as it is; just to forbid
>> creating new snapshots with numeric names.  This would prevent users
>> from getting into the whole situation.
>
> That's the version with an even more complex resolution method C. :-)
>
> I actually think the current behaviour is more confusing than helpful.
> Without looking into the code or trying it out, I couldn't even tell
> whether ID or name takes precedence if there is a matching snapshot for
> both.

Been there, done that, more than once.

>       Considering your proposal, it's probably the ID, but how should a
> user know that? (If against all expectations documentation exists, it
> doesn't count because nobody reads that.)

In this case, probably for the better --- I'd expect documentation of
this mess (if any) to be rather losely related to the code.
