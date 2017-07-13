Received: from eggs.gnu.org ([2001:4830:134:3::10]:38004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dVZqC-0001Zb-E6
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dVZq9-0007GG-9Y
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:51:20 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dVZq9-0007ED-3z
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:51:17 -0400
Received: by mail-wr0-f177.google.com with SMTP id 77so49656976wrb.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 01:51:16 -0700 (PDT)
Date: Thu, 13 Jul 2017 10:51:11 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170713105111.4f26e435@fiorina>
In-Reply-To: <346b5b87-4d9b-ab82-8966-71680ae06af0@redhat.com>
References: <cover.1498222907.git.tgolembi@redhat.com>
	<346b5b87-4d9b-ab82-8966-71680ae06af0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] qemu-ga: support for sending events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Fri, 7 Jul 2017 15:55:31 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 06/23/2017 08:02 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> > This is just a draft, or a request for comments if you will.
> >=20
> > This patch sets drafts the support of sending events by QEMU Guest Agen=
t.
> > Events can plan important role in monitoring of the guest OS behaviour.=
 The
> > range of use cases ranges from events important for scheduling, e.g. me=
mory and
> > CPU usage statistics, to things like changes to IP addresses on network
> > interfaces to for example changes in the list of active users.
> >=20
> > For now the patch set adds single periodic callback function to the GA =
main
> > loop that can perform checks and trigger events that have occured since
> > previous run of the callback. =20
>=20
> How do we guarantee that the guest cannot flood qemu with too many events?
>=20
> Obviously, qga is already used where we (in general) trust the guest to
> not be malicious, but we still have to assume that a guest can be
> compromised, and will try to abuse qga to escape to an attack against qem=
u.
>=20

If you mean situation where something in guest will be triggering events
that qga will be sending then we can implement some throttling in qga. I
belive qemu does something similar for QMP events.

But if you're considering situation where something kills qga and will
attach itself to the serial channel then this is of course more
complex issue.

> >=20
> > We can of course take it one step further and add a general framwork for
> > periodically running any of the already implemented commands. Add a fun=
ction
> > that would maintain a list of registered checks. Client would use some =
command
> > (register-monitor-command) passing it a command name and timeout in sec=
onds and
> > the monitoring handler would then run the specified command and report =
the
> > result... or report only if the return value changed since previous inv=
ocation.
> > This feature would remove part of the communication overhead between cl=
ient and
> > GA.
> >=20
> > So before I invest any more time in either of these approaches, tell me=
. Would
> > somethign like this be wanted or is that too controversial? Any other t=
houghts
> > and ideas?
> >  =20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
