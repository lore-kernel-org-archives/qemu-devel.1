Received: from eggs.gnu.org ([2001:4830:134:3::10]:55864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dzejrou@gmail.com>) id 1dcKQE-0005D3-32
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 19:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dzejrou@gmail.com>) id 1dcKQD-0000Ne-5Y
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 19:48:26 -0400
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:37944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dzejrou@gmail.com>) id 1dcKQC-0000N7-Vo
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 19:48:25 -0400
Received: by mail-ua0-x22f.google.com with SMTP id w45so333457uac.5
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 16:48:23 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Jaroslav_Jindr=C3=A1k?= <dzejrou@gmail.com>
Date: Tue, 1 Aug 2017 01:48:21 +0200
Message-ID: <CAE-Qwfz-RqR_qiOPmv8XF9SO-+4nroai0tNhE_CboEge9ufy+w@mail.gmail.com>
Content-Type: multipart/mixed; boundary="f403043c4b2484cc8b0555a5aaac"
Subject: [Qemu-devel] xhci: move command stop and command abort flag check
 to the case when the crcr_low register is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

--f403043c4b2484cc8b0555a5aaac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to submit a patch to the xhci subsystem of QEMU. Currently, when
the command stop or command abort flags in the crcr_low register are set,
nothing happens. This is because the part of the code that tests those two
flags (and performs command ring abort/stop) is in the crcr_high case. This
error has a simple workaround - after writing to the crcr_low register with
either of these two flags set, one can write the value of crcr_high to
crcr_high, so I assume this fix does not have that big of a priority, but a
driver that follows the specification strictly would misbehave in this kind
of situation (stopping/aborting the command ring).

The patch is contained in the attachement.

=E2=80=8BKind=E2=80=8B regards,
Jaroslav Jindrak

--f403043c4b2484cc8b0555a5aaac
Content-Type: text/x-patch; charset="US-ASCII"; name="xhci_crcr_patch.patch"
Content-Disposition: attachment; filename="xhci_crcr_patch.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j5sszldh0

RnJvbSBiMThhMTY1ZjNjNzBjNjE1NDk0NDcwNmJkMDk2ZmIwMDJhOWI0NDYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEemVqcm91IDxkemVqcm91QGdtYWlsLmNvbT4KRGF0ZTogVHVl
LCAxIEF1ZyAyMDE3IDAxOjMwOjQ5ICswMjAwClN1YmplY3Q6IFtQQVRDSCAxLzFdIHhoY2k6IG1v
dmUgY29tbWFuZCBzdG9wIGFuZCBjb21tYW5kIGFib3J0IGZsYWcgY2hlY2sgdG8KIHRoZSBjYXNl
IHdoZW4gdGhlIGNyY3JfbG93IHJlZ2lzdGVyIGlzIHNldAoKU2lnbmVkLW9mZi1ieTogRHplanJv
dSA8ZHplanJvdUBnbWFpbC5jb20+Ci0tLQogaHcvdXNiL2hjZC14aGNpLmMgfCA2ICsrKy0tLQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9ody91c2IvaGNkLXhoY2kuYyBiL2h3L3VzYi9oY2QteGhjaS5jCmluZGV4IDIwNGVhNjku
LjllYjNjODMgMTAwNjQ0Ci0tLSBhL2h3L3VzYi9oY2QteGhjaS5jCisrKyBiL2h3L3VzYi9oY2Qt
eGhjaS5jCkBAIC0yOTM3LDkgKzI5MzcsNiBAQCBzdGF0aWMgdm9pZCB4aGNpX29wZXJfd3JpdGUo
dm9pZCAqcHRyLCBod2FkZHIgcmVnLAogICAgICAgICBicmVhazsKICAgICBjYXNlIDB4MTg6IC8q
IENSQ1IgbG93ICovCiAgICAgICAgIHhoY2ktPmNyY3JfbG93ID0gKHZhbCAmIDB4ZmZmZmZmY2Yp
IHwgKHhoY2ktPmNyY3JfbG93ICYgQ1JDUl9DUlIpOwotICAgICAgICBicmVhazsKLSAgICBjYXNl
IDB4MWM6IC8qIENSQ1IgaGlnaCAqLwotICAgICAgICB4aGNpLT5jcmNyX2hpZ2ggPSB2YWw7CiAg
ICAgICAgIGlmICh4aGNpLT5jcmNyX2xvdyAmIChDUkNSX0NBfENSQ1JfQ1MpICYmICh4aGNpLT5j
cmNyX2xvdyAmIENSQ1JfQ1JSKSkgewogICAgICAgICAgICAgWEhDSUV2ZW50IGV2ZW50ID0ge0VS
X0NPTU1BTkRfQ09NUExFVEUsIENDX0NPTU1BTkRfUklOR19TVE9QUEVEfTsKICAgICAgICAgICAg
IHhoY2ktPmNyY3JfbG93ICY9IH5DUkNSX0NSUjsKQEAgLTI5NTEsNiArMjk0OCw5IEBAIHN0YXRp
YyB2b2lkIHhoY2lfb3Blcl93cml0ZSh2b2lkICpwdHIsIGh3YWRkciByZWcsCiAgICAgICAgIH0K
ICAgICAgICAgeGhjaS0+Y3Jjcl9sb3cgJj0gfihDUkNSX0NBIHwgQ1JDUl9DUyk7CiAgICAgICAg
IGJyZWFrOworICAgIGNhc2UgMHgxYzogLyogQ1JDUiBoaWdoICovCisgICAgICAgIHhoY2ktPmNy
Y3JfaGlnaCA9IHZhbDsKKyAgICAgICAgYnJlYWs7CiAgICAgY2FzZSAweDMwOiAvKiBEQ0JBQVAg
bG93ICovCiAgICAgICAgIHhoY2ktPmRjYmFhcF9sb3cgPSB2YWwgJiAweGZmZmZmZmMwOwogICAg
ICAgICBicmVhazsKLS0gCjIuNC4xMQoK
--f403043c4b2484cc8b0555a5aaac--
