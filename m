Received: from eggs.gnu.org ([2001:4830:134:3::10]:37048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4783105bd=Ian.Jackson@citrix.com>)
	id 1eCOnH-00044R-La
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4783105bd=Ian.Jackson@citrix.com>)
	id 1eCOnD-0000nD-Ll
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:45:19 -0500
Received: from smtp.citrix.com ([66.165.176.89]:42368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4783105bd=Ian.Jackson@citrix.com>)
	id 1eCOnD-0000mp-Dp
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:45:15 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23042.59208.477246.94910@mariner.uk.xensource.com>
Date: Wed, 8 Nov 2017 11:15:20 +0000
In-Reply-To: <874lq7b68c.fsf@dusky.pond.sub.org>
References: <1507314444-30835-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507314444-30835-8-git-send-email-ian.jackson@eu.citrix.com>
	<87inenfv4y.fsf@dusky.pond.sub.org>
	<23040.31929.577241.244120@mariner.uk.xensource.com>
	<874lq7b68c.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option"):
> Ian Jackson <ian.jackson@eu.citrix.com> writes:
> > qemu_strtoul fails (returns an error) if the delimiter (that is, the
> > first character which is not processed as digit by strtoul) is not
> > '\0'.
> 
> It does that *only* when its @endptr argument is null.  Since you pass
> &ep, it should work fine here.

I have just read it again and you are right.  Sorry.  I will fix this
then.

> > Does that all make sense ?
> 
> Your code makes sense to me.  It's just the comment that confuses me.
> Does ID mean "implementation-defined behavior"?  That would be wrong:

Yes, that's what I meant by ID.

>        6.3.1.3  Signed and unsigned integers
> 
>        [#1] When a value with integer type is converted to  another
>        integer   type  other  than  _Bool,  if  the  value  can  be
>        represented by the new type, it is unchanged.
> 
>        [#2] Otherwise, if the new type is unsigned,  the  value  is
>        converted  by repeatedly adding or subtracting one more than
>        the maximum value that can be represented in  the  new  type
>        until the value is in the range of the new type.

That applies if the new type (uid_t, here) is unsigned.  But I think
uid_t's signedness is not specified, so it might be signed.  (SuS
says, in the section on types.h, only

  Additionally:
     * nlink_t, uid_t, gid_t, and id_t shall be integer types.

C99 6.3.1.3 continues:

         Otherwise, the new type is signed and the value cannot be
         represented in it; either the result is
         implementation-defined or an implementation-defined signal is
         raised.

So the type of uid_t is ID too.

> One more thing: please report errors with error_report().  Here:

>             error_report("Could not obtain uid");
> 
> No need to quote optarg back at the user, because error_report() already
> does.

Ah, I will do that.  Thanks.

Regards,
Ian.
