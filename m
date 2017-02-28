Received: from eggs.gnu.org ([2001:4830:134:3::10]:54056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciore-0008UB-MB
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciord-0006zG-OA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:59:18 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-19-git-send-email-armbru@redhat.com>
	<20170228195722.GB4090@noname.redhat.com>
Date: Tue, 28 Feb 2017 21:59:07 +0100
In-Reply-To: <20170228195722.GB4090@noname.redhat.com> (Kevin Wolf's message
	of "Tue, 28 Feb 2017 20:57:22 +0100")
Message-ID: <87innuav6s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 18/24] block: Initial implementation of
 -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>> The new command line option -blockdev works like QMP command
>> blockdev-add.
>> 
>> The option argument may be given in JSON syntax, exactly as in QMP.
>> Example usage:
>> 
>>     -blockdev '{"node-name": "foo", "driver": "raw", "file": {"driver": "file", "filename": "foo.img"} }'
>> 
>> The JSON argument doesn't exactly blend into the existing option
>> syntax, so the traditional KEY=VALUE,... syntax is also supported,
>> using dotted keys to do the nesting:
>> 
>>     -blockdev node-name=foo,driver=raw,file.driver=file,file.filename=foo.img
>> 
>> This does not yet support lists or downstream extensions, i.e. keys
>> with __RFQDN_ prefix, but the next few patches will take care of that.
>> 
>> Note that calling qmp_blockdev_add() (say via qmp_marshal_block_add())
>> right away would crash.  We need to stash the configuration for later
>> instead.  This is crudely done, and bypasses QemuOpts, even though
>> storing configuration is what QemuOpts is for.  Need to revamp option
>> infrastructure to support QAPI types like BlockdevOptions.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Apparently I forgot to actually reply here after going back to the
> previous patch...
>
>> @@ -532,6 +532,13 @@ Use @var{file} as CD-ROM image (you cannot use @option{-hdc} and
>>  using @file{/dev/cdrom} as filename (@pxref{host_drives}).
>>  ETEXI
>>  
>> +DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
>> +    "-blockdev driver[,node-name=N][,discard=ignore|unmap]\n"
>
> I was going to suggest the same thing as Eric here, simply 'driver'
> doesn't look right.

Matches how we document -chardev, -netdev, -device, ..., which is where
I looked.  But [driver=]driver matches a whole bunch of other options.
I'll change it.

>> +    "          [,cache.direct=on|off][,cache.no-flush=on|off]\n"
>> +    "          [,read-only=on|off][,detect-zeroes=on|off|unmap]\n"
>> +    "          [,driver specific parameters...]\n"
>> +    "                configure a block backend\n", QEMU_ARCH_ALL)
>> +
>>  DEF("drive", HAS_ARG, QEMU_OPTION_drive,
>>      "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
>>      "       [,cyls=c,heads=h,secs=s[,trans=t]][,snapshot=on|off]\n"
>
>> @@ -4454,6 +4483,16 @@ int main(int argc, char **argv, char **envp)
        /* open the virtual block devices */
        if (snapshot || replay_mode != REPLAY_MODE_NONE) {
            qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
>>          qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
>>                            NULL, NULL);
>>      }
>> +    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
>> +        BlockdevOptions_queue *bdo = QSIMPLEQ_FIRST(&bdo_queue);
>> +
>> +        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
>> +        loc_push_restore(&bdo->loc);
>> +        qmp_blockdev_add(bdo->bdo, &error_fatal);
>> +        loc_pop(&bdo->loc);
>> +        qapi_free_BlockdevOptions(bdo->bdo);
>> +        g_free(bdo);
>> +    }
>>      if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>>                            &machine_class->block_default_type, NULL)) {
>>          exit(1);
>
> And here I found the placement of the new code odd, it's in the middle
> of -drive handling. The current placement means that -drive can
> reference -blockdev nodes, but not the other way round. I like this and
> wouldn't recommand changing it. So my suggestion for a better placement
> would be to move the -blockdev code up a bit.

Moving it right after /* open the virtual block devices */
