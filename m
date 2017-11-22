Received: from eggs.gnu.org ([2001:4830:134:3::10]:36203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHUAH-0008HP-EO
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHUAD-00020a-Gx
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:30:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHUAD-0001zZ-Bl
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:30:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91C5B37E6E
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 12:30:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171103100746.GC20155@redhat.com> (Daniel P. Berrange's message
	of "Fri, 3 Nov 2017 10:07:46 +0000")
References: <20171030112112.6952-1-quintela@redhat.com>
	<20171030112112.6952-6-quintela@redhat.com>
	<20171103100746.GC20155@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Nov 2017 13:29:57 +0100
Message-ID: <873756pkca.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/6] migration: Now set the migration uri
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Mon, Oct 30, 2017 at 12:21:11PM +0100, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/migration.c | 25 ++++++++++++++++++-------
>>  migration/migration.h |  2 ++
>>  migration/socket.c    |  7 +++++++
>>  3 files changed, 27 insertions(+), 7 deletions(-)
>
>
>> diff --git a/migration/socket.c b/migration/socket.c
>> index 3a8232dd2d..c3ab81d1fb 100644
>> --- a/migration/socket.c
>> +++ b/migration/socket.c
>> @@ -187,7 +187,14 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
>>      Error *err = NULL;
>>      SocketAddress *saddr = tcp_build_address(host_port, &err);
>>      if (!err) {
>> +        char *new_uri;
>>          socket_start_incoming_migration(saddr, &err);
>> +        if (!err) {
>> +            new_uri = g_strdup_printf("tcp:%s:%s", saddr->u.inet.host,
>> +                                      saddr->u.inet.port);
>
> This is bad as it is throwing away data that the original URI had. In particular
> you loose the 'ipv4=on|off' and 'ipv6=on|off' flags. If you need to keep the
> original URI for later, then why not just keep the 'host_port' parameter that
> was passed into this function instead of trying to reverse engineeer the URI ?

I don't need the original uri anymore, this is the incoming side of
migration, and we can only set that once, if migration fails, we need to
restart qemu anymore.

I changed it to this:

            new_uri = g_strdup_printf("tcp:%s:%s%s%s", address->u.inet.host,
                                      address->u.inet.port,
                                      iaddr->has_ipv4 ? ",ipv4" : "",
                                      iaddr->has_ipv6 ? ",ipv6" : "");


Clearly, we don't care about the to= parameter.

The whole point of this exercise is that in destination, we use

-incoming tcp:0:0

and with the output of info migrate_parameters (uri) we are able to
migrate to that place.  For rest of migration posibilities, there is no
changes at all.


Thanks, Juan.
