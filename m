Received: from eggs.gnu.org ([2001:4830:134:3::10]:38447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ciMKo-0001oy-45
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ciMKm-0007y6-Hl
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:34016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ciMKm-0007xw-Br
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ciMKl-0003c1-2u
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:31:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ACF952E818C
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:31:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Feb 2017 14:23:36 -0000
From: Nehal J Wani <nehaljw.kkd1@gmail.com>
Reply-To: Bug 1668273 <1668273@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170227140328.20639.14786.malonedeb@soybean.canonical.com>
Message-Id: <20170227142337.20737.80472.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1668273] Re: DoS possible on - a QEMU process
 using userspace SLIRP?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Summary changed:

- DDoS possible on - a QEMU process using userspace SLIRP?
+ DoS possible on - a QEMU process using userspace SLIRP?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1668273

Title:
  DoS possible on - a QEMU process using userspace SLIRP?

Status in QEMU:
  New

Bug description:
  Steps to reproduce:

  - Launch a VM using QEMU (2.8.0):

  $ qemu-system-x86_64 \
  =C2=A0=C2=A0=C2=A0=C2=A0-machine accel=3Dkvm \
  =C2=A0=C2=A0=C2=A0=C2=A0-hda Fedora-Cloud-Base-25-1.3.x86_64.qcow2 \
  =C2=A0=C2=A0=C2=A0=C2=A0-m 2G \
  =C2=A0=C2=A0=C2=A0=C2=A0-smp 2 \
  =C2=A0=C2=A0=C2=A0=C2=A0-vnc :8 \
  =C2=A0=C2=A0=C2=A0=C2=A0-boot dc \
  =C2=A0=C2=A0=C2=A0=C2=A0-vga std \
  =C2=A0=C2=A0=C2=A0=C2=A0-cpu host \
  =C2=A0=C2=A0=C2=A0=C2=A0-net nic,vlan=3D0 \
  =C2=A0=C2=A0=C2=A0=C2=A0-net user,vlan=3D0,hostfwd=3Dtcp::10024-:22,hostf=
wd=3Dtcp::8082-:80

  - SSH into the VM, install httpd, start httpd

  $ ssh -p 10024 root@localhost 'dnf install -y httpd && systemctl start
  httpd'

  - Compile and run the following Java program (on the host):

  $ cat <<EOF > URLConnectionReader.java
  import java.net.*;
  import java.io.*;

  public class URLConnectionReader {
  =C2=A0=C2=A0=C2=A0=C2=A0public static void main(String[] args) throws Exc=
eption {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i =3D 0;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (i < 1024) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0U=
RL this_is_404 =3D new URL("http://localhost:8082/blah");
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0U=
RLConnection yc =3D this_is_404.openConnection();
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0t=
ry {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0BufferedReader in =3D new BufferedReader(new InputS=
treamReader(
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0yc.getInputStream()));
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0String inputLine;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0while ((inputLine =3D in.readLine()) !=3D null)
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0System.out.println(inputLin=
e);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0in.close();
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}=
 catch (Exception e) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0//HttpURLConnection urlConnection =3D (HttpURLConne=
ction) yc;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0//urlConnection.disconnect();
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i=
++;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Thread.sleep(1000000000);
  =C2=A0=C2=A0=C2=A0=C2=A0}
  }

  $ javac URLConnectionReader.java

  $ java URLConnectionReader &

  The java program tries to open a lot of HTTP connections, but never
  calls disconnect() on any.

  - Take a look at the list of open FDs of the qemu process:

  $ ls -tl /proc/${qemu-pid}/fd

  $ lsof -p ${qemu-pid}
  All of the TCP connections will be stuck at FIN_WAIT2

  The VM becomes unresponsive. Neither SSH or VNC works after this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1668273/+subscriptions
