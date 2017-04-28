Received: from eggs.gnu.org ([2001:4830:134:3::10]:56314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d47Xx-0001dI-Q7
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d47Xt-0004wx-LF
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:11:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d47Xt-0004wG-Ef
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:10:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5685E4AEBE
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 15:10:56 +0000 (UTC)
Date: Fri, 28 Apr 2017 16:10:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170428151051.GH11415@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170427165526.19836-1-dgilbert@redhat.com>
	<20170428134230.GB11415@redhat.com> <20170428134532.GG2085@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170428134532.GG2085@work-vm>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Disallow glib asserts in main
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com

On Fri, Apr 28, 2017 at 02:45:32PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Thu, Apr 27, 2017 at 05:55:26PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Glib commit a6a875068779 (from 2013) made many of the glib assert
> > > macros non-fatal if a flag is set.
> > > This causes two problems:
> > >   a) Compilers moan that your code is unsafe even though you've
> > >      put an assert in before the point of use.
> > >   b) Someone evil could, in a library, call
> > >      g_test_set_nonfatal_assertions() and cause our assertions in
> > >      important places not to fail and potentially allow memory overruns.
> > > 
> > > Ban most of the glib assertion functions (basically everything except
> > > g_assert and g_assert_not_reached) except in tests/
> > > 
> > > This makes checkpatch gives an error such as:
> > > 
> > >   ERROR: Use g_assert or g_assert_not_reached
> > >   #77: FILE: vl.c:4725:
> > >   +    g_assert_cmpstr("Chocolate", >, "Cheese");
> > 
> > Or could we perhaps instead undo the damage via a hack like
> > 
> >  #define g_assert_cmpint g_assert_cmpint_orig
> >  #define g_assert_cmpint(x, y, z) \
> >      g_assert_cmpint_orig(x, y,x); \
> >      abort()
> 
> I'd be kind of OK adding a q_assert_cmpint if you wanted,
> but I think we shouldn't change the semantics of a public
> name.

Personally I think it would be worth having them - the whole point of
these more specific g_assert_* macros is that they provide clearer
error messages when they're triggered, so I prefer their use generally


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
