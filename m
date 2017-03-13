Received: from eggs.gnu.org ([2001:4830:134:3::10]:48342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnTIU-0006Hv-Ck
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnTIQ-0007Iq-FL
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:58:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnTIQ-0007Hh-6c
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:58:10 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 077973674A7
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 16:58:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170313164134.GM4799@redhat.com> (Daniel P. Berrange's message
	of "Mon, 13 Mar 2017 16:41:40 +0000")
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-10-quintela@redhat.com>
	<20170313164134.GM4799@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Mar 2017 17:58:06 +0100
Message-ID: <87fuihuna9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/16] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Mon, Mar 13, 2017 at 01:44:27PM +0100, Juan Quintela wrote:
>> We create new channels for each new thread created. We only send through
>> them a character to be sure that we are creating the channels in the
>> right order.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> --
>> Split SocketArgs into incoming and outgoing args
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/migration.h |  7 +++++
>>  migration/ram.c               | 35 ++++++++++++++++++++++
>>  migration/socket.c            | 67 +++++++++++++++++++++++++++++++++++++++++--
>>  3 files changed, 106 insertions(+), 3 deletions(-)
>> 
>
>> diff --git a/migration/socket.c b/migration/socket.c
>> index 13966f1..58a16b5 100644
>> --- a/migration/socket.c
>> +++ b/migration/socket.c
>> @@ -24,6 +24,65 @@
>>  #include "io/channel-socket.h"
>>  #include "trace.h"
>>  
>> +struct SocketIncomingArgs {
>> +    QIOChannelSocket *ioc;
>> +} incoming_args;
>> +
>> +QIOChannel *socket_recv_channel_create(void)
>> +{
>> +    QIOChannelSocket *sioc;
>> +    Error *err = NULL;
>> +
>> +    sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(incoming_args.ioc),
>> +                                     &err);
>> +    if (!sioc) {
>> +        error_report("could not accept migration connection (%s)",
>> +                     error_get_pretty(err));
>> +        return NULL;
>> +    }
>> +    return QIO_CHANNEL(sioc);
>> +}
>> +
>> +int socket_recv_channel_destroy(QIOChannel *recv)
>> +{
>> +    /* Remove channel */
>> +    object_unref(OBJECT(send));
>> +    return 0;
>> +}
>> +
>> +/* we have created all the recv channels, we can close the main one */
>> +int socket_recv_channel_close_listening(void)
>> +{
>> +    /* Close listening socket as its no longer needed */
>> +    qio_channel_close(QIO_CHANNEL(incoming_args.ioc), NULL);
>> +    return 0;
>> +}
>> +
>> +struct SocketOutgoingArgs {
>> +    SocketAddress *saddr;
>> +    Error **errp;
>> +} outgoing_args;
>> +
>> +QIOChannel *socket_send_channel_create(void)
>> +{
>> +    QIOChannelSocket *sioc = qio_channel_socket_new();
>> +
>> +    qio_channel_socket_connect_sync(sioc, outgoing_args.saddr,
>> +                                    outgoing_args.errp);
>> +    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
>> +    return QIO_CHANNEL(sioc);
>> +}
>> +
>> +int socket_send_channel_destroy(QIOChannel *send)
>> +{
>> +    /* Remove channel */
>> +    object_unref(OBJECT(send));
>> +    if (outgoing_args.saddr) {
>> +        qapi_free_SocketAddress(outgoing_args.saddr);
>> +        outgoing_args.saddr = NULL;
>> +    }
>> +    return 0;
>> +}
>>  
>>  static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
>>  {
>> @@ -97,6 +156,10 @@ static void socket_start_outgoing_migration(MigrationState *s,
>>      struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
>>  
>>      data->s = s;
>> +
>> +    outgoing_args.saddr = saddr;
>> +    outgoing_args.errp = errp;
>> +
>>      if (saddr->type == SOCKET_ADDRESS_KIND_INET) {
>>          data->hostname = g_strdup(saddr->u.inet.data->host);
>>      }
>> @@ -107,7 +170,6 @@ static void socket_start_outgoing_migration(MigrationState *s,
>>                                       socket_outgoing_migration,
>>                                       data,
>>                                       socket_connect_data_free);
>> -    qapi_free_SocketAddress(saddr);
>>  }
>>  
>>  void tcp_start_outgoing_migration(MigrationState *s,
>> @@ -154,8 +216,6 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>>      object_unref(OBJECT(sioc));
>>  
>>  out:
>> -    /* Close listening socket as its no longer needed */
>> -    qio_channel_close(ioc, NULL);
>>      return FALSE; /* unregister */

*HERE*


>>  }
>>  
>> @@ -164,6 +224,7 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>>                                              Error **errp)
>>  {
>>      QIOChannelSocket *listen_ioc = qio_channel_socket_new();
>> +    incoming_args.ioc = listen_ioc;
>>  
>>      qio_channel_set_name(QIO_CHANNEL(listen_ioc),
>>                           "migration-socket-listener");
>
> I still don't really like any of the changes in this file. We've now got
> two sets of methods which connect to a remote host and two sets of methods
> which accept incoming clients. I've got to think there's a better way to
> refactor the existing code, such that we don't need two sets of methods
> for the same actions

I am open to suggestions, basically we want to be able to:
- open one + n channels
- be sure that we got the same id on both sides of the connection.

You suggested on the previous iteration that I changed the FALSE in
*HERE* for TRUE, but I was not able to:
- make sure that we have opened n sockets before we continue with
  migration
- making sure that we got same id numbers in both sides, that is doable,
  just add a new id field
- right now I open a channel, and wait for the other side to open it
  before open the following one.  I can do things in parallel, but
  locking is going to be "interesting".

So, as said, I don't really care how we open the channels, I am totally
open to suggestions.  Looking at the current code, this is the best way
that I have been able to think of.

Later, Juan.
