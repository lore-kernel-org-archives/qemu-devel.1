Received: from eggs.gnu.org ([2001:4830:134:3::10]:34477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSIx8-0004po-H3
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSIx3-0003Lw-Hr
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:12:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dSIx3-0003Kf-9j
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:12:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BF60C0567A3
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 08:12:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<1499049848-18012-3-git-send-email-peterx@redhat.com>
	<20170703145903.GL12152@localhost.localdomain>
Date: Tue, 04 Jul 2017 10:12:45 +0200
In-Reply-To: <20170703145903.GL12152@localhost.localdomain> (Eduardo Habkost's
	message of "Mon, 3 Jul 2017 11:59:03 -0300")
Message-ID: <87zickr56q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] vl: move global property,
 migrate init earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Jul 03, 2017 at 10:44:06AM +0800, Peter Xu wrote:
>> Currently drive_init_func() may call migrate_get_current() while the
>> migrate object is still not ready yet at that time. Move the migration
>> object init earlier, along with the global properties, right after
>> acceleration init.
>>=20
>> This fixes a breakage for iotest 055, which caused an assertion failure.
>>=20
>> Reported-by: Max Reitz <mreitz@redhat.com>
>> Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Fixes: 3df663 ("migration: move only_migratable to MigrationState")
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  vl.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/vl.c b/vl.c
>> index 0c497a3..2ae4313 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4414,6 +4414,18 @@ int main(int argc, char **argv, char **envp)
>>=20=20
>>      configure_accelerator(current_machine);
>>=20=20
>> +    /*
>> +     * Register all the global properties, including accel properties,
>> +     * machine properties, and user-specified ones.
>> +     */
>> +    register_global_properties(current_machine);
>> +
>> +    /*
>> +     * Migration object can only be created after global properties
>> +     * are applied correctly.
>> +     */
>> +    migration_object_init();
>> +
>
> So, things that might introduce bugs here are:
> 1) Unexpected qdev_prop_register_global() calls between this place and
>    the original register_global_properties() call (that would now happen
>    in a different order).
> 2) register_global_properties() seeing a different global property list
>    because it is being called earlier.
>    2.1) AccelClass::global_props is statically defined and will be the
>         same here. Not a problem.
>    2.2) MachineClass::compat_props: same as above.
>    2.3) user-provided global properties: we need to ensure all
>         properties in the "global" QemuOpts section are already
>         available at this point.

This stuff is fragile.  There are lots of dependencies, all implicit,
and once again we reorder things ever so slightly to keep them
satisfied.  We could certainly use a more robust solution.

[...]
