Received: from eggs.gnu.org ([2001:4830:134:3::10]:50740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cY7N4-0004Xs-NB
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cY7My-0001WL-JP
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:31:30 -0500
Received: from mail-db5eur01on0118.outbound.protection.outlook.com
	([104.47.2.118]:51633
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cY7Mx-0001RU-Lx
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:31:24 -0500
References: <1485362572-7246-1-git-send-email-den@openvz.org>
	<1e511c84-c9fa-1d4e-8a73-e48c0b29a59a@redhat.com>
	<1251c8d7-3862-2cb9-a3c8-aa6d3c8e3924@openvz.org>
	<6c3d6ad4-3f77-3a5a-c619-fd242b58a730@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <b3f64825-d9dc-e4a1-1b9e-8d4c0108454d@openvz.org>
Date: Mon, 30 Jan 2017 11:31:16 +0300
MIME-Version: 1.0
In-Reply-To: <6c3d6ad4-3f77-3a5a-c619-fd242b58a730@redhat.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] block: add missed BDRV_O_NOCACHE when
 block device is opened without file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On 01/28/2017 07:23 PM, Max Reitz wrote:
> On 25.01.2017 20:44, Denis V. Lunev wrote:
>> On 01/25/2017 08:59 PM, Max Reitz wrote:
>>> [CC-ing John]
>>>
>>> On 25.01.2017 17:42, Denis V. Lunev wrote:
>>>> Technically there is a problem when the guest DVD is created by libv=
irt
>>>> with AIO mode 'native' on Linux. Current QEMU is unable to start the=

>>>> domain configured as follows:
>>>>     <disk type=3D'file' device=3D'cdrom'>
>>>>       <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native=
'/>
>>>>       <target dev=3D'sdb' bus=3D'scsi'/>
>>>>       <readonly/>
>>>>     </disk>
>>>> The problem comes from the combination of 'cache' and 'io' options.
>>>>
>>>> 'io' option is common option and it is removed from block driver
>>>> specific options. 'cache' originally is not. The patch makes 'cache'=

>>>> option common. This works fine as long as cdrom media insertion
>>>> later on.
>>>>
>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>> CC: Kevin Wolf <kwolf@redhat.com>
>>>> CC: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  blockdev.c | 18 +++++++++++++++---
>>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>> There was a Red Hat BZ for this:
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1342999
>>>
>>> There is now a corresponding BZ for libvirt:
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1377321
>>>
>>> The gist is that it was determined to be a problem with libvirt.
>>>
>>> RHEL has a downstream commit to work around this issue by ignoring th=
e
>>> cache mode set for empty CD-ROMs -- but that is only because that was=

>>> simpler than fixing libvirt.
>>>
>>> (Note that it's ignoring the cache mode instead of actually evaluatin=
g it.)
>>>
>> This is what I have exactly started from:
>> http://ftp.redhat.com/pub/redhat/linux/enterprise/7Server/en/RHEV/SRPM=
S/qemu-kvm-rhev-2.6.0-27.el7.src.rpm
>>
>> This package starts VM well for the above mentioned configuration:
>>
>>     <disk type=3D'file' device=3D'cdrom'>
>>       <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/=
>
>>       <target dev=3D'sdb' bus=3D'scsi'/>
>>       <readonly/>
>>     </disk>
>>
>> but the problem comes later at 'change' moment. It reports
>>
>> 'Details: internal error: unable to execute QEMU command 'change':
>> aio=3Dnative was specified, but it requires cache.direct=3Don, which
>> was not specified.)'
>>
>>
>> Thus partial solution implemented by the RedHat is really
>> partial and does not work at the second stage.
> Yes, because it is not supposed to work for that. The only thing the
> downstream patch does is ignore the cache mode so you can still start
> the VM even if libvirt decides to specify a cache parameter for an empt=
y
> drive (which it should not do).
>
>>                                                I have started from
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index d280dc4..e2c9053 100644  =20
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -608,6 +608,13 @@ static BlockBackend *blockdev_init(const char
>> *file, QDict *bs_opts,
>>              goto early_err;
>>          }
>> =20
>> +        if (qdict_haskey(bs_opts, BDRV_OPT_CACHE_DIRECT)) {
>> +            bdrv_flags |=3D BDRV_O_NOCACHE;
>> +        }
>> +        if (qdict_haskey(bs_opts, BDRV_OPT_CACHE_NO_FLUSH)) {
>> +            bdrv_flags |=3D BDRV_O_NO_FLUSH;
>> +        }
>> +
>>          blk_rs =3D blk_get_root_state(blk);
>>          blk_rs->open_flags    =3D bdrv_flags;
>>          blk_rs->read_only     =3D !(bdrv_flags & BDRV_O_RDWR);
>>
>> The problem for us is that we have such previously valid configuration=
s
>> in the field.
>>
>>>> May be this has already discussed, but still. AIO=3Dnative for CDROM=
 without
>>>> media seems important case.
>>> First, I personally don't find aio=3Dnative very important for CD-ROM=

>>> drives. Yes, we shouldn't make IDE CD-ROM slower than necessary, but =
I
>>> don't think aio=3Dnative will make the difference between "Slow like
>>> CD-ROMs are in reality" and "As fast as virtio".
>> the problem for me is that each clone() call is costly and counts. Tha=
t
>> is why we are trying to avoid it whenever possible. That is why 'nativ=
e'
>> mode is MUCH better. Also it would be very nice not to use cached
>> IO, which is very good for memory overcommit situations.
>>
>> Here I am fighting not with the performance, which does not make
>> any real sense, but with a memory footprint.
> Fair enough. Still, specifying a cache mode for an empty drive simply
> doesn't make sense.
>
> Have you considered inserting a null-co:// file at startup as a
> workaround? If you use the old 'change' (or blockdev-change-medium)
> command, it should retain AIO and cache mode.
ok. Thanks for the suggestion.


>
>>> Second, all this patch does is revert some changes done by commit
>>> 91a097e7478940483e76d52217f05bc05b98d5a5, which was very deliberate.
>>>
>>> Third, you may then be asking for the recommended way to put an
>>> aio=3Dnative medium into a CD-ROM drive. Good thing you ask, because =
we
>>> have a way that we want to recommend but can't because it's still
>>> considered experimental:
>>>
>>> The BDS is added using blockdev-add, with all of the appropriate cach=
ing
>>> and aio options. Then it's inserted into the drive using the
>>> x-blockdev-insert-medium command, and the drive is closed using
>>> blockdev-close-tray.
>> the problem, again, is that with x-blockdev-insert-medium I can not
>> deal with block driver options, or may be I am missing something.
> x-blockdev-insert-medium just inserts a BDS as a medium. The BDS is
> added via blockdev-add which allows you to set all of these options.
>
>>> There are a couple of issues with this: First, blockdev-add and
>>> x-blockdev-insert-medium are still experimental. The good news are th=
at
>>> I think the reason why the latter is experimental has actually
>>> disappeared and we can just drop the x- by now. The
>>> not-so-good-but-not-so-bad-either news are that we plan to get
>>> blockdev-add declared non-experimental for 2.9. Let's see how it goes=
=2E
>> Does this mean that x-blockdev-del would also lose x- prefix?
> As far as I'm aware, yes.

that sounds good!


>>> The other issue is that of course it's more cumbersome to use than a
>>> simple 'change' via HMP. I argue that if someone communicates with a =
VM
>>> by hand, they either have to deal with this added complexity or they
>>> cannot use aio=3Dnative for CD-ROM drives -- which, as I said, I don'=
t
>>> think is too bad.
>> this is how 'virsh change-media' works at the moment, at least with
>> latest downstreams.
>> That is why this is not that clear.
> Well, that can be easily changed, the question is how fast that will be=
=2E
> You would still need to make libvirt aware of what cache mode to use fo=
r
> the new medium, and that may require deeper changes.
>
> (I supposed libvirt only stores a cache mode per drive while it should
> actually store a cache mode per image.)

fair enough. libvirt could do that.
Thank you for these clarifications.

Den
