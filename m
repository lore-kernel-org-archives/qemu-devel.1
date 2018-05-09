Received: from eggs.gnu.org ([2001:4830:134:3::10]:48897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGMVQ-0002jE-5W
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGMVM-0001uY-UQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:39:32 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fGMVM-0001sf-Nm
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:39:28 -0400
Received: by mail-wr0-f194.google.com with SMTP id v5-v6so35187899wrf.9
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 03:39:28 -0700 (PDT)
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <094f90c0-04dd-eddd-fd29-f081def1a812@redhat.com>
Date: Wed, 9 May 2018 12:39:25 +0200
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/67] include path cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org

On 03/05/2018 21:50, Michael S. Tsirkin wrote:
> At the moment during build we have multiple subdirectories of the source
> tree on the search path for include files.  This includes source
> directory itself, tcg and accel/tcg subdirectories, target-specific
> source subdirectory and the include subdirectory.
> 
> The result is that there are many ways to include each
> specific file, e.g. for a file in the include directory:
> 
> #include "dir/foo.h"
> #include "include/dir/foo.h"
> 
> (We actually do both).
> 
> OTOH local headers can be included with
> #include "foo.h"
> #include "dir/foo.h"
> 
> There are also target-specific headers and they are even
> trickier - e.g. try to guess which file does
> #include "cpu.h"
> pull in?  The answer actually depends on which target is built.
> 
> It is also quite easy to place an external header outside of
> include/ as nothing will catch this misuse.
> 
> In an attempt to simplify this situation, this changes the build to look
> for headers in a single directory under the source tree: include/
> (generated files are still spread around a bit, this is left for another
> patchset - and RFC of that I posted earlier).
> 
> This way, one can always find any header under include/
> (and sometimes follow from there to another directory).
> 
> A nice side effect of this refactoring is that it makes it easy to
> identify external headers which are not under include/.

Yes, this was always the intended usage.

> I decided not to actually move any headers around -
> instead I created small stub files using include_next
> which pull in the original files.

For the RFC is okay, but I think we should at least see which headers
can just get a home in include/ before applying the series.  Perhaps we
can add an include-from-topsrcdir/ directory with the #include_next
directives so that the todo list is clear.

> This way we can move the headers gradually - in particular it is often
> benefitial to split a header up with external parts under include and
> internal ones with the source.

I agree.

> Note that it's already benefitial even in this form, since
> - it's now easy to see there is an external header outside include
>   that requires work
> - reader can simply look at the header and immediately know
>   where to look for it
> 
> Target specific files are pulled in using preprocessor which is still
> tricky but arguably easier to understand than makefile tricks.

Another possibility is to directories like include/target/<XXX>, or
target/<XXX>/include/.

Paolo
