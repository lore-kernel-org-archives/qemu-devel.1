Received: from eggs.gnu.org ([2001:4830:134:3::10]:37085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evhy3-0007Ea-Px
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evhy0-0005ae-LM
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:19:43 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evhy0-0005a8-EQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:19:40 -0400
Received: by mail-wr0-f173.google.com with SMTP id r8so6356858wrg.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 04:19:40 -0700 (PDT)
References: <20180312141714.7223-1-berrange@redhat.com>
	<20180313092053.GA3545@work-vm>
	<be16f4e2-7b97-e251-332e-9445e4d9965c@redhat.com>
	<20180313110652.GS3048@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92106b88-98f4-cc19-95f0-5d59020c2357@redhat.com>
Date: Tue, 13 Mar 2018 12:19:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180313110652.GS3048@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 REPOST] migration: convert socket
 server to QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On 13/03/2018 12:06, Daniel P. Berrangé wrote:
> On Tue, Mar 13, 2018 at 11:57:17AM +0100, Paolo Bonzini wrote:
>> On 13/03/2018 10:20, Dr. David Alan Gilbert wrote:
>>>>  static void socket_start_incoming_migration(SocketAddress *saddr,
>>>>                                              Error **errp)
>>>>  {
>>>> -    QIOChannelSocket *listen_ioc = qio_channel_socket_new();
>>>> +    QIONetListener *listener = qio_net_listener_new();
>>>>  
>>>> -    qio_channel_set_name(QIO_CHANNEL(listen_ioc),
>>>> -                         "migration-socket-listener");
>>>> +    qio_net_listener_set_name(listener, "migration-socket-listener");
>>>>  
>>>> -    if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
>>>> -        object_unref(OBJECT(listen_ioc));
>>>> +    if (qio_net_listener_open_sync(listener, saddr, errp) < 0) {
>>>> +        object_unref(OBJECT(listener));
>>>>          return;
>>>>      }
>>>>  
>>>> -    qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
>>>> -                          G_IO_IN,
>>>> -                          socket_accept_incoming_migration,
>>>> -                          listen_ioc,
>>>> -                          (GDestroyNotify)object_unref);
>>>> +    qio_net_listener_set_client_func(listener,
>>>> +                                     socket_accept_incoming_migration,
>>>> +                                     NULL, NULL);
>>>>  }
>>>>  
>>>>  void tcp_start_incoming_migration(const char *host_port, Error **errp)
>>>> -- 
>>>> 2.14.3
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
>>
>> Could this get in 2.12 as a bugfix, even after soft freeze?  It's the
>> last user of qio_channel_listen_sync that blocks full IPv4/IPv6 support.
>>  All other users are for vsock/AF_UNIX.
> 
> I had been thinking of all this conversion as feature, but I guess if we
> squint our eyes a bit we could claim it is just a bugfix on the grounds
> that it is fixing broken IPv4/6 dual stack support.

It is certainly a feature, but when only one listener remains broken
then it becomes more of a bugfix.

Paolo
