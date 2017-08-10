Received: from eggs.gnu.org ([2001:4830:134:3::10]:58188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfqOk-0006Fi-2u
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfqOf-000468-5o
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:33:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfqOe-00045i-Sm
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:33:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
	<1502367921-17730-3-git-send-email-armbru@redhat.com>
	<7ce274ba-e487-4f16-4620-8c68a3ace35d@redhat.com>
Date: Thu, 10 Aug 2017 18:33:16 +0200
In-Reply-To: <7ce274ba-e487-4f16-4620-8c68a3ace35d@redhat.com> (Eric Blake's
	message of "Thu, 10 Aug 2017 09:59:31 -0500")
Message-ID: <87inhv8jsj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, el13635@mail.ntua.gr

Eric Blake <eblake@redhat.com> writes:

> On 08/10/2017 07:25 AM, Markus Armbruster wrote:
>> We've wanted -object to support non-scalar properties for a while.
>> Dan Berrange tried in "[PATCH v4 00/10]Provide a QOM-based
>> authorization API".  Review led to the conclusion that we need to
>> replace rather than add to QemuOpts.  Initial work towards that goal
>> has been merged to provide -blockdev (commit 8746709), but there's
>> substantial work left, mostly due to an bewildering array of
>> compatibility problems.
>> 
>> Even if a full solution is still out of reach, we can have a partial
>> solution now: accept -object argument in JSON syntax.  This should
>> unblock development work that needs non-scalar properties with -object
>> 
>
> Trailing dot?

Will fix.

>> The implementation is similar to -blockdev, except we use the new
>> infrastructure only for the new JSON case, and stick to QemuOpts for
>> the existing KEY=VALUE,... case, to sidestep compatibility problems.
>> 
>> If we did this for more options, we'd have to factor out common code.
>> But for one option, this will do.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi-schema.json | 14 +++++++++++---
>>  vl.c             | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 66 insertions(+), 3 deletions(-)
>> 
>
> 2.11 material.

Yes.

>> @@ -4078,6 +4102,29 @@ int main(int argc, char **argv, char **envp)
>>  #endif
>>                  break;
>>              case QEMU_OPTION_object:
>> +                /*
>> +                 * TODO Use qobject_input_visitor_new_str() instead of
>> +                 * QemuOpts, not in addition to.  Not done now because
>> +                 * keyval_parse() isn't wart-compatible with QemuOpts.
>> +                 */
>> +                if (optarg[0] == '{') {
>
> So we DON'T allow " {...}", even though that is valid JSON.  I'm okay
> with stating that { is magic only as the first byte.

Consistent with -blockdev.  Can improve later, if we want to.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Do we need any documentation additions (whether in --help output, or in
> the man page, or ?)

Let's not advertise this just yet.  It's mostly so that Manos can make
progress while we work on the full solution (he wants to use -object for
throttle filters, and needs non-scalar properties).
