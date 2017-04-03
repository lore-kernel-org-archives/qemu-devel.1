Received: from eggs.gnu.org ([2001:4830:134:3::10]:41959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cv6T4-0008Mh-RP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cv6T1-0000ZZ-NO
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:12:42 -0400
Received: from mail-bl2nam02on0112.outbound.protection.outlook.com
	([104.47.38.112]:48303
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1cv6T1-0000Xr-AY
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:12:39 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Mon, 3 Apr 2017 18:12:34 +0000
Message-ID: <CY1PR21MB005570FEDC849D13F608915B9E080@CY1PR21MB0055.namprd21.prod.outlook.com>
References: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
	<20170403162016.6c033dd8.cornelia.huck@de.ibm.com>
In-Reply-To: <20170403162016.6c033dd8.cornelia.huck@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] win32: replace custom mutex and condition
 variable with native primitives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Andrey Shedel <ashedel@microsoft.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>

> From: Cornelia Huck [mailto:cornelia.huck@de.ibm.com]
> Sent: Monday, 3 April 2017 7:20
>=20
> On Fri, 24 Mar 2017 15:01:41 -0700
> Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:
>=20
> > From: Andrey Shedel <ashedel@microsoft.com>
> >
> > The multithreaded TCG implementation exposed deadlocks in the win32
> > condition variables: as implemented, qemu_cond_broadcast waited on
> > receivers, whereas the pthreads API it was intended to emulate does
> > not. This was causing a deadlock because broadcast was called while
> > holding the IO lock, as well as all possible waiters blocked on the
> > same lock.
> >
> > This patch replaces all the custom synchronisation code for mutexes
> > and condition variables with native Windows primitives (SRWlocks and
> > condition variables) with the same semantics as their POSIX
> > equivalents. To enable that, it requires a Windows Vista or newer host
> > OS.
> >
> > [AB: edited commit message]
> > Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> > ---
> > The major implication of this patch is that it drops support for
> > pre-Vista versions of Windows. However, those OSes are past their end
> > of life, and other OSS projects have dropped support. e.g.; the last
> > Cygwin release supporting XP was in Jun 2016. It doesn't seem like a
> > good tradeoff to invest effort in fixing broken code needed to support
> > them, so hopefully this isn't too controversial.
>=20
> Just a quick question:
>=20
> I noticed that this breaks builds on an old fc20-based installation I
> run some mingw cross builds on (getting an undefined reference to
> `_imp__TryAcquireSRWLockExclusive@4'). I should probably take that as a
> trigger to update that installation ;), but wanted to confirm that this
> is expected.

Yes, please try updating your mingw headers. I've done x64 cross-builds fro=
m Ubuntu 16.04 (WSL) using mingw-w64 4.0.4.

Andrew
