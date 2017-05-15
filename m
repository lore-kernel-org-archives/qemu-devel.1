Received: from eggs.gnu.org ([2001:4830:134:3::10]:53991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAIVf-0002dG-VA
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAIVb-0000Xn-GF
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAIVa-0000XW-RS
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:06:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D07EA5F742
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 16:06:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-3-quintela@redhat.com>
	<20170512034033.GN28293@pxdev.xzpeter.org>
	<877f1mgx9h.fsf@secure.mitica>
	<5bab598f-30eb-fcf6-9d06-8f683b466414@redhat.com>
	<87lgpyfo28.fsf@secure.mitica>
Date: Mon, 15 May 2017 18:06:01 +0200
In-Reply-To: <87lgpyfo28.fsf@secure.mitica> (Juan Quintela's message of "Mon,
	15 May 2017 11:48:31 +0200")
Message-ID: <87k25iqf4m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
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
Cc: Eric Blake <eblake@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, dgilbert@redhat.com

Juan Quintela <quintela@redhat.com> writes:

> Eric Blake <eblake@redhat.com> wrote:
>> On 05/12/2017 05:55 AM, Juan Quintela wrote:
>>>>> @@ -1239,6 +1240,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>>>>>      }
>>>>>  
>>>>>      if (has_inc && inc) {
>>>>> +        migrate_set_block_enabled(s, true);
>>>>>          migrate_set_block_shared(s, true);
>>>>
>>>> [2]
>>>>
>>>> IIUC for [1] & [2] we are solving the same problem that "shared"
>>>> depends on "enabled" bit. Would it be good to unitfy this dependency
>>>> somewhere? E.g., by changing migrate_set_block_shared() into:
>>>>
>>>> void migrate_set_block_shared(MigrationState *s, bool value)
>>>> {
>>>>     s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] = value;
>>>>     if (value) {
>>>>         migrate_set_block_enabled(s, true);
>>>>     }
>>>> }
>>> 
>>> ok with this.
>>
>> Or, as I commented on 1/3, maybe having a single property that is a
>> tri-state enum value, instead of 2 separate boolean properties, might be
>> nicer (but certainly a bit more complex to code up).
>
> If you teach me how to do the qapi/qmp part, I will do the other bits.
> I don't really care if we do it one way or the other.
>
>>> I will add once here that when we disable block enabled, we also disable
>>> shared, or just let it that way?
>>> 
>>>> Another thing to mention: after switching to the capability interface,
>>>> we'll cache the "enabled" and "shared" bits now while we don't cache
>>>> it before, right? IIUC it'll affect behavior of such sequence:
>>>>
>>>> - 1st migrate with enabled=1, shared=1, then
>>>> - 2nd migrate with enabled=0, shared=0
>>>>
>>>> Before the series, the 2nd migrate will use enabled=shared=0, but
>>>> after the series it should be using enabled=shared=1. Not sure whether
>>>> this would be a problem (or I missed anything?).
>>> 
>>> We can't be consistent with both old/new way.
>>> 
>>> Old way: we always setup the capabilities on command line (that should
>>> have been deprecated long, long ago)
>>
>> Well, the easy way out is to have the HMP migrate command (I assume
>> that's what you mean by "on command line") explicitly clear the
>> parameters if it is called without the -b/-i flag.  So the start of each
>> migration is what changes the properties, so long as you are still using
>> HMP to start the migration.  Or, on the QMP side, since 'migrate' has
>> optional 'blk' and 'inc' booleans, basically leave the settings alone if
>> the parameters were omitted, and explicitly update the property to the
>> value of those parameters if they were present.
>
> We are going to have trouble whatever way that we do it, or we start
> doing lots of strange things.
>
> Forget about qmp, we are going to assume that it is consistent with hmp.
>
> migrate_set_capabilities block_enabled on
> migrate -b .....
>
> Should migrate disable the block_enabled capability?  Give one
> warning/error?
>
> And notice that this only matter if we do a migration, we cancel/get one
> error, and then we migrate again.
>
> What I tried to do is assume that -b/-i arguments don't exist.  And if
> the user use them, we implement its behaviour with the minimal fuss
> possibly.
>
> Only way that I can think of being consistent and bug compatible will be
> to store:
> - old block_shared/enanbeld capability value
> - if we set -b/-i on the command line
>
> In migration cleanup do the right thing depending on this four
> variables.  I think that it is adding lots of complexity for very few
> improvement.
>
>
>> Or is the proposal that we are also going to simplify the QMP 'migrate'
>> command to get rid of crufty parameters?
>
> I didn't read it that way, but I would not oppose O:-)
>
> Later, Juan.

I'm not too familiar with this stuff, so please correct my
misunderstandings.

"Normal" migration configuration is global state, i.e. it applies to all
future migrations.

Except the "migrate" command's flags apply to just the migration kicked
off by that command.

QMP command "migrate" has two flags "blk" (HMP: -b) and "inc" (HMP: -i).
!blk && inc makes no sense and is silently treated like !blk && !inc.

There's a third flag "detach" (HMP: -d), but it does nothing in QMP.

You'd like to deprecate these flags in favour of "normal" configuration.
However, we need to maintain QMP backward compatibility at least for a
while.  HMP backward compatibility is nice to have, but not required.

First step is to design the new interface you want.  Second step is to
figure out backward compatibility.

The new interface adds a block migration tri-state (off,
non-incremental, incremental) to global state, default off.  Whether
it's done as two bools or an enum of three values doesn't matter here.

If the new interface isn't used, the old one still needs to work.  If it
is used, the old one either has to do "the right thing", or fail
cleanly.

We approximate "new interface isn't used" by "block migration is off in
global state".  When it is off, the migration command needs to honor its
two flags for compatibility.  It must leave block migration off in
global state.  Yes, this will complicate the implementation until we
actually remove the deprecated flags.  Par for the backward compatility
course.

When block migration isn't off in global state, we can either

* let the flags take precedence over the global state (one
  interpretation of "do the right thing"), or

* reject flags that conflict with global state (another interpretation),
  or

* reject *all* flags (fail cleanly).

The last one looks perfectly servicable to me.
