Received: from eggs.gnu.org ([2001:4830:134:3::10]:46567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfJIp-0006FP-K2
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfJIk-0003sc-Kh
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dfJIk-0003sJ-Ah
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:13:02 -0400
References: <20170808153827.427-1-cohuck@redhat.com>
	<20170808182623.45e88fd6@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3988876c-6699-3da9-cdd4-bd3729a693ff@redhat.com>
Date: Wed, 9 Aug 2017 07:12:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170808182623.45e88fd6@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hrqLBXBR36sn9PNOOKKfqqIPt5T4dfcvJ"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Cornelia Huck <cohuck@redhat.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hrqLBXBR36sn9PNOOKKfqqIPt5T4dfcvJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.08.2017 18:26, Greg Kurz wrote:
> On Tue,  8 Aug 2017 17:38:27 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
>> Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
>> on CONFIG_VIRTFS and on the presence of an appropriate virtio transpor=
t
>> device.
>>
>> Let's introduce CONFIG_VIRTIO_CCW to cover s390x and check for
>> CONFIG_VIRTFS && (CONFIG_VIRTIO_PCI || CONFIG_VIRTIO_CCW).
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>
>> This is the alternative approach to "9pfs: fix and simplify dependenci=
es".
>> Uglier; but probably not broken...
>>
>=20
> Yikes. I don't know why yet but this doesn't work for PCI-less targets
> like cris-softmmu...
>=20
>   LINK    cris-softmmu/qemu-system-cris
> vl.o: In function `fsdev_init_func':
> vl.c:2360: undefined reference to `qemu_fsdev_add'
>=20
>> ---
>>  default-configs/s390x-softmmu.mak | 1 +
>>  fsdev/Makefile.objs               | 9 +++------
>>  hw/Makefile.objs                  | 2 +-
>>  3 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x=
-softmmu.mak
>> index 51191b77df..e4c5236ceb 100644
>> --- a/default-configs/s390x-softmmu.mak
>> +++ b/default-configs/s390x-softmmu.mak
>> @@ -8,3 +8,4 @@ CONFIG_S390_FLIC=3Dy
>>  CONFIG_S390_FLIC_KVM=3D$(CONFIG_KVM)
>>  CONFIG_VFIO_CCW=3D$(CONFIG_LINUX)
>>  CONFIG_WDT_DIAG288=3Dy
>> +CONFIG_VIRTIO_CCW=3Dy
>> diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
>> index 659df6e187..10d8caa291 100644
>> --- a/fsdev/Makefile.objs
>> +++ b/fsdev/Makefile.objs
>> @@ -1,10 +1,7 @@
>> -ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
>>  # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
>> -# only pull in the actual virtio-9p device if we also enabled virtio.=

>> -common-obj-y =3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
>> -else
>> -common-obj-y =3D qemu-fsdev-dummy.o
>> -endif
>> +# only pull in the actual virtio-9p device if we also enabled a virti=
o backend.
>> +common-obj-$(call land, $(CONFIG_VIRTFS),$(call lor, $(CONFIG_VIRTIO_=
PCI),$(CONFIG_VIRTIO_CCW)))=3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o=

>> +common-obj-$(call lnot, $(call land, $(CONFIG_VIRTFS),$(call lor, $(C=
ONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW)))) =3D qemu-fsdev-dummy.o
>>  common-obj-y +=3D qemu-fsdev-opts.o qemu-fsdev-throttle.o
>> =20
>>  # Toplevel always builds this; targets without virtio will put it in
>> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
>> index a2c61f6b09..10942fe0b4 100644
>> --- a/hw/Makefile.objs
>> +++ b/hw/Makefile.objs
>> @@ -1,4 +1,4 @@
>> -devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRTF=
S),$(CONFIG_PCI))) +=3D 9pfs/
>> +devices-dirs-$(call land, $(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO=
_PCI),$(CONFIG_VIRTIO_CCW))) +=3D 9pfs/
>>  devices-dirs-$(CONFIG_SOFTMMU) +=3D acpi/
>>  devices-dirs-$(CONFIG_SOFTMMU) +=3D adc/
>>  devices-dirs-$(CONFIG_SOFTMMU) +=3D audio/

I think the problem are the white spaces after a ",". For example for
the following test code in a makefile:

	@echo test1: $(call lnot, n)
	@echo test2: $(call lnot,n)

I get the following output:

 test1: n
 test2: y

Hope that helps,
 Thomas


--hrqLBXBR36sn9PNOOKKfqqIPt5T4dfcvJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZipnYAAoJEC7Z13T+cC21LAwP/1dbnttb10E4S1NE2xwMN4wn
htwvDAFPVmyMgAbGGqHGASyW3SHfMZs9MH+4YQdqK00aIVrEkYyb9jv2fPbYCueV
66uX4CsOPOGhrDtRWE5v05Fo1JCnYQwm7tQiR7tqDWNeEM+0THl/qkcOpr1GBKzC
bZpFq02KkCT2ge0725NPWFVXNwAhtH25y1cUSouc09SqTqk346RM1OSbr9WPumkK
M06KpLpd0aaHB6K8KLe/njPMjEKt4K214VtJ+OcWFPYe/0IzeM+3hgvHDEj8cL7M
8f9EhQG3LVWeL+aIdwAqonAcr7SrNsLkP6CQuALrefz3/2LUzW3kP6B7aCT5t6kf
6+jY10sHQuowCOE8U/zohyXjxm69+CRLGRz01VpAWhIlD6qlVtwew9AScs5lXRs6
+vo+2jCPIsf49O2eFpzz0DiKnnPi1r290cpK9Q0N+BiixwK1U6wMN6esJ/QJTYsB
eILrW8kttyN1TIAWUzGEqKtZpyEYSrZbWGXOPgpDgdRJ3v7zDO+fXT+BcZfViZSj
9KIsm2Zl/Vi3gSwyrxiTevGAtGkt0Oog6E5GZd08ToCNUFickj0oZVWDUiMnlyj9
rODPDKR+4SK2TJdjhfBf1jlpJWjG7JmHRxdKKcHNDkWpkJqzu4nDA903T4y0+mQe
+y3GOkEAGwlZwLQEy/sZ
=kO3j
-----END PGP SIGNATURE-----

--hrqLBXBR36sn9PNOOKKfqqIPt5T4dfcvJ--
