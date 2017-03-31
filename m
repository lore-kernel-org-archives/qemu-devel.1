Received: from eggs.gnu.org ([2001:4830:134:3::10]:43988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctpNW-0006v4-3q
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 01:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctpNS-0000Ld-Oq
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 01:45:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ctpNS-0000Kw-Fk
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 01:45:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0628161D16
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 05:45:37 +0000 (UTC)
Message-ID: <1490939133.1877.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 31 Mar 2017 07:45:33 +0200
In-Reply-To: <20170330174242.GM2800@work-vm>
References: <20170330122354.GF2800@work-vm>
	<1490883039.28523.25.camel@redhat.com> <20170330174242.GM2800@work-vm>
Content-Type: multipart/mixed; boundary="=-ME67J1UrslUBJe/IL3AH"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] xhci migration breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org


--=-ME67J1UrslUBJe/IL3AH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Hi,

> dest:
> (qemu) red_dispatcher_loadvm_commands:=20
> usb-storage msd post_load 0x7f45f510ee50 sig=3D0 tag=3D0
>=20
> I added these as debug on the 'usb-storage' vmsd element; but
> the signature/tag being 0 I assume they're not the culprit.

Yep, no inflight transfer, so highly unlikely (also note that ehci works
fine according to bugzilla).

> #6  0x00007febabacae27 in xhci_kick_epctx (epctx=3D<optimized out>, xfer=
=3D<optimized out>, xhci=3D<optimized out>)
>     at /root/1436616/qemu/hw/usb/hcd-xhci.c:2103 <- right at the end of x=
hci_submit
> #7  0x00007febabacae27 in xhci_kick_epctx (epctx=3D<optimized out>, xfer=
=3D<optimized out>, xhci=3D<optimized out>)
>     at /root/1436616/qemu/hw/usb/hcd-xhci.c:2112 right at end of xhci_fir=
e_transfer
> #8  0x00007febabacae27 in xhci_kick_epctx (epctx=3D0x7febaec395a0, stream=
id=3D0)
>     at /root/1436616/qemu/hw/usb/hcd-xhci.c:2240

Recursive xhci_kick_epctx calls, not good.

Does the attached patch (not tested yet) make any difference?

cheers,
  Gerd


--=-ME67J1UrslUBJe/IL3AH
Content-Disposition: attachment;
	filename="0001-xhci-set-kick_active-for-retried-xfers-too.patch"
Content-Type: text/x-patch; name="0001-xhci-set-kick_active-for-retried-xfers-too.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAxYjEwYjEwNDQ1YWI0MzhjM2ZhMTEwN2Y5OTYyYWRkM2FlMDcxNmM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4KRGF0
ZTogRnJpLCAzMSBNYXIgMjAxNyAwNzo0MDo0NSArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIHhoY2k6
IHNldCBraWNrX2FjdGl2ZSBmb3IgcmV0cmllZCB4ZmVycyB0b28KClNpZ25lZC1vZmYtYnk6IEdl
cmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPgotLS0KIGh3L3VzYi9oY2QteGhjaS5jIHwg
OCArKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2h3L3VzYi9oY2QteGhjaS5jIGIvaHcvdXNiL2hjZC14aGNpLmMKaW5k
ZXggZjBhZjg1Mi4uODk1OGY5NSAxMDA2NDQKLS0tIGEvaHcvdXNiL2hjZC14aGNpLmMKKysrIGIv
aHcvdXNiL2hjZC14aGNpLmMKQEAgLTIwODMsNiArMjA4Myw3IEBAIHN0YXRpYyB2b2lkIHhoY2lf
a2lja19lcGN0eChYSENJRVBDb250ZXh0ICplcGN0eCwgdW5zaWduZWQgaW50IHN0cmVhbWlkKQog
ICAgICAgICByZXR1cm47CiAgICAgfQogCisgICAgZXBjdHgtPmtpY2tfYWN0aXZlKys7CiAgICAg
aWYgKGVwY3R4LT5yZXRyeSkgewogICAgICAgICBYSENJVHJhbnNmZXIgKnhmZXIgPSBlcGN0eC0+
cmV0cnk7CiAKQEAgLTIwOTMsNiArMjA5NCw3IEBAIHN0YXRpYyB2b2lkIHhoY2lfa2lja19lcGN0
eChYSENJRVBDb250ZXh0ICplcGN0eCwgdW5zaWduZWQgaW50IHN0cmVhbWlkKQogICAgICAgICAg
ICAgbWZpbmRleCA9IHhoY2lfbWZpbmRleF9nZXQoeGhjaSk7CiAgICAgICAgICAgICB4aGNpX2No
ZWNrX2ludHJfaXNvX2tpY2soeGhjaSwgeGZlciwgZXBjdHgsIG1maW5kZXgpOwogICAgICAgICAg
ICAgaWYgKHhmZXItPnJ1bm5pbmdfcmV0cnkpIHsKKyAgICAgICAgICAgICAgICBlcGN0eC0+a2lj
a19hY3RpdmUtLTsKICAgICAgICAgICAgICAgICByZXR1cm47CiAgICAgICAgICAgICB9CiAgICAg
ICAgICAgICB4ZmVyLT50aW1lZF94ZmVyID0gMDsKQEAgLTIxMDEsNiArMjEwMyw3IEBAIHN0YXRp
YyB2b2lkIHhoY2lfa2lja19lcGN0eChYSENJRVBDb250ZXh0ICplcGN0eCwgdW5zaWduZWQgaW50
IHN0cmVhbWlkKQogICAgICAgICBpZiAoeGZlci0+aXNvX3hmZXIpIHsKICAgICAgICAgICAgIC8q
IHJldHJ5IGlzbyB0cmFuc2ZlciAqLwogICAgICAgICAgICAgaWYgKHhoY2lfc2V0dXBfcGFja2V0
KHhmZXIpIDwgMCkgeworICAgICAgICAgICAgICAgIGVwY3R4LT5raWNrX2FjdGl2ZS0tOwogICAg
ICAgICAgICAgICAgIHJldHVybjsKICAgICAgICAgICAgIH0KICAgICAgICAgICAgIHVzYl9oYW5k
bGVfcGFja2V0KHhmZXItPnBhY2tldC5lcC0+ZGV2LCAmeGZlci0+cGFja2V0KTsKQEAgLTIxMDks
MTAgKzIxMTIsMTIgQEAgc3RhdGljIHZvaWQgeGhjaV9raWNrX2VwY3R4KFhIQ0lFUENvbnRleHQg
KmVwY3R4LCB1bnNpZ25lZCBpbnQgc3RyZWFtaWQpCiAgICAgICAgIH0gZWxzZSB7CiAgICAgICAg
ICAgICAvKiByZXRyeSBuYWsnZWQgdHJhbnNmZXIgKi8KICAgICAgICAgICAgIGlmICh4aGNpX3Nl
dHVwX3BhY2tldCh4ZmVyKSA8IDApIHsKKyAgICAgICAgICAgICAgICBlcGN0eC0+a2lja19hY3Rp
dmUtLTsKICAgICAgICAgICAgICAgICByZXR1cm47CiAgICAgICAgICAgICB9CiAgICAgICAgICAg
ICB1c2JfaGFuZGxlX3BhY2tldCh4ZmVyLT5wYWNrZXQuZXAtPmRldiwgJnhmZXItPnBhY2tldCk7
CiAgICAgICAgICAgICBpZiAoeGZlci0+cGFja2V0LnN0YXR1cyA9PSBVU0JfUkVUX05BSykgewor
ICAgICAgICAgICAgICAgIGVwY3R4LT5raWNrX2FjdGl2ZS0tOwogICAgICAgICAgICAgICAgIHJl
dHVybjsKICAgICAgICAgICAgIH0KICAgICAgICAgICAgIHhoY2lfdHJ5X2NvbXBsZXRlX3BhY2tl
dCh4ZmVyKTsKQEAgLTIxMjYsNiArMjEzMSw3IEBAIHN0YXRpYyB2b2lkIHhoY2lfa2lja19lcGN0
eChYSENJRVBDb250ZXh0ICplcGN0eCwgdW5zaWduZWQgaW50IHN0cmVhbWlkKQogCiAgICAgaWYg
KGVwY3R4LT5zdGF0ZSA9PSBFUF9IQUxURUQpIHsKICAgICAgICAgRFBSSU5URigieGhjaTogZXAg
aGFsdGVkLCBub3QgcnVubmluZyBzY2hlZHVsZVxuIik7CisgICAgICAgIGVwY3R4LT5raWNrX2Fj
dGl2ZS0tOwogICAgICAgICByZXR1cm47CiAgICAgfQogCkBAIC0yMTM0LDYgKzIxNDAsNyBAQCBz
dGF0aWMgdm9pZCB4aGNpX2tpY2tfZXBjdHgoWEhDSUVQQ29udGV4dCAqZXBjdHgsIHVuc2lnbmVk
IGludCBzdHJlYW1pZCkKICAgICAgICAgdWludDMyX3QgZXJyOwogICAgICAgICBzdGN0eCA9IHho
Y2lfZmluZF9zdHJlYW0oZXBjdHgsIHN0cmVhbWlkLCAmZXJyKTsKICAgICAgICAgaWYgKHN0Y3R4
ID09IE5VTEwpIHsKKyAgICAgICAgICAgIGVwY3R4LT5raWNrX2FjdGl2ZS0tOwogICAgICAgICAg
ICAgcmV0dXJuOwogICAgICAgICB9CiAgICAgICAgIHJpbmcgPSAmc3RjdHgtPnJpbmc7CkBAIC0y
MTQ1LDcgKzIxNTIsNiBAQCBzdGF0aWMgdm9pZCB4aGNpX2tpY2tfZXBjdHgoWEhDSUVQQ29udGV4
dCAqZXBjdHgsIHVuc2lnbmVkIGludCBzdHJlYW1pZCkKICAgICB9CiAgICAgYXNzZXJ0KHJpbmct
PmRlcXVldWUgIT0gMCk7CiAKLSAgICBlcGN0eC0+a2lja19hY3RpdmUrKzsKICAgICB3aGlsZSAo
MSkgewogICAgICAgICBsZW5ndGggPSB4aGNpX3JpbmdfY2hhaW5fbGVuZ3RoKHhoY2ksIHJpbmcp
OwogICAgICAgICBpZiAobGVuZ3RoIDw9IDApIHsKLS0gCjEuOC4zLjEKCg==


--=-ME67J1UrslUBJe/IL3AH--
