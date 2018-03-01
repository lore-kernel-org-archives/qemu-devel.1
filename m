Received: from eggs.gnu.org ([2001:4830:134:3::10]:36685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRpD-0005xJ-Bo
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRpA-0000B4-9N
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:16:58 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1erRpA-0008W7-2l
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:16:56 -0500
Received: by mail-wr0-x244.google.com with SMTP id v65so7348505wrc.11
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:16:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-9-peterx@redhat.com>
	<20180301154638.GO14643@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca243953-2f86-f73a-c3c3-95335f94bba2@redhat.com>
Date: Thu, 1 Mar 2018 18:16:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180301154638.GO14643@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/15] chardev: allow telnet gsource to
 switch gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 01/03/2018 16:46, Daniel P. Berrangé wrote:
> On Thu, Mar 01, 2018 at 04:44:31PM +0800, Peter Xu wrote:
>> It was originally created by qio_channel_add_watch() so it's always
>> assigning the task to main context.  Now we use the new API called
>> qio_channel_add_watch_source() so that we get the GSource handle rather
>> than the tag ID.
>>
>> Meanwhile, caching the gsource in SocketChardev.telnet_source so that we
>> can also do dynamic context switch when update read handlers.
> I don't see why we would ever want to dynamically switch the
> GMainContext in use while in middle of reading the telnet greeting.

Maybe because the remote client hangs in the middle of the telnet
greeting?  The user of the Chardev can't know that the initial handshake
hasn't been done yet.

Paolo
