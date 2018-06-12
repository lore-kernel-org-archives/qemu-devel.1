Received: from eggs.gnu.org ([2001:4830:134:3::10]:54786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSm6Q-0006FJ-0J
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSm6O-00022l-N4
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:25:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180607062559.16127-1-armbru@redhat.com>
	<20180607062559.16127-7-armbru@redhat.com>
	<20180612133834.GC4355@localhost.localdomain>
Date: Tue, 12 Jun 2018 18:24:53 +0200
In-Reply-To: <20180612133834.GC4355@localhost.localdomain> (Kevin Wolf's
	message of "Tue, 12 Jun 2018 15:38:34 +0200")
Message-ID: <87bmcgotuy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 06/19] block: Fix -blockdev for certain
 non-string scalars
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: jcody@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 07.06.2018 um 08:25 hat Markus Armbruster geschrieben:
>> Configuration flows through the block subsystem in a rather peculiar
>> way.  Configuration made with -drive enters it as QemuOpts.
>> Configuration made with -blockdev / blockdev-add enters it as QAPI
>> type BlockdevOptions.  The block subsystem uses QDict, QemuOpts and
>> QAPI types internally.  The precise flow is next to impossible to
>> explain (I tried for this commit message, but gave up after wasting
>> several hours).  What I can explain is a flaw in the BlockDriver
>> interface that leads to this bug:
>> 
>>     $ qemu-system-x86 -blockdev node-name=n1,driver=nfs,server.type=inet,server.host=localhost,path=/foo/bar,user=1234: Internal error: parameter user invalid
>>     qemu-system-x86: -blockdev node-name=n1,driver=nfs,server.type=inet,server.host=localhost,path=/foo/bar,user=1234: Internal error: parameter user invalid
>
> I don't think the error message was intended to be part of your command
> line, and I also don't have a binary called qemu-system-x86. :-)

Uh, I managed to combine a pasto with a typo.  Fixing...

>> QMP blockdev-add is broken the same way.
>> 
>> Here's what happens.  The block layer passes configuration represented
>> as flat QDict (with dotted keys) to BlockDriver methods
>> .bdrv_file_open().  The QDict's members are typed according to the
>> QAPI schema.
>> 
>> nfs_file_open() converts it to QAPI type BlockdevOptionsNfs, with
>> qdict_crumple() and a qobject input visitor.
>> 
>> This visitor comes in two flavors.  The plain flavor requires scalars
>> to be typed according to the QAPI schema.  That's the case here.  The
>> keyval flavor requires string scalars.  That's not the case here.
>> nfs_file_open() uses the latter, and promptly falls apart for members
>> @user, @group, @tcp-syn-count, @readahead-size, @page-cache-size,
>> @debug.
>> 
>> Switching to the plain flavor would fix -blockdev, but break -drive,
>> because there the scalars arrive in nfs_file_open() as strings.
>> 
>> The proper fix would be to replace the QDict by QAPI type
>> BlockdevOptions in the BlockDriver interface.  Sadly, that's beyond my
>> reach right now.
>> 
>> Next best would be to fix the block layer to always pass correctly
>> typed QDicts to the BlockDriver methods.  Also beyond my reach.
>> 
>> What I can do is throw another hack onto the pile: have
>> nfs_file_open() convert all members to string, so use of the keyval
>> flavor actually works, by replacing qdict_crumple() by new function
>> qdict_crumple_for_keyval_qiv().
>> 
>> The pattern "pass result of qdict_crumple() to
>> qobject_input_visitor_new_keyval()" occurs several times more:
>> 
>> * qemu_rbd_open()
>> 
>>   Same issue as nfs_file_open(), but since BlockdevOptionsRbd has only
>>   string members, its only a latent bug.  Fix it anyway.
>> 
>> * parallels_co_create_opts(), qcow_co_create_opts(),
>>   qcow2_co_create_opts(), bdrv_qed_co_create_opts(),
>>   sd_co_create_opts(), vhdx_co_create_opts(), vpc_co_create_opts()
>> 
>>   These work, because they create the QDict with
>>   qemu_opts_to_qdict_filtered(), which creates only string scalars.
>>   The function sports a TODO comment asking for better typing; that's
>>   going to be fun.  Use qdict_crumple_for_keyval_qiv() to be safe.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>> +QObject *qdict_crumple_for_keyval_qiv(QDict *src, Error **errp)
>> +{
>> +    QDict *tmp = NULL;
>> +    char *buf;
>> +    const char *s;
>> +    const QDictEntry *ent;
>> +    QObject *dst;
>> +
>> +    for (ent = qdict_first(src); ent; ent = qdict_next(src, ent)) {
>> +        buf = NULL;
>> +        switch (qobject_type(ent->value)) {
>> +        case QTYPE_QNULL:
>> +        case QTYPE_QSTRING:
>> +            continue;
>> +        case QTYPE_QNUM:
>> +            s = buf = qnum_to_string(qobject_to(QNum, ent->value));
>> +            break;
>> +        case QTYPE_QDICT:
>> +        case QTYPE_QLIST:
>> +            /* @src isn't flat; qdict_crumple() will fail */
>> +            continue;
>> +        case QTYPE_QBOOL:
>> +            s = qbool_get_bool(qobject_to(QBool, ent->value))
>> +                ? "on" : "off";
>
> This fits in a single line.

Pushing column 77, for an effective line width of 65 characters.  I hate
that :)

I could be persuaded to add qbool_to_string().

>> +            break;
>> +        default:
>> +            abort();
>> +        }
>> +
>> +        if (!tmp) {
>> +            tmp = qdict_clone_shallow(src);
>> +        }
>> +        qdict_put(tmp, ent->key, qstring_from_str(s));
>> +        g_free(buf);
>> +    }
>> +
>> +    dst = qdict_crumple(tmp ?: src, errp);
>> +    qobject_unref(tmp);
>> +    return dst;
>> +}
>
> Kevin
