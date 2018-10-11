Received: from eggs.gnu.org ([2001:4830:134:3::10]:39824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAeii-0008L1-SC
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAeie-0005fC-QC
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAeie-0005ed-HL
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:25:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-2-armbru@redhat.com>
	<bcd7e170-8728-f691-f357-b0f8f6d811ed@redhat.com>
Date: Thu, 11 Oct 2018 19:25:49 +0200
In-Reply-To: <bcd7e170-8728-f691-f357-b0f8f6d811ed@redhat.com> (Eric Blake's
	message of "Mon, 8 Oct 2018 15:32:56 -0500")
Message-ID: <87h8hsz97m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 01/31] Use error_fatal to simplify obvious
 fatal errors (again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Eric Blake <eblake@redhat.com> writes:

> On 10/8/18 12:30 PM, Markus Armbruster wrote:
>> Add a slight improvement of the Coccinelle semantic patch from commit
>> 07d04a0219b,
>
> which shares the same commit title, but does not actually have a
> semantic patch, but rather defers to the even older 007b065.  But I'm
> not too worried about either the duplicated commit title nor the chain
> of references to follow - as this is a no-semantic-change patch rather
> than a bugfix, it's less likely to cause confusion to any downstream
> backport efforts.

I'm changing the reference to 007b06578ab anyway.

>> and use it to clean up.  It leaves dead Error * variables
>> behind, cleaned up manually.
>
> Coccinelle can handle that too, if we want to make the .cocci file
> longer (but off-hand, I don't remember the exact semantic patch
> formula to express a variable that is initialized but then never used,
> as a result of applying earlier semantic patches). So the manual
> cleanup for now still seems tractable.

We can track down the recipe when the manual cleanup becomes tiresome.

>>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/intc/xics_kvm.c                       |  7 +------
>>   qemu-nbd.c                               |  6 +-----
>>   scripts/coccinelle/use-error_fatal.cocci | 20 ++++++++++++++++++++
>>   vl.c                                     |  7 +------
>>   4 files changed, 23 insertions(+), 17 deletions(-)
>>   create mode 100644 scripts/coccinelle/use-error_fatal.cocci
>>
>
>> +++ b/scripts/coccinelle/use-error_fatal.cocci
>> @@ -0,0 +1,20 @@
>> +@@
>> +type T;
>> +identifier FUN, RET;
>> +expression list ARGS;
>> +expression ERR, EC, FAIL;
>
> The slight improvement from the original git commit log script is the
> addition of FAIL,
>
>> +@@
>> +(
>> +-    T RET = FUN(ARGS, &ERR);
>> ++    T RET = FUN(ARGS, &error_fatal);
>> +|
>> +-    RET = FUN(ARGS, &ERR);
>> ++    RET = FUN(ARGS, &error_fatal);
>> +|
>> +-    FUN(ARGS, &ERR);
>> ++    FUN(ARGS, &error_fatal);
>> +)
>> +-    if (FAIL) {
>
> and a check for arbitrary condition FAIL rather than a more specific
> ERR != NULL.  Makes sense.

Yes.

>> +-        error_report_err(ERR);
>> +-        exit(EC);
>> +-    }
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
