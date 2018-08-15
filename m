Received: from eggs.gnu.org ([2001:4830:134:3::10]:34291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpqv0-0004B2-Mt
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 04:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpquz-0005Xd-Cx
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 04:12:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180725151011.25951-1-armbru@redhat.com>
	<5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
	<20180725160144.GJ12855@redhat.com>
	<20180728043238.GC1325070@localhost.localdomain>
	<371fc437-1330-6873-7f6d-99af8d56c5df@redhat.com>
Date: Wed, 15 Aug 2018 10:12:12 +0200
In-Reply-To: <371fc437-1330-6873-7f6d-99af8d56c5df@redhat.com> (Max Reitz's
	message of "Sun, 29 Jul 2018 16:51:40 +0200")
Message-ID: <87ftzgnj4z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON
 and back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, kwolf@redhat.com, jdurgin@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> On 2018-07-28 06:32, Jeff Cody wrote:
>> On Wed, Jul 25, 2018 at 05:01:44PM +0100, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Jul 25, 2018 at 10:56:48AM -0500, Eric Blake wrote:
>>>> On 07/25/2018 10:10 AM, Markus Armbruster wrote:
>>>>> qemu_rbd_parse_filename() builds a keypairs QList, converts it to JSO=
N, and
>>>>> stores the resulting QString in a QDict.
>>>>>
>>>>> qemu_rbd_co_create_opts() and qemu_rbd_open() get the QString from the
>>>>> QDict, pass it to qemu_rbd_set_keypairs(), which converts it back into
>>>>> a QList.
>>>>>
>>>>> Drop both conversions, store the QList instead.
>>>>>
>>>>> This affects output of qemu-img info.  Before this patch:
>>>>>
>>>>>      $ qemu-img info rbd:rbd/testimg.raw:mon_host=3D192.168.15.180:rb=
d_cache=3Dtrue:conf=3D/tmp/ceph.conf
>>>>>      [junk printed by Ceph library code...]
>>>>>      image: json:{"driver": "raw", "file": {"pool": "rbd", "image": "=
testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=3Dkeyvalue-pairs=
": "[\"mon_host\", \"192.168.15.180\", \"rbd_cache\", \"true\"]"}}
>>>>>      [more output, not interesting here]
>>>>>
>>>>> After this patch, we get
>>>>>
>>>>>      image: json:{"driver": "raw", "file": {"pool": "rbd", "image": "=
testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=3Dkeyvalue-pairs=
": ["mon_host", "192.168.15.180", "rbd_cache", "true"]}}
>>>>>
>>>>> The value of member "=3Dkeyvalue-pairs" changes from a string contain=
ing
>>>>> a JSON array to that JSON array.  That's an improvement of sorts.  Ho=
wever:
>>>>>
>>>>> * Should "=3Dkeyvalue-pairs" even be visible here?  It's supposed to =
be
>>>>>    purely internal...
>>>>
>>>> I'd argue that since it is supposed to be internal (as evidenced by the
>>>> leading '=3D' that does not name a normal variable), changing it doesn=
't hurt
>>>> stability. But yes, it would be nicer if we could filter it entirely s=
o that
>>>> it does not appear in json: output, if it doesn't truly affect the con=
tents
>>>> that the guest would see.
>>>
>>> If it appears in the json: output, then that means it could get written
>>> into qcow2 headers as a backing file name, which would make it ABI
>>> sensitive. This makes it even more important to filter it if it is supp=
osed
>>> to be internal only, with no ABI guarantee.
>>>
>>=20
>> It's been present for a couple releases (counting 3.0); is it safe to
>> assume that, although it could be present in the qcow2 headers, that it =
will
>> not break anything by altering it or removing it?
>
> Did =3Dkeyvalue-pairs even work in json:{} filename?  If so, it will
> continue to work even after filtering it.  If not, then filtering it
> won't break existing files because they didn't work before either.

I'm afraid it does work:

    $ gdb --args upstream-qemu -nodefaults -S -display vnc=3D:0 -readconfig=
 test.cfg 'json:{"driver": "raw", "file": {"pool": "rbd", "image": "testimg=
.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=3Dkeyvalue-pairs": "[\"=
mon_host\", \"192.168.15.180\", \"rbd_cache\", \"true\"]"}}'
    GNU gdb (GDB) Fedora 8.1-25.fc28
    [...]
    (gdb) b qemu_rbd_open=20
    Breakpoint 1 at 0x845f83: file /work/armbru/qemu/block/rbd.c, line 660.
    (gdb) r
    Starting program: /home/armbru/bin/upstream-qemu -nodefaults -S -displa=
y vnc=3D:0 -readconfig test.cfg json:\{\"driver\":\ \"raw\",\ \"file\":\ \{=
\"pool\":\ \"rbd\",\ \"image\":\ \"testimg.raw\",\ \"conf\":\ \"/tmp/ceph.c=
onf\",\ \"driver\":\ \"rbd\",\ \"=3Dkeyvalue-pairs\":\ \"\[\\\"mon_host\\\"=
,\ \\\"192.168.15.180\\\",\ \\\"rbd_cache\\\",\ \\\"true\\\"\]\"\}\}
    [...]
    Thread 1 "upstream-qemu" hit Breakpoint 1, qemu_rbd_open (bs=3D0x555556=
a5a970,=20
        options=3D0x555556a5ec40, flags=3D24578, errp=3D0x7fffffffd370)
        at /work/armbru/qemu/block/rbd.c:660
    660	{
    [...]
    (gdb) n
    661	    BDRVRBDState *s =3D bs->opaque;
    (gdb)=20
    662	    BlockdevOptionsRbd *opts =3D NULL;
    (gdb)=20
    665	    Error *local_err =3D NULL;
    (gdb)=20
    669	    keypairs =3D g_strdup(qdict_get_try_str(options, "=3Dkeyvalue-p=
airs"));
    (gdb)=20
    670	    if (keypairs) {
    (gdb) p keypairs=20
    $1 =3D 0x5555569e54c0 "[\"mon_host\", \"192.168.15.180\", \"rbd_cache\"=
, \"true\"]"

It really, really, really should not work.

It doesn't work with anything that relies on QAPI to represent
configuration (such as QMP's blockdev-add), because BlockdevOptionsRbd
doesn't have it.

It works with -drive only with a pseudo-filename (more on that below),
even though -drive uses QemuOpts and QDict rather than QAPI, because the
(carefully chosen) name "=3Dkeyvalue-pairs" is impossible to use with
QemuOpts.

However, we missed the json:... backdoor :(

Block device configuration has become waaaaay too baroque.  I can't keep
enough of it in my mind at the same time to change it safely.  I believe
none of us can.

> To me personally the issue is that if you can specify a plain filename,
> bdrv_refresh_filename() should give you that plain filename back.  So
> rbd's implementation of that is lacking.  Well, it just doesn't exist.

I'm not even sure I understand what you're talking about.

>> If so, and we are comfortable changing the output the way this patch does
>> (technically altering ABI anyway), we might as well go all the way and
>> filter it out completely.  That would be preferable to cleaning up the j=
son
>> output of the internal key/value pairs, IMO.
>
> Well, this filtering at least is done by my "Fix some filename
> generation issues" series.

Likewise.

Back to rbd.  =3Dkeyvalue-pairs exists only to implement the part after
':' in pseudo-filenames
rbd:poolname/devicename[@snapshotname][:option1=3Dvalue1[:option2=3Dvalue2.=
..]]

Lets you pass arbitrary configuration to rados_conf_set().  We pass it
before we pass configuration the rbd driver computes (such as
rbd_cache), which should get conflicting key-value pairs silently
ignored.

We treat "id" and "conf" specially.  "id" gets passed to rados_create(),
not rados_conf_set().  "conf" names a configuration file, i.e. it's yet
another way to pass arbitrary configuration, this time via
rados_conf_read_file().  We call that before passing the non-special
key-value pairs to rados_conf_set(), which should get conflicting
settings in the conf file silently ignored.

We provide the equivalent to "id" and "conf" in QAPI, but we refused to
provide key-value pairs.

Same for -drive without a pseudo-filename.

Unfortunately, our attempt to confine the unloved key-value pair feature
to pseudo-filenames has failed: it escaped through the json: backdoor.

Can we get rid of the key-value pair feature?
