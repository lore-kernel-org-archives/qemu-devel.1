Received: from eggs.gnu.org ([2001:4830:134:3::10]:37647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAJIK-0006aK-SA
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAJIF-0007T9-RT
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:56:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAJIF-0007Sb-Ir
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:56:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C058C04B92C
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 16:56:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170515163841.GB2324@work-vm> (David Alan Gilbert's message of
	"Mon, 15 May 2017 17:38:41 +0100")
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-3-quintela@redhat.com>
	<20170512034033.GN28293@pxdev.xzpeter.org>
	<877f1mgx9h.fsf@secure.mitica>
	<5bab598f-30eb-fcf6-9d06-8f683b466414@redhat.com>
	<87lgpyfo28.fsf@secure.mitica> <87k25iqf4m.fsf@dusky.pond.sub.org>
	<87efvqdqqj.fsf@secure.mitica> <20170515163841.GB2324@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 15 May 2017 18:56:18 +0200
Message-ID: <87a86edpot.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Markus Armbruster <armbru@redhat.com> wrote:
>> > Juan Quintela <quintela@redhat.com> writes:
>> >
>> >> Eric Blake <eblake@redhat.com> wrote:
>> 
>> 
>> >>> Or is the proposal that we are also going to simplify the QMP 'migrate'
>> >>> command to get rid of crufty parameters?
>> >>
>> >> I didn't read it that way, but I would not oppose O:-)
>> >>
>> >> Later, Juan.
>> >
>> > I'm not too familiar with this stuff, so please correct my
>> > misunderstandings.
>> >
>> > "Normal" migration configuration is global state, i.e. it applies to all
>> > future migrations.
>> >
>> > Except the "migrate" command's flags apply to just the migration kicked
>> > off by that command.
>> >
>> > QMP command "migrate" has two flags "blk" (HMP: -b) and "inc" (HMP: -i).
>> > !blk && inc makes no sense and is silently treated like !blk && !inc.
>> >
>> > There's a third flag "detach" (HMP: -d), but it does nothing in QMP.
>> 
>> As qmp command is asynchronous, you can think that -d is *always* on in
>> QMP O:-)
>> 
>> > You'd like to deprecate these flags in favour of "normal" configuration.
>> > However, we need to maintain QMP backward compatibility at least for a
>> > while.  HMP backward compatibility is nice to have, but not required.
>> >
>> > First step is to design the new interface you want.  Second step is to
>> > figure out backward compatibility.
>> >
>> > The new interface adds a block migration tri-state (off,
>> > non-incremental, incremental) to global state, default off.  Whether
>> > it's done as two bools or an enum of three values doesn't matter here.
>> 
>> Tristates will complicate it.  I still think that:
>> 
>> - capability: block_migration
>> - parameter: block_shared
>> 
>> Makes more sense, no?
>
> I don't understand what making block_shared a parameter gives you as
> opposed to simply having two capabilities.
>
> (And how did we get 'shared'? We started off with block & incremental)

The variables on MigrationParams:

struct MigrationParams {
    bool blk;
    bool shared;
};


I can move to incremental.  I am not sure which one is clearer.

The advantage of having shared as a parameter is that we forget about
all this dependency bussiness.  Is the same than compression_threads
paramter, you setup to whichever value that you want.  But you don't get
compression_threads until you set the compress capability.

So, in this case we will have:

block capability: Are we using block migration or not
block-incremental parameter: If we are using block migration, are we
      using incremental copying of the block layer?


Later, Juan.
