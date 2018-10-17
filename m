Received: from eggs.gnu.org ([2001:4830:134:3::10]:36586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCkcF-0004I2-Qa
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCkcE-0006vC-Tq
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:07:55 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181016140655.GI2426@work-vm> (David Alan Gilbert's message of
	"Tue, 16 Oct 2018 15:06:55 +0100")
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-4-aclindsa@gmail.com>
	<3a964ae2-a5d0-5960-9e15-7ede929a8294@linaro.org>
	<20181016082117.GB2426@work-vm>
	<20181016135517.GO3671@okra.localdomain>
	<20181016140655.GI2426@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 17 Oct 2018 14:07:32 +0200
Message-ID: <87y3aw93p7.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 03/14] migration: Add post_save function
 to VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Aaron Lindsay <aclindsa@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Wei Huang <wei@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Aaron Lindsay (aclindsa@gmail.com) wrote:
>> On Oct 16 09:21, Dr. David Alan Gilbert wrote:
>> > * Richard Henderson (richard.henderson@linaro.org) wrote:
>> > > On 10/10/18 1:37 PM, Aaron Lindsay wrote:
>> > > > In some cases it may be helpful to modify state before saving it for
>> > > > migration, and then modify the state back after it has been saved. The
>> > > > existing pre_save function provides half of this functionality. This
>> > > > patch adds a post_save function to provide the second half.
>> > > > 
>> > > > Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
>> > > > ---
>> > > >  docs/devel/migration.rst    |  9 +++++++--
>> > > >  include/migration/vmstate.h |  1 +
>> > > >  migration/vmstate.c         | 10 +++++++++-
>> > > >  3 files changed, 17 insertions(+), 3 deletions(-)
>> > > 
>> > > Hmm, maybe.  I believe the common practice is for pre_save to
>> > > copy state into a
>> > > separate member on the side, so that conversion back isn't necessary.
>> > > 
>> > > Ccing in the migration maintainers for a second opinion.
>> > 
>> > It is common to copy stuff into a separate member; however we do
>> > occasionally think that post_save would be a useful addition; so I think
>> > we should take it (if nothing else it actually makes stuff symmetric!).
>> > 
>> > Please make it return 'int' in the same way that pre_save/pre_load
>> > does, so that it can fail and stop the migration.
>> 
>> This patch calls post_save *even if the save operation fails*. My
>> reasoning was that I didn't want a failed migration to leave a
>> still-running original QEMU instance in an invalid state. Was this
>> misguided?
>
> That's fine - my only issue is that I want post_save to be able to fail
> itself even if pre_save failed.
>
>> If it was not, which error do you prefer to be returned from
>> vmstate_save_state_v() in the case that both the save operation itself
>> and the post_save call returned errors?
>
> The return value from the save operation.
> I did wonder about suggesting that you pass the return value from the
> save operation as a parameter to post_save.

The one from save.  In general, this one shouldn't be called, and if it
gets an error, we are really in big trouble, no?  By big treauble I mean
that we can basically only stop the guest?

Later, Juan.

>
> Dave
>
>> -Aaron
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
