Received: from eggs.gnu.org ([2001:4830:134:3::10]:55872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5q6X-0003Cu-1L
	for qemu-devel@nongnu.org; Wed, 03 May 2017 04:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5q6S-00081M-6H
	for qemu-devel@nongnu.org; Wed, 03 May 2017 04:57:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5q6R-000810-T5
	for qemu-devel@nongnu.org; Wed, 03 May 2017 04:57:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170427215821.19397-1-eblake@redhat.com>
	<20170427215821.19397-11-eblake@redhat.com>
	<149374359665.32299.11589637295145834940@loki>
	<149374416427.32299.10266856249198036332@loki>
Date: Wed, 03 May 2017 10:57:41 +0200
In-Reply-To: <149374416427.32299.10266856249198036332@loki> (Michael Roth's
	message of "Tue, 02 May 2017 11:56:04 -0500")
Message-ID: <87a86u48sa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 10/10] test-qga: Actually test 0xff sync
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

> Quoting Michael Roth (2017-05-02 11:46:36)
>> Quoting Eric Blake (2017-04-27 16:58:21)
>> > Commit 62c39b3 introduced test-qga, and at face value, appears
>> > to be testing the 'guest-sync' behavior that is recommended for
>> > guests in sending 0xff to QGA to force the parser to reset.  But
>> > this aspect of the test has never actually done anything: the
>> > qmp_fd() call chain converts its string argument into QObject,
>> > then converts that QObject back to the actual string that is
>> > sent over the wire - and the conversion process silently drops
>> > the 0xff byte from the string sent to QGA, thus never resetting
>> > the QGA parser.
>> > 
>> > An upcoming patch will get rid of the wasteful round trip
>> > through QObject, at which point the string in test-qga will be
>> > directly sent over the wire.
>> > 
>> > But fixing qmp_fd() to actually send 0xff over the wire is not
>> > all we have to do - the actual QMP parser loudly complains that
>> > 0xff is not valid JSON, and sends an error message _prior_ to
>> > actually parsing the 'guest-sync' or 'guest-sync-delimited'
>> > command.  With 'guest-sync', we cannot easily tell if this error
>> > message is a result of our command - which is WHY we invented
>> > the 'guest-sync-delimited' command.  So for the testsuite, fix
>> > things to only check 0xff behavior on 'guest-sync-delimited',
>> > and to loop until we've consumed all garbage prior to the
>> > requested delimiter, which matches the documented actions that
>> > a real QGA client is supposed to do.
>> 
>> The full re-sync sequence is actually to perform that process,
>> check if the response matches the client-provided sync token,
>> and then repeat the procedure if it doesn't (in the odd case
>> that a previous client initiated a guest-sync-delimited
>> sequence and never consumed the response). The current
>> implementation only performs one iteration so it's not quite
>> a full implementation of the documentation procedure.
>
> Well, to be more accurate it's a full implementation of the
> documented procedure, it's just that the procedure isn't
> fully documented properly. I'll send a patch to address that.

Good.

>> For the immediate purpose of improving the handling to deal
>> with the 0xFF-generated error the patch seems sound though,
>> maybe just something worth noting in the commit msg or
>> comments so that we might eventually test the full procedure.

Feel free to suggest something for me to add to the commit message.

>> In any case:
>> 
>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Noted, thanks!
