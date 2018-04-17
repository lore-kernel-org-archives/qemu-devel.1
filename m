Received: from eggs.gnu.org ([2001:4830:134:3::10]:53710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1f8YDS-0001Ym-BP
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1f8YDQ-0006h5-28
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:32:42 -0400
MIME-Version: 1.0
From: Henry Wertz <hwertz10@gmail.com>
Date: Tue, 17 Apr 2018 16:32:26 -0500
Message-ID: <CAOuPqTFJABMcDHmQcNoNZioBBJ8RcreeevsRfh5b46ZgKZLetw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="f403045f1a0a2e9baf056a1213be"
Subject: [Qemu-devel] ARM memory barrier patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

--f403045f1a0a2e9baf056a1213be
Content-Type: text/plain; charset="UTF-8"

Please find submitted a patch for ARM memory barriers.  This patch is
against qemu-2.12-rc2 but I do believe it should apply for anything from
2.11.x to current. (the code being patched was added in for 2.11 series.)


I found with qemu 2.11.x or newer that I would get an illegal instruction
error running some Intel binaries on my ARM chromebook.  On investigation,
I found it was quitting on memory barriers.
qemu instruction:
mb $0x31
was translating as:
0x604050cc:  5bf07ff5  blpl     #0x600250a8

After patch it gives:
0x604050cc:  f57ff05b  dmb      ish

In short, I found INSN_DMB_ISH (memory barrier for ARMv7) appeared to be
correct based on online docs, but due to some endian-related shenanigans it
had to be byte-swapped to suit qemu; it appears INSN_DMB_MCR (memory
barrier for ARMv6) also should be byte swapped  (and this patch does so).
I have not checked for correctness of aarch64's barrier instruction.

Signed-off-by: Henry Wertz <hwertz10@gmail.com>

--f403045f1a0a2e9baf056a1213be
Content-Type: text/x-patch; charset="US-ASCII"; name="arm-mb.patch"
Content-Disposition: attachment; filename="arm-mb.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jg46ow5z0

KioqIHRjZy9hcm0vdGNnLXRhcmdldC5pbmMuYy5vcmlnCTIwMTgtMDQtMDQgMTU6Mjg6NTAuMDAw
MDAwMDAwIC0wNTAwCi0tLSB0Y2cvYXJtL3RjZy10YXJnZXQuaW5jLmMJMjAxOC0wNC0xNiAxMjo1
NTowNC45MTc1MTg4OTggLTA1MDAKKioqKioqKioqKioqKioqCioqKiAxNTgsMTY3ICoqKioKICAg
ICAgSU5TTl9MRFJEX1JFRyAgPSAweDAwMDAwMGQwLAogICAgICBJTlNOX1NUUkRfSU1NICA9IDB4
MDA0MDAwZjAsCiAgICAgIElOU05fU1RSRF9SRUcgID0gMHgwMDAwMDBmMCwKICAKISAgICAgSU5T
Tl9ETUJfSVNIICAgPSAweDViZjA3ZmY1LAohICAgICBJTlNOX0RNQl9NQ1IgICA9IDB4YmEwZjA3
ZWUsCiAgCiAgICAgIC8qIEFyY2hpdGVjdGVkIG5vcCBpbnRyb2R1Y2VkIGluIHY2ay4gICovCiAg
ICAgIC8qID8/PyBUaGlzIGlzIGFuIE1TUiAoaW1tKSAwLDAsMCBpbnNuLiAgQW55b25lIGtub3cg
aWYgdGhpcwogICAgICAgICBhbHNvIEp1c3QgU28gSGFwcGVuZWQgdG8gZG8gbm90aGluZyBvbiBw
cmUtdjZrIHNvIHRoYXQgd2UKLS0tIDE1OCwxNjcgLS0tLQogICAgICBJTlNOX0xEUkRfUkVHICA9
IDB4MDAwMDAwZDAsCiAgICAgIElOU05fU1RSRF9JTU0gID0gMHgwMDQwMDBmMCwKICAgICAgSU5T
Tl9TVFJEX1JFRyAgPSAweDAwMDAwMGYwLAogIAohICAgICBJTlNOX0RNQl9JU0ggICA9IDB4ZjU3
ZmYwNWIsCiEgICAgIElOU05fRE1CX01DUiAgID0gMHhlZTA3MGZiYSwKICAKICAgICAgLyogQXJj
aGl0ZWN0ZWQgbm9wIGludHJvZHVjZWQgaW4gdjZrLiAgKi8KICAgICAgLyogPz8/IFRoaXMgaXMg
YW4gTVNSIChpbW0pIDAsMCwwIGluc24uICBBbnlvbmUga25vdyBpZiB0aGlzCiAgICAgICAgIGFs
c28gSnVzdCBTbyBIYXBwZW5lZCB0byBkbyBub3RoaW5nIG9uIHByZS12Nmsgc28gdGhhdCB3ZQo=
--f403045f1a0a2e9baf056a1213be--
