Received: from eggs.gnu.org ([2001:4830:134:3::10]:60390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dibdW-0002IV-IX
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dibdT-0005Ae-E4
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:24:06 -0400
References: <1502994790-21856-1-git-send-email-thuth@redhat.com>
	<20170818012501.GK5509@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b08f13f1-39ba-b4c4-a64d-6a84619ecc09@redhat.com>
Date: Fri, 18 Aug 2017 09:23:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170818012501.GK5509@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="tT0fHchf8fqfAiqR7WOwmsPjs0BixAEEd"
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Fix segfault when
 instantiating a 'pc-dimm' without 'memdev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tT0fHchf8fqfAiqR7WOwmsPjs0BixAEEd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.08.2017 03:25, David Gibson wrote:
> On Thu, Aug 17, 2017 at 08:33:10PM +0200, Thomas Huth wrote:
>> QEMU currently crashes when trying to use a 'pc-dimm' on the pseries
>> machine without specifying its 'memdev' property. Let's add a sanity
>> check to the pre_plug handler to fix this issue.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Thanks for all these patches fixing little bugs in 2.10.

=2E.. or 2.11 ;-) ... not sure if there will be another RC next week or
the final 2.10 release?

Anyway, the fixes are required for a new qtest that I'm working on
(calling device_add + device_del for all available devices), that's why
I'm coming up with all these patches now. There is another crash with
one of the ppc64 devices, where I don't know how to fix it yet - so if
somebody got a clue, help is appreciated:

$ qemu-system-ppc64 -nographic -S -nodefaults -monitor stdio -M pseries
QEMU 2.9.92 monitor - type 'help' for more information
(qemu) device_add macio-oldworld,id=3Dx
(qemu) device_del x
(qemu) **
ERROR:qemu/qom/object.c:1611:object_get_canonical_path_component:
 assertion failed: (obj->parent !=3D NULL)
Aborted (core dumped)

>> ---
>>  hw/ppc/spapr.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index f7a1972..22d400a 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2808,10 +2808,17 @@ static void spapr_memory_pre_plug(HotplugHandl=
er *hotplug_dev, DeviceState *dev,
>>  {
>>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>> -    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
>> -    uint64_t size =3D memory_region_size(mr);
>> +    MemoryRegion *mr;
>> +    uint64_t size;
>>      char *mem_dev;
>> =20
>> +    if (!dimm->hostmem) {
>=20
> Isn't checking dimm->hostmem directly here an abstraction violation?
> Could we just check for a NULL return from get_memory_region instead?

The crash happens within get_memory_region: pc_dimm_get_memory_region()
calls host_memory_backend_get_memory(), which calls
host_memory_backend_mr_inited() - and that function dereferences the
NULL pointer.

I could add an additional check to one of the called functions and
return NULL in case the pointer is already NULL ... do you prefer that?
Let me know, then I'll send a v2...

>=20
>> +        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be =
set");
>> +        return;
>> +    }
>> +
>> +    mr =3D ddc->get_memory_region(dimm);
>> +    size =3D memory_region_size(mr);
>>      if (size % SPAPR_MEMORY_BLOCK_SIZE) {
>>          error_setg(errp, "Hotplugged memory size must be a multiple o=
f "
>>                        "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
>=20

 Thomas


--tT0fHchf8fqfAiqR7WOwmsPjs0BixAEEd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZlpYOAAoJEC7Z13T+cC21aekP/1fFyD59vGkrt5FVFTStWCr7
etCDF9IRC2i7SSrccleLWPiceOUpni4SvyWdAUK/IbkeckXqvf0YzV6CM/+Om+zU
gb3PtpNWVLfkdxA0ePftWD+0V7/+7lsLvAXLWRO9IHQrhmfqF4TJFUQb/dOzgLnR
zQk0e6cTNXRKoWiteVmI8euEN5QyJ7sMZ/wS/ry/FmJq26eBTbOQBcYn8fnmB9ri
VAfFzKM25ddp6+ePpalnTiVfkg6mAAgBVXIJZJo9UwvfsV3rWHrtAtcxn5qg4bCL
gPrKsfm2Q4GeRd+TH968kH6bZdXKSnzMeiF8st4/KgF7dYhTmiWVMYdMI/IGKd7f
YavVVycYo4pAmZoQAHgxo8lf1BaVRqZKvxtYKNVJw8O9LHPFkOvVGRn0Qz4DKIdS
ZvswQJMkxVq3qp5kFzKKInPc8fII6I8B4SqNZlfPTpD6W7O/3a53aIbg2SKi8MBc
UxmdQHFcOBdexBQOpbWDOe6aZoUEmI+ZTzjxlSluAJo2OMgOSANth/aHlhuGXyGA
B3hCfjri+L0cTIJQPVdTa4kBaUCWcdG9OA7gPzZEeryIi0LP6ZIloK7OpnTiuIOv
HxKdr6MtwnY15Kk5oF6D1QqVQWthVo0mHLrxY2YePQQDqAC07Ki+OlZ+4eRSrR5M
3AO5aq/wm7NT6vvEIqMN
=Wim2
-----END PGP SIGNATURE-----

--tT0fHchf8fqfAiqR7WOwmsPjs0BixAEEd--
