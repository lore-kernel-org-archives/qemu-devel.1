Received: from eggs.gnu.org ([2001:4830:134:3::10]:44625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1egrc5-0005yn-6x
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1egrc0-0003CL-Cn
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:35:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1egrc0-0003Bp-23
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:35:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FD21524E
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 12:35:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180131120339.GC31397@xz-mi> (Peter Xu's message of "Wed, 31
	Jan 2018 20:03:39 +0800")
References: <20180129121754.13033-1-quintela@redhat.com>
	<20180129121754.13033-3-quintela@redhat.com>
	<20180131120339.GC31397@xz-mi>
Reply-To: quintela@redhat.com
Date: Wed, 31 Jan 2018 13:35:33 +0100
Message-ID: <87lgge9pey.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 2/5] migration: Set the migration tcp
 port
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
> On Mon, Jan 29, 2018 at 01:17:51PM +0100, Juan Quintela wrote:
>> We can set the port parameter as zero.  This patch lets us know what
>> port the system was choosen for us.  Now we can migrate to this place.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> --
>> 
>> This was migrate_set_uri(), but as we only need the tcp_port, change
>> to that one.
>> ---
>>  migration/migration.c | 10 ++++++++++
>>  migration/migration.h |  2 ++
>>  migration/socket.c    | 35 ++++++++++++++++++++++++++++++-----
>>  3 files changed, 42 insertions(+), 5 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index eb6958dcda..53818a87af 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -245,6 +245,16 @@ void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
>>      }
>>  }
>>  
>> +void migrate_set_port(const uint16_t port, Error **errp)
>> +{
>> +    MigrateSetParameters p = {
>> +        .has_x_tcp_port = true,
>> +        .x_tcp_port = port,
>> +    };
>> +
>> +    qmp_migrate_set_parameters(&p, errp);
>
> If we are calling qmp_migrate_set_parameters() here, does it mean that
> user can also set this parameter via QMP?

Yeap.  We do that, or we invent yet another mechanism to update the
tcp_port parameter :-(

You can't have both.

if the user modifies it, it just shots itself it its feet, no?

>>                           "migration-socket-listener");
>>  
>>      if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
>>          object_unref(OBJECT(listen_ioc));
>> -        return;
>> +        return NULL;
>> +    }
>> +
>> +    address = qio_channel_socket_get_local_address(listen_ioc, errp);
>
> [1]
>
>> +    if (address < 0) {
>> +        object_unref(OBJECT(listen_ioc));
>> +        return NULL;
>>      }
>>  
>>      qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
>
> [2]
>
>> @@ -178,14 +186,28 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>>                            socket_accept_incoming_migration,
>>                            listen_ioc,
>>                            (GDestroyNotify)object_unref);
>> +    return address;
>>  }
>>  
>>  void tcp_start_incoming_migration(const char *host_port, Error **errp)
>>  {
>>      Error *err = NULL;
>>      SocketAddress *saddr = tcp_build_address(host_port, &err);
>> +
>>      if (!err) {
>> -        socket_start_incoming_migration(saddr, &err);
>> +        SocketAddress *address = socket_start_incoming_migration(saddr, &err);
>> +
>> +        if (address) {
>> +            unsigned long long port;
>> +
>> +            if (parse_uint_full(address->u.inet.port, &port, 10) < 0) {
>> +                error_setg(errp, "error parsing port in '%s'",
>> +                           address->u.inet.port);
>> +            } else {
>> +                migrate_set_port(port, errp);
>> +            }
>
> If *errp is non-NULL when reach here (I don't know when this will
> happen, though), would there be a dangling incoming task in main
> thread (which was created during socket_start_incoming_migration at
> [2])?
>
> Not sure whether it can be fixed by moving the set port logic to [1]
> above.  Then the watch won't be created only if set port succeeded.

Ok, will take a look at reorganizing the code.

Thanks for the review.

Later, Juan.
