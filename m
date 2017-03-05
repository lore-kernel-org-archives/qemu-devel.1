Received: from eggs.gnu.org ([2001:4830:134:3::10]:56721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckT4r-0005X4-4l
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 05:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckT4q-0005Ys-67
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 05:07:45 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
	<1488317230-26248-4-git-send-email-armbru@redhat.com>
	<3ecd3de0-c390-984d-daa6-0c7e609b9e9f@redhat.com>
	<8760ju561c.fsf@dusky.pond.sub.org>
Date: Sun, 05 Mar 2017 11:07:35 +0100
In-Reply-To: <8760ju561c.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 28 Feb 2017 23:01:19 +0100")
Message-ID: <87y3wkavfc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 03/24] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 02/28/2017 03:26 PM, Markus Armbruster wrote:
>>> keyval_parse() parses KEY=VALUE,... into a QDict.  Works like
>>> qemu_opts_parse(), except:
>>> 
>>> * Returns a QDict instead of a QemuOpts (d'oh).
>>> 
>>> * Supports nesting, unlike QemuOpts: a KEY is split into key
>>>   fragments at '.' (dotted key convention; the block layer does
>>>   something similar on top of QemuOpts).  The key fragments are QDict
>>>   keys, and the last one's value is updated to VALUE.
>>> 
>>> * Each key fragment may be up to 127 bytes long.  qemu_opts_parse()
>>>   limits the entire key to 127 bytes.
>>> 
>>> * Overlong key fragments are rejected.  qemu_opts_parse() silently
>>>   truncates them.
>>> 
>>> * Empty key fragments are rejected.  qemu_opts_parse() happily
>>>   accepts empty keys.
>>> 
>>> * It does not store the returned value.  qemu_opts_parse() stores it
>>>   in the QemuOptsList.
>>> 
>>> * It does not treat parameter "id" specially.  qemu_opts_parse()
>>>   ignores all but the first "id", and fails when its value isn't
>>>   id_wellformed(), or duplicate (a QemuOpts with the same ID is
>>>   already stored).  It also screws up when a value contains ",id=".
>>> 
>>> * Implied value is not supported.  qemu_opts_parse() desugars "foo" to
>>>   "foo=on", and "nofoo" to "foo=off".
>>> 
>>> * An implied key's value can't be empty, and can't contain ','.
>>
>> or '=' (but the presence of '=' means no implied key, while the presence
>> of ',' marks end of the implied key's value).  Not sure it's worth
>> tweaking this commit message any further.
>
> Both fail the assertion they're meant to fail (I tested).  I'll fix the
> commit message.

Actually, there is nothing to fix, because there's no difference to
qemu_opts_parse().

Note that the comment in the code documents both ',' and '=', because
it's about keyval_parse(), not its difference to qemu_opts_parse().

>>> I intend to grow this into a saner replacement for QemuOpts.  It'll
>>> take time, though.
>>> 
>>> Note: keyval_parse() provides no way to do lists, and its key syntax
>>> is incompatible with the __RFQDN_ prefix convention for downstream
>>> extensions, because it blindly splits at '.', even in __RFQDN_.  Both
>>> issues will be addressed later in the series.
>>> 
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>> Looks like you addressed all the comments.
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Thanks!
