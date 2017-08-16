Received: from eggs.gnu.org ([2001:4830:134:3::10]:60173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhrdq-0008Td-Ux
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhrdm-0002gf-0C
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:17:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhrdl-0002gP-Pn
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:17:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-4-apahim@redhat.com>
	<87zib1s13v.fsf@dusky.pond.sub.org>
	<20170815195827.GW3108@localhost.localdomain>
Date: Wed, 16 Aug 2017 08:17:11 +0200
In-Reply-To: <20170815195827.GW3108@localhost.localdomain> (Eduardo Habkost's
	message of "Tue, 15 Aug 2017 16:58:27 -0300")
Message-ID: <878tikf34o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 3/7] qemu.py: use python logging system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: kwolf@redhat.com, ldoktor@redhat.com, famz@redhat.com, stefanha@gmail.com, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, crosa@redhat.com

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, Aug 15, 2017 at 10:10:12AM +0200, Markus Armbruster wrote:
>> Please spell "Python" with a capital "P" (it's a proper name).
>> 
>> Amador Pahim <apahim@redhat.com> writes:
>> 
>> > Let's provide extra control and flexibility by using python logging
>> > system instead of print and/or sys.std*.write().
>> >
>> > Signed-off-by: Amador Pahim <apahim@redhat.com>
>> 
>> How exactly does this change error messages?
>> 
>> Is logging the right tool to report errors to the human user?  I'm
>> asking because logging and error reporting are generally separate
>> things.  Example: a program runs into a recoverable error.  It logs the
>> error, but does not report it.
>> 
>> Is reporting errors to stderr the right thing to do for library class
>> QEMUMachine?  I doubt it.  Libraries throw exceptions and let their
>> users decide how to handle them.
>
> I believe the "qemu received signal" event is supposed to be
> logged, not necessarily reported.  Callers can then choose where
> the log messages should go (scripts could choose to send them
> directly to stderr if verbose or debugging mode is enabled).  We
> don't even need an exception for it: we can let callers check
> exitcode() and decide what to do about the QEMU exit code.

Makes sense.

> The send_fd_scm() messages, on the other hand, could become
> exceptions, and don't need the logging system at all.

I think we all agree that printing to stderr is not a good idea for this
library class.  Instead of a blanket conversion to logging without
further explanation, I'd like to see cleanup with rationale such as
yours.
