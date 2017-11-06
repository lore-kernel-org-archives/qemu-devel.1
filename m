Received: from eggs.gnu.org ([2001:4830:134:3::10]:51246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=476082529=Ian.Jackson@citrix.com>)
	id 1eBj9w-00030s-OO
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=476082529=Ian.Jackson@citrix.com>)
	id 1eBj9r-0003SH-Tb
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:17:56 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:3757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=476082529=Ian.Jackson@citrix.com>)
	id 1eBj9r-0003R6-NC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:17:51 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23040.31929.577241.244120@mariner.uk.xensource.com>
Date: Mon, 6 Nov 2017 15:16:09 +0000
In-Reply-To: <87inenfv4y.fsf@dusky.pond.sub.org>
References: <1507314444-30835-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507314444-30835-8-git-send-email-ian.jackson@eu.citrix.com>
	<87inenfv4y.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Hi.  Thanks for the (re)-review.

Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option"):
> Ian Jackson <ian.jackson@eu.citrix.com> writes:
> > +    case QEMU_OPTION_runasid:
> > +        errno = 0;
> > +        lv = strtoul(optarg, &ep, 0); /* can't qemu_strtoul, want *ep=='.' */
> 
> I'm afraid I can't see why qemu_strtoul() wouldn't work here.  Can you
> enlighten me?

qemu_strtoul fails (returns an error) if the delimiter (that is, the
first character which is not processed as digit by strtoul) is not
'\0'.  Normally this is desirable, because it correctly rejects
strings like "123blather".  But here we are trying to process a string
whose first non-digit is ':', and we will handle the tail part
explicitly.

It would be possible to use strchr and then to write a '\0' over the
':' but I dislike that processing style (and it is forbidden by the
const annotations on os_parse_cmd_args etc.)

> > +        user_uid = lv; /* overflow here is ID in C99 */
> 
> I don't get the comment.  You check for overflow the obvious way below.
> Sure you need a comment?

This relates to overflow in the assignment, only.  lv is an unsigned
long and user_uid is a uid_t (which may be smaller).  Normally, signed
integer overflow is UB, but this is not the case when converting from
another integer type.

There are two possible overflows: 1. a string that strtoul cannot get
to fit in an unsigned long, which produces a nonzero errno; and, 2. a
value which fits in an unsigned long but not a uid_t.  In the latter
case, we convert it _back_ into an unsigned long, as an implicit
conversion in this middle test:

> > +        if (errno || *ep != '.' || user_uid != lv || user_uid == (uid_t)-1) {

If that succeeds, we know we can round-trip it so it is valid.  The
remaining check needed is that it doesn't round trip to the sentinel
uid value.

Does that all make sense ?  I'm not sure how much of this to document
in comments.  It's deeply annoying that C is such a puzzle language
here and that therefore such complicated reasoning and
not-immediately-obvious code is needed, to do something so simple.

If you would like me to remove the comment, I can drop it, of course.
I don't really mind.

> > +#ifndef _WIN32
> > +DEF("runasid", HAS_ARG, QEMU_OPTION_runasid, \
> > +    "-runasid uid.gid     change to numeric uid and gid just before starting the VM\n",
> > +    QEMU_ARCH_ALL)
> > +#endif
> > +STEXI
> > +@item -runasid @var{uid}.@var{gid}
> 
> Didn't we agree on using ':' instead of '.' as separator?
> 
> Sure we need yet another option?  Why can't we compatibly extend -runas?

For some reason you are looking at an old version of the patch.  That
may be my fault - there were a few mis-posts.  Sorry about that.

The final version does indeed have ':' and does reuse the -runas
option.

> If we truly need both, the rationale belongs into the commit message,
> and we need to consider how they interact.  I'd recommend left-to-right
> semantics, i.e. if you specify both, the last one wins.  Not what your
> current code does, if I read it correctly.

Happily this is now irrelevant.

I will repost this series after I hear from you about strtoul and the
overflow comment.

Regards,
Ian.
