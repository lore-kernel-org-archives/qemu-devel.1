Received: from eggs.gnu.org ([2001:4830:134:3::10]:37596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4k3l-0007qf-0y
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4k3Y-0005Tp-Jj
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4k3Y-0005Rk-4r
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:50:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE0797EA88
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 08:50:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171012120432.GC2343@work-vm> (David Alan Gilbert's message of
	"Thu, 12 Oct 2017 13:04:33 +0100")
References: <20171010181542.24168-1-quintela@redhat.com>
	<20171010181542.24168-10-quintela@redhat.com>
	<20171012120432.GC2343@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 18 Oct 2017 10:50:17 +0200
Message-ID: <878tg8on5i.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/10] migration: Make xbzrle_cache_size a
 migration parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Right now it is a variable in MigrationState instead of a
>> MigrationParameter.  The change allows to set it as the rest of the
>> Migration parameters, from the command line, with
>> query_migration_paramters, set_migrate_parameters, etc.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>>  static void migrate_params_apply(MigrateSetParameters *params)
>> @@ -939,6 +954,10 @@ static void migrate_params_apply(MigrateSetParameters *params)
>>      if (params->has_x_multifd_page_count) {
>>          s->parameters.x_multifd_page_count = params->x_multifd_page_count;
>>      }
>> +    if (params->has_xbzrle_cache_size) {
>> +        s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
>> +        xbzrle_cache_resize(params->xbzrle_cache_size, NULL);
>
> Not having the errp is a pain;   you've just moved all the error
> checking into xbzrle_cache_resize, so I think we really need an error
> pointer and to do something with it (even if it's just a local report).

ok.


>> @@ -474,6 +474,10 @@
>>  # @x-multifd-page-count: Number of pages sent together to a thread
>>  #                        The default value is 16 (since 2.11)
>>  #
>> +# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
>> +#                     needs to be a multiple of the target page size
>
> and power of 2
>
>> +#                     (Since 2.11)
>> +#
>>  # Since: 2.4
>>  ##
>>  { 'enum': 'MigrationParameter',
>> @@ -481,7 +485,8 @@
>>             'cpu-throttle-initial', 'cpu-throttle-increment',
>>             'tls-creds', 'tls-hostname', 'max-bandwidth',
>>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>> -           'x-multifd-channels', 'x-multifd-page-count' ] }
>> +           'x-multifd-channels', 'x-multifd-page-count',
>> +           'xbzrle-cache-size' ] }
>>  
>>  ##
>>  # @MigrateSetParameters:
>> @@ -545,6 +550,9 @@
>>  # @x-multifd-page-count: Number of pages sent together to a thread
>>  #                        The default value is 16 (since 2.11)
>>  #
>> +# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
>> +#                     needs to be a multiple of the target page size
>> +#                     (Since 2.11)
>
> and power of 2
>
>>  # Since: 2.4
>>  ##
>>  # TODO either fuse back into MigrationParameters, or make
>> @@ -562,7 +570,8 @@
>>              '*x-checkpoint-delay': 'int',
>>              '*block-incremental': 'bool',
>>              '*x-multifd-channels': 'int',
>> -            '*x-multifd-page-count': 'int' } }
>> +            '*x-multifd-page-count': 'int',
>> +            '*xbzrle-cache-size': 'size' } }
>>  
>>  ##
>>  # @migrate-set-parameters:
>> @@ -641,6 +650,9 @@
>>  # @x-multifd-page-count: Number of pages sent together to a thread
>>  #                        The default value is 16 (since 2.11)
>>  #
>> +# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
>> +#                     needs to be a multiple of the target page size
>> +#                     (Since 2.11)
>
> and power of 2 (wow this text is repeated a lot)

We repeat each parameter three times, and the text another three times.

Could we just put a pointer telling that documentation is in a single
place and call it a day?

I know that we need to declare the name in three places for historical
reasons, but at least the help can be done in a single place, or is the
text taken automagically?

Later, Juan.
