Received: from eggs.gnu.org ([2001:4830:134:3::10]:41823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fBYMW-0008U8-Gu
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 00:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fBYMR-0007P0-Hl
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 00:18:28 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1fBYMR-0007Nz-BG
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 00:18:23 -0400
Received: by mail-wm0-f54.google.com with SMTP id n10so10373348wmc.1
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 21:18:22 -0700 (PDT)
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <0a704c5f-8f14-c755-e1e1-1a87967471ed@tuxfamily.org>
Date: Thu, 26 Apr 2018 06:18:20 +0200
MIME-Version: 1.0
In-Reply-To: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Large patch set advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Kamil Rytarowski <kamil@netbsd.org>, Brad Smith <brad@comstyle.com>

On 25.04.2018 21:57, Warner Losh wrote:
> Greetings,
> 
> I’ve foolishly volunteered to rebase all the changes that the bad-user mode folks have done to a recent master rev to get these changes upstreamed.

Great that finally someone dares to do this step! But I hope the "bad"
was just a typo ;-)

[...]
> So as with everything that’s developed over time, the early patches no longer are bistable because there’s later patches that fix the old APIs that were current at the start of the project to use newer APIs.

bistable = bisectable? ... well, I guess that doesn't really matter here
since the upstream bsd-user code is completely broken anyway.

[...]
> Oh, and the number of SoBs in the original code is somewhat lacking. A tedious detail I need to chase down independent of all the other stuff.

Yes, please chase that down first. QEMU project is quite strict about SoBs.

[...]
> My first question seems almost rhetorical: that’s not an acceptable state of affairs, and curation is needed to upstream. Right?

I'd say this does not sound like an acceptable state, but it's finally
Peter who decides what patches get merged.

> My curation plans:
> 
> (1) Find where each of the bits of my ‘true up’ commits at the end are needed and to merge those bits back to those commits (I’m guessing it’s due to conflicts, or false conflict detection in git’s merging logic, since it was 4 hours and there attepts to get through the ‘git rebase -i master’ phase). These aren’t true changes anyway: just my screw up. Most of them are easy to find where they belong.
> 
> (2) back merge the API changes as best I can to as early in the stream as possible. One wrinkle here is that there’s a lot of code motion in the early patches to get the MI/MD stuff right, but even in the original commits, it never was very pure at all. And these changes are 2-3k lines long, but completely confined to bsd-user so maybe that’s OK. (I say completely, but sometimes there’s this or that thing added to a Makefile).
> 
> (3) Keep the classes of syscall implementation commits separate, but merge back the API and/or related new syscalls that were added. It’s a tradeoff between having 200 diffs that are minnows and 20 diffs that are related schools of fish vs one huge whale that’s just too big.
> 
> (4) Deal with the cases where multiple people have worked on a patch by putting SoBs for all of them (or reworking them if I can’t get a hold of the original authors) on the commits that are merged. I didn’t see a specific policy for this, but this seems sane. The alternative seems worse (having elements that don’t compile)

AFAIK, merging patches is ok, just mention it in the patch description.
For example if you have a patch with a description like this:

"
 Implement new feature XYZ

 This patch implements a new feature that is very cool.

 Signed-off-by: Alice
"

and then a fixup patch later:

"
 Fix XYZ

 This fixes a bug in XYZ

 Signed-off-by: Bob
"

You could merge them by supplying a note in square brackets:

"
 Implement new feature XYZ

 This patch implements a new feature that is very cool.

 Signed-off-by: Alice
 Signed-off-by: Bob
 [imp: merged fix from Bob into the patch from Alice]
 Signed-off-by: Warner Losh <imp@bsdimp.com>
"

I think it depends on the contents of Bob's patch whether you should
also include the complete patch description of Bob's patch or not.

> (5) Send them in small batches. I’d go insane trying to manage 200 concurrent code reviews, and I can’t image that I’m unique in this. I also image that fixes in the early part of the series may have ripples to the later parts if my past experience with these things has any relevance.

Yes, please keep the batch sizes small and digestible.

 Thanks,
  Thomas
