Received: from eggs.gnu.org ([2001:4830:134:3::10]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ditmJ-0003xe-S8
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 22:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ditmG-0003Ch-NY
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 22:46:23 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ditmG-0003Bb-CK
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 22:46:20 -0400
Received: by mail-pg0-x242.google.com with SMTP id n4so2532875pgn.0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 19:46:19 -0700 (PDT)
References: <20170818133118.8650-1-stefanha@redhat.com>
	<72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
Date: Sat, 19 Aug 2017 12:46:11 +1000
MIME-Version: 1.0
In-Reply-To: <72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gbml65kfcSbPiWVJB2HnkVEun9MFnV53L"
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gbml65kfcSbPiWVJB2HnkVEun9MFnV53L
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
References: <20170818133118.8650-1-stefanha@redhat.com>
 <72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
In-Reply-To: <72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/08/17 01:18, Eric Blake wrote:
> On 08/18/2017 08:31 AM, Stefan Hajnoczi wrote:
>> Most qcow2 files are uncompressed so it is wasteful to allocate (32 + =
1)
>> * cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
>> s->cluster_data when the first read operation is performance on a
>> compressed cluster.
>>
>> The buffers are freed in .bdrv_close().  .bdrv_open() no longer has an=
y
>> code paths that can allocate these buffers, so remove the free functio=
ns
>> in the error code path.
>>
>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>> Alexey: Does this improve your memory profiling results?
>=20
> Is this a regression from earlier versions?=20

Hm, I have not thought about this.

So. I did bisect and this started happening from
9a4c0e220d8a4f82b5665d0ee95ef94d8e1509d5
"hw/virtio-pci: fix virtio behaviour"

Before that, the very same command line would take less than 1GB of
resident memory. That thing basically enforces virtio-1.0 for QEMU <=3D2.=
6
which means that upstream with "-machine pseries-2.6" works fine (less th=
an
1GB), "-machine pseries-2.7" does not (close to 7GB, sometime even 9GB).

Then I tried bisecting again, with
"scsi=3Doff,disable-modern=3Doff,disable-legacy=3Don" on my 150 virtio-bl=
ock
devices, started from
e266d421490e0 "virtio-pci: add flags to enable/disable legacy/modern" (it=

added the disable-modern switch) which uses 2GB of memory.

I ended up with ada434cd0b44 "virtio-pci: implement cfg capability".

Then I removed proxy->modern_as on v2.10.0-rc3 (see below) and got 1.5GB =
of
used memory (yay!)

I do not really know how to reinterpret all of this, do you?


Note: 1GB..9GB numbers from below are the peak values from valgrind's
massif. This is pretty much resident memory used by QEMU process. In my
testing I did not enable KVM and I did not start the guest (i.e. used -S)=
=2E
150 virtio-block devices, 2GB RAM for the guest.

Also, while bisecting, I only paid attention if it is 1..2GB or 6..9GB -
all tests did fit these 2 ranges, for any given sha1 the amount of memory=

would be stable but among "good" commits it could change between 1GB and =
2GB.



diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5d14bd6..7ad447a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1783,6 +1783,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev,
Error **errp)
                        /* PCI BAR regions must be powers of 2 */
                        pow2ceil(proxy->notify.offset + proxy->notify.siz=
e));

+#if 0
     memory_region_init_alias(&proxy->modern_cfg,
                              OBJECT(proxy),
                              "virtio-pci-cfg",
@@ -1791,7 +1792,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev,
Error **errp)
                              memory_region_size(&proxy->modern_bar));

     address_space_init(&proxy->modern_as, &proxy->modern_cfg,
"virtio-pci-cfg-as");
-
+#endif
     if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) {
         proxy->disable_legacy =3D pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AU=
TO_OFF;
     }
@@ -1860,10 +1861,10 @@ static void virtio_pci_realize(PCIDevice *pci_dev=
,
Error **errp)

 static void virtio_pci_exit(PCIDevice *pci_dev)
 {
-    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
+    //VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);

     msix_uninit_exclusive_bar(pci_dev);
-    address_space_destroy(&proxy->modern_as);
+    //address_space_destroy(&proxy->modern_as);
 }

 static void virtio_pci_reset(DeviceState *qdev)





> Likely, it is NOT -rc4
> material, and thus can wait for 2.11; but it should be fine for -stable=

> as part of 2.10.1 down the road.
>=20
>> +++ b/block/qcow2-cluster.c
>> @@ -1516,6 +1516,23 @@ int qcow2_decompress_cluster(BlockDriverState *=
bs, uint64_t cluster_offset)
>>          nb_csectors =3D ((cluster_offset >> s->csize_shift) & s->csiz=
e_mask) + 1;
>>          sector_offset =3D coffset & 511;
>>          csize =3D nb_csectors * 512 - sector_offset;
>> +
>> +        /* Allocate buffers on first decompress operation, most image=
s are
>> +         * uncompressed and the memory overhead can be avoided.  The =
buffers
>> +         * are freed in .bdrv_close().
>> +         */
>> +        if (!s->cluster_data) {
>> +            /* one more sector for decompressed data alignment */
>> +            s->cluster_data =3D qemu_try_blockalign(bs->file->bs,
>> +                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);=

>> +            if (!s->cluster_data) {
>> +                return -EIO;
>=20
> Is -ENOMEM any better than -EIO here?
>=20


--=20
Alexey


--Gbml65kfcSbPiWVJB2HnkVEun9MFnV53L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZl6Z0DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5rhsP/0gn
JxZ2wOBqao1kdWta5yNt+5ldHFuCcyV8nZtyPUNnhV0uQRnpiJ0HIqnq1dt2o0Hm
+GkKoXfEoNrbAlBDfVDSAFEv6u2uBqulu0LiHu9qt6FVCBGo8C8xvXsxYyXyIJQx
tHBbr84h6zQIhUvwl/YMcFt6fR1UrcCBNdkj50lJBbwRN7G8JVVQ5y9HLsXLXtUy
oA+919tbpBf7ArtvDwodvh1n4Qt37n9c1JJ5gmE07WGdvKC5g6wZOrUP4E8JPcUQ
MqOFuQ2OaMJVNV8SDnV452OcaUpWnXthXYf9XTJ26BgIMeTXx4etXtmCg3ryfdUc
Ss3OFWg+xq6tee1V6JrEvEAZ2UbrIwVX8WLgVtWAfkx5qjD8FiuxH4mfYC2uGMMO
F0REymKx/qSjDArkvw823A131uu8wVHUxC8b21tpasg6nMBc/F5zSDnS3S2irxo5
z2qXMGrffbUgqLLpiMlm6W+w8mp7zSmF3NXdCIMhJcFirKznjwYET3S0SjyyM/+g
NbHVee8wc8OTqGSEsNpGs/R3Bkqsm2oopyA9riiiF6vJ1drWfRKbpu5ic3GQnmA9
wsdz9rNCmGN8NoZ4WZ+nZ5TTLLCo2/52Ex/NEOjfDTRO6uuScO9PFTQs9CUhWO+w
eoO+ZrIy8J0ssrJ/oJNgOr+XRcZAv/UjHSYJ36hN
=d19x
-----END PGP SIGNATURE-----

--Gbml65kfcSbPiWVJB2HnkVEun9MFnV53L--
