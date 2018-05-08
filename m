Received: from eggs.gnu.org ([2001:4830:134:3::10]:39518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fFxXy-0003UY-Lf
	for qemu-devel@nongnu.org; Tue, 08 May 2018 04:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fFxXq-00047C-Td
	for qemu-devel@nongnu.org; Tue, 08 May 2018 04:00:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fFxXq-00046n-LF
	for qemu-devel@nongnu.org; Tue, 08 May 2018 04:00:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 513E340201A3
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 08:00:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180413120120.GE16263@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Fri, 13 Apr 2018 13:01:20 +0100")
References: <20180404112731.5922-1-quintela@redhat.com>
	<20180404112731.5922-5-quintela@redhat.com>
	<20180413120120.GE16263@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 08 May 2018 10:02:32 +0200
Message-ID: <87lgcua82v.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 4/8] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Wed, Apr 04, 2018 at 01:27:27PM +0200, Juan Quintela wrote:
>> It will be used to store the uri parameters. We want this only for
>> tcp, so we don't set it for other uris.  We need it to know what port
>> is migration running.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> @@ -277,6 +279,21 @@ int migrate_send_rp_req_pages(MigrationIncomingStat=
e *mis, const char *rbname,
>>      return migrate_send_rp_message(mis, msg_type, msglen, bufc);
>>  }
>>=20=20
>> +void migrate_set_address(SocketAddress *address)
>
> s/set/add/ in the method name since you're expecting this to be called
> multiple times, augmenting the value, not replacing it.

Makes sense, done.

>> @@ -564,6 +581,11 @@ MigrationParameters *qmp_query_migrate_parameters(E=
rror **errp)
>>      params->x_multifd_page_count =3D s->parameters.x_multifd_page_count;
>>      params->has_xbzrle_cache_size =3D true;
>>      params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
>> +    if (s->parameters.socket_address) {
>
> nitpick, should really check  s->parameters.has_socket_address

Changed to state, no has_socket_address on mis-> anymore (if
socket_address !=3D NULL, we know there are some)


>> @@ -152,6 +153,7 @@ static void socket_start_incoming_migration(SocketAd=
dress *saddr,
>>                                              Error **errp)
>>  {
>>      QIONetListener *listener =3D qio_net_listener_new();
>> +    int i;
>
> Nitpick   size_t for array indexes

changed.

>>=20=20
>>      qio_net_listener_set_name(listener, "migration-socket-listener");
>>=20=20
>> @@ -163,6 +165,15 @@ static void socket_start_incoming_migration(SocketA=
ddress *saddr,
>>      qio_net_listener_set_client_func(listener,
>>                                       socket_accept_incoming_migration,
>>                                       NULL, NULL);
>> +
>> +    for (i =3D 0; i < listener->nsioc; i++)  {
>> +        SocketAddress *address =3D
>> +            qio_channel_socket_get_local_address(listener->sioc[i], err=
p);
>> +        if (address < 0) {
>
> 'address' is a pointer, so comparing to ' < 0' is wrong - I'm surprised
> the compiler isn't issuing a warning about this.

Oops, I guess a copy & paste from other error check.  No real clue why
compiler didn't detect it either.
>> +
>> +##
>> +# @DummyStruct:
>> +#
>> +# Both block-core and migration needs SocketAddressList
>> +# I am open to comments about how to share it
>
> What's the actual problem you're addressing with this ?

Until now, List of SocketAddress were onl used on block-core.  QAPI
generator is able to cope with that.  Now, we need to use them on both
migration.json and block-core.json.  QAPI generator is smart enough to
detect that SocketAddressList templates have already been generated, but
it is not able to use them on both sides.  if I put them in a common
place that are included from both .json, it is just generated correctly,
only once, and it compiles.

I haven't been able to find a way to convince qapi generator that I just
want it to generate the code here, without creating something that uses
it.

I am open to changes.

Thanks, Juan.

>
>> +#
>> +# @dummy-list: A dummy list
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct': 'DummyStruct',
>> +  'data': { 'dummy-list': ['SocketAddress'] } }
>> --=20
>> 2.14.3
>>=20
>>=20
>
> Regards,
> Daniel
