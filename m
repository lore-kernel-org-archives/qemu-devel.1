Received: from eggs.gnu.org ([209.51.188.92]:50816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkN1-0004sY-Hu
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkJ0-0007mc-89
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:42:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gzkJ0-0007lp-1W
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:42:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57524A148A
	for <qemu-devel@nongnu.org>; Fri,  1 Mar 2019 15:42:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190220092214.2384-1-quintela@redhat.com>
	<20190220092214.2384-3-quintela@redhat.com>
	<2bcdaa5b-4ce2-cf40-5774-a3c81690b1e3@redhat.com>
	<87d0nl1e0b.fsf@dusky.pond.sub.org>
Date: Fri, 01 Mar 2019 16:42:27 +0100
In-Reply-To: <87d0nl1e0b.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 21 Feb 2019 14:12:52 +0100")
Message-ID: <87d0namwik.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v13 2/3] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
[...]
>> That says we have a bug in our QAPI generator - the type
>> SocketAddressList should be auto-generated at the point where it is
>> needed in migration.json. Markus, any ideas why we are not properly
>> auto-generating an array type when the only use of that array comes from
>> a different module than where the original type was declared?
>
> With the DummyStruct, we generate SocketAddressList stuff into
> qapi-{types,visit}-sockets.[ch].
>
> Without it, we it ends up in qapi-{types,visit}-block-core.[ch].  How
> come?
>
> We create non-builtin array types on demand, i.e. on first use, by
> calling ._make_array_type().
>
> Like any other non-builtin type, an array type takes an info tuple
> describing where it's defined.  We pass it the info of whatever
> triggered its creation.  That's not as silly as it may sound; it can be
> viewed as a definition.
>
> However, it falls apart when we use the info to set the type's module,
> in ._def_entity().  The module dicates where the generated code goes.
> The array type's module becomes whatever module uses it first.  It
> should be its element type's module instead.
>
> Needs fixing.
>
> If you don't want to wait for the fix, commit the DummyStruct
> work-around with a big fat FIXME comment.

Proposed fix:
Subject: [PATCH 0/7] qapi: Code generation fixes
Message-Id: <20190301154051.23317-1-armbru@redhat.com>
