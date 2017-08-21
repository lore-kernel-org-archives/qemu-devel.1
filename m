Received: from eggs.gnu.org ([2001:4830:134:3::10]:42332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djixy-0000zH-1E
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djixt-0004Pi-3T
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:25:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:38579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1djixs-0004NP-Sr
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:25:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1djixq-00068V-UZ
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 09:25:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8EE8C2E80D3
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 09:25:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Aug 2017 09:12:02 -0000
From: Huang Yong <1712027@bugs.launchpad.net>
Reply-To: Bug 1712027 <1712027@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150330672268.8725.17665790368733773133.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1712027] [NEW] qemu: Cryptography adding
 encrypted disk with luks format failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I'm using libvirt to attach luks encrypted disk to a running VM. The
qemu-monitor-command like the

following:

{"execute":"object-add","arguments":{"qom-type":"secret","id":"virtio-
disk11-luks-
secret0","props":{"data":"El7jOYLCZwrij2Mue0q2tA=3D=3D","keyid":"masterKey0=
","iv":"J2je0WJjCa89L3iKc1lceg=3D=3D","format":"base64"}}

the masterKey0 specify the secret which has been created before.

command above return with error message "Incorrect number of padding
bytes XXX found on decrypted

data". This is triggered by the following code snippets in qemu/crypto/secr=
et.c:
         =

if (plaintext[ciphertextlen - 1] > 16 ||
             plaintext[ciphertextlen - 1] > ciphertextlen) {
             error_setg(errp, "Incorrect number of padding bytes (%d) "
                     "found on decrypted data",
                     (int)plaintext[ciphertextlen - 1]); =

                   =E2=80=A6
         }

The bug is: There is on padding in plaintext if the actual length of the
plaintext  decrypted is

equal to ciphertext.

In this case, the last element in plaintext array may be one of the
character in base64 code table

or other.

I would like to know why length of padding bytes cannot exceed 16 and
whether i can remove

judement: =E2=80=9Cplaintext[ciphertextlen - 1] > 16=E2=80=9D so that I can=
 eliminate
the error above.

Much appreciate it if doubts above is cleared up.

libvirt/qemu version:

# virsh version
Compiled against library: libvirt 3.0.0
Using library: libvirt 3.0.0
Using API: QEMU 3.0.0
Running hypervisor: QEMU 2.7.1

OS: Ubuntu 12.04 LTS

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1712027

Title:
  qemu: Cryptography adding encrypted disk with luks format failed

Status in QEMU:
  New

Bug description:
  I'm using libvirt to attach luks encrypted disk to a running VM. The
  qemu-monitor-command like the

  following:

  {"execute":"object-add","arguments":{"qom-type":"secret","id":"virtio-
  disk11-luks-
  secret0","props":{"data":"El7jOYLCZwrij2Mue0q2tA=3D=3D","keyid":"masterKe=
y0","iv":"J2je0WJjCa89L3iKc1lceg=3D=3D","format":"base64"}}

  the masterKey0 specify the secret which has been created before.

  command above return with error message "Incorrect number of padding
  bytes XXX found on decrypted

  data". This is triggered by the following code snippets in qemu/crypto/se=
cret.c:
           =

  if (plaintext[ciphertextlen - 1] > 16 ||
               plaintext[ciphertextlen - 1] > ciphertextlen) {
               error_setg(errp, "Incorrect number of padding bytes (%d) "
                       "found on decrypted data",
                       (int)plaintext[ciphertextlen - 1]); =

                     =E2=80=A6
           }

  The bug is: There is on padding in plaintext if the actual length of
  the plaintext  decrypted is

  equal to ciphertext.

  In this case, the last element in plaintext array may be one of the
  character in base64 code table

  or other.

  I would like to know why length of padding bytes cannot exceed 16 and
  whether i can remove

  judement: =E2=80=9Cplaintext[ciphertextlen - 1] > 16=E2=80=9D so that I c=
an eliminate
  the error above.

  Much appreciate it if doubts above is cleared up.

  libvirt/qemu version:

  # virsh version
  Compiled against library: libvirt 3.0.0
  Using library: libvirt 3.0.0
  Using API: QEMU 3.0.0
  Running hypervisor: QEMU 2.7.1

  OS: Ubuntu 12.04 LTS

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1712027/+subscriptions
