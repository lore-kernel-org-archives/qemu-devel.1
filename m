Received: from eggs.gnu.org ([2001:4830:134:3::10]:44990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eefIR-00084K-0O
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eefIN-0004X1-Rz
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:02:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eefIN-0004WN-M7
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:02:15 -0500
Date: Thu, 25 Jan 2018 11:02:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180125110208.GB1776@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAK-iXgUO7LMZ7+Bvs66_yno_q6ZDEzgKS5baxG7SASVNChYyvw@mail.gmail.com>
	<982e13e4-6591-0f4c-9faa-17e0302ad350@redhat.com>
	<20180125105257.GC27269@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125105257.GC27269@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Prevent overriding the input file with the output
 file when using qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, River Chiang <riverchiang@gmail.com>, qemu-devel@nongnu.org

On Thu, Jan 25, 2018 at 10:52:57AM +0000, Stefan Hajnoczi wrote:
> On Tue, Jan 23, 2018 at 08:48:15AM -0600, Eric Blake wrote:
> > On 01/22/2018 10:40 PM, River Chiang wrote:
> > >     Signed-off-by: River Chiang <riverchiang@gmail.com>
> > > 
> > > ---------------------------------- qemu-img.c
> > > ----------------------------------
> > > index 68b375f998..5ce594ea00 100644
> > > @@ -2098,6 +2098,9 @@ static int img_convert(int argc, char **argv)
> > >      if (s.src_num < 1) {
> > >          error_report("Must specify image file name");
> > >          goto fail_getopt;
> > > +    } else if (!strcmp(argv[optind], out_filename)) {
> > > +        error_report("Override the input file with the output file");
> > > +        goto fail_getopt;
> > 
> > Comparing names is too prone to false negatives.  'foo' and './foo' are
> > the same file, but your test won't catch it.  Better might be checking
> > if stat() reports the same dev/inode pair for the two files.
> > 
> > By the way, your patch is not in proper 'git send-email' format, which
> > makes it hard to test whether it even applies.  More patch submission
> > hints at http://wiki.qemu.org/Contribute/SubmitAPatch
> 
> stat(2) cannot be used since the "filenames" may not be a local file,
> (nbd://, iscsi://, etc).
> 
> strcmp(3) is also not a full solution, for the reasons you mentioned.

It isn't a full solution, but I does it really need to be ? This check
is only needed to protect against user accidents. It doesn't trigger
false reports so won't block valid usage, it merely fails to report
the problem in some edge cases.  IOW, I think strcmp is good enough
in absence of any other simple solution - better than nothing IMHO.

> 
> Even file locking probably isn't a full solution.  What happens when
> input and output files are nbd:// URIs?
> 
> Attempting to prevent the user from harming themselves is very hard to
> do.  It's better not to second-guess the user than to have some magic
> that doesn't always work (the user cannot rely on it anyway).



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
