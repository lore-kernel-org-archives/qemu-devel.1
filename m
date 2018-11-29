Received: from eggs.gnu.org ([2001:4830:134:3::10]:34193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSIei-0006AK-L4
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSIef-0005Cl-Aw
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:30:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSIef-0005Ca-59
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:30:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E81D30DEFF2
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 09:30:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181128113337.7238-1-quintela@redhat.com>
	<20181128113337.7238-3-quintela@redhat.com>
	<743778f1-1769-502d-26ff-51c17578e283@redhat.com>
Date: Thu, 29 Nov 2018 10:30:36 +0100
In-Reply-To: <743778f1-1769-502d-26ff-51c17578e283@redhat.com> (Eric Blake's
	message of "Wed, 28 Nov 2018 08:27:40 -0600")
Message-ID: <87woowb58j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 2/5] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Eric Blake <eblake@redhat.com> writes:

[...]
>> +++ b/qapi/sockets.json
>> @@ -152,3 +152,16 @@
>>               'unix': 'UnixSocketAddress',
>>               'vsock': 'VsockSocketAddress',
>>               'fd': 'String' } }
>> +
>> +##
>> +# @DummyStruct:
>> +#
>> +# Both block-core and migration needs SocketAddressList
>> +# I am open to comments about how to share it
>> +#
>> +# @dummy-list: A dummy list
>> +#
>> +# Since: 3.1
>> +##
>> +{ 'struct': 'DummyStruct',
>> +  'data': { 'dummy-list': ['SocketAddress'] } }
>
> We've had a couple of threads about this in the last couple of months;
> maybe it's time for a qapi generator patch where we add an optional
> 'gen-list':true marker to any struct that needs to have a list
> generated for C code even when no QMP command uses the list form.

Maybe.

As long as we need just a few such lists, stuffing them all into
DummyForceArrays should do fine.  There's no need for a fresh dummy type
for each list.

Beyond a certain point, the DummyForceArrays hack may become bothersome
enough to justify development and maintenance of a proper QAPI feature.

You mentioned "a couple of threads".  Have they resulted in fresh dummy
types?  Or, to ask the same question differently, for which types do we
force generation of list types?
