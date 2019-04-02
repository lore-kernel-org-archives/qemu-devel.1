Received: from eggs.gnu.org ([209.51.188.92]:59270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hBDtx-0004qn-Us
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hBDmH-0001Yr-70
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:24:15 -0400
Received: from mail-eopbgr760127.outbound.protection.outlook.com
	([40.107.76.127]:26229
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tjin@wavecomp.com>) id 1hBDmD-0001U1-Fn
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:24:11 -0400
From: Tommy Jin <tjin@wavecomp.com>
Date: Tue, 2 Apr 2019 07:24:04 +0000
Message-ID: <MWHPR2201MB11190F1FFDE9CD41E3674DDFB8560@MWHPR2201MB1119.namprd22.prod.outlook.com>
References: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
	<1554099897-28606-2-git-send-email-tjin@wavecomp.com>
	<CAFEAcA8eVfmLdPQs0YKsAUYP5LzsFrcF96xknjfKtzbzY97BNw@mail.gmail.com>
	<CAL1e-=jj4y=_ViZPepZ15VQnQQ++tbD2FYcmNST88O59GcjXfA@mail.gmail.com>
	<MWHPR2201MB11199232622EFEFBF361C3A9B8560@MWHPR2201MB1119.namprd22.prod.outlook.com>,
	<CAFEAcA9NDmKV0EdrEM6BGWqLwXpqbdBLXz-YHcWhxEgBSQttQw@mail.gmail.com>
In-Reply-To: <CAFEAcA9NDmKV0EdrEM6BGWqLwXpqbdBLXz-YHcWhxEgBSQttQw@mail.gmail.com>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_MWHPR2201MB11190F1FFDE9CD41E3674DDFB8560MWHPR2201MB1119_"
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard for
 mips boston board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pburton.wavecomp.com@gmail.com" <pburton.wavecomp.com@gmail.com>

--_004_MWHPR2201MB11190F1FFDE9CD41E3674DDFB8560MWHPR2201MB1119_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

I'm glad to hear these qemu general rules from you.
Here you raised two options:

  1.  Using a tool like libvirt to add a pluggable network card
  2.  Specify the network card on the command line

For the option2, I think specify the network model in command line is not e=
nough, per my understanding, we still need to create the device using API l=
ike pci_create && qdev_set_nic_properties && qdev_init_nofail, otherwise we=
'll get error prompts like "requested NIC (anonymous, model virtio) was not=
 created (not supported by this machine?)", currently I just add these piec=
es of code in /hw/mips/boston.c, Do you call these pieces of code board cod=
e and what's your suggestion?

You mentioned "optional pluggable cards should just be created without any =
board code required if the user specifies them on the command line."
I don't quite understand what you mean, if I don't want to use option1, how=
 to create pluggable cards without any board code?

Best regards,
Tommy
________________________________
From: Peter Maydell <peter.maydell@linaro.org>
Sent: Tuesday, April 2, 2019 10:37 AM
To: Tommy Jin
Cc: Aleksandar Markovic; qemu-devel@nongnu.org; pburton.wavecomp.com@gmail.=
com
Subject: Re: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard fo=
r mips boston board.

On Tue, 2 Apr 2019 at 09:29, Tommy Jin <tjin@wavecomp.com> wrote:
> If always creating virtio-net-pci device is not a good idea, is it
> feasible to make virtio-net-pci as an option for boston without
> using libvirt?

It's always an option, just specify it on the command line.

> Actually, Botson board can have an Intel GBE network card in it,
> compared to mips malta, it also has a pcnet network card created
> in its machine, is it acceptable to create a pch_gbe network card
> if the user specify like "model=3Dpch_gbe"?

Again, optional pluggable cards should just be created without
any board code required if the user specifies them on the command line.

In general, the QEMU command line does not aim for "short,
do what the user probably wants without them specifying
many options". It aims for "be flexible, allow the user
to configure what they want". The user-friendly interface
is supposed to be the next level up (libvirt, etc). This does
mean that command lines can get quite long in some cases. That's
unfortunate but I don't think we should be putting workarounds
for that in individual board models.

thanks
-- PMM

--_004_MWHPR2201MB11190F1FFDE9CD41E3674DDFB8560MWHPR2201MB1119_
Content-Type: text/x-patch;
	name="0001-adds-a-virtio_net-netcard-for-mips-boston-board.patch"
Content-Description: 0001-adds-a-virtio_net-netcard-for-mips-boston-board.patch
Content-Disposition: attachment;
	filename="0001-adds-a-virtio_net-netcard-for-mips-boston-board.patch";
	size=2129; creation-date="Tue, 02 Apr 2019 07:09:59 GMT";
	modification-date="Tue, 02 Apr 2019 07:09:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1ZWNiNzdlYzlmNmYxY2ZiMDJiMjNjZGI5YTFlYjJlY2E5MDViMTJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB0amluIDx0amluQHdhdmVjb21wLmNvbT4KRGF0ZTogVHVlLCAy
IEFwciAyMDE5IDE0OjQ4OjI1ICswODAwClN1YmplY3Q6IFtQQVRDSF0gYWRkcyBhIHZpcnRpb19u
ZXQgbmV0Y2FyZCBmb3IgbWlwcyBib3N0b24gYm9hcmQKCkFkZHMgYSBuZXR3b3JrIGNhcmQgZm9y
IGJvc3RvbiB0byBtYWtlIGl0IGNvbnZlbmllbnQgZm9yIHVzZXJzIHdobyBhcmUgdmVyaWZ5aW5n
IG5ldHdvcmsgcmVsYXRlZCBmdW5jdGlvbmFsaXRpZXMgb24gdGhpcyBib2FyZC4KQXMgdGhlIGxp
bnV4IGtlcm5lbCBoYXMgYWxyZWFkeSBzdXBwb3J0ZWQgdmlydGlvX25ldCwgbm93IGFkZCBhIHZp
cnRpbyBuZXRjYXJkIGZvciBib3N0b24sIHRvIG1ha2UgdmlydGlvIHdvcmsgcHJvcGVybHksIHBs
ZWFzZToKMS4gc2V0IHZpcnRpbyBuZXQgb3B0aW9ucyBpbiBsaW51eCBrZXJuZWwsIHNheWluZyBD
T05GSUdfVklSVElPICYmIENPTkZJR19WSVJUSU9fUENJICYmIENPTkZJR19WSVJUSU9fTkVUCjIu
IHNwZWNpZnkgbW9kZWw9dmlydGlvIHdoZW4geW91IHN0YXJ0IGJvc3RvbiBpbiBxZW11LgoKU2ln
bmVkLW9mZi1ieTogdGppbiA8dGppbkB3YXZlY29tcC5jb20+Ci0tLQogaHcvbWlwcy9ib3N0b24u
YyB8IDIxICsrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9ody9taXBzL2Jvc3Rvbi5jIGIvaHcvbWlwcy9ib3N0b24uYwpp
bmRleCBlNWJhYjNjLi45N2MxNzI4IDEwMDY0NAotLS0gYS9ody9taXBzL2Jvc3Rvbi5jCisrKyBi
L2h3L21pcHMvYm9zdG9uLmMKQEAgLTMyLDYgKzMyLDcgQEAKICNpbmNsdWRlICJody9taXBzL2Nw
cy5oIgogI2luY2x1ZGUgImh3L21pcHMvY3B1ZGV2cy5oIgogI2luY2x1ZGUgImh3L3BjaS1ob3N0
L3hpbGlueC1wY2llLmgiCisjaW5jbHVkZSAiaHcvdmlydGlvL3ZpcnRpby1wY2kuaCIKICNpbmNs
dWRlICJxYXBpL2Vycm9yLmgiCiAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCIKICNpbmNs
dWRlICJxZW11L2xvZy5oIgpAQCAtNDIyLDYgKzQyMywyMyBAQCB4aWxpbnhfcGNpZV9pbml0KE1l
bW9yeVJlZ2lvbiAqc3lzX21lbSwgdWludDMyX3QgYnVzX25yLAogICAgIHJldHVybiBYSUxJTlhf
UENJRV9IT1NUKGRldik7CiB9CiAKKy8qIFBsdWcgbmV0d29yayBjYXJkICBpbiBwY2llIHNsb3Qu
Ki8KK3N0YXRpYyB2b2lkIG5ldHdvcmtfaW5pdChQQ0lCdXMgKmJ1cykKK3sKKyAgICBOSUNJbmZv
ICpuZCA9ICZuZF90YWJsZVswXTsKKyAgICBQQ0lEZXZpY2UgKmV0aDsKKworICAgIC8qIFBsZWFz
ZSBzZXQgQ09ORklHX1ZJUlRJTyAmJiBDT05GSUdfVklSVElPX1BDSSAmJiBDT05GSUdfVklSVElP
X05FVCAqLworICAgIC8qIG9mIExpbnV4IGtlcm5lbC4gKi8KKyAgICBpZiAobmQtPm1vZGVsICYm
IHN0cmNtcChuZC0+bW9kZWwsICJ2aXJ0aW8iKSA9PSAwKSB7CisgICAgICAgIGV0aCA9IHBjaV9j
cmVhdGUoYnVzLAorICAgICAgICAgICAgICAgICAgICAgICAgUENJX0RFVkZOKDAsIDEpLCAidmly
dGlvLW5ldC1wY2kiKTsKKworICAgICAgICBxZGV2X3NldF9uaWNfcHJvcGVydGllcygmZXRoLT5x
ZGV2LCAmbmRfdGFibGVbMF0pOworICAgICAgICBxZGV2X2luaXRfbm9mYWlsKCZldGgtPnFkZXYp
OworICAgIH0KK30KKwogc3RhdGljIHZvaWQgYm9zdG9uX21hY2hfaW5pdChNYWNoaW5lU3RhdGUg
Km1hY2hpbmUpCiB7CiAgICAgRGV2aWNlU3RhdGUgKmRldjsKQEAgLTU0NSw2ICs1NjMsOSBAQCBz
dGF0aWMgdm9pZCBib3N0b25fbWFjaF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkKICAgICAg
ICAgZXJyb3JfcHJpbnRmKCJQbGVhc2UgcHJvdmlkZSBlaXRoZXIgYSAta2VybmVsIG9yIC1iaW9z
IGFyZ3VtZW50XG4iKTsKICAgICAgICAgZXhpdCgxKTsKICAgICB9CisKKyAgICAvKiBOZXR3b3Jr
IGNhcmQgKi8KKyAgICBuZXR3b3JrX2luaXQoJlBDSV9CUklER0UoJnBjaWUyLT5yb290KS0+c2Vj
X2J1cyk7CiB9CiAKIHN0YXRpYyB2b2lkIGJvc3Rvbl9tYWNoX2NsYXNzX2luaXQoTWFjaGluZUNs
YXNzICptYykKLS0gCjIuNy40Cgo=

--_004_MWHPR2201MB11190F1FFDE9CD41E3674DDFB8560MWHPR2201MB1119_--
