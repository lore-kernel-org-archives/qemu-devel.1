Received: from eggs.gnu.org ([2001:4830:134:3::10]:39239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch92r-0005yt-7U
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch92m-00030n-7s
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:07:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ch92m-0002zE-1d
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:07:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-2-git-send-email-armbru@redhat.com>
	<12466fb1-5182-e97c-f82c-40d124fbbbcb@redhat.com>
	<f0f8abd7-18e8-f0b2-5232-f505866590f0@redhat.com>
Date: Fri, 24 Feb 2017 07:07:48 +0100
In-Reply-To: <f0f8abd7-18e8-f0b2-5232-f505866590f0@redhat.com> (Eric Blake's
	message of "Thu, 23 Feb 2017 16:50:44 -0600")
Message-ID: <87wpcg2kaz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 01/21] qga: Fix crash on non-dictionary QMP
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> On 02/23/2017 04:46 PM, Eric Blake wrote:
>> On 02/23/2017 03:44 PM, Markus Armbruster wrote:
>>> The value of key 'arguments' must be a JSON object.  qemu-ga neglects
>>> to check, and crashes.  To reproduce, send
>>>
>>>     { 'execute': 'guest-sync', 'arguments': [] }
>>>
>>> to qemu-ga.
>>>
>>> do_qmp_dispatch() uses qdict_get_qdict() to get the arguments.  When
>>> not a JSON object, this gets a null pointer, which flows through the
>>> generated marshalling function to qobject_input_visitor_new(), where
>>> it fails the assertion.  qmp_dispatch_check_obj() needs to catch this
>>> error.
>>>
>>> QEMU isn't affected, because it runs qmp_check_input_obj() first,
>>> which basically duplicates qmp_check_input_obj()'s checks, plus the
>
> This sentence is weird (func A can't duplicate func A's checks; you're
> missing a func B, but I'm not sure which instance is wrong, nor what B
> should be).

B is qmp_dispatch_check_obj().  I'll fix it.

>>> missing one.
>>>
>>> Fix by copying the missing one from qmp_check_input_obj() to
>>> qmp_dispatch_check_obj().
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>> ---
>>>  qapi/qmp-dispatch.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
