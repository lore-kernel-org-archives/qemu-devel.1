Received: from eggs.gnu.org ([209.51.188.92]:53949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grSG2-00009W-2U
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grSG0-00036k-QE
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:49:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grSG0-00036S-Kk
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:49:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C641E58E43
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:49:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190130120616.5260-1-quintela@redhat.com>
	<20190130120616.5260-3-quintela@redhat.com>
	<711166e7-e8de-9335-5a7f-63cf86a62524@redhat.com>
	<875ztxf62a.fsf@trasno.org>
Date: Wed, 06 Feb 2019 19:49:10 +0100
In-Reply-To: <875ztxf62a.fsf@trasno.org> (Juan Quintela's message of "Wed, 06
	Feb 2019 13:35:25 +0100")
Message-ID: <87h8dgoiqh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 2/4] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Juan Quintela <quintela@redhat.com> writes:

> Eric Blake <eblake@redhat.com> wrote:
>> On 1/30/19 6:06 AM, Juan Quintela wrote:
>>> It will be used to store the uri parameters. We want this only for
>>> tcp, so we don't set it for other uris.  We need it to know what port
>>> is migration running.
>>> 
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
[...]
>>> @@ -199,6 +200,8 @@
>>>  # @compression: migration compression statistics, only returned if compression
>>>  #           feature is on and status is 'active' or 'completed' (Since 3.1)
>>>  #
>>> +# @socket-address: Only used for tcp, to know what the real port is (Since 3.1)
>>> +#
>>
>> s/3.1/4.0/
>
> Done.
>
>>> +##
>>> +# @DummyStruct:
>>> +#
>>> +# Both block-core and migration needs SocketAddressList
>>> +# I am open to comments about how to share it
>>> +#
>>> +# @dummy-list: A dummy list
>>> +#
>>> +# Since: 3.1
>>
>> s/3.1/4.0/
>> This matches how we force list types elsewhere for use in C code even
>> when the type is not exposed through QMP. But do you still need to force
>> the generation, given that ['SocketAddress'] used in MigrationInfo is
>> visible through QMP?
>
> I think so but I am not an expert here.

If the list type is visible in QMP, we shouldn't add this hack to force
it.  Easy to find out: drop DummyStruct, and if it still compiles, the
forcing needs to go.
