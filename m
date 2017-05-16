Received: from eggs.gnu.org ([2001:4830:134:3::10]:40989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAeVs-00017y-AY
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAeVo-0000UC-2J
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAeVn-0000U1-SS
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FA0872479
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 15:35:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170516111123.17692-1-quintela@redhat.com>
	<20170516111123.17692-4-quintela@redhat.com>
	<87o9usg9v7.fsf@dusky.pond.sub.org> <87inl0dg2t.fsf@secure.mitica>
Date: Tue, 16 May 2017 17:35:40 +0200
In-Reply-To: <87inl0dg2t.fsf@secure.mitica> (Juan Quintela's message of "Tue,
	16 May 2017 16:36:10 +0200")
Message-ID: <87shk4byr7.fsf@dusky.pond.sub.org>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> We have change in the previous patch to use migration capabilities for
>>> it.  Notice that we continue using the old command line flags from
>>> migrate command from the time being.  Remove the set_params method as
>>> now it is empty.
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index b4f736f..5fc10ab 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -1233,8 +1233,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>>>  {
>>>      int ret;
>>>      MigrationParams params = {
>>> -        .blk = 0,
>>> -        .shared = 0
>>>      };
>>>      MigrationState *ms = migrate_init(&params);
>>>      MigrationStatus status;
>>> @@ -1245,6 +1243,12 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>>>          goto done;
>>>      }
>>>  
>>> +    if (migrate_use_block()) {
>>> +        error_setg(errp, "Block migration and snapshots are incompatible");
>>> +        ret = -EINVAL;
>>> +        goto done;
>>> +    }
>>> +
>>>      qemu_mutex_unlock_iothread();
>>>      qemu_savevm_state_header(f);
>>>      qemu_savevm_state_begin(f, &params);
>>
>> New error that isn't mentioned in the commit message.  Does it belong
>> here?
>
> It is the equivalent of the previous chunk.
>
> If you do a savevm, you can't do a:
>
> savevm -b/-i foo
>
> but now you can do:
>
> migrate_set_capability block on
> savevm foo
>
> And we can't use block migration.  If you preffer, I can disable the
> feature unconditionally, but I am not sure that it is much better.

I see.

Add your explanation to the commit message, and I'm happy.
