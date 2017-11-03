Received: from eggs.gnu.org ([2001:4830:134:3::10]:46070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1eAg9O-0006Sw-C4
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1eAg9J-0002Px-H3
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:53:02 -0400
Received: from mail.univention.de ([82.198.197.8]:22676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hahn@univention.de>) id 1eAg9J-0002Ou-5z
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:52:57 -0400
References: <CAATJJ0KveNV1tHT-w5TCL9_TrCdMzp34=fGfhMm7NzZux=7K+Q@mail.gmail.com>
	<CAATJJ0L6Xs6vbauBeznVuf+e_GjRLbU2Kz8MWSrBHzD_+wLhhQ@mail.gmail.com>
	<20171102153424.GP32533@redhat.com>
	<CAATJJ0KSKFKDz7sW4qtRDCJpRv3fin+RxCL6U-TKeQPgZUK5BA@mail.gmail.com>
From: Philipp Hahn <hahn@univention.de>
Message-ID: <82fc2736-0151-1728-fb6e-ded5a9d2b83b@univention.de>
Date: Fri, 3 Nov 2017 18:16:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAATJJ0KSKFKDz7sW4qtRDCJpRv3fin+RxCL6U-TKeQPgZUK5BA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------A6A48B9A711B1B93FE187B66"
Content-Language: en-GB
Subject: Re: [Qemu-devel] [libvirt] How to best handle the reoccurring of
 rom changes breaking cross version migrations?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Libvirt Devel <libvir-list@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

This is a multi-part message in MIME format.
--------------A6A48B9A711B1B93FE187B66
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello

Am 03.11.2017 um 08:30 schrieb Christian Ehrhardt:
> On Thu, Nov 2, 2017 at 4:34 PM, Daniel P. Berrange <berrange@redhat.com=
> wrote:
>>
>> On Thu, Nov 02, 2017 at 04:14:06PM +0100, Christian Ehrhardt wrote:
>>> Ping - since there wasn't any reply so far - any best practices one c=
ould
>>> share?
>>>
>>> Let me add a TL;DR:
>>> - bump of ipxe rom versions change the size of virtio-net-pci.rom
>>> - that breaks on migration "Length mismatch"
>>>
>>> I'd guess the size of that rom has to be fixed up on the fly, but if =
that
>>> is really ok and how/where is the question.
>>
>> The actual ROM contents will be transferred in the migration stream, s=
o
>> the fact that the target host has ROMs with different content is not
>> important. The key thing that matters is that QEMU the target host loa=
ds
>> the ROMs at the same location, so that when the ROM contents is overwr=
itten
>> with data from the incoming migration scheme, it all ends up at the sa=
me
>> place as it was on the source.
>=20
>=20
> Thanks Daniel for your answer, although you try to kill my remaining
> hopes of a better solution :-)
> But if the actual ROM content is migrated over anyway "all I'd have to
> do" is to make clear that the newer system (qemu) knows that the
> incoming rom has a different size than it thinks.
> I thought that was what the machine types and their mechanisms were
> for, but so far I only scratched like 10% of those - maybe they don't
> cover these rom sizes?

The problem is that libvirt launches a qemu process without knowing
those details.
Later when you try to restore an old snapshot or try to do a live
migration, the newly spawned qemu process must have the same layout to
be able to load the old VMState.

Qemu has gone through several such changes and is worsened by the fact,
that distributions like Debian use their own ROM files, which might be
different from the sizes shipped with Qemu.
For that reason we (Univention) still ship the old ROM images next to
the new ones and carry the attached patch to switch between them based
on the model. Maybe that works for you, too.

One more warning (we experiences): Even if the sizes are the same, live
migration can still fail afterwards: We have observed several cases,
where a migrated VM carried an old version of SeaBIOS, which fails when
you reboot the VM. We traced that down to Qemu implementing a new
feature (SMM), which was not supported by the old SeaBIOS and then got
it wrong after reboot only.

Hope that helps.

Philipp

--------------A6A48B9A711B1B93FE187B66
Content-Type: text/plain; charset=UTF-8;
 name="0002-Bug-24702-Rom-file-compatibility.quilt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-Bug-24702-Rom-file-compatibility.quilt"

QnVnICMyNDcwMjogRml4IFBYRSBST00gc2l6ZSBtaXNtYXRjaAoKRm9yIHBjLTAuMTQgYW5k
IG9sZGVyIHVzZSB0aGUgUFhFIFJPTXMgZnJvbSB0aGUgZGVwcmVjYXRlZCBldGhlcmJvb3Qt
cWVtdQpwYWNrYWdlLCB3aGljaCBoYXZlIGRpZmZlcmVudCBzaXplcy4gV2l0aG91dCB0aGUg
cGF0Y2ggdGhlIHZpcnR1YWwgUEMgZ2V0cwpidWlsZCB3aXRoIHRoZSBjdXJyZW50IFJPTSBz
aXplcy4gTG9hZGluZyB0aGVuIGZhaWxzIGJlY2F1c2UgdGhlIHN0b3JlZCBQQ0kgUk9NCkJB
UiBzaXplIG1pc21hdGNoZXMgdGhlIGNvbmZpZ3VyZWQgc2l6ZS4KLS0tIGEvaHcvcGNfcGlp
eC5jCisrKyBiL2h3L3BjX3BpaXguYwpAQCAtNDMzLDYgKzQzMywzMCBAQCBzdGF0aWMgUUVN
VU1hY2hpbmUgcGNfbWFjaGluZV92MF8xNSA9IHsKICAgICAgICAgICAgIC5kcml2ZXIgICA9
ICJ2aXJ0aW8tYmFsbG9vbi1wY2kiLFwKICAgICAgICAgICAgIC5wcm9wZXJ0eSA9ICJldmVu
dF9pZHgiLFwKICAgICAgICAgICAgIC52YWx1ZSAgICA9ICJvZmYiLFwKKyAgICAgICAgfSx7
XAorICAgICAgICAgICAgLmRyaXZlciAgID0gIm5lMjAwMCIsXAorICAgICAgICAgICAgLnBy
b3BlcnR5ID0gInJvbWZpbGUiLFwKKyAgICAgICAgICAgIC52YWx1ZSAgID0gIi91c3IvbGli
L2V0aGVyYm9vdC9ydGw4MDI5LnJvbSIsXAorICAgICAgICB9LHtcCisgICAgICAgICAgICAu
ZHJpdmVyICAgPSAicnRsODEzOSIsXAorICAgICAgICAgICAgLnByb3BlcnR5ID0gInJvbWZp
bGUiLFwKKyAgICAgICAgICAgIC52YWx1ZSAgID0gIi91c3IvbGliL2V0aGVyYm9vdC9ydGw4
MTM5LnJvbSIsXAorICAgICAgICB9LHtcCisgICAgICAgICAgICAuZHJpdmVyICAgPSAiZTEw
MDAiLFwKKyAgICAgICAgICAgIC5wcm9wZXJ0eSA9ICJyb21maWxlIixcCisgICAgICAgICAg
ICAudmFsdWUgICA9ICIvdXNyL2xpYi9ldGhlcmJvb3QvZTEwMDAtODI1NDBlbS5yb20iLFwK
KyAgICAgICAgfSx7XAorICAgICAgICAgICAgLmRyaXZlciAgID0gInBjbmV0IixcCisgICAg
ICAgICAgICAucHJvcGVydHkgPSAicm9tZmlsZSIsXAorICAgICAgICAgICAgLnZhbHVlICAg
PSAiL3Vzci9saWIvZXRoZXJib290L3BjbmV0MzIucm9tIixcCisgICAgICAgIH0se1wKKyAg
ICAgICAgICAgIC5kcml2ZXIgICA9ICJuZTJrLWlzYSIsXAorICAgICAgICAgICAgLnByb3Bl
cnR5ID0gInJvbWZpbGUiLFwKKyAgICAgICAgICAgIC52YWx1ZSAgID0gIi91c3IvbGliL2V0
aGVyYm9vdC9uZS5yb20iLFwKKyAgICAgICAgfSx7XAorICAgICAgICAgICAgLmRyaXZlciAg
ID0gInZpcnRpby1uZXQtcGNpIixcCisgICAgICAgICAgICAucHJvcGVydHkgPSAicm9tZmls
ZSIsXAorICAgICAgICAgICAgLnZhbHVlICAgPSAiL3Vzci9saWIvZXRoZXJib290L3ZpcnRp
by1uZXQucm9tIixcCiAgICAgICAgIH0KIAogc3RhdGljIFFFTVVNYWNoaW5lIHBjX21hY2hp
bmVfdjBfMTQgPSB7Cg==
--------------A6A48B9A711B1B93FE187B66--
