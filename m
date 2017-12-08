Received: from eggs.gnu.org ([2001:4830:134:3::10]:36074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNJ60-000460-Ev
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNJ5z-0004ih-DP
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:53:44 -0500
Date: Fri, 8 Dec 2017 13:53:29 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171208135329.GG11767@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-25-mreitz@redhat.com>
	<w51k1y2307y.fsf@maestria.local.igalia.com>
	<bcbf0021-4fcd-26d0-e05c-cd3e35608988@redhat.com>
	<w51h8t531ql.fsf@maestria.local.igalia.com>
	<032b64ec-a161-ff2a-5505-06b91deb2682@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <032b64ec-a161-ff2a-5505-06b91deb2682@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 24/25] block/curl: Implement
 bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

On Fri, Dec 08, 2017 at 02:47:52PM +0100, Max Reitz wrote:
> On 2017-12-05 11:31, Alberto Garcia wrote:
> > On Mon 04 Dec 2017 07:26:02 PM CET, Max Reitz wrote:
> >>>> +static void curl_refresh_filename(BlockDriverState *bs)
> >>>> +{
> >>>> +    BDRVCURLState *s = bs->opaque;
> >>>> +
> >>>> +    if (!s->sslverify || s->cookie ||
> >>>> +        s->username || s->password || s->proxyusername || s->proxypassword)
> >>>> +    {
> >>>
> >>> Is !s->sslverify negative because that setting is true by default?
> >>
> >> Yes, exactly.  If it's false, you'd need to override it (and you can't
> >> do that through a plain filename).
> > 
> > I think this is not the only case in this series, but I'm not very
> > comfortable with the idea that this condition and the default value of
> > the setting are implicity dependent on each other. If you change one and
> > forget to change the other things will break.
> 
> Well, yes, but...
> 
> > I understand that the default value is never supposed to change so in
> > practice I don't see this breaking,
> 
> Yes.
> 
> >                                     but is it perhaps worth adding tests
> > for all these cases?
> 
> In theory, sure.  In practice, adding a curl test case seems hard.
> 
> Well, I could connect to, I don't know, qemu.org or something and then
> just test things there (with the index used as a raw image), but if I
> add one test for the curl protocol, nobody is ever going to run them...
> And in theory, that's not how a curl test should work.  In theory, you'd
> expect the user to set up a localhost server with some known root
> directory and then _make_test_img etc. would set up images there.  But
> that way, really nobody is ever going to run them.

For qemu I/O tests I would suggest just having the iotest spin up a simple
http server in Python - there's standard APIs in python that make this
pretty trivial

  http://www.pythonforbeginners.com/modules-in-python/how-to-use-simplehttpserver/

That way curl could be reliably tested without any special setup by the
developer

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
