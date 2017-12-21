Received: from eggs.gnu.org ([2001:4830:134:3::10]:42108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRwsN-00024R-Jj
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRwsI-000125-Hj
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:10:51 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20171221013600.17648-1-eblake@redhat.com>
	<20171221013600.17648-5-eblake@redhat.com>
	<47a78a6e-cc5b-5ac5-1f80-222ecb4ee8c4@virtuozzo.com>
Message-ID: <8efcad22-de4d-8158-caaa-279bad992648@virtuozzo.com>
Date: Thu, 21 Dec 2017 12:10:31 +0300
MIME-Version: 1.0
In-Reply-To: <47a78a6e-cc5b-5ac5-1f80-222ecb4ee8c4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] STOP Re: [PULL 4/4] qmp: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

look at "[PATCH v2 0/6] nbd export qmp interface"

21.12.2017 12:07, Vladimir Sementsov-Ogievskiy wrote:
> no, I've updated it, we discussed with Kevin that this approach is bad
>
> 21.12.2017 04:36, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Add command for export removing. It is needed for cases when we
>> don't want to keep export after the operation on it was completed.
>> The other example is temporary node, created with blockdev-add.
>> If we want to delete it we should firstly remove corresponding
>> NBD export.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Message-Id: <20171109154049.42386-3-vsementsov@virtuozzo.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>> =C2=A0 qapi/block.json | 20 ++++++++++++++++++++
>> =C2=A0 blockdev-nbd.c=C2=A0 | 27 +++++++++++++++++++++++++++
>> =C2=A0 2 files changed, 47 insertions(+)
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index f093fa3f27..1827940717 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -222,6 +222,26 @@
>> =C2=A0 ##
>> =C2=A0 { 'command': 'nbd-server-add', 'data': {'device': 'str',=20
>> '*writable': 'bool'} }
>>
>> +##
>> +# @nbd-server-remove:
>> +#
>> +# Stop exporting block node through QEMU's embedded NBD server.
>> +#
>> +# @device: The device name or node name of the exported node. Should=20
>> be equal
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to @device para=
meter for corresponding nbd-server-add=20
>> command call.
>> +#
>> +# @force: Whether active connections to the export should be closed.=20
>> If this
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parameter is false th=
e export is only removed from named=20
>> exports list,
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 so new connetions are=
 impossible and it would be freed=20
>> after all
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clients are disconnec=
ted (default false).
>> +#
>> +# Returns: error if the server is not running or the device is not=20
>> marked for
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 export.
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'command': 'nbd-server-remove', 'data': {'device': 'str',=20
>> '*force': 'bool'} }
>> +
>> =C2=A0 ##
>> =C2=A0 # @nbd-server-stop:
>> =C2=A0 #
>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>> index 28f551a7b0..5f66951c33 100644
>> --- a/blockdev-nbd.c
>> +++ b/blockdev-nbd.c
>> @@ -203,6 +203,33 @@ void qmp_nbd_server_add(const char *device, bool=20
>> has_writable, bool writable,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_export_put(exp);
>> =C2=A0 }
>>
>> +void qmp_nbd_server_remove(const char *device, bool has_force, bool=20
>> force,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 NBDExport *exp;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!nbd_server) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "NBD server=
 not running");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 exp =3D nbd_export_find(device);
>> +=C2=A0=C2=A0=C2=A0 if (exp =3D=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "'%s' is no=
t exported", device);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!has_force) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 force =3D false;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (force) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_export_close(exp);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_export_set_name(exp, NUL=
L);
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> =C2=A0 void qmp_nbd_server_stop(Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_export_close_all();
>
>


--=20
Best regards,
Vladimir
