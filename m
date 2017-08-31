Received: from eggs.gnu.org ([2001:4830:134:3::10]:53747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnPIc-0008OR-0v
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnPIX-0008M8-VS
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnPIX-0008Lq-M8
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:17 -0400
Date: Thu, 31 Aug 2017 14:14:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170831131412.GK17315@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
	<CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
	<87r2vrlwr3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2vrlwr3.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, David Michael <fedora.dm0@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Aug 31, 2017 at 02:58:24PM +0200, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On 31 August 2017 at 07:35, Markus Armbruster <armbru@redhat.com> wrote:
> >> So, first we'll invest in work-arounds to make both 2 and 3 work.  Once
> >> 2 is gone, we can invest some more to clean them up.  Which probably
> >> won't happen, so we'll continue to carry work-arounds that no longer
> >> make sense.
> >>
> >> I maintain roughly one fourth of all Python code in qemu, and I'm not
> >> looking forward to this hoop-jumping at all.
> >>
> >> Are we really, really sure we want to go this way?  What exactly are we
> >> hoping to accomplish by it?
> >
> > My take is that we have the following goals we want to achieve:
> >
> > (1) We need to continue to build and run on older (long-term-support)
> > distros that still ship only Python 2.x (alas even back to 2.6)
> 
> That's an assertion, not an answer to my question :)
> 
> What exactly are we hoping to accomplish by supporting what distros
> exactly?
> 
> > (2) We need to be able to build and run on newer distros that
> > have dropped Python 2 altogether in favour of Python 3
> > (I don't know if there are any such today, but presumably by
> > 2020 there will be)
> 
> Yup.
> 
> > Unless we can confidently say that either (1) or (2) is the
> > empty set, we need to handle both 2 and 3 in the same codebase.
> > This is a pain, but unfortunately Python upstream have forced
> > us into it by breaking source code compatibility.
> >
> > I think (1) is pretty clearly not (yet) an empty set, so the
> > only alternative I see to "support 2 and 3 now" is "keep supporting
> > only 2 for the moment and hope that no distro drops 2 support
> > before all the LTS 2-only distro versions vanish into history".
> 
> I don't buy the "clearly" in "pretty clearly not (yet) an empty set",
> because I don't understand *why* we need to support "older
> (long-term-support) distros".
> 
> If we can leave Python 2 behind, I'm all for porting to Python 3 now.
> 
> If we can't yet, then I don't see why I should do work *now* just
> because "some" distro might drop support for Python 2 "before all the
> LTS 2-only distro versions vanish into history".

As mentioned before, while for many projects, maintaining py2 & py3
in parallel is hard, I don't think that is going to be the case for
QEMU due to the simplicity of much of our python usage. IOW, for QEMU
I tend to view this as more like the work we do to fix up compiler
warnings when new GCC comes out. There's some cleanup needed, but the
result is rarely harder to maintain.

It is fine if you don't want to do the work to convert QAPI code to
support py3, but if some other contributor submits patches for parallel
py2 & py3 support that don't appreciably harm maintainability I see 
little reason to reject them.

> If it ain't broke, don't fix it!

NB, some distros have already changed /usr/bin/python to point to py3
so all the files with #!/usr/bin/python in QEMU are already broken on
those distros.

In theory you could change the shebang to #!/usr/bin/python2, but the
/usr/bin/python2 file symlink is not standard in py2.6 - though certain
distros have backported support for it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
