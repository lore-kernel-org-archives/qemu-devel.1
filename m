Received: from eggs.gnu.org ([2001:4830:134:3::10]:42140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVc0G-0004QV-2V
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVc0D-0005ds-Lu
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVc0D-0005d6-Ed
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:09:49 -0400
References: <468425bd8090e3a9fd7fc791db42e24d6c75315c.1499940552.git.alistair.francis@xilinx.com>
	<20170713102359.GH4011@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c00858e-2425-ecf5-af6e-ba1030715f16@redhat.com>
Date: Thu, 13 Jul 2017 13:09:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170713102359.GH4011@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] io/channel-watch.c: Only select on
 what we are actually waiting for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, alistair23@gmail.com, Fam Zheng <famz@redhat.com>

On 13/07/2017 12:23, Daniel P. Berrange wrote:
> On Thu, Jul 13, 2017 at 03:15:49AM -0700, Alistair Francis wrote:
>> diff --git a/io/channel-watch.c b/io/channel-watch.c
>> index 8640d1c464..d80722f496 100644
>> --- a/io/channel-watch.c
>> +++ b/io/channel-watch.c
>> @@ -286,9 +286,21 @@ GSource *qio_channel_create_socket_watch(QIOChannel *ioc,
>>      QIOChannelSocketSource *ssource;
>>  
>>  #ifdef WIN32
>> -    WSAEventSelect(socket, ioc->event,
>> -                   FD_READ | FD_ACCEPT | FD_CLOSE |
>> -                   FD_CONNECT | FD_WRITE | FD_OOB);
>> +    long bitmask = 0;
>> +
>> +    if (condition & (G_IO_IN | G_IO_PRI)) {
>> +        bitmask |= FD_READ | FD_ACCEPT;
>> +    }
>> +
>> +    if (condition & G_IO_HUP) {
>> +        bitmask |= FD_CLOSE;
>> +    }
>> +
>> +    if (condition & G_IO_OUT) {
>> +        bitmask |= FD_WRITE | FD_CONNECT;
>> +    }
>> +
>> +    WSAEventSelect(socket, ioc->event, bitmask);
>>  #endif
> 
> I think the problem with doing this is that WSAEventSelect is a global
> setting that applies to the socket handle. If you use qio_channel_create_watch
> twice on the same socket with different events, the second watch will break
> the first watch by potentially discarding events that it requested.

This makes sense, and it means the corresponding aio-win32 patch is
wrong too.

WSAEventSelect events are edge-triggered, so they shouldn't be too bad.
In particular, they won't cause a busy wait.

Paolo
