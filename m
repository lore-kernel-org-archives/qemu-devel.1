Received: from eggs.gnu.org ([2001:4830:134:3::10]:35766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsWEX-0006jD-W7
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsWEU-0003mT-QJ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:43:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsWEU-0003l7-J3
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:43:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E2644023476
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 16:43:46 +0000 (UTC)
Date: Wed, 22 Aug 2018 17:43:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822164336.GS12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
	<20180822142956.6859-4-marcandre.lureau@redhat.com>
	<20180822154611.GN12750@redhat.com>
	<CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
	<4a0122ad-52eb-d241-709b-76038e65a858@redhat.com>
	<CAMxuvaxEM4DjCq=AKEEg3cTJzoo1PX9N5R6p1_+wvCY=TMtgqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvaxEM4DjCq=AKEEg3cTJzoo1PX9N5R6p1_+wvCY=TMtgqQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] seccomp: set the seccomp filter to
 all threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Paul Moore <pmoore@redhat.com>, Eduardo Otubo <otubo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Wed, Aug 22, 2018 at 06:19:16PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Aug 22, 2018 at 6:07 PM, Eric Blake <eblake@redhat.com> wrote:
> > On 08/22/2018 10:58 AM, Marc-Andr=C3=A9 Lureau wrote:
> >
> >>> At this point you might as well not bother using seccomp at all. Th=
e
> >>> thread that is confined merely needs to scribble something into the
> >>> stack of the unconfined thread and now it can do whatever it wants.
> >>
> >>
> >> Actually, that message is incorrect, it should rather be "not all
> >> threads will be filtered" (as described in commit message).
> >>
> >>> IMHO we need to find a way to get the policy to apply to those othe=
r
> >>> threads.
> >>
> >>
> >> That's what the patch is about ;)
> >
> >
> > In other words, this patch is patching the gaping security hole that =
already
> > exists, but...
> >
> >>>> +++ b/qemu-options.hx
> >>>> @@ -3864,6 +3864,8 @@ Disable set*uid|gid system calls
> >>>>   Disable *fork and execve
> >>>>   @item resourcecontrol=3D@var{string}
> >>>>   Disable process affinity and schedular priority
> >>>> +@item tsync=3D@var{bool}
> >>>> +Apply seccomp filter to all threads (default is auto, and will wa=
rn if
> >>>> fail)
> >>>
> >>>
> >>> IMHO this should never exist, as setting "tsync" to anything other
> >>> than "yes", is akin to just running without any sandbox.
> >>
> >>
> >> Then we should just fail -sandbox on those systems.
> >
> >
> > ...leaving the backdoor open.  Yes, we should instead fix things to h=
ard
> > fail when -sandbox cannot fully protect the process, rather than addi=
ng a
> > tsync=3Doff backdoor to permit execution in spite of the insecurity.
>=20
> Ok, -sandbox will now require libseccomp 2.2.0 (not available in
> Debian oldstable - so it will fail at configure time) and kernel >=3D
> 3.17 (error during start). If that sounds ok, I'll update the series.

Hmm, that will cause seccomp to be unusable for RHEL-7, prior to
the 7.5 kernel, which has complications wrt libvirt using -sandbox
by default.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
