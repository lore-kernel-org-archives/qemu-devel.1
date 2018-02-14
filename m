Received: from eggs.gnu.org ([2001:4830:134:3::10]:51305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1eltdO-00046m-Lb
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1eltdI-0001ef-VG
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:45:50 -0500
Received: from mailpro.odiso.net ([89.248.211.110]:56730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1eltdI-0001e6-OJ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:45:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id D28EC1F55D40
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:45:41 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Zl-48MhnOF1i for <qemu-devel@nongnu.org>;
	Wed, 14 Feb 2018 10:45:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id B90901F55D42
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:45:41 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kBTA0GXY-AVU for <qemu-devel@nongnu.org>;
	Wed, 14 Feb 2018 10:45:41 +0100 (CET)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.111])
	by mailpro.odiso.net (Postfix) with ESMTP id A5D921F55D40
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:45:41 +0100 (CET)
Date: Wed, 14 Feb 2018 10:45:41 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <1564471998.3427173.1518601541505.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <201297396.3423395.1518598461012.JavaMail.zimbra@oxygem.tv>
References: <201297396.3423395.1518598461012.JavaMail.zimbra@oxygem.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] drive-mirroring to nbd is failing with multiple
 parallel jobs (qemu 2.9 -> 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Sorry, I just find that the problem is in our proxmox implementation,

as we use a socat tunnel for the nbd mirroring, with a timeout of 30s in ca=
se of inactivity.

So, not a qemu bug.

Regards,

Alexandre

----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "qemu-devel" <qemu-devel@nongnu.org>
Envoy=C3=A9: Mercredi 14 F=C3=A9vrier 2018 09:54:21
Objet: [Qemu-devel] drive-mirroring to nbd is failing with multiple paralle=
l jobs (qemu 2.9 -> 2.11)

Hi,=20

I currently have failing mirroring jobs to nbd, when multiple jobs are runn=
ing in parallel.=20


step to reproduce, with 2 disks:=20


1) launch mirroring job of first disk to remote target nbd.(to qemu running=
 target)=20
2) wait until is reach ready =3D 1 , do not complete=20
3) launch mirroring job of second disk to remote target nbd(to same qemu ru=
nning target)=20

-> mirroring job of second disk is currently running (ready=3D0), first dis=
k is still at ready=3D1 and still mirroring new write coming.=20


then, after some time, mainly if no new write are coming to first disk (aro=
und 30-40s), the first job is crashing with input/output error.=20



Note that I don't have network problem, or disk problem, I'm able to mirror=
 both disk individually.=20


Another similar bug report on proxmox bugzilla:=20

https://bugzilla.proxmox.com/show_bug.cgi?id=3D1664=20


Maybe related to this :=20
https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03086.html=20
?=20


I don't remember to have the problem with qemu 2.7, but I'm able to reprodu=
ce with qemu 2.9 && qemu 2.11.=20


Best Regards,=20

Alexandre=20
