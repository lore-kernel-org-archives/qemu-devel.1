Received: from eggs.gnu.org ([2001:4830:134:3::10]:40301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVdro-0002Et-Aa
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVdrj-0007ZR-AT
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:13:48 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-6-vsementsov@virtuozzo.com>
	<45f6544a-d384-f3cc-5fd4-c3d5f0268f25@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f92c42cd-d5ed-b89d-5381-f220fdd4aa02@virtuozzo.com>
Date: Wed, 20 Jun 2018 17:13:34 +0300
MIME-Version: 1.0
In-Reply-To: <45f6544a-d384-f3cc-5fd4-c3d5f0268f25@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 5/6] qapi: new qmp command
 nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

20.06.2018 14:26, Eric Blake wrote:
> On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 qapi/block.json | 23 +++++++++++++++++++++++
>> =C2=A0 blockdev-nbd.c=C2=A0 | 23 +++++++++++++++++++++++
>> =C2=A0 2 files changed, 46 insertions(+)
>
> I'm tempted to temporarily name this x-nbd-server-add-bitmap, until I=20
> have the counterpart Libvirt patches tested, just in case testing=20
> turns up any tweaks we need to the interface.
>
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index c694524002..ddbca2e286 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -269,6 +269,29 @@
>> =C2=A0=C2=A0=C2=A0 'data': {'name': 'str', '*mode': 'NbdServerRemoveMode=
'} }
>> =C2=A0 =C2=A0 ##
>> +# @nbd-server-add-bitmap:
>> +#
>> +# Expose a dirty bitmap associated with the selected export. The=20
>> bitmap search
>> +# starts at the device attached to the export, and includes all=20
>> backing files.
>> +# The exported bitmap is then locked until the NBD export is removed.
>
> The fact that you search the backing chain is at least consistent with=20
> your code.
>
>> +#
>> +# @name: Export name.
>> +#
>> +# @bitmap: Bitmap name to search for.
>> +#
>> +# @bitmap-export-name: How the bitmap will be seen by nbd clients
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (default @bitmap)
>
> Do we really need the flexibility of naming the bitmap differently to=20
> the NBD client than we do in qemu?

It was needed for our backup-api implementation. Nikolay?

>
>> +#
>> +# Note: the client must use NBD_OPT_SET_META_CONTEXT with a query of
>> +# "qemu:dirty-bitmap:NAME" (where NAME matches @bitmap-export-name)=20
>> to access
>> +# the exposed bitmap.
>> +#
>> +# Since: 3.0
>> +##
>> +=C2=A0 { 'command': 'nbd-server-add-bitmap',
>> +=C2=A0=C2=A0=C2=A0 'data': {'name': 'str', 'bitmap': 'str', '*bitmap-ex=
port-name':=20
>> 'str'} }
>> +
>> +##
>> =C2=A0 # @nbd-server-stop:
>> =C2=A0 #
>> =C2=A0 # Stop QEMU's embedded NBD server, and unregister all devices=20
>> previously
>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>> index 65a84739ed..6b0c50732c 100644
>> --- a/blockdev-nbd.c
>> +++ b/blockdev-nbd.c
>> @@ -220,3 +220,26 @@ void qmp_nbd_server_stop(Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_server_free(nbd_server);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_server =3D NULL;
>> =C2=A0 }
>> +
>> +void qmp_nbd_server_add_bitmap(const char *name, const char *bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_bitmap_export_name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *bitmap_export_name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 NBDExport *exp;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!nbd_server) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "NBD server=
 not running");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 exp =3D nbd_export_find(name);
>> +=C2=A0=C2=A0=C2=A0 if (exp =3D=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Export '%s=
' is not found", name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 nbd_export_bitmap(exp, bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has_bitmap_export=
_name ? bitmap_export_name :=20
>> bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>> +}
>>
>


--=20
Best regards,
Vladimir
