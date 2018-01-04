Received: from eggs.gnu.org ([2001:4830:134:3::10]:47583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXA5s-00014V-KV
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXA5r-0003C7-Lk
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:18:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXA5r-0003Av-DC
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:18:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E0BE34CD
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 18:18:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171205080230.GD2925@xz-mi> (Peter Xu's message of "Tue, 5 Dec
	2017 16:02:30 +0800")
References: <20171201125750.1372-1-quintela@redhat.com>
	<20171201125750.1372-2-quintela@redhat.com>
	<20171205080230.GD2925@xz-mi>
Reply-To: quintela@redhat.com
Date: Thu, 04 Jan 2018 19:18:15 +0100
Message-ID: <87mv1ta3o8.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/2] migration: Create tcp_port parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:

>> @@ -1659,6 +1662,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>          }
>>          p->xbzrle_cache_size = cache_size;
>>          break;
>> +    case MIGRATION_PARAMETER_TCP_PORT:
>> +        p->has_tcp_port = true;
>> +        visit_type_uint16(v, param, &p->tcp_port, &err);
>
> Should we allow user to set this parameter?  Or it's just used for
> query, only?  (AFAIU from next patch, this is only used for query)

Only for query.  Really it is only needed for tcp, due to the wierd way
that ports are allocated to allow for test running in parallel safely.

>
>> +        break;
>>      default:
>>          assert(0);
>>      }
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 19917a4b5b..abc02d4efd 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -517,6 +517,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>>      params->x_multifd_page_count = s->parameters.x_multifd_page_count;
>>      params->has_xbzrle_cache_size = true;
>>      params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
>> +    params->has_tcp_port = true;
>> +    params->tcp_port = s->parameters.tcp_port;
>>  
>>      return params;
>>  }
>> @@ -884,6 +886,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>>      if (params->has_xbzrle_cache_size) {
>>          dest->xbzrle_cache_size = params->xbzrle_cache_size;
>>      }
>> +    if (params->has_tcp_port) {
>> +        dest->tcp_port = params->tcp_port;
>> +    }
>>  }
>>  
>>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>> @@ -956,6 +961,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>>          s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
>>          xbzrle_cache_resize(params->xbzrle_cache_size, errp);
>>      }
>> +    if (params->has_tcp_port) {
>> +        s->parameters.tcp_port = params->tcp_port;
>> +    }
>>  }
>>  
>>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>> @@ -2422,6 +2430,8 @@ static Property migration_properties[] = {
>>      DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
>>                        parameters.xbzrle_cache_size,
>>                        DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
>> +    DEFINE_PROP_UINT16("x-tcp-port", MigrationState,
>> +                       parameters.tcp_port, 0),
>
> Same question here...  If it's only for querying, why allow user to
> specify it?

You are right.

Because *I* changed the x-uri bits into this.  and for x-uri it made
sense.

And I just did the conversion, witohut too much thinking.

Later, Juan.
