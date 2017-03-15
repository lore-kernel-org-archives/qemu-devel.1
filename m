Received: from eggs.gnu.org ([2001:4830:134:3::10]:46584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3Gx-00022B-C9
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3Gs-0004KX-Bq
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:23:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co3Gs-0004KJ-2z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:22:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-18-git-send-email-armbru@redhat.com>
	<c90b20a4-8180-4f73-6a99-bf71e124ea77@redhat.com>
Date: Wed, 15 Mar 2017 08:22:54 +0100
In-Reply-To: <c90b20a4-8180-4f73-6a99-bf71e124ea77@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 12:59:45 -0500")
Message-ID: <87fuifrokx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 17/47] qapi: The #optional tag is
 redundant, drop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> We traditionally mark optional members #optional in the doc comment.
>> Before commit 3313b61, this was entirely manual.
>> 
>> Commit 3313b61 added some automation because its qapi2texi.py relied
>> on #optional to determine whether a member is optional.  This is no
>> longer the case since the previous commit: the only thing qapi2texi.py
>> still does with #optional is stripping it out.  We still reject bogus
>> qapi-schema.json and six places for qga/qapi-schema.json.
>> 
>> Thus, you can't actually rely on #optional to see whether something is
>> optional.  Yet we still make people add it manually.  That's just
>> busy-work.
>
> Yay! Let the computer do the work for us!
>
>> 
>> Drop the code to check, fix up and strip out #optional, along with all
>> instances of #optional.  To keep it out, add code to reject it, to be
>> dropped again once the dust settles.
>> 
>> No change to generated documentation.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> @@ -150,10 +148,10 @@ For example:
>>  #
>>  # Statistics of a virtual block device or a block backing device.
>>  #
>> -# @device: #optional If the stats are for a virtual block device, the name
>> -#          corresponding to the virtual block device.
>> +# @device: If the stats are for a virtual block device, the name
>> +# corresponding to the virtual block device.
>
> This loses the hanging indentation in the example, but I don't see you
> making that change in the actual .json files.  It shouldn't matter in
> the long run, and is certainly easier if the way you generated this
> patch was with sed scripts (where computing correct hanging indentation
> after rewrapping is a lot harder than omitting it).

Obvious sed job.

>                                                      I don't have any
> strong opinions about the change (less typing, but slightly harder to
> visually see that the following lines belong to the same parameter doc,
> if you don't have blank lines between distinct parameter docs).  I'm not
> even sure if it you want to call it out in the commit message as an
> intentional reformat, particularly since you didn't do it everywhere.

I'll touch up this patch to change qapi-code-gen.txt exactly like the
schema.

>> +++ b/qapi-schema.json
>> @@ -150,10 +150,10 @@
>>  #
>>  # @fdname: file descriptor name previously passed via 'getfd' command
>>  #
>> -# @skipauth: #optional whether to skip authentication. Only applies
>> +# @skipauth: whether to skip authentication. Only applies
>>  #            to "vnc" and "spice" protocols
>>  #
>> -# @tls: #optional whether to perform TLS. Only applies to the "spice"
>> +# @tls: whether to perform TLS. Only applies to the "spice"
>>  #       protocol
>
> Again, whitespace changes shouldn't affect generated output, so
> rewrapping lines like this would be more busy-work than necessary, even
> though this particular example would now fit on one line.
>
>> @@ -667,45 +667,45 @@
>>  #
> ...
>>  #
>> -# @setup-time: #optional amount of setup time in milliseconds _before_ the
>> +# @setup-time: amount of setup time in milliseconds _before_ the
>>  #        iterations begin but _after_ the QMP command is issued. This is designed
>>  #        to provide an accounting of any activities (such as RDMA pinning) which
>>  #        may be expensive, but do not actually occur during the iterative
>>  #        migration rounds themselves. (since 1.6)
>
> Here's another place where wrapping now looks odd (short, followed by
> multiple longer lines).  Again, the effort of rewrapping lines is not
> worth the churn (and it's actually easier to read diffs that _don't_
> reflow text).  So I'll just overlook wrapping oddities in the rest of
> the patch, as inconsequential to the end result.

A sufficiently clever Emacs macro could give us more pleasantly wrapped
lines, at the cost of a messier diff.  I'll experiment if time permits.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
