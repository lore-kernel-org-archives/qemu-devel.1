Received: from eggs.gnu.org ([2001:4830:134:3::10]:33081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dk1Ea-00075l-L3
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dk1EW-0008Dm-Gu
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:56:12 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dk1EW-0008Bm-71
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:56:08 -0400
Received: by mail-pf0-x241.google.com with SMTP id w127so1065097pfd.1
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 21:56:08 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20170818133118.8650-1-stefanha@redhat.com>
	<72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
	<37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
Message-ID: <a3fb2086-5c6c-4b0a-cb05-2061fbfea1e6@ozlabs.ru>
Date: Tue, 22 Aug 2017 14:56:00 +1000
MIME-Version: 1.0
In-Reply-To: <37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pAVgF4UgjpMuVM425a2lKOeGtclsQ9p4K"
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
--pAVgF4UgjpMuVM425a2lKOeGtclsQ9p4K
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <a3fb2086-5c6c-4b0a-cb05-2061fbfea1e6@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
References: <20170818133118.8650-1-stefanha@redhat.com>
 <72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
 <37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
In-Reply-To: <37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/08/17 12:46, Alexey Kardashevskiy wrote:
> On 19/08/17 01:18, Eric Blake wrote:
>> On 08/18/2017 08:31 AM, Stefan Hajnoczi wrote:
>>> Most qcow2 files are uncompressed so it is wasteful to allocate (32 +=
 1)
>>> * cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
>>> s->cluster_data when the first read operation is performance on a
>>> compressed cluster.
>>>
>>> The buffers are freed in .bdrv_close().  .bdrv_open() no longer has a=
ny
>>> code paths that can allocate these buffers, so remove the free functi=
ons
>>> in the error code path.
>>>
>>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>> Alexey: Does this improve your memory profiling results?
>>
>> Is this a regression from earlier versions?=20
>=20
> Hm, I have not thought about this.
>=20
> So. I did bisect and this started happening from
> 9a4c0e220d8a4f82b5665d0ee95ef94d8e1509d5
> "hw/virtio-pci: fix virtio behaviour"
>=20
> Before that, the very same command line would take less than 1GB of
> resident memory. That thing basically enforces virtio-1.0 for QEMU <=3D=
2.6
> which means that upstream with "-machine pseries-2.6" works fine (less =
than
> 1GB), "-machine pseries-2.7" does not (close to 7GB, sometime even 9GB)=
=2E
>=20
> Then I tried bisecting again, with
> "scsi=3Doff,disable-modern=3Doff,disable-legacy=3Don" on my 150 virtio-=
block
> devices, started from
> e266d421490e0 "virtio-pci: add flags to enable/disable legacy/modern" (=
it
> added the disable-modern switch) which uses 2GB of memory.
>=20
> I ended up with ada434cd0b44 "virtio-pci: implement cfg capability".
>=20
> Then I removed proxy->modern_as on v2.10.0-rc3 (see below) and got 1.5G=
B of
> used memory (yay!)
>=20
> I do not really know how to reinterpret all of this, do you?


Anyone, ping? Should I move the conversation to the original thread? Any
hacks to try with libc?



>=20
>=20
> Note: 1GB..9GB numbers from below are the peak values from valgrind's
> massif. This is pretty much resident memory used by QEMU process. In my=

> testing I did not enable KVM and I did not start the guest (i.e. used -=
S).
> 150 virtio-block devices, 2GB RAM for the guest.
>=20
> Also, while bisecting, I only paid attention if it is 1..2GB or 6..9GB =
-
> all tests did fit these 2 ranges, for any given sha1 the amount of memo=
ry
> would be stable but among "good" commits it could change between 1GB an=
d 2GB.
>=20
>=20
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 5d14bd6..7ad447a 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1783,6 +1783,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev=
,
> Error **errp)
>                         /* PCI BAR regions must be powers of 2 */
>                         pow2ceil(proxy->notify.offset + proxy->notify.s=
ize));
>=20
> +#if 0
>      memory_region_init_alias(&proxy->modern_cfg,
>                               OBJECT(proxy),
>                               "virtio-pci-cfg",
> @@ -1791,7 +1792,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev=
,
> Error **errp)
>                               memory_region_size(&proxy->modern_bar));
>=20
>      address_space_init(&proxy->modern_as, &proxy->modern_cfg,
> "virtio-pci-cfg-as");
> -
> +#endif
>      if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) {
>          proxy->disable_legacy =3D pcie_port ? ON_OFF_AUTO_ON : ON_OFF_=
AUTO_OFF;
>      }
> @@ -1860,10 +1861,10 @@ static void virtio_pci_realize(PCIDevice *pci_d=
ev,
> Error **errp)
>=20
>  static void virtio_pci_exit(PCIDevice *pci_dev)
>  {
> -    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
> +    //VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
>=20
>      msix_uninit_exclusive_bar(pci_dev);
> -    address_space_destroy(&proxy->modern_as);
> +    //address_space_destroy(&proxy->modern_as);
>  }
>=20
>  static void virtio_pci_reset(DeviceState *qdev)
>=20
>=20
>=20
>=20
>=20
>> Likely, it is NOT -rc4
>> material, and thus can wait for 2.11; but it should be fine for -stabl=
e
>> as part of 2.10.1 down the road.
>>
>>> +++ b/block/qcow2-cluster.c
>>> @@ -1516,6 +1516,23 @@ int qcow2_decompress_cluster(BlockDriverState =
*bs, uint64_t cluster_offset)
>>>          nb_csectors =3D ((cluster_offset >> s->csize_shift) & s->csi=
ze_mask) + 1;
>>>          sector_offset =3D coffset & 511;
>>>          csize =3D nb_csectors * 512 - sector_offset;
>>> +
>>> +        /* Allocate buffers on first decompress operation, most imag=
es are
>>> +         * uncompressed and the memory overhead can be avoided.  The=
 buffers
>>> +         * are freed in .bdrv_close().
>>> +         */
>>> +        if (!s->cluster_data) {
>>> +            /* one more sector for decompressed data alignment */
>>> +            s->cluster_data =3D qemu_try_blockalign(bs->file->bs,
>>> +                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512)=
;
>>> +            if (!s->cluster_data) {
>>> +                return -EIO;
>>
>> Is -ENOMEM any better than -EIO here?
>>
>=20
>=20


--=20
Alexey


--pAVgF4UgjpMuVM425a2lKOeGtclsQ9p4K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZm7lgDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5i/UQALJT
OD2yqDPyj7LFE3Lm+97V99Mwwhz93nmLmVOoZxiKVRq6agGkJW6XjlJ22RbLzJr5
ju1UzraKEwCegWLCAq6M2dr6s215sJPEeqCeuAarskN+xQd4aMXZf/NCgwyvKD7V
icY/+1ky2sYd08KHMyBTMED2EHn0dDS004Xe5lBvhaTLP0NPZwaqeZrvC4SpXcjB
2OKYZSjWntlqHnGQMlExlJJTRgRM+3ciOnsiu3AoNBVwplvfdujNHW/irdLc5r7d
5/TQ6N8CbkKnLl3PR0RENPf9XrJiwJssZ0tT/Oeh654XGX8M/fFYZ+b2X1pnwKQW
vyyQEaEhDIDymGOUuT6lwvLCux9w0xcUL8JQfONd8AkX4nheLEyrx3yE5geaOyq/
v+WMRQB4cTy/wbZGGXSaFrvSAYUzw+xFo6BcvRQ4MZlGTgY8m308w+3AkPRTQlYq
7U70ehyGwkv7p/vGug8jx2a2xlefqpDvkGUrIws1jtBXNMVVtgO6T1Zy8IYspVRX
V3gz/VWC/WhPosDOX7yogrrgvAWPP01PbaCJyQvMSKQzOmmUXbBvRM12tENRWFpm
Gln6ZcKPkswt3b20QuM66l2Q6E1FUPQzkYel3NwA6carsEbokrldG8DPCxDedUIl
0rTbMRHLA9v4/t3/+p/ICqEvLmtJX0JOnTTV8A+0
=7SUt
-----END PGP SIGNATURE-----

--pAVgF4UgjpMuVM425a2lKOeGtclsQ9p4K--
