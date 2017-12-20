Received: from eggs.gnu.org ([2001:4830:134:3::10]:43026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRd0T-00028t-60
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRd0S-00072z-9i
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:57:53 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:42739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eRd0S-00072T-2Q
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:57:52 -0500
Received: by mail-wm0-x233.google.com with SMTP id b199so9419706wme.1
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 03:57:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Dec 2017 12:57:50 +0100
Message-ID: <CAJ+F1CL0Eew0VaaoPVAVNuu9rrKXwn+7QOGMvKHKKTOFs3MXUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

On Mon, Dec 18, 2017 at 8:12 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
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
>
> The key patches containing the security fix are 9, 10, 11.
>
> Since this code is incredibly subtle & hard to understand though, the fir=
st
> 8 patches do a bunch of independant cleanups/refactoring to make the secu=
rity
> fixes clearer.  The last two patches are just some extra cleanup / help f=
or
> future maint.
>
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
>
>  ui/trace-events    |   7 ++
>  ui/vnc-auth-sasl.c |  16 ++-
>  ui/vnc-auth-sasl.h |   5 +-
>  ui/vnc-jobs.c      |   5 +
>  ui/vnc.c           | 320 ++++++++++++++++++++++++++++++++++++++---------=
------
>  ui/vnc.h           |  28 ++++-
>  6 files changed, 277 insertions(+), 104 deletions(-)
>

For the series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




--=20
Marc-Andr=C3=A9 Lureau
