Received: from eggs.gnu.org ([2001:4830:134:3::10]:43193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fL52t-0005pb-Em
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fL52q-0005oK-C0
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:01:35 -0400
Date: Tue, 22 May 2018 13:01:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180522110114.GC6233@localhost.localdomain>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518184151.GA2479@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180518184151.GA2479@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/40] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com

Am 18.05.2018 um 20:41 hat Dr. David Alan Gilbert geschrieben:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Before we can make x-blockdev-create a background job, we need to
> > generalise the job infrastructure so that it can be used without any
> > associated block node.
>=20
> Is there any relationship between what this does, and what
> Marc-Andr=E9's 'monitor: add asynchronous command type' tries to do?
> (See 20180326150916.9602-1-marcandre.lureau@redhat.com 26th March)

Depends on who you ask. :-)

In a way, yes. Marc-Andr=E9's async commands are for long-running
operations and jobs are for long-running operations. However, they are
for a different kind of "long-running".

Basically, Marc-Andr=E9's work is for commands that are generally quick,
but perform some blocking operation. Usually commands that are currently
implemented synchronously, but always bothered us because they block the
VM for a while. They take maybe a few seconds at most, but you really
don't want them to block the guest even for short time.

The important part here is you don't want to modify the operations while
they're running, they just send their return value when they are done.
(In the latest version, Marc-Andr=E9 even made sure not to modify the wir=
e
protocol, so IIUC the commands aren't really async any more in the sense
that you can have multiple commands running, but they are just
non-blocking in the sense that the guest can keep running while they are
doing their work.)

In comparison, jobs are typically really long running, like several
minutes (like copying a whole disk image). Some of them can even run
indefinitely (like mirroring) until you explicitly tell them to stop.
You want to continue using the monitor while they are running, and to be
able to manage them at runtime (pause/resume/set speed/cancel/...).

So I think both address different problems.

Kevin
