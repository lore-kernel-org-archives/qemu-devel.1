Received: from eggs.gnu.org ([2001:4830:134:3::10]:59139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXXEJ-00018j-Oe
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 14:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXXEI-0008EA-NT
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 14:28:19 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-7-git-send-email-armbru@redhat.com>
	<6bf7ff84-5286-fd21-c9a8-f25f2e37df50@redhat.com>
Date: Tue, 18 Jul 2017 20:28:10 +0200
In-Reply-To: <6bf7ff84-5286-fd21-c9a8-f25f2e37df50@redhat.com> (Eric Blake's
	message of "Tue, 18 Jul 2017 12:34:49 -0500")
Message-ID: <87o9shk3b9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 06/10] hmp: Clean up and simplify
 hmp_migrate_set_parameter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/18/2017 08:41 AM, Markus Armbruster wrote:
>> The bulk of hmp_migrate_set_parameter()'s code sets one member of
>> MigrationParameters according to the command's arguments.  It uses a
>> string visitor for integer and boolean members, but not for string and
>> size members.  It calls visit_type_bool() right away, but delays
>> visit_type_int() some.  The delaying requires a flag variable and a
>> bit of trickery: we set all integer members instead of just the one we
>> want, and rely on the has_FOOs to mask the unwanted ones.
>> 
>> Clean this up as follows.  Don't delay calling visit_type_int().  Use
>> the string visitor for strings, too.  This involves extra allocations
>> and cleanup, but doing them is simpler and cleaner than avoiding them.
>> 
>> Sadly, using the string visitor for sizes isn't possible, because it
>> defaults to Bytes rather than Mebibytes.  Add a comment explaining
>> that.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hmp.c | 78 ++++++++++++++++++++++++++++---------------------------------------
>>  1 file changed, 32 insertions(+), 46 deletions(-)
>>
>
> Diffstat says it's cleaner.
>
>>              case MIGRATION_PARAMETER_MAX_BANDWIDTH:
>> -                p.has_max_bandwidth = true;
>> +                p->has_max_bandwidth = true;
>> +                /*
>> +                 * Can't use visit_type_size() here, because it
>> +                 * defaults to Bytes rather than Mebibytes.
>> +                 */
>>                  ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
>
> Can we munge valuestr (if it has a suffix, leave it alone; if it has
> none, tack on "M"), and then call the size visitor as usual?

We could, but I expect it to be more complicated than this inline copy.

A possible alternative is adding flags to string_input_visitor_new().  I
suspect that will also be more complicated once you add tests.  Keeping
non-standard suffixes somewhat bothersome will at least help prevent
more of them.

>>                  if (ret < 0 || valuebw > INT64_MAX
>>                      || (size_t)valuebw != valuebw) {
>>                      error_setg(&err, "Invalid size %s", valuestr);
>> -                    goto cleanup;
>> +                    break;
>>                  }
>
> But for now, the inline version works.

>> -                /* Set all integers; only one has_FOO will be set, and
>> -                 * the code ignores the remaining values */
>> -                p.compress_level = valueint;
>> -                p.compress_threads = valueint;
>> -                p.decompress_threads = valueint;
>> -                p.cpu_throttle_initial = valueint;
>> -                p.cpu_throttle_increment = valueint;
>> -                p.downtime_limit = valueint;
>> -                p.x_checkpoint_delay = valueint;
>> +            if (err) {
>> +                goto cleanup;
>>              }
>>  
>> -            qmp_migrate_set_parameters(&p, &err);
>
> The old code is calling qmp_migrate_set_parameters() once per loop
> iteration, because it could only parse one integer per loop.
>
>> +            qmp_migrate_set_parameters(p, &err);
>
> But couldn't you now sink this below the loop, and call it only once
> after all members are parsed?  Can be a separate patch, though.

The whole switch could sink along.  Left for another day.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
