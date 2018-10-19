Received: from eggs.gnu.org ([2001:4830:134:3::10]:33715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDOTb-0002Y2-48
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDOTW-0004Gm-MG
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:41:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:59658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gDOTU-0003mg-RO
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:41:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gDOFV-00030H-WC
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:27:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 92ADD2E852F
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:25:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Oct 2018 06:12:40 -0000
From: Thomas Huth <1798659@bugs.launchpad.net>
Reply-To: Bug 1798659 <1798659@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153989027444.15424.224613242357516969.malonedeb@gac.canonical.com>
Message-Id: <153992956104.3741.12869393628335044379.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798659] Re: A typo in trace/simple.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It's perfect valid C to terminate a statement with "," instead of ";" -
it just has a different meaning. Consider this:

#include <stdio.h>

int main()
{
    if (0)
        printf("Hello!\n"),
        =

    printf("Good bye!\n");

    return 0;
}

At a first glance, you'd expect this program to print "Good bye!" - but
it does not. Actually, the "," is used here to put the two printf
statements into the same block, so this program is the same as:

    if (0) {
        printf("Hello!\n");
        printf("Good bye!\n");
    }

Thus, there is no real bug in simple.c here, but of course it would be
better style to clean this up and use ";" instead.

By the way, two lines earlier there is another line ending in ",":

    dropped.rec.event =3D DROPPED_EVENT_ID,

** Summary changed:

- A typo in trace/simple.c
+ Replace comma with semicolon in trace/simple.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798659

Title:
  Replace comma with semicolon in trace/simple.c

Status in QEMU:
  New

Bug description:
  In the master branch in trace/simple.c in writeout_thread (https://github=
.com/qemu/qemu/blob/master/trace/simple.c#L174) we currently have:
    dropped.rec.length =3D sizeof(TraceRecord) + sizeof(uint64_t),
    dropped.rec.pid =3D trace_pid;

  It seems to me like a typo that the first line ends with a comma.
  Currently this causes no harm, but I think this should be fixed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798659/+subscriptions
