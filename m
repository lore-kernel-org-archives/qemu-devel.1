Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJlUD-0005dt-Id
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 13:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJlUC-0006lv-Hd
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 13:19:33 -0500
Date: Wed, 21 Dec 2016 16:19:21 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161221181921.GJ3808@thinpad.lan.raisama.net>
References: <20161201170624.26496-1-lersek@redhat.com>
	<148227487620.73.10055858460424473693@790289a7ca88>
	<20161221152226.GH3808@thinpad.lan.raisama.net>
	<70b42a58-381d-7011-7eef-2120af178f91@redhat.com>
	<20161221180155.GI3808@thinpad.lan.raisama.net>
	<e45bb195-578f-6afc-8617-f75e7775193e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e45bb195-578f-6afc-8617-f75e7775193e@redhat.com>
Subject: Re: [Qemu-devel] checkpatch.pl false positive (was Re: [PATCH v4
 0/7] q35: add negotiable broadcast SMI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, famz@redhat.com, mst@redhat.com, somlo@cmu.edu, Markus Armbruster <armbru@redhat.com>, michael@walle.cc, qemu-arm@nongnu.org, kraxel@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, imammedo@redhat.com

On Wed, Dec 21, 2016 at 07:08:29PM +0100, Paolo Bonzini wrote:
> 
> 
> On 21/12/2016 19:01, Eduardo Habkost wrote:
> > The following code replaces the whole "{ .driver = ... }" block
> > with "1":
> > 
> > 	# Flatten any parentheses and braces
> > 	while ($dstat =~ s/\([^\(\)]*\)/1/ ||
> > 	       $dstat =~ s/\{[^\{\}]*\}/1/ ||
> > 	       $dstat =~ s/\[[^\{\}]*\]/1/)
> > 	{
> > 	}
> 
> Maybe change it like
> 
> - 	       $dstat =~ s/\{[^\{\}]*\}/1/ ||
> + 	       $dstat =~ s/\{[^\{\}]*;[^\{\}]*\}/1;/ ||
> 
> so that it requires a statement?

I am not sure the point of this line is to detect multi-statement
blocks, but to replace other types of expressions containing {}
that could incorrectly match $exceptions, like:

#define FOO { \
   Foo f = { .somefield = 1 }; \
   some_statement(); \
   another_statement();
  }

In this case, $dstat would become:
"{ Foo f = 1; some_statement(); another_statement(); }"


>                                   It would have a false positive on
> strings containing a semicolon, but that's not a big deal (or could be
> fixed by similarly turning strings into just "").

String contents are already replaced with "XXX" by some other
code. These are the contents of $dstat:

 '{        .driver   = "XXXXXXXXXX",        .property = "XXXXXXXXXX",        .value    = stringify1,    }'

> 
> Paolo
> 
> > The following change fixes the bug, but I don't know if it has
> > unwanted side-effects:
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index f084542..0aab3ac 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -2200,6 +2200,10 @@ sub process {
> >                         $dstat =~ s/^\s*//s;
> >                         $dstat =~ s/\s*$//s;
> >  
> > +                       # remove braces that cover the whole block, if any:
> > +                       $dstat =~ s/^\{//;
> > +                       $dstat =~ s/\}$//;
> > +
> >                         # Flatten any parentheses and braces
> >                         while ($dstat =~ s/\([^\(\)]*\)/1/ ||
> >                                $dstat =~ s/\{[^\{\}]*\}/1/ ||
> 
> 
> Paolo

-- 
Eduardo
