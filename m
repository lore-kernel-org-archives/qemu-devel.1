Received: from eggs.gnu.org ([2001:4830:134:3::10]:44163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eRJLI-0006vo-KB
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eRJLF-0003PU-T5
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:58:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eRJLF-0003OT-KF
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:58:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A3B5356DE
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 14:58:00 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 20B57183C6
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 14:58:00 +0000 (UTC)
Date: Tue, 19 Dec 2017 09:57:59 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <32374673.1188228.1513695479889.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 00/13] Fix VNC server unbounded memory
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

Hi

----- Original Message -----
> In the 2.11 release we fixed CVE-2017-15268, which allowed the VNC websoc=
kets
> server to consume arbitrary memory when a slow client was connected. I ha=
ve
> since discovered that this same type of problem can be triggered in sever=
al
> other ways in the regular (non-websockets) VNC server. This patch series
> attempts to fix this problem by limiting framebuffer updates and other da=
ta
> sent from server to client. The mitigating factor is that you need to hav=
e
> successfully authenticated with the VNC server to trigger these new flaws=
.
> This new more general flaw is assigned CVE-2017-15124 by the Red Hat secu=
rity
> team.
>=20
> The key patches containing the security fix are 9, 10, 11.
>=20
> Since this code is incredibly subtle & hard to understand though, the fir=
st
> 8 patches do a bunch of independant cleanups/refactoring to make the secu=
rity
> fixes clearer.  The last two patches are just some extra cleanup / help f=
or
> future maint.

I already reviewed the series privately, and in general, I'd ack it.

Did you manage to run some throttle tests? (I tried to trigger them manuall=
y by slowing artificially network or calling framebuffer_update_request() i=
n gdb, I didn't manage yet :-/)

>=20
> Daniel P. Berrange (13):
>   ui: remove 'sync' parametr from vnc_update_client
>   ui: remove unreachable code in vnc_update_client
>   ui: remove redundant indentation in vnc_client_update
>   ui: avoid pointless VNC updates if framebuffer isn't dirty
>   ui: track how much decoded data we consumed when doing SASL encoding
>   ui: introduce enum to track VNC client framebuffer update request
>     state
>   ui: correctly reset framebuffer update state after processing dirty
>     regions
>   ui: refactor code for determining if an update should be sent to the
>     client
>   ui: fix VNC client throttling when audio capture is active
>   ui: fix VNC client throttling when forced update is requested
>   ui: place a hard cap on VNC server output buffer size
>   ui: add trace events related to VNC client throttling
>   ui: mix misleading comments & return types of VNC I/O helper methods
>=20
>  ui/trace-events    |   7 ++
>  ui/vnc-auth-sasl.c |  16 ++-
>  ui/vnc-auth-sasl.h |   5 +-
>  ui/vnc-jobs.c      |   5 +
>  ui/vnc.c           | 320
>  ++++++++++++++++++++++++++++++++++++++---------------
>  ui/vnc.h           |  28 ++++-
>  6 files changed, 277 insertions(+), 104 deletions(-)
>=20

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> --
> 2.14.3
>=20
>=20
