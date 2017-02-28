Received: from eggs.gnu.org ([2001:4830:134:3::10]:41101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cimsf-00050h-Hm
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cimse-0008Ax-PD
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:52:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-20-git-send-email-armbru@redhat.com>
	<20170228175142.GU4090@noname.redhat.com>
Date: Tue, 28 Feb 2017 19:52:05 +0100
In-Reply-To: <20170228175142.GU4090@noname.redhat.com> (Kevin Wolf's message
	of "Tue, 28 Feb 2017 18:51:42 +0100")
Message-ID: <87a896jgh6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 19/24] qapi: Improve how keyval input
 visitor reports unexpected dicts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>> Incorrect option
>> 
>>     -blockdev node-name=foo,driver=file,filename=foo.img,aio.unmap
>> 
>> is rejected with "Invalid parameter type for 'aio', expected: string".
>> To make sense of this, you almost have to translate it into the
>> equivalent QMP command
>> 
>>     { "execute": "blockdev-add", "arguments": { "node-name": "foo", "driver": "file", "filename": "foo.img", "aio": { "unmap": true } } }
>> 
>> Improve the error message to "Parameters 'aio.*' are unexpected".
>
> In fact, what I get (after fixing the previous review comments that
> would make it crash) is "Expected '=' after parameter 'aio.unmap'". Only
> if I add a value, I get the newly added message.

Fallout from ditching implied value sugar some time after this commit
message was written.  Will fix.

> Doesn't make the patch less correct, though.
>
>> Take care not to confuse the case "unexpected nested parameters"
>> (i.e. the object is a QDict or QList) with the case "non-string scalar
>> parameter".  The latter is a misuse of the visitor, and should perhaps
>> be an assertion.  Note that test-qobject-input-visitor exercises this
>> misuse in test_visitor_in_int_keyval(), test_visitor_in_bool_keyval()
>> and test_visitor_in_number_keyval().
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Thanks!
