Received: from eggs.gnu.org ([2001:4830:134:3::10]:49342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkVlE-0002Bn-O5
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkVl9-0002Ov-OL
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:36:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fkVl9-0002Og-J2
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:36:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E9607C6CA
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 14:36:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <44f12777-4905-0590-3417-62f982dcf96b@redhat.com> (Eric Blake's
	message of "Wed, 9 May 2018 08:05:32 -0500")
References: <20180509120140.6612-1-quintela@redhat.com>
	<20180509120140.6612-2-quintela@redhat.com>
	<44f12777-4905-0590-3417-62f982dcf96b@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 31 Jul 2018 16:40:14 +0200
Message-ID: <87wotbqxip.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 1/3] migration: Create socket-address
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Eric Blake <eblake@redhat.com> wrote:

>> +++ b/qapi/migration.json
>> @@ -6,6 +6,7 @@
>>   ##
>>     { 'include': 'common.json' }
>> +{ 'include': 'sockets.json' }
>>     ##
>>   # @MigrationStats:
>> @@ -169,6 +170,7 @@
>>   #           only present when the postcopy-blocktime migration capability
>>   #           is enabled. (Since 2.13)
>>   #
>> +# @socket-address: Only used for tcp, to know what the real port is (Since 2.13)
>
> Maybe s/real port is/real ports are/, since...

done.

>
>>   #
>>   # Since: 0.14.0
>>   ##
>> @@ -183,7 +185,8 @@
>>              '*cpu-throttle-percentage': 'int',
>>              '*error-desc': 'str',
>>              '*postcopy-blocktime' : 'uint32',
>> -           '*postcopy-vcpu-blocktime': ['uint32']} }
>> +           '*postcopy-vcpu-blocktime': ['uint32'],
>> +           '*socket-address': ['SocketAddress'] } }
>
> ...an array is potentially plural.

done. (didn't like to put so many s's, but ...)

>>     ##
>>   # @query-migrate:
>> @@ -690,6 +693,7 @@
>>   #                     needs to be a multiple of the target page size
>>   #                     and a power of 2
>>   #                     (Since 2.11)
>> +#
>>   # Since: 2.4
>>   ##
>>   { 'struct': 'MigrationParameters',
>
> Spurious hunk?  Although it looks reasonable, it could be a separate
> trivial cleanup patch.

Fixed thanks.

>
>> diff --git a/qapi/sockets.json b/qapi/sockets.json
>> index fc81d8d5e8..f1ca09a927 100644
>> --- a/qapi/sockets.json
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
>
> s/needs/need/

done

>> +# I am open to comments about how to share it
>
> Since this is two sentences, trailing '.' would help.

done

>> +#
>> +# @dummy-list: A dummy list
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct': 'DummyStruct',
>> +  'data': { 'dummy-list': ['SocketAddress'] } }
>>
>
> We've used this idiom elsewhere; it might be better to amend
> DummyForceArrays in qapi/misc.json, except then misc.json might need
> to include sockets.json for the definition of SocketAddress.

Not done.  It needs more qapi magic that puttingthe socket.json include
there, so this one stays.  Putting it there means including
qapi/<vhateve>-misc.h in several places, I think it is easier this way
(famous last words).

Later, Juan.
