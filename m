Received: from eggs.gnu.org ([2001:4830:134:3::10]:39925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eBmKR-0007Rz-JX
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eBmKM-000531-PI
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eBmKM-00052I-G0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1507314444-30835-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507314444-30835-8-git-send-email-ian.jackson@eu.citrix.com>
	<87inenfv4y.fsf@dusky.pond.sub.org>
	<23040.31929.577241.244120@mariner.uk.xensource.com>
Date: Mon, 06 Nov 2017 19:40:51 +0100
In-Reply-To: <23040.31929.577241.244120@mariner.uk.xensource.com> (Ian
	Jackson's message of "Mon, 6 Nov 2017 15:16:09 +0000")
Message-ID: <874lq7b68c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Ian Jackson <ian.jackson@eu.citrix.com> writes:

> Hi.  Thanks for the (re)-review.
>
> Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option"):
>> Ian Jackson <ian.jackson@eu.citrix.com> writes:
>> > +    case QEMU_OPTION_runasid:
>> > +        errno = 0;
>> > +        lv = strtoul(optarg, &ep, 0); /* can't qemu_strtoul, want *ep=='.' */
>> 
>> I'm afraid I can't see why qemu_strtoul() wouldn't work here.  Can you
>> enlighten me?
>
> qemu_strtoul fails (returns an error) if the delimiter (that is, the
> first character which is not processed as digit by strtoul) is not
> '\0'.

It does that *only* when its @endptr argument is null.  Since you pass
&ep, it should work fine here.

>        Normally this is desirable, because it correctly rejects
> strings like "123blather".  But here we are trying to process a string
> whose first non-digit is ':', and we will handle the tail part
> explicitly.
>
> It would be possible to use strchr and then to write a '\0' over the
> ':' but I dislike that processing style (and it is forbidden by the
> const annotations on os_parse_cmd_args etc.)

I'd dislike that, too.

>> > +        user_uid = lv; /* overflow here is ID in C99 */
>> 
>> I don't get the comment.  You check for overflow the obvious way below.
>> Sure you need a comment?
>
> This relates to overflow in the assignment, only.  lv is an unsigned
> long and user_uid is a uid_t (which may be smaller).  Normally, signed
> integer overflow is UB, but this is not the case when converting from
> another integer type.
>
> There are two possible overflows: 1. a string that strtoul cannot get
> to fit in an unsigned long, which produces a nonzero errno; and, 2. a
> value which fits in an unsigned long but not a uid_t.  In the latter
> case, we convert it _back_ into an unsigned long, as an implicit
> conversion in this middle test:
>
>> > +        if (errno || *ep != '.' || user_uid != lv || user_uid == (uid_t)-1) {
>
> If that succeeds, we know we can round-trip it so it is valid.  The
> remaining check needed is that it doesn't round trip to the sentinel
> uid value.
>
> Does that all make sense ?

Your code makes sense to me.  It's just the comment that confuses me.
Does ID mean "implementation-defined behavior"?  That would be wrong:

       6.3.1.3  Signed and unsigned integers

       [#1] When a value with integer type is converted to  another
       integer   type  other  than  _Bool,  if  the  value  can  be
       represented by the new type, it is unchanged.

       [#2] Otherwise, if the new type is unsigned,  the  value  is
       converted  by repeatedly adding or subtracting one more than
       the maximum value that can be represented in  the  new  type
       until the value is in the range of the new type.

>                             I'm not sure how much of this to document
> in comments.  It's deeply annoying that C is such a puzzle language
> here and that therefore such complicated reasoning and
> not-immediately-obvious code is needed, to do something so simple.
>
> If you would like me to remove the comment, I can drop it, of course.
> I don't really mind.

I'd drop it.

You might find this variation of your code slightly more obvious, or
slightly less:

        if (errno || *ep != '.' || (uid_t)lv != lv || user_uid == (uid_t)-1) {
            fprintf(stderr, "Could not obtain uid from \"%s\"", optarg);
            exit(1);
        }
        user_uid = lv;

Your choice.

One more thing: please report errors with error_report().  Here:

            error_report("Could not obtain uid");

No need to quote optarg back at the user, because error_report() already
does.

>> > +#ifndef _WIN32
>> > +DEF("runasid", HAS_ARG, QEMU_OPTION_runasid, \
>> > +    "-runasid uid.gid     change to numeric uid and gid just before starting the VM\n",
>> > +    QEMU_ARCH_ALL)
>> > +#endif
>> > +STEXI
>> > +@item -runasid @var{uid}.@var{gid}
>> 
>> Didn't we agree on using ':' instead of '.' as separator?
>> 
>> Sure we need yet another option?  Why can't we compatibly extend -runas?
>
> For some reason you are looking at an old version of the patch.  That
> may be my fault - there were a few mis-posts.  Sorry about that.

It could be just as well my fault: my inbox spun out of control before
KVM Forum.

> The final version does indeed have ':' and does reuse the -runas
> option.
>
>> If we truly need both, the rationale belongs into the commit message,
>> and we need to consider how they interact.  I'd recommend left-to-right
>> semantics, i.e. if you specify both, the last one wins.  Not what your
>> current code does, if I read it correctly.
>
> Happily this is now irrelevant.
>
> I will repost this series after I hear from you about strtoul and the
> overflow comment.

Thanks!
