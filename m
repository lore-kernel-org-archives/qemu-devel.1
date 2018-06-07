Received: from eggs.gnu.org ([2001:4830:134:3::10]:54619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fQzxd-0005Ot-Lg
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fQzxc-0001be-Id
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:37 -0400
References: <1528382429-13478-1-git-send-email-ari@tuxera.com>
	<1528382429-13478-3-git-send-email-ari@tuxera.com>
	<337a4d38-397e-a251-b387-27034140d94d@redhat.com>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <98fccefb-89ab-3d14-b838-4991ac302959@tuxera.com>
Date: Thu, 7 Jun 2018 21:48:27 +0300
MIME-Version: 1.0
In-Reply-To: <337a4d38-397e-a251-b387-27034140d94d@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/10] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Aapo Vienamo <aapo@tuxera.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>"open list:Block layer core" <qemu-block@nongnu.org>

On 06/07/2018 09:32 PM, Eric Blake wrote:
> On 06/07/2018 09:40 AM, Ari Sundholm wrote:
>> From: Aapo Vienamo <aapo@tuxera.com>
>>
>> Implements a block device write logging system, similar to Linux kerne=
l
>> device mapper dm-log-writes. The write operations that are performed
>> on a block device are logged to a file or another block device. The
>> write log format is identical to the dm-log-writes format. Currently,
>> log markers are not supported.
>>
>> This functionality can be used for crash consistency and fs consistenc=
y
>> testing. By implementing it in qemu, tests utilizing write logs can be
>> be used to test non-Linux drivers and older kernels.
>>
>> The implementation is based on the blkverify and blkdebug block driver=
s.
>>
>> Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>> ---
>=20
>> +++ b/qapi/block-core.json
>> @@ -2429,12 +2429,12 @@
>> =C2=A0 # Since: 2.9
>> =C2=A0 ##
>> =C2=A0 { 'enum': 'BlockdevDriver',
>=20
> Missing a comment:
>=20
> # @blklogwrites: Since 3.0
>=20

Thanks, will add in v4.

>> -=C2=A0 'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop', 'copy-on-=
read',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'd=
mg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'h=
ost_device', 'http', 'https', 'iscsi', 'luks', 'nbd',=20
>> 'nfs',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'n=
ull-aio', 'null-co', 'nvme', 'parallels', 'qcow',=20
>> 'qcow2', 'qed',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'q=
uorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 't=
hrottle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs'=20
>> ] }
>> +=C2=A0 'data': [ 'blkdebug', 'blklogwrites', 'blkverify', 'bochs', 'c=
loop',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'c=
opy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'h=
ost_cdrom', 'host_device', 'http', 'https', 'iscsi',=20
>> 'luks',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'n=
bd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels',=20
>> 'qcow',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'q=
cow2', 'qed', 'quorum', 'raw', 'rbd', 'replication',=20
>> 'sheepdog',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 's=
sh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat',=20
>> 'vxhs' ] }
>> =C2=A0 ##
>> =C2=A0 # @BlockdevOptionsFile:
>> @@ -2949,6 +2949,21 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*set-state': ['BlkdebugSetStateOptions'] } }
>> =C2=A0 ##
>> +# @BlockdevOptionsBlklogwrites:
>> +#
>> +# Driver specific block device options for blklogwrites.
>> +#
>> +# @raw:=C2=A0=C2=A0=C2=A0=C2=A0 block device
>> +#
>> +# @log:=C2=A0=C2=A0=C2=A0=C2=A0 block device used to log writes on @r=
aw
>> +#
>> +# Since: foo
>=20
> s/foo/3.0/
>=20

Oops, this was a placeholder that I ended up forgetting about. Will be=20
fixed in v4.

Thanks,
Ari Sundholm
ari@tuxera.com

>> +##
>> +{ 'struct': 'BlockdevOptionsBlklogwrites',
>> +=C2=A0 'data': { 'raw': 'BlockdevRef',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'l=
og': 'BlockdevRef' } }
>> +
>> +##
>> =C2=A0 # @BlockdevOptionsBlkverify:
>> =C2=A0 #
>> =C2=A0 # Driver specific block device options for blkverify.
>> @@ -3443,6 +3458,7 @@
>> =C2=A0=C2=A0=C2=A0 'discriminator': 'driver',
>> =C2=A0=C2=A0=C2=A0 'data': {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blkdebug':=C2=A0=C2=A0 'Bl=
ockdevOptionsBlkdebug',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blklogwrites': 'BlockdevOptionsBlklog=
writes',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blkverify':=C2=A0 'Blockde=
vOptionsBlkverify',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'bochs':=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'BlockdevOptionsGenericFormat',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'cloop':=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'BlockdevOptionsGenericFormat',
>> @@ -3971,6 +3987,7 @@
>> =C2=A0=C2=A0=C2=A0 'discriminator': 'driver',
>> =C2=A0=C2=A0=C2=A0 'data': {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blkdebug':=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 'BlockdevCreateNotSupported',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blklogwrites':=C2=A0=C2=A0 'BlockdevC=
reateNotSupported',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blkverify':=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'BlockdevCreateNotSupported',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'bochs':=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'BlockdevCreateNotSupported',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'cloop':=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'BlockdevCreateNotSupported',
>>
>=20
