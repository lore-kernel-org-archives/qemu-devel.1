Received: from eggs.gnu.org ([2001:4830:134:3::10]:41452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4i9D-0005vy-Vf
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 02:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4i9A-00066R-Ra
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 02:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e4i9A-00066C-IM
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 02:48:08 -0400
Message-ID: <1508309285.10073.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 18 Oct 2017 08:48:05 +0200
In-Reply-To: <20171015184033.2951-1-martin@schrodt.org>
References: <20171015184033.2951-1-martin@schrodt.org>
Content-Type: multipart/mixed; boundary="=-2Te1/mA8vSCW0kwMPuvN"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Improve audio output quality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org


--=-2Te1/mA8vSCW0kwMPuvN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

  Hi,

> This is still missing proper handling for VMState-migration, which I
> will need a bit of assistance with.

See attachment.  It adds a bool to the state and a property to turn
on/off the timer.  It also adds a vmstate subsection, which will only
saved in case the timer is in use.  Also extends the compat list so the
timer will be turned off for old machine types (-M pc-i440fx-2.10 &
older).

Background: Using "-M pc-i440fx-2.10" instead of "-M pc" puts qemu into
2.10 compatibility mode.  Live migration is supposed to work even
between different qemu versions as long as they use the same machine
type.

Missing:  Continue to use the old code in case the timer is turned off
(needed for backward compatibility).  Most of the changes are in the
callbacks, probably it is easiest to rename the existing callbacks
(_compat or _notimer postfix for example) and register the old or new
ones depending on the use_timer variable.

> Sorry for v4 already, having a hard time with the style checker
> bots... :(

There is scripts/checkpatch.pl to run those tests locally.

Which guests did you test with?

I did a brief test with Windows 7 and still have sound dropouts, even
though it seems to not be as bad as before.  Didn't investigate yet
why.

cheers,
  Gerd

--=-2Te1/mA8vSCW0kwMPuvN
Content-Disposition: attachment; filename="0001-hda-buffer-compatibility-fluff.patch"
Content-Type: text/x-patch; name="0001-hda-buffer-compatibility-fluff.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA3ZjdhOGIyYmI4MThmZjdhNzZjZmE1OTJlMDZiMmQyNzFhMGY4YmNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4KRGF0
ZTogTW9uLCAxNiBPY3QgMjAxNyAxMjoyMjo1NyArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIGhkYSBi
dWZmZXIgY29tcGF0aWJpbGl0eSBmbHVmZgoKLS0tCiBpbmNsdWRlL2h3L2NvbXBhdC5oICB8ICA0
ICsrKysKIGh3L2F1ZGlvL2hkYS1jb2RlYy5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysr
KysKIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaHcvY29tcGF0LmggYi9pbmNsdWRlL2h3L2NvbXBhdC5oCmluZGV4IGNmMzg5YjRlODUuLjIy
ZDE1NDAzNWUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvY29tcGF0LmgKKysrIGIvaW5jbHVkZS9o
dy9jb21wYXQuaApAQCAtMTAsNiArMTAsMTAgQEAKICAgICAgICAgLmRyaXZlciAgID0gInZpcnRp
by10YWJsZXQtZGV2aWNlIixcCiAgICAgICAgIC5wcm9wZXJ0eSA9ICJ3aGVlbC1heGlzIixcCiAg
ICAgICAgIC52YWx1ZSAgICA9ICJmYWxzZSIsXAorICAgIH0se1wKKyAgICAgICAgLmRyaXZlciAg
ID0gImhkYS1hdWRpbyIsXAorICAgICAgICAucHJvcGVydHkgPSAidXNlLXRpbWVyIixcCisgICAg
ICAgIC52YWx1ZSAgICA9ICJmYWxzZSIsXAogICAgIH0sCiAKICNkZWZpbmUgSFdfQ09NUEFUXzJf
OSBcCmRpZmYgLS1naXQgYS9ody9hdWRpby9oZGEtY29kZWMuYyBiL2h3L2F1ZGlvL2hkYS1jb2Rl
Yy5jCmluZGV4IGFiODkxNThiZmMuLmRmN2ZjODdmOTYgMTAwNjQ0Ci0tLSBhL2h3L2F1ZGlvL2hk
YS1jb2RlYy5jCisrKyBiL2h3L2F1ZGlvL2hkYS1jb2RlYy5jCkBAIC0xODUsNiArMTg1LDcgQEAg
c3RydWN0IEhEQUF1ZGlvU3RhdGUgewogICAgIC8qIHByb3BlcnRpZXMgKi8KICAgICB1aW50MzJf
dCBkZWJ1ZzsKICAgICBib29sICAgICBtaXhlcjsKKyAgICBib29sICAgICB1c2VfdGltZXI7CiB9
OwogCiBzdGF0aWMgaW5saW5lIGludDY0X3QgaGRhX2J5dGVzX3Blcl9zZWNvbmQoSERBQXVkaW9T
dHJlYW0gKnN0KQpAQCAtNjk2LDYgKzY5NywyNiBAQCBzdGF0aWMgdm9pZCBoZGFfYXVkaW9fcmVz
ZXQoRGV2aWNlU3RhdGUgKmRldikKICAgICB9CiB9CiAKK3N0YXRpYyBib29sIHZtc3RhdGVfaGRh
X2F1ZGlvX3N0cmVhbV9idWZfbmVlZGVkKHZvaWQgKm9wYXF1ZSkKK3sKKyAgICBIREFBdWRpb1N0
cmVhbSAqc3QgPSBvcGFxdWU7CisgICAgcmV0dXJuIHN0LT5zdGF0ZS0+dXNlX3RpbWVyOworfQor
CitzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGRhX2F1ZGlvX3N0cmVh
bV9idWYgPSB7CisgICAgLm5hbWUgPSAiaGRhLWF1ZGlvLXN0cmVhbS9idWZmZXIiLAorICAgIC52
ZXJzaW9uX2lkID0gMSwKKyAgICAubmVlZGVkID0gdm1zdGF0ZV9oZGFfYXVkaW9fc3RyZWFtX2J1
Zl9uZWVkZWQsCisgICAgLmZpZWxkcyA9IChWTVN0YXRlRmllbGRbXSkgeworICAgICAgICBWTVNU
QVRFX0JVRkZFUihidWYsIEhEQUF1ZGlvU3RyZWFtKSwKKyAgICAgICAgVk1TVEFURV9JTlQ2NChy
cG9zLCBIREFBdWRpb1N0cmVhbSksCisgICAgICAgIFZNU1RBVEVfSU5UNjQod3BvcywgSERBQXVk
aW9TdHJlYW0pLAorICAgICAgICBWTVNUQVRFX1RJTUVSX1BUUihidWZ0LCBIREFBdWRpb1N0cmVh
bSksCisgICAgICAgIFZNU1RBVEVfSU5UNjQoYnVmdF9zdGFydCwgSERBQXVkaW9TdHJlYW0pLAor
ICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkKKyAgICB9Cit9OworCiBzdGF0aWMgY29uc3Qg
Vk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGRhX2F1ZGlvX3N0cmVhbSA9IHsKICAgICAubmFt
ZSA9ICJoZGEtYXVkaW8tc3RyZWFtIiwKICAgICAudmVyc2lvbl9pZCA9IDEsCkBAIC03MTAsNiAr
NzMxLDEwIEBAIHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZGFfYXVk
aW9fc3RyZWFtID0gewogICAgICAgICBWTVNUQVRFX1VJTlQzMihjb21wYXRfYnBvcywgSERBQXVk
aW9TdHJlYW0pLAogICAgICAgICBWTVNUQVRFX0JVRkZFUihjb21wYXRfYnVmLCBIREFBdWRpb1N0
cmVhbSksCiAgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAgIH0sCisgICAgLnN1YnNl
Y3Rpb25zID0gKGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiAqIFtdKSB7CisgICAgICAgICZ2bXN0
YXRlX2hkYV9hdWRpb19zdHJlYW1fYnVmLAorICAgICAgICBOVUxMCiAgICAgfQogfTsKIApAQCAt
NzMwLDYgKzc1NSw3IEBAIHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9o
ZGFfYXVkaW8gPSB7CiBzdGF0aWMgUHJvcGVydHkgaGRhX2F1ZGlvX3Byb3BlcnRpZXNbXSA9IHsK
ICAgICBERUZJTkVfUFJPUF9VSU5UMzIoImRlYnVnIiwgSERBQXVkaW9TdGF0ZSwgZGVidWcsICAg
MCksCiAgICAgREVGSU5FX1BST1BfQk9PTCgibWl4ZXIiLCBIREFBdWRpb1N0YXRlLCBtaXhlciwg
IHRydWUpLAorICAgIERFRklORV9QUk9QX0JPT0woInVzZS10aW1lciIsIEhEQUF1ZGlvU3RhdGUs
IHVzZV90aW1lciwgIHRydWUpLAogICAgIERFRklORV9QUk9QX0VORF9PRl9MSVNUKCksCiB9Owog
Ci0tIAoyLjkuMwoK


--=-2Te1/mA8vSCW0kwMPuvN--
