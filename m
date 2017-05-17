Received: from eggs.gnu.org ([2001:4830:134:3::10]:36553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB2L2-0003g9-0p
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB2Ky-0001x2-Uu
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:02:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB2Ky-0001wp-Lz
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:02:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CBD119D4CF
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 17:02:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <2c957f44-3318-0f99-6f6e-936df2bce154@redhat.com> (Eric Blake's
	message of "Wed, 17 May 2017 10:52:11 -0500")
References: <20170517153812.21993-1-quintela@redhat.com>
	<20170517153812.21993-3-quintela@redhat.com>
	<2c957f44-3318-0f99-6f6e-936df2bce154@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 May 2017 19:02:07 +0200
Message-ID: <87k25fbenk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, armbru@redhat.com

Eric Blake <eblake@redhat.com> wrote:
> On 05/17/2017 10:38 AM, Juan Quintela wrote:
>> Create one capability for block migration and one parameter for
>> incremental block migration.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> ---
>> 
>> @@ -1207,6 +1242,26 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>>          return;
>>      }
>>  
>> +    if (((has_blk && blk) || (has_inc && inc))
>> +        && (migrate_use_block() || migrate_use_block_incremental())) {
>> +        error_setg(errp, "Command options are incompatible with current "
>> +                   "migration capabilities");
>> +        return;
>> +    }
>> +
>> +    if ((has_blk && blk) || (has_inc & inc)) {
>> +        migrate_set_block_enabled(true, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>> +        s->must_remove_block_options = true;
>> +    }
>
> You wrote:
> if (A && B) {
>   error;
> }
> if (A) {
>   stuff;
> }
>
> I might have done:
>
> if (A) {
>   if (B) {
>     error;
>   }
>   stuff;
> }
>
> but it's the same either way.

One less line, and as I have to respin due to the last patch.

>> +++ b/qapi-schema.json
>> @@ -894,11 +894,18 @@
>>  # @release-ram: if enabled, qemu will free the migrated ram pages on the source
>>  #        during postcopy-ram migration. (since 2.9)
>>  #
>> +# @block: If enabled, QEMU will also migrate the contents of all block
>> +#          devices.  Default is disabled.  A possible alternative are
>
> s/are/uses/

done

>> +#          mirror jobs to a builtin NBD server on the destination, which
>> +#          are more flexible.
>
> s/are more flexible/offers more flexibility/

done

>> +#          (Since 2.10)
>> +#
>>  # Since: 1.2
>>  ##
>>  { 'enum': 'MigrationCapability',
>>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>> -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
>> +           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>> +           'block' ] }
>>  
>
> The grammar touchups can be done in preparing the pull request, if there
> is no other reason for a respin.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, Juan.
