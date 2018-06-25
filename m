Received: from eggs.gnu.org ([2001:4830:134:3::10]:38679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fXOTu-00080s-Q5
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fXOTr-0002vx-M5
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:12:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1fXOTr-0002vj-GL
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:12:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E50ABBB40A
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 10:12:18 +0000 (UTC)
Date: Mon, 25 Jun 2018 12:12:16 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180625101216.GE18277@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] RNG: Any reason QEMU doesn't default to `/dev/urandom`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rjones@redhat.com, dgilbert@redhat.com, berrange@redhat.com

QEMU still defaults to /dev/random as entropy source.  Any reason why
not default to /dev/urandom?

The other day Dan Berrang=C3=A9 explained elsewhere that /dev/urandom is
recommended -- as it is non-blocking; and doesn't have the same
limitations of /dev/random, which is a legacy interface.  (And other
applications[*] are any way overriding the QEMU default to
/dev/urandom.)

`random(4)` says the following about the blocking nature of /dev/random:

       The /dev/random device is a legacy interface which dates back to
       a time where the cryptographic primitives used in the
       implementation of /dev/urandom were not widely trusted.  It will
       return random bytes only within the estimated number of bits of
       fresh noise in the entropy pool, blocking if necessary.
       /dev/random is suitable for applications  that  need high quality
       randomness, and can afford indeterminate delays.

And its "Usage" section says:

       The  /dev/random  interface is considered a legacy interface, and
       /dev/urandom is preferred and sufficient in all use cases, with
       the exception of applications which require ran=E2=80=90 domness d=
uring
       early boot time; for these applications, getrandom(2) must be
       used instead, because it will block until the entropy pool is
       initialized.

       If a seed file is saved across reboots as recommended below (all
       major Linux distributions have done this since 2000 at least),
       the output  is  cryptographically  secure  against attackers
       without local root access as soon as it is reloaded in the boot
       sequence, and perfectly adequate for network encryption session
       keys.  Since reads from /dev/random may block, users will usually
       want to open it in nonblocking mode (or perform a read with
       timeout), and provide some sort of user notification if the
       desired entropy is  not  immedi=E2=80=90 ately available.

[*] E.g. libguestfs:
    https://github.com/libguestfs/libguestfs/blob/master/lib/launch-direc=
t.c#L592

--=20
/kashyap
