Received: from eggs.gnu.org ([2001:4830:134:3::10]:60582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eErfl-0006E8-5k
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 01:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eErfh-0005Xs-Tc
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 01:59:45 -0500
References: <1510658424-16527-1-git-send-email-thuth@redhat.com>
	<20171115103345.7582aa37@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8360a4ac-421d-1150-5e4c-cac5e2f7bdb3@redhat.com>
Date: Wed, 15 Nov 2017 07:59:31 +0100
MIME-Version: 1.0
In-Reply-To: <20171115103345.7582aa37@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Nmb1sAUJBtp9NMLdEvBIf88ck1en5DNTh"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] hw/net/vmxnet3: Fix code to
 work on big endian hosts, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <dgibson@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nmb1sAUJBtp9NMLdEvBIf88ck1en5DNTh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.11.2017 00:33, David Gibson wrote:
> On Tue, 14 Nov 2017 12:20:24 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> Since commit ab06ec43577177a442e8 we test the vmxnet3 device in the
>> pxe-tester, too (when running "make check SPEED=3Dslow"). This now
>> revealed that the code is not working there if the host is a big
>> endian machine (for example ppc64 or s390x) - "make check SPEED=3Dslow=
"
>> is now failing on such hosts.
>>
>> The vmxnet3 code lacks endianess conversions in a couple of places.
>> Interestingly, the bitfields in the structs in vmxnet3.h already tried=
 to
>> take care of the *bit* endianess of the C compilers - but the code mis=
sed
>> to change the *byte* endianess when reading or writing the correspondi=
ng
>> structs. So the bitfields are now wrapped into unions which allow to c=
hange
>> the byte endianess during runtime with the non-bitfield member of the =
union.
>> With these changes, "make check SPEED=3Dslow" now properly works on bi=
g endian
>> hosts, too.
>>
>> Reported-by: David Gibson <dgibson@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2:
>>  - Introduced vmxnet3_ring_read_curr_txdesc() & vmxnet3_pci_dma_write_=
rxcd()
>>    helper functions to wrap the byte-swapping code that is required in=

>>    multiple places (as suggested by Philippe)
[...]
>> +static inline void
>> +vmxnet3_ring_read_curr_txdesc(PCIDevice *pcidev, Vmxnet3Ring *ring,
>> +                              struct Vmxnet3_TxDesc *txd)
>> +{
>> +    vmxnet3_ring_read_curr_cell(pcidev, ring, txd);
>> +    txd->addr =3D le64_to_cpu(txd->addr);
>> +    txd->val1 =3D le32_to_cpu(txd->val1);
>> +    txd->val2 =3D le32_to_cpu(txd->val2);
>=20
> Urgh.. and I dislike swabbing struct fields in place even more :(.
> Having to know the endianness of a structure field is bad enough,
> having to know what endianness it's in *right now* is much worse.
>=20
> But possibly you're stuck with it, given the existing code?
>=20
> Looks like this is a structure determined by the hardware, in which
> case I think it should be left in hardware endian, and only swabbed
> when you go to actually look at the fields within.
[...]
>> diff --git a/hw/net/vmxnet3.h b/hw/net/vmxnet3.h
>> index f9352c4..5b3b76b 100644
>> --- a/hw/net/vmxnet3.h
>> +++ b/hw/net/vmxnet3.h
>> @@ -226,39 +226,49 @@ enum {
>>  struct Vmxnet3_TxDesc {
>>      __le64 addr;
>> =20
>> +    union {
>> +        struct {
>>  #ifdef __BIG_ENDIAN_BITFIELD
>> -    u32 msscof:14;  /* MSS, checksum offset, flags */
>> -    u32 ext1:1;
>> -    u32 dtype:1;    /* descriptor type */
>> -    u32 rsvd:1;
>> -    u32 gen:1;      /* generation bit */
>> -    u32 len:14;
>> +            u32 msscof:14;  /* MSS, checksum offset, flags */
>> +            u32 ext1:1;
>> +            u32 dtype:1;    /* descriptor type */
>> +            u32 rsvd:1;
>> +            u32 gen:1;      /* generation bit */
>> +            u32 len:14;
>=20
> Blech.  This is one reason I think bitfields are a terrible idea for
> mirroring hardware (or on disk) data.  Still, I guess changing that's
> kind of out of scope for a quick fix.

David, I agree with all of your comments - I had similar thoughts when I
was working with the code. However, as you already indicated, to address
all of this, we would need to rewrite most parts of this device. That's
out of my scope here - I wanted to keep the changes as minimal as
possible, so that there is a chance that we can get the endianness
problem still fixed for 2.11. So do you think that the patch is OK for
this? ... otherwise, I think I'll rather send a patch that removes the
vmxnet3 from the pxe-tester again - then it won't be tested anymore and
we won't get anymore endianness test failures.

 Thomas


--Nmb1sAUJBtp9NMLdEvBIf88ck1en5DNTh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJaC+XYAAoJEC7Z13T+cC21X6YP/R1x/+H5mPipeEL4VCD9c4uf
kEByrCn6mrLVr6WDMNYQHp3yR7Z7lLwPiJyCQSxFllqSNCJmAFfnm/yNGM+OtrrM
4tsj8b1nxFgbSjl4LGhH8WExr0mgagdLPM0gRIFFEvb/sTHlXD0JO+eaFigE9TsA
COUNjlZ7c2TMwVY6ZWEJpMrPjId7oKOsjvdQD+gRVVdN5rAuflKtCaKLx5YlgKGB
86+d1ImwQkY2KnC4rpN1OjAvCDeMn+HG8K+xHNypOdJFg9Sl8ZI7R9TsuHZ9g2Mp
wIPB/8Kmizt4IOjeSrt8c16BTM/H3E5i8X4Cx9GOEAqlc7Ah91l0cl3eBeuddmE9
0YROhQo+0XFSGm3Y4TX6Gu10yokRvNWTFJk35MWVCGqZoWLt9Fdh4gdSwlpJleHG
qI72u4vh3TwePEyB2RUB2wmiB+sTM+wJ/z38Km2uu5Q1QqM+4SsrICWlHoF39Lv2
Eyfe3VcrXZI1dCUr2DBGHUKxPXMHmE2e8Qm9tUf6D0pKlTY4/wE4OG9hr913kq1e
tQibv9JEQGN9HWfOkhZZ8SmQ/xQjcoaxLsnKRjfRAQevRr1rWJ30jY7JFJ8neTXf
4fA4vMkxHYb7X2z7FIRmqdlkWgRBOPwB/zrXZgkWogZFAzKjMTBu8UkZvX6eN+DV
EicD1ScORC+mQtYUL1df
=p1SV
-----END PGP SIGNATURE-----

--Nmb1sAUJBtp9NMLdEvBIf88ck1en5DNTh--
