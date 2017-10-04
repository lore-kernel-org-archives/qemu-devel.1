Received: from eggs.gnu.org ([2001:4830:134:3::10]:55440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzbdl-0004aW-Jc
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 00:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzbdi-0005mu-Ae
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 00:50:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170929140540.13766-1-otubo@redhat.com>
	<20170929193139.GB17385@localhost.localdomain>
	<9c365c30-8b63-f762-aa56-5b952b491aec@redhat.com>
	<20171003133705.GH17385@localhost.localdomain>
Date: Wed, 04 Oct 2017 06:50:28 +0200
In-Reply-To: <20171003133705.GH17385@localhost.localdomain> (Eduardo Habkost's
	message of "Tue, 3 Oct 2017 10:37:05 -0300")
Message-ID: <87d163v7mz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCHv2] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Otubo <otubo@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Oct 02, 2017 at 02:50:07PM +0200, Paolo Bonzini wrote:
>> On 29/09/2017 21:31, Eduardo Habkost wrote:
>> >> -void DMA_init(ISABus *bus, int high_page_enable)
>> >> +void DMA_init(ISABus *bus, int high_page_enable, Error **errp)
>> > 
>> > If you make the function return a boolean to indicate success (in
>> > addition to setting *errp), you avoid the need for a local_err
>> > variable on the caller.
>> 
>> I think in this case, rather than a bool, it would be better to return 0
>> or -EBUSY.  A check for "< 0" would be more self-explanatory in the caller.
>
> I'm OK with that, too.
>
> We really need to document the available and preferred error
> reporting styles somewhere (probably on qapi/error.h).  We
> discussed that a lot recently[1], but the conclusions were not
> documented anywhere.
>
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg461702.html

Yes, we need to document it.  We also need to convert existing code.

In my experience, documentation is a great time saver when people ask
questions.  It's less successful at getting people do the right thing.
For that, you have to make good examples common and bad examples
sufficiently rare.
