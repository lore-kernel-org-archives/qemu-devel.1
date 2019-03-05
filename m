Received: from eggs.gnu.org ([209.51.188.92]:44443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1Aj1-0004G9-Pf
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1Aj0-0004u1-Lu
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:07:19 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-6-armbru@redhat.com>
	<8691f7df-c802-9528-a474-3bcdfa2aa498@redhat.com>
	<8736o1vc5g.fsf@dusky.pond.sub.org>
	<f1cff39e-9612-397a-d408-f0ef8610f699@redhat.com>
Date: Tue, 05 Mar 2019 15:07:11 +0100
In-Reply-To: <f1cff39e-9612-397a-d408-f0ef8610f699@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Mar 2019 12:34:36
	+0100")
Message-ID: <87k1hd76uo.fsf@dusky.pond.sub.org>
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 3/5/19 11:38 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>> On 2/25/19 7:37 PM, Markus Armbruster wrote:
>>>> qemu-system-FOO's main() acts on command line arguments in its own
>>>> idiosyncratic order.  There's not much method to its madness.
>>>> Whenever we find a case where one kind of command line argument needs
>>>> to refer to something created for another kind later, we rejigger the
>>>> order.
>>>>
>>>> Block devices get created long after machine properties get processed.
>>>> Therefore, block device machine properties can be created, but not
>>>> set.  No such properties exist.  But the next commit will create some.
>>>> Time to rejigger again: create block devices earlier.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>  vl.c | 66 ++++++++++++++++++++++++++++++------------------------------
>>>>  1 file changed, 33 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/vl.c b/vl.c
>>>> index 6ce3d2d448..5cb0810ffa 100644
>>>> --- a/vl.c
>>>> +++ b/vl.c
>>>> @@ -4232,6 +4232,39 @@ int main(int argc, char **argv, char **envp)
>>>>          exit(0);
>>>>      }
>>>>=20=20
>>>
>>> Can we extract this from the main, maybe as "parse_blockdev()"? This
>>> will ease further 	 :)
>>=20
>> I can try and see whether I like it.
>>=20
>>>> +    /* If the currently selected machine wishes to override the units=
-per-bus
>>>> +     * property of its default HBA interface type, do so now. */
>>>> +    if (machine_class->units_per_default_bus) {
>>>> +        override_max_devs(machine_class->block_default_type,
>>>> +                          machine_class->units_per_default_bus);
>>>> +    }
>>>> +
>>>> +    /* open the virtual block devices */
>>>> +    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
>>>> +        BlockdevOptions_queue *bdo =3D QSIMPLEQ_FIRST(&bdo_queue);
>>>> +
>>>> +        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
>>>> +        loc_push_restore(&bdo->loc);
>>>> +        qmp_blockdev_add(bdo->bdo, &error_fatal);
>>>> +        loc_pop(&bdo->loc);
>>>> +        qapi_free_BlockdevOptions(bdo->bdo);
>>>> +        g_free(bdo);
>>>> +    }
>>>> +    if (snapshot || replay_mode !=3D REPLAY_MODE_NONE) {
>>>> +        qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snaps=
hot,
>>>> +                          NULL, NULL);
>>>> +    }
>>>> +    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>>>> +                          &machine_class->block_default_type, &error_=
fatal)) {
>>>> +        /* We printed help */
>>>> +        exit(0);
>>>> +    }
>>>> +
>>>> +    default_drive(default_cdrom, snapshot, machine_class->block_defau=
lt_type, 2,
>>>> +                  CDROM_OPTS);
>>>> +    default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>>>> +    default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>>>> +
>>>
>>> Can you add a comment here such:
>>>
>>>    /*
>>>     * Arguments setting properties on devices has to be processed before
>>>     * the following qemu_opt_foreach(...machine_set_property...) call.
>>>     */
>>=20
>> Hmm, is this accurate?  The issue this patch addresses is
>>=20
>>     "arguments creating block backends have to be processed before
>>     machine_set_property()",
>>=20
>> which is an instance of
>>=20
>>     "arguments creating backends ...",
>>=20
>> which is an instance of
>>=20
>>     "arguments creating stuff machine property values can reference ..."
>>=20
>> The patch only addresses the instance "block backends".  I have no
>> appetite for attacking more general problems right now.
>>=20
>> See also
>>=20
>>     Subject: Re: [Qemu-devel] [PATCH RFC 0/3] qdev: order devices by pri=
ority before creating them
>>     Date: Wed, 11 May 2016 09:51:39 +0200
>>     Message-ID: <87y47hhw1g.fsf@dusky.pond.sub.org>
>>     https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg01589.ht=
ml
>>=20
>>     Subject: Re: [Qemu-devel] [PATCH] vl: Delay initialization of memory=
 backends
>>     Date: Fri, 02 Sep 2016 08:13:17 +0200
>>     Message-ID: <87poomg77m.fsf@dusky.pond.sub.org>
>>     https://lists.nongnu.org/archive/html/qemu-devel/2016-09/msg00163.ht=
ml
>>=20
>> That said, I'm fine with adding a comment explaining the more general
>> mess.  Can you give me some hints on what future readers will find
>> useful?
>
> This can be as simple as:
>
>      /*
>       * Arguments creating block backends have to be processed before
>       * machine_set_property().
>       */
>      parse_blockdev(...);
>
> So if I have to hack around in the future I'd look at the commit
> introducing this comment:
>
>   Block devices get created long after machine properties get processed.
>   Therefore, block device machine properties can be created, but not
>   set.  No such properties exist.  But the next commit will create some.
>
> So I won't rejig this at his previous place :)

Makes sense, thanks.

[...]
