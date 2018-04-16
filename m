Received: from eggs.gnu.org ([2001:4830:134:3::10]:44007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1f897b-0002zk-7a
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1f897a-0004p8-4g
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:44:59 -0400
MIME-Version: 1.0
From: Henry Wertz <hwertz10@gmail.com>
Date: Mon, 16 Apr 2018 13:44:52 -0500
Message-ID: <CAOuPqTE8GsN_+REWzSt4DOiqddSbZC-kOH=WnYG3U8ge3GsLoA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="001a11469e3c0eed180569fb9e8a"
Subject: [Qemu-devel] Patch for ARM memory barriers and getdent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: QEMU Developers <qemu-devel@nongnu.org>

--001a11469e3c0eed180569fb9e8a
Content-Type: text/plain; charset="UTF-8"

Please find submitted a patch for ARM memory barriers.  This patch is
against qemu-2.12-rc2 but I do believe it should apply for anything from
2.11.x to current.

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
-------------------------------
Please find submitted a patch for getdents (this system call stands for
"get directory entries", it is passed a file descriptor pointing to a
directory and returns a struct with info on the entries in that
directory.)  This patch is against qemu-2.10 series but continues to apply
cleanly on current as of April 15 2018.  If you are running a 32-bit binary
on 64-bit target current qemu will convert he getdents struct, but it will
NOT in the case of 64-bit binary on 32-bit host.  (In my case, I had
android SDK's "aapt" for x86-64 error out on 32-bit ARM without this patch,
and run fine with it.)  This patch simply replaces a "#if TARGET_ABI_BITS
== 32 && HOST_LONG_BITS == 64" with "#if TARGET_ABI_BITS != HOST_LONG_BITS".

Thanks!

--001a11469e3c0eed180569fb9e8a
Content-Type: text/x-patch; charset="US-ASCII"; name="arm-mb.patch"
Content-Disposition: attachment; filename="arm-mb.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jg2l7sjc0

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
--001a11469e3c0eed180569fb9e8a
Content-Type: text/x-patch; charset="US-ASCII"; name="qemu-getdents.patch"
Content-Disposition: attachment; filename="qemu-getdents.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jg2l7slu1

KioqIGxpbnV4LXVzZXIvc3lzY2FsbC5jfgkyMDE3LTAzLTA0IDEwOjMxOjE0LjAwMDAwMDAwMCAt
MDYwMAotLS0gbGludXgtdXNlci9zeXNjYWxsLmMJMjAxNy0wMy0wNyAxNzowODoyNC42MTUzOTkx
MTYgLTA2MDAKKioqKioqKioqKioqKioqCioqKiA5OTEzLDk5MjEgKioqKgogICNlbmRpZgogICNp
ZmRlZiBUQVJHRVRfTlJfZ2V0ZGVudHMKICAgICAgY2FzZSBUQVJHRVRfTlJfZ2V0ZGVudHM6CiAg
I2lmZGVmIF9fTlJfZ2V0ZGVudHMKISAjaWYgVEFSR0VUX0FCSV9CSVRTID09IDMyICYmIEhPU1Rf
TE9OR19CSVRTID09IDY0CiAgICAgICAgICB7CiAgICAgICAgICAgICAgc3RydWN0IHRhcmdldF9k
aXJlbnQgKnRhcmdldF9kaXJwOwogICAgICAgICAgICAgIHN0cnVjdCBsaW51eF9kaXJlbnQgKmRp
cnA7CiAgICAgICAgICAgICAgYWJpX2xvbmcgY291bnQgPSBhcmczOwotLS0gOTkxMyw5OTIxIC0t
LS0KICAjZW5kaWYKICAjaWZkZWYgVEFSR0VUX05SX2dldGRlbnRzCiAgICAgIGNhc2UgVEFSR0VU
X05SX2dldGRlbnRzOgogICNpZmRlZiBfX05SX2dldGRlbnRzCiEgI2lmIFRBUkdFVF9BQklfQklU
UyAhPSBIT1NUX0xPTkdfQklUUwogICAgICAgICAgewogICAgICAgICAgICAgIHN0cnVjdCB0YXJn
ZXRfZGlyZW50ICp0YXJnZXRfZGlycDsKICAgICAgICAgICAgICBzdHJ1Y3QgbGludXhfZGlyZW50
ICpkaXJwOwogICAgICAgICAgICAgIGFiaV9sb25nIGNvdW50ID0gYXJnMzsK
--001a11469e3c0eed180569fb9e8a--
