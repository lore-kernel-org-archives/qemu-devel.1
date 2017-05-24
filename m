Received: from eggs.gnu.org ([2001:4830:134:3::10]:48932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDVi6-0005YS-8X
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDVi3-0002Zy-59
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:48:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dDVi2-0002ZQ-Ul
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:48:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D10A624DD
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:48:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170518111837.29212-1-quintela@redhat.com>
	<20170518111837.29212-4-quintela@redhat.com>
	<8760gxce1f.fsf@dusky.pond.sub.org>
Date: Wed, 24 May 2017 14:48:07 +0200
In-Reply-To: <8760gxce1f.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 19 May 2017 12:54:36 +0200")
Message-ID: <8737buo1yw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/5] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> Juan Quintela <quintela@redhat.com> writes:
>
>> We have change in the previous patch to use migration capabilities for
>> it.  Notice that we continue using the old command line flags from
>> migrate command from the time being.  Remove the set_params method as
>> now it is empty.
>>
>> For savevm, one can't do a:
>>
>> savevm -b/-i foo
>
> Yes (savem has no such options).
>
>> but now one can do:
>>
>> migrate_set_capability block on
>> savevm foo
>>
>> And we can't use block migration. We could disable block capability
>> unconditionally, but it would not be much better.
>
> This leaves me confused: what does the example do?  Reading ahead...
> looks like it fails with "Block migration and snapshots are
> incompatible".  What are you trying to say here?

I think I now get what you're trying to say, but only because I've
picked up enough context.  Let me try to rephrase:

  migration: Use new configuration instead of old MigrationParams

  The previous commit introduced a MigrationCapability and a
  MigrationParameter for block migration.  Use them instead of the old
  MigrationParams.

  Take care to reject attempts to combine block migration with
  snapshots, e.g. like this:

      migrate_set_capability block on
      savevm foo

>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Patch looks good to me.

Preferably with a commit message I can still understand three weeks from
now:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
