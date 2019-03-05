Received: from eggs.gnu.org ([209.51.188.92]:56128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h17TS-0006MJ-S8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 05:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h17TR-0004ou-JR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 05:39:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-6-armbru@redhat.com>
	<8691f7df-c802-9528-a474-3bcdfa2aa498@redhat.com>
Date: Tue, 05 Mar 2019 11:38:51 +0100
In-Reply-To: <8691f7df-c802-9528-a474-3bcdfa2aa498@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 4 Mar 2019 17:14:32
	+0100")
Message-ID: <8736o1vc5g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] vl: Create block backends before
 setting machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/25/19 7:37 PM, Markus Armbruster wrote:
>> qemu-system-FOO's main() acts on command line arguments in its own
>> idiosyncratic order.  There's not much method to its madness.
>> Whenever we find a case where one kind of command line argument needs
>> to refer to something created for another kind later, we rejigger the
>> order.
>>=20
>> Block devices get created long after machine properties get processed.
>> Therefore, block device machine properties can be created, but not
>> set.  No such properties exist.  But the next commit will create some.
>> Time to rejigger again: create block devices earlier.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  vl.c | 66 ++++++++++++++++++++++++++++++------------------------------
>>  1 file changed, 33 insertions(+), 33 deletions(-)
>>=20
>> diff --git a/vl.c b/vl.c
>> index 6ce3d2d448..5cb0810ffa 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4232,6 +4232,39 @@ int main(int argc, char **argv, char **envp)
>>          exit(0);
>>      }
>>=20=20
>
> Can we extract this from the main, maybe as "parse_blockdev()"? This
> will ease further rejigger :)

I can try and see whether I like it.

>> +    /* If the currently selected machine wishes to override the units-p=
er-bus
>> +     * property of its default HBA interface type, do so now. */
>> +    if (machine_class->units_per_default_bus) {
>> +        override_max_devs(machine_class->block_default_type,
>> +                          machine_class->units_per_default_bus);
>> +    }
>> +
>> +    /* open the virtual block devices */
>> +    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
>> +        BlockdevOptions_queue *bdo =3D QSIMPLEQ_FIRST(&bdo_queue);
>> +
>> +        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
>> +        loc_push_restore(&bdo->loc);
>> +        qmp_blockdev_add(bdo->bdo, &error_fatal);
>> +        loc_pop(&bdo->loc);
>> +        qapi_free_BlockdevOptions(bdo->bdo);
>> +        g_free(bdo);
>> +    }
>> +    if (snapshot || replay_mode !=3D REPLAY_MODE_NONE) {
>> +        qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapsho=
t,
>> +                          NULL, NULL);
>> +    }
>> +    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>> +                          &machine_class->block_default_type, &error_fa=
tal)) {
>> +        /* We printed help */
>> +        exit(0);
>> +    }
>> +
>> +    default_drive(default_cdrom, snapshot, machine_class->block_default=
_type, 2,
>> +                  CDROM_OPTS);
>> +    default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>> +    default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>> +
>
> Can you add a comment here such:
>
>    /*
>     * Arguments setting properties on devices has to be processed before
>     * the following qemu_opt_foreach(...machine_set_property...) call.
>     */

Hmm, is this accurate?  The issue this patch addresses is

    "arguments creating block backends have to be processed before
    machine_set_property()",

which is an instance of

    "arguments creating backends ...",

which is an instance of

    "arguments creating stuff machine property values can reference ..."

The patch only addresses the instance "block backends".  I have no
appetite for attacking more general problems right now.

See also

    Subject: Re: [Qemu-devel] [PATCH RFC 0/3] qdev: order devices by priori=
ty before creating them
    Date: Wed, 11 May 2016 09:51:39 +0200
    Message-ID: <87y47hhw1g.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg01589.html

    Subject: Re: [Qemu-devel] [PATCH] vl: Delay initialization of memory ba=
ckends
    Date: Fri, 02 Sep 2016 08:13:17 +0200
    Message-ID: <87poomg77m.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2016-09/msg00163.html

That said, I'm fine with adding a comment explaining the more general
mess.  Can you give me some hints on what future readers will find
useful?

>>      machine_opts =3D qemu_get_machine_opts();
>>      qemu_opt_foreach(machine_opts, machine_set_property, current_machin=
e,
>>                       &error_fatal);
>> @@ -4355,39 +4388,6 @@ int main(int argc, char **argv, char **envp)
>>      ram_mig_init();
>>      dirty_bitmap_mig_init();
>>=20=20
>> -    /* If the currently selected machine wishes to override the units-p=
er-bus
>> -     * property of its default HBA interface type, do so now. */
>> -    if (machine_class->units_per_default_bus) {
>> -        override_max_devs(machine_class->block_default_type,
>> -                          machine_class->units_per_default_bus);
>> -    }
>> -
>> -    /* open the virtual block devices */
>> -    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
>> -        BlockdevOptions_queue *bdo =3D QSIMPLEQ_FIRST(&bdo_queue);
>> -
>> -        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
>> -        loc_push_restore(&bdo->loc);
>> -        qmp_blockdev_add(bdo->bdo, &error_fatal);
>> -        loc_pop(&bdo->loc);
>> -        qapi_free_BlockdevOptions(bdo->bdo);
>> -        g_free(bdo);
>> -    }
>> -    if (snapshot || replay_mode !=3D REPLAY_MODE_NONE) {
>> -        qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapsho=
t,
>> -                          NULL, NULL);
>> -    }
>> -    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>> -                          &machine_class->block_default_type, &error_fa=
tal)) {
>> -        /* We printed help */
>> -        exit(0);
>> -    }
>> -
>> -    default_drive(default_cdrom, snapshot, machine_class->block_default=
_type, 2,
>> -                  CDROM_OPTS);
>> -    default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>> -    default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>> -
>>      qemu_opts_foreach(qemu_find_opts("mon"),
>>                        mon_init_func, NULL, &error_fatal);
>>=20=20
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!
