Received: from eggs.gnu.org ([2001:4830:134:3::10]:42280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSKU2-0007xI-P6
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSKPV-0005k2-7p
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:23:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gSKPU-0005jO-VF
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:23:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4DB531256A3
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:23:07 +0000 (UTC)
Date: Thu, 29 Nov 2018 12:23:04 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181129112304.7wg3kb3xv2nwd763@sirius.home.kraxel.org>
References: <20181128155932.16171-1-marcandre.lureau@redhat.com>
	<20181129080926.qyji6olhjqzkkcuz@sirius.home.kraxel.org>
	<CAMxuvaywjHiBPLuaqhV1H_0XnariFHm=JLeo3fptSKLaZbFo9g@mail.gmail.com>
	<2135052047.46423828.1543480348695.JavaMail.zimbra@redhat.com>
	<20181129090701.lbyqnyw4u3s2bxxw@sirius.home.kraxel.org>
	<905475153.46444981.1543487749747.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905475153.46444981.1543487749747.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3] configure: bump spice-server
 required version to 0.12.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

> > seems the spice-protocol dep is there due to qemu itself needing it:
> > 
> > commit 358689fe299c306f1d81bea57a5067d0abb56699
> > Author: Michal Privoznik <mprivozn@redhat.com>
> > Date:   Fri Mar 1 08:43:18 2013 +0100
> > 
> >     configure: Require at least spice-protocol-0.12.3
> >     
> >     As of 5a49d3e9 we assume SPICE_PORT_EVENT_BREAK to be defined.
> >     However, it is defined not in 0.12.2 what we require now, but in
> >     0.12.3.  Therefore in order to prevent build failure we must
> >     adjust our minimal requirements.
> >     
> >     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > That makes sense.  So, when spice-server 0.12.5 requires spice-protocol
> > 0.12.8+ anyway I think we can savely drop the spice-protocol check.
> > 
> > cheers,
> >   Gerd
> > 
> 
> My idea was more to revert (kind of) 7e3efdac75caca0b283f8e76ad24c924b4718e7b:
> 
> 
> commit 7e3efdac75caca0b283f8e76ad24c924b4718e7b
> Author: Alon Levy <alevy@redhat.com>
> Date:   Wed Mar 7 16:19:03 2012 +0200
> 
>     spice: require spice-protocol >= 0.8.1
>     
>     Requiring spice-server >= 0.8.2 is not enough since spice-server.pc
>     doesn't require spice-protocol (any version). Until that is fixed
>     upstream an explicit requirement in qemu fixes compilation broken since
>     
>     commit 2e1a98c9c1b90ca093278c6b43244dc46604d7b7
>     Author: Alon Levy <alevy@redhat.com>
>     Date:   Fri Feb 24 23:19:30 2012 +0200
>     
>         qxl: introduce QXLCookie
>     
>     Reported-by: Peter Maydell <peter.maydell@linaro.org>
>     
>     Signed-off-by: Alon Levy <alevy@redhat.com>
>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> diff --git a/configure b/configure
> index 0111774cb0..62aa7609e1 100755
> --- a/configure
> +++ b/configure
> @@ -2592,6 +2592,7 @@ EOF
>    spice_cflags=$($pkg_config --cflags spice-protocol spice-server 2>/dev/null)
>    spice_libs=$($pkg_config --libs spice-protocol spice-server 2>/dev/null)
>    if $pkg_config --atleast-version=0.8.2 spice-server >/dev/null 2>&1 && \
> +     $pkg_config --atleast-version=0.8.1 spice-protocol > /dev/null 2>&1 && \
>       compile_prog "$spice_cflags" "$spice_libs" ; then
>      spice="yes"
>      libs_softmmu="$libs_softmmu $spice_libs"
> 
> 
> The rationale does not apply any more, spice-server depends on spice-protocol.

Fine with me too.

cheers,
  Gerd
