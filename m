Received: from eggs.gnu.org ([2001:4830:134:3::10]:47394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHuiK-0000Vn-LV
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHuiE-00064O-Pw
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHuiB-0005zi-2T
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:55:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-2-david@redhat.com>
	<87pnvqdvsj.fsf@dusky.pond.sub.org>
	<e8fe86a1-d075-2ea8-d1f4-e08e5dceee07@redhat.com>
Date: Wed, 31 Oct 2018 18:55:12 +0100
In-Reply-To: <e8fe86a1-d075-2ea8-d1f4-e08e5dceee07@redhat.com> (David
	Hildenbrand's message of "Wed, 31 Oct 2018 17:47:13 +0100")
Message-ID: <875zxingqn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/7] qapi: use qemu_strtoi64() in
 parse_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

David Hildenbrand <david@redhat.com> writes:

> On 31.10.18 15:40, Markus Armbruster wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> The qemu api claims to be easier to use, and the resulting code seems to
>>> agree.
[...]
>>> @@ -60,9 +61,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>>      }
>>>  
>>>      do {
>>> -        errno = 0;
>>> -        start = strtoll(str, &endptr, 0);
>>> -        if (errno == 0 && endptr > str) {
>>> +        if (!qemu_strtoi64(str, &endptr, 0, &start)) {
>>>              if (*endptr == '\0') {
>>>                  cur = g_malloc0(sizeof(*cur));
>>>                  range_set_bounds(cur, start, start);
>>> @@ -71,11 +70,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>>                  str = NULL;
>>>              } else if (*endptr == '-') {
>>>                  str = endptr + 1;
>>> -                errno = 0;
>>> -                end = strtoll(str, &endptr, 0);
>>> -                if (errno == 0 && endptr > str && start <= end &&
>>> -                    (start > INT64_MAX - 65536 ||
>>> -                     end < start + 65536)) {
>>> +                if (!qemu_strtoi64(str, &endptr, 0, &end) && start < end) {
>> 
>> You deleted (start > INT64_MAX - 65536 || end < start + 65536).  Can you
>> explain that to me?  I'm feeling particularly dense today...
>
> qemu_strtoi64 performs all different kinds of error handling completely
> internally. This old code here was an attempt to filter out -EWHATEVER
> from the response. No longer needed as errors and the actual value are
> reported via different ways.

I understand why errno == 0 && endptr > str go away.  They also do in
the previous hunk.

The deletion of (start > INT64_MAX - 65536 || end < start + 65536) is
unobvious.  What does it do before the patch?

The condition goes back to commit 659268ffbff, which predates my watch
as maintainer.  Its commit message is of no particular help.  Its code
is... allright, the less I say about that, the better.

We're parsing a range here.  We already parsed its lower bound into
@start (and guarded against errors), and its upper bound into @end (and
guarded against errors).

If the condition you delete is false, we goto error.  So the condition
is about range validity.  I figure it's an attempt to require valid
ranges to be no "wider" than 65535.  The second part end < start + 65536
checks exactly that, except shit happens when start + 65536 overflows.
The first part attempts to guard against that, but

(1) INT64_MAX is *wrong*, because we compute in long long, and

(2) it rejects even small ranges like INT64_MAX - 2 .. INT64_MAX - 1.

WTF?!?

Unless I'm mistaken, the condition is not about handling any of the
errors that qemu_strtoi64() handles for us.

The easiest way for you out of this morass is probably to keep the
condition exactly as it was, then use the "my patch doesn't make things
any worse" get-out-of-jail-free card.
