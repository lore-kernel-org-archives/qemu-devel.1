Received: from eggs.gnu.org ([2001:4830:134:3::10]:42331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1eZxZf-0008HU-Dq
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1eZxZa-0006LM-Nh
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:39 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:38566 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1eZxZa-0006H9-EB
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:34 -0500
From: Antonios Motakis <antonios.motakis@huawei.com>
Message-ID: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
Date: Fri, 12 Jan 2018 19:32:10 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------303602ACDA40D510D798D283"
Subject: [Qemu-devel] [RFC] qid path collision issues in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Cc: Veaceslav Falico <veaceslav.falico@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, Eduard Shishkin <Eduard.Shishkin@huawei.com>, "vfalico@gmail.com" <vfalico@gmail.com>, "Wangguoli (Andy)" <andy.wangguoli@huawei.com>, Jiangyiwen <jiangyiwen@huawei.com>, "zhangwei
	(CR)" <zhangwei555@huawei.com>

--------------303602ACDA40D510D798D283
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

We have found an issue in the 9p implementation of QEMU, with how qid pat=
hs are generated, which can cause qid path collisions and several issues =
caused by them. In our use case (running containers under VMs) these have=
 proven to be critical.

In particular, stat_to_qid in hw/9pfs/9p.c generates a qid path using the=
 inode number of the file as input. According to the 9p spec the path sho=
uld be able to uniquely identify a file, distinct files should not share =
a path value.

The current implementation that defines qid.path =3D inode nr works fine =
as long as there are not files from multiple partitions visible under the=
 9p share. In that case, distinct files from different devices are allowe=
d to have the same inode number. So with multiple partitions, we have a v=
ery high probability of qid path collisions.

How to demonstrate the issue:
1) Prepare a problematic share:
 - mount one partition under share/p1/ with some files inside
 - mount another one *with identical contents* under share/p2/
 - confirm that both partitions have files with same inode nr, size, etc
2) Demonstrate breakage:
 - start a VM with a virtio-9p pointing to the share
 - mount 9p share with FSCACHE on
 - keep open share/p1/file
 - open and write to share/p2/file

What should happen is, the guest will consider share/p1/file and share/p2=
/file to be the same file, and since we are using the cache it will not r=
eopen it. We intended to write to partition 2, but we just wrote to parti=
tion 1. This is just one example on how the guest may rely on qid paths b=
eing unique.

In the use case of containers where we commonly have a few containers per=
 VM, all based on similar images, these kind of qid path collisions are v=
ery common and they seem to cause all kinds of funny behavior (sometimes =
very subtle).

To avoid this situation, the device id of a file needs to be also taken a=
s input for generating a qid path. Unfortunately, the size of both inode =
nr + device id together would be 96 bits, while we have only 64 bits for =
the qid path, so we can't just append them and call it a day :(

We have thought of a few approaches, but we would definitely like to hear=
 what the upstream maintainers and community think:

* Full fix: Change the 9p protocol

We would need to support a longer qid path, based on a virtio feature fla=
g. This would take reworking of host and guest parts of virtio-9p, so bot=
h QEMU and Linux for most users.

* Fallback and/or interim solutions

A virtio feature flag may be refused by the guest, so we think we still n=
eed to make collisions less likely even with 64 bit paths. E.g.
1. XOR the device id with inode nr to produce the qid path (we attach a p=
roof of concept patch)
2. 64 bit hash of device id and inode nr
3. other ideas, such as allocating new qid paths and keep a look up table=
 of some sorts (possibly too expensive)

With our proof of concept patch, the issues caused by qid path collisions=
 go away, so it can be seen as an interim solution of sorts. However, the=
 chance of collisions is not eliminated, we are just replacing the curren=
t strategy, which is almost guaranteed to cause collisions in certain use=
 cases, with one that makes them more rare. We think that a virtio featur=
e flag for longer qid paths is the only way to eliminate these issues com=
pletely.

This is the extent that we were able to analyze the issue from our side, =
we would like to hear if there are some better ideas, or which approach w=
ould be more appropriate for upstream.

Best regards,

--=20
Antonios Motakis
Virtualization Engineer
Huawei Technologies Duesseldorf GmbH
European Research Center
Riesstrasse 25, 80992 M=C3=BCnchen

--------------303602ACDA40D510D798D283
Content-Type: text/plain; charset="UTF-8";
	name="0001-9pfs-stat_to_qid-use-device-id-as-input-to-qid.path.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="0001-9pfs-stat_to_qid-use-device-id-as-input-to-qid.path.pat";
	filename*1="ch"

RnJvbSBiZDU5ZjUwNGU2ODA2ZGFjNWIzYzFiZDljNjI2ZGUwODU5ODdmMWUwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBWZWFjZXNsYXYgRmFsaWNvIDx2ZWFjZXNsYXYuZmFs
aWNvQGh1YXdlaS5jb20+CkRhdGU6IEZyaSwgMTIgSmFuIDIwMTggMTk6MjY6MTggKzA4MDAK
U3ViamVjdDogW1BBVENIXSA5cGZzOiBzdGF0X3RvX3FpZDogdXNlIGRldmljZSBpZCBhcyBp
bnB1dCB0byBxaWQucGF0aAoKQ3VycmVudGx5LCBvbmx5IHRoZSBpbm9kZSBudW1iZXIgb2Yg
YSBmaWxlIGlzIGJlaW5nCnVzZWQgYXMgaW5wdXQgdG8gdGhlIHFpZC5wYXRoIGZpZWxkLiBU
aGUgOXAgUkZDCnNwZWNpZmllcyB0aGF0IHRoZSBwYXRoIG5lZWRzIHRvIGJlIHVuaXF1ZSBw
ZXIgZmlsZQppbiB0aGUgZGlyZWN0b3J5IGhpZXJhcmNoeSwgaG93ZXZlciBvbiB0aGUgaG9z
dApzaWRlIHRoZSBpbm9kZSBhbG9uZSBkb2VzIG5vdCBzdWZmaWNlIHRvIHVuaXF1ZWx5Cmlk
ZW50aWZ5IGEgZmlsZSwgYXMgYW5vdGhlciBmaWxlIG9uIGEgZGlmZmVyZW50CmRldmljZSBt
YXkgaGF2ZSB0aGUgc2FtZSBpbm9kZSBudW1iZXIuCgpUbyBhdm9pZCBxaWQgcGF0aCBjb2xs
aXNpb25zLCB3ZSB0YWtlIHRoZSBkZXZpY2UgaWQKYXMgaW5wdXQgYXMgd2VsbC4KClNpZ25l
ZC1vZmYtYnk6IFZlYWNlc2xhdiBGYWxpY28gPHZlYWNlc2xhdi5mYWxpY29AaHVhd2VpLmNv
bT4KU2lnbmVkLW9mZi1ieTogQW50b25pb3MgTW90YWtpcyA8YW50b25pb3MubW90YWtpc0Bo
dWF3ZWkuY29tPgotLS0KIGh3LzlwZnMvOXAuYyB8IDYgKy0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaHcvOXBm
cy85cC5jIGIvaHcvOXBmcy85cC5jCmluZGV4IDM5M2EyYjIuLmE4MTBkMTMgMTAwNjQ0Ci0t
LSBhL2h3LzlwZnMvOXAuYworKysgYi9ody85cGZzLzlwLmMKQEAgLTU4MywxMSArNTgzLDcg
QEAgc3RhdGljIHZvaWQgdmlydGZzX3Jlc2V0KFY5ZnNQRFUgKnBkdSkKIC8qIFRoaXMgaXMg
dGhlIGFsZ29yaXRobSBmcm9tIHVmcyBpbiBzcGZzICovCiBzdGF0aWMgdm9pZCBzdGF0X3Rv
X3FpZChjb25zdCBzdHJ1Y3Qgc3RhdCAqc3RidWYsIFY5ZnNRSUQgKnFpZHApCiB7Ci0gICAg
c2l6ZV90IHNpemU7Ci0KLSAgICBtZW1zZXQoJnFpZHAtPnBhdGgsIDAsIHNpemVvZihxaWRw
LT5wYXRoKSk7Ci0gICAgc2l6ZSA9IE1JTihzaXplb2Yoc3RidWYtPnN0X2lubyksIHNpemVv
ZihxaWRwLT5wYXRoKSk7Ci0gICAgbWVtY3B5KCZxaWRwLT5wYXRoLCAmc3RidWYtPnN0X2lu
bywgc2l6ZSk7CisgICAgcWlkcC0+cGF0aCA9IHN0YnVmLT5zdF9pbm8gXiAoKGludDY0X3Qp
c3RidWYtPnN0X2RldiA8PCAxNik7CiAgICAgcWlkcC0+dmVyc2lvbiA9IHN0YnVmLT5zdF9t
dGltZSBeIChzdGJ1Zi0+c3Rfc2l6ZSA8PCA4KTsKICAgICBxaWRwLT50eXBlID0gMDsKICAg
ICBpZiAoU19JU0RJUihzdGJ1Zi0+c3RfbW9kZSkpIHsKLS0gCjEuOC4zLjEKCg==
--------------303602ACDA40D510D798D283--
