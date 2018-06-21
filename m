Received: from eggs.gnu.org ([2001:4830:134:3::10]:50186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVwXz-0007pq-Rq
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVwXv-0003Vf-OK
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:10:35 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-6-vsementsov@virtuozzo.com>
	<45f6544a-d384-f3cc-5fd4-c3d5f0268f25@redhat.com>
	<f92c42cd-d5ed-b89d-5381-f220fdd4aa02@virtuozzo.com>
	<88afa2f6-39b3-092e-33c2-4436cbe8e5dd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b0d9121b-db6a-36c9-ad29-f743a535ac71@virtuozzo.com>
Date: Thu, 21 Jun 2018 13:10:26 +0300
MIME-Version: 1.0
In-Reply-To: <88afa2f6-39b3-092e-33c2-4436cbe8e5dd@redhat.com>
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

20.06.2018 21:14, Eric Blake wrote:
> On 06/20/2018 09:13 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 20.06.2018 14:26, Eric Blake wrote:
>>> On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>> =C2=A0 qapi/block.json | 23 +++++++++++++++++++++++
>>>> =C2=A0 blockdev-nbd.c=C2=A0 | 23 +++++++++++++++++++++++
>>>> =C2=A0 2 files changed, 46 insertions(+)
>>>
>>> I'm tempted to temporarily name this x-nbd-server-add-bitmap, until=20
>>> I have the counterpart Libvirt patches tested, just in case testing=20
>>> turns up any tweaks we need to the interface.
>>>
>
>>>> +# @bitmap-export-name: How the bitmap will be seen by nbd clients
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (default @bitm=
ap)
>>>
>>> Do we really need the flexibility of naming the bitmap differently=20
>>> to the NBD client than we do in qemu?
>>
>> It was needed for our backup-api implementation. Nikolay?
>
> In fact, if we include the ability now, we can't remove it later=20
> (unless we use the x- prefix); but if we omit it now, we can add it=20
> later (regardless of using the x- prefix).=C2=A0 So I've gone ahead and=20
> added the x- prefix; here's what I'm squashing, along with:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> diff --git i/qapi/block.json w/qapi/block.json
> index ddbca2e286c..ca807f176ae 100644
> --- i/qapi/block.json
> +++ w/qapi/block.json
> @@ -269,7 +269,7 @@
> =C2=A0=C2=A0 'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }
>
> =C2=A0##
> -# @nbd-server-add-bitmap:
> +# @x-nbd-server-add-bitmap:
> =C2=A0#
> =C2=A0# Expose a dirty bitmap associated with the selected export. The=20
> bitmap search
> =C2=A0# starts at the device attached to the export, and includes all=20
> backing files.
> @@ -288,7 +288,7 @@
> =C2=A0#
> =C2=A0# Since: 3.0
> =C2=A0##
> -=C2=A0 { 'command': 'nbd-server-add-bitmap',
> +=C2=A0 { 'command': 'x-nbd-server-add-bitmap',
> =C2=A0=C2=A0=C2=A0=C2=A0 'data': {'name': 'str', 'bitmap': 'str', '*bitma=
p-export-name':=20
> 'str'} }
>
> =C2=A0##
> diff --git i/blockdev-nbd.c w/blockdev-nbd.c
> index 6b0c50732c1..1ef11041a73 100644
> --- i/blockdev-nbd.c
> +++ w/blockdev-nbd.c
> @@ -221,10 +221,10 @@ void qmp_nbd_server_stop(Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0 nbd_server =3D NULL;
> =C2=A0}
>
> -void qmp_nbd_server_add_bitmap(const char *name, const char *bitmap,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_bitmap_export_name,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *bitmap_export_name,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
> +void qmp_x_nbd_server_add_bitmap(const char *name, const char *bitmap,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_bitmap_export_name,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *bitmap_export_nam=
e,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 NBDExport *exp;
>
>
>

Ok, good

--=20
Best regards,
Vladimir
