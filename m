Received: from eggs.gnu.org ([2001:4830:134:3::10]:48139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOorE-00074g-UV
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOorA-0005vI-1K
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:56:13 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:33951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cOor9-0005ug-RR
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:56:07 -0500
Received: by mail-wj0-x243.google.com with SMTP id qs7so38621216wjc.1
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 08:56:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161223182641.2718-1-pbonzini@redhat.com>
	<20161223182641.2718-2-pbonzini@redhat.com>
	<318eee50-fc8b-281d-6b98-50aa6dfa5259@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <23eb9e7c-40ca-e81e-0892-0a79d7ec54fc@redhat.com>
Date: Wed, 4 Jan 2017 17:56:04 +0100
MIME-Version: 1.0
In-Reply-To: <318eee50-fc8b-281d-6b98-50aa6dfa5259@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] io: add methods to set I/O handlers on
 AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org



On 04/01/2017 17:45, Eric Blake wrote:
>> -#ifdef WIN32
>> -        WSAEventSelect(sioc->fd, ioc->event,
>> -                       FD_READ | FD_ACCEPT | FD_CLOSE |
>> -                       FD_CONNECT | FD_WRITE | FD_OOB);
>> -#endif
>>      }
>>      return 0;
> How does this hunk fit in?
> 
>> +++ b/io/channel-watch.c
>> @@ -285,6 +285,12 @@ GSource *qio_channel_create_socket_watch(QIOChannel *ioc,
>>      GSource *source;
>>      QIOChannelSocketSource *ssource;
>>  
>> +#ifdef WIN32
>> +    WSAEventSelect(socket, ioc->event,
>> +                   FD_READ | FD_ACCEPT | FD_CLOSE |
>> +                   FD_CONNECT | FD_WRITE | FD_OOB);
>> +#endif
>> +
> Is it that you're moving it, now that the ability to associate handlers
> lets you have more fine-grained control on when to adjust the properties?

Yes, I'm setting the event here because aio_set_fd_handler can also call
WSAEventSelect, and only one event can be in use at a time.  So you
cannot use qio_channel_create_socket_watch and qio_channel_yield at the
same time, but you can switch from one to the other.

Paolo
